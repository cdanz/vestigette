<?php
session_start();

// Generate a fresh CSRF token only when serving the form (GET).
// On POST the token was already stored in the session from the GET load;
// regenerating it here would overwrite it and make every submission fail.
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $_SESSION['csrfToken'] = md5(uniqid(mt_rand(), true));
}
$csrfToken = $_SESSION['csrfToken'] ?? '';

// Validate type param
$allowedTypes = ['Because', 'Therefore', 'Rebuttal'];
$argID   = intval($_GET['arg'] ?? ($_SESSION['currentArg'] ?? 0));
$type    = isset($_GET['type']) && in_array($_GET['type'], $allowedTypes)
           ? $_GET['type'] : 'Because';

if ($argID === 0) {
    header('Location: /');
    exit;
}

// Redirect if not logged in
if (!isset($_SESSION['profile'])) {
    header('Location: /login.php?arg=' . $argID);
    exit;
}

$profileID = intval($_SESSION['profile']);
$_SESSION['currentArg'] = $argID;

include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

// ── POST handler ──────────────────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // CSRF check
    if (($_POST['csrfToken'] ?? '') !== $_SESSION['csrfToken']) {
        die('Unauthorized source!');
    }

    $postType  = in_array($_POST['type'] ?? '', $allowedTypes) ? $_POST['type'] : $type;
    $postArgID = intval($_POST['argID'] ?? $argID);
    $raw       = $_POST['pinnedData'] ?? '';
    $items     = json_decode($raw, true);

    if (empty($items) || !is_array($items)) {
        header('Location: /flesh_out.php?arg=' . $postArgID . '&type=' . urlencode($postType));
        exit;
    }

    $allWeighted = []; // [{argID, weight, reciprocate}]
    $newArgIDs   = []; // argIDs created fresh in this session (for bot queue)

    // ── Step 1: create new args ───────────────────────────────────────────────
    foreach ($items as $item) {
        $itemType = $item['type'] ?? '';
        if ($itemType === 'new') {
            $text = isset($item['text']) ? substr(trim($item['text']), 0, 300) : '';
            if ($text === '') continue;

            $escaped = mysqli_real_escape_string($db, $text);
            $weight  = floatval($item['weight'] ?? 0);
            $recip   = !empty($item['reciprocate']);

            // Create ARGUMENT
            mysqli_query($db, "INSERT INTO ARGUMENT (createdBy, createdDate, lastVisited)
                               VALUES ($profileID, NOW(), NOW())");
            $freshArgID = mysqli_insert_id($db);

            // Create PHRASING
            mysqli_query($db, "INSERT INTO PHRASING (argumentID, phrasing, createdDate, coinedBy)
                               VALUES ($freshArgID, '$escaped', NOW(), $profileID)");
            $freshPhraseID = mysqli_insert_id($db);

            // Endorse phrasing (active=1)
            mysqli_query($db, "INSERT INTO PHRASE_ENDORSE
                                   (argumentID, phrasingID, weight, profileID, firstVisit, lastVisit, active)
                               VALUES ($freshArgID, $freshPhraseID, 100, $profileID, NOW(), NOW(), TRUE)");

            // Accept the new argument
            mysqli_query($db, "CALL assertOpinion(1, $freshArgID, $profileID)");
            while (mysqli_more_results($db)) { mysqli_next_result($db); if ($r = mysqli_store_result($db)) mysqli_free_result($r); }

            // Update phrasing cache
            mysqli_query($db, "CALL updatePhrasingCache($freshArgID)");
            while (mysqli_more_results($db)) { mysqli_next_result($db); if ($r = mysqli_store_result($db)) mysqli_free_result($r); }

            $allWeighted[] = ['argID' => $freshArgID, 'weight' => $weight, 'reciprocate' => $recip];
            $newArgIDs[]   = $freshArgID;

        } elseif ($itemType === 'existing') {
            $allWeighted[] = [
                'argID'      => intval($item['argID'] ?? 0),
                'weight'     => floatval($item['weight'] ?? 0),
                'reciprocate' => !empty($item['reciprocate']),
            ];
        }
    }

    if (empty($allWeighted)) {
        header('Location: /flesh_out.php?arg=' . $postArgID . '&type=' . urlencode($postType));
        exit;
    }

    // ── Step 2: normalize weights to sum to exactly 100 ──────────────────────
    $totalW = array_sum(array_column($allWeighted, 'weight'));
    if ($totalW > 0) {
        $runningSum = 0;
        $last = count($allWeighted) - 1;
        foreach ($allWeighted as $i => &$item) {
            if ($i === $last) {
                $item['weight'] = round(100 - $runningSum, 5);
            } else {
                $item['weight'] = round(($item['weight'] / $totalW) * 100, 5);
                $runningSum += $item['weight'];
            }
        }
        unset($item);
    }

    // ── Step 3: bulk endorsement ──────────────────────────────────────────────
    $safeType = mysqli_real_escape_string($db, $postType);
    $query    = "CALL prepareForNewEndorse(\"$safeType\", $postArgID, $profileID);";

    foreach ($allWeighted as $w) {
        $query .= "INSERT INTO ENDORSEMENT VALUES($postArgID, $profileID, \"$safeType\", "
                . $w['argID'] . ", " . $w['weight'] . ", NOW(), NOW(), TRUE);";
    }
    $query .= "CALL resolveOldWithNewEndorse(\"$safeType\", $postArgID, $profileID);";

    if (mysqli_multi_query($db, $query)) {
        while (mysqli_more_results($db)) {
            mysqli_next_result($db);
            if ($r = mysqli_store_result($db)) mysqli_free_result($r);
        }
    }

    // ── Step 4: reciprocal endorsements ──────────────────────────────────────
    $reciprocalType = null;
    if ($postType === 'Because')   $reciprocalType = 'Therefore';
    elseif ($postType === 'Therefore') $reciprocalType = 'Because';

    if ($reciprocalType !== null) {
        $safeRecipType = mysqli_real_escape_string($db, $reciprocalType);
        foreach ($allWeighted as $w) {
            if (!empty($w['reciprocate'])) {
                mysqli_query($db,
                    "CALL useInstead(\"$safeRecipType\", " . $w['argID'] . ", $postArgID, $profileID)"
                );
                while (mysqli_more_results($db)) {
                    mysqli_next_result($db);
                    if ($r = mysqli_store_result($db)) mysqli_free_result($r);
                }
            }
        }
    }

    // ── Step 5: queue new arguments for bot seeding ──────────────────────────
    // Uses the normalized weight from $allWeighted so the threshold check in
    // the queue processor reflects what the user actually assigned.
    if (!empty($newArgIDs)) {
        $safeEndorseType = mysqli_real_escape_string($db, $postType);
        foreach ($allWeighted as $w) {
            if (in_array($w['argID'], $newArgIDs)) {
                mysqli_query($db,
                    "INSERT INTO BOT_SEED_QUEUE
                         (argumentID, createdBy, parentArgID, parentWeight, endorseType)
                     VALUES ({$w['argID']}, $profileID, $postArgID, {$w['weight']}, '$safeEndorseType')"
                );
            }
        }
    }

    mysqli_close($db);
    header('Location: /?arg=' . $postArgID);
    exit;
}
// ── End POST handler ──────────────────────────────────────────────────────────

// ── GET: fetch focal phrasing ─────────────────────────────────────────────────
$focalPhrasing = '';
$row = mysqli_fetch_row(mysqli_query($db,
    "SELECT COALESCE(currentPhrasing,
            (SELECT phrasing FROM PHRASING
             WHERE argumentID = $argID ORDER BY createdDate ASC LIMIT 1))
     FROM ARGUMENT WHERE argumentID = $argID"
));
if ($row) $focalPhrasing = $row[0];

// ── GET: fetch neighborhood ───────────────────────────────────────────────────
$results = [];
$safeType = mysqli_real_escape_string($db, $type);
$sql = "CALL getNeighborhood($argID, '$safeType')";
if (mysqli_multi_query($db, $sql)) {
    $result = mysqli_store_result($db);
    if ($result && mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_row($result)) {
            $results[] = [$row[0], $row[1], $row[2]]; // [argID, score, phrasing]
        }
    }
    if ($result) mysqli_free_result($result);
    while (mysqli_more_results($db)) {
        mysqli_next_result($db);
        if ($r = mysqli_store_result($db)) mysqli_free_result($r);
    }
}

mysqli_close($db);

$typeClass    = 'flesh-' . strtolower($type);
$showRecipCol = ($type !== 'Rebuttal');
$typeLabel    = htmlspecialchars($type);
$argIDEsc     = $argID;
$baseURL      = '/';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Flesh Out – <?php echo $typeLabel; ?></title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>"/>
    <script language="javascript" src="script_vestigette.js?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/script_vestigette.js'); ?>"></script>
</head>
<body class="flesh-out-page">

<div id="mastHead" class="container">
    <h1><a href="/?arg=<?php echo $argIDEsc; ?>">AGITATE</a></h1>
    <div>
        <a href="About.php?arg=<?php echo $argIDEsc; ?>">About</a>
        <a href="Explore.php?arg=<?php echo $argIDEsc; ?>">Explore</a>
        <a href="Profile.php?arg=<?php echo $argIDEsc; ?>">Profile</a>
        <a href="#" class="closenav" onclick="closeNav()">&times;</a>
    </div>
    <a href="#" class="opennav" onclick="openNav()">&equiv;</a>
</div>

<div id="flesh-out" class="container <?php echo $typeClass; ?>">

    <div class="flesh-header">
        <div class="flesh-header-text">
            <h2><?php echo htmlspecialchars($focalPhrasing); ?> <span class="flesh-type-suffix"><?php echo $typeLabel; ?>…</span></h2>
        </div>
        <a href="/?arg=<?php echo $argIDEsc; ?>" class="button flesh-cancel">Cancel</a>
    </div>

<?php if ($showRecipCol): ?>
    <div class="flesh-col-labels">
        <span class="flesh-col-weight">Weight</span>
        <span class="flesh-col-phrasing">Assertion</span>
        <span class="flesh-col-recip">Reciprocate</span>
    </div>
<?php else: ?>
    <div class="flesh-col-labels">
        <span class="flesh-col-weight">Weight</span>
        <span class="flesh-col-phrasing">Assertion</span>
    </div>
<?php endif; ?>

    <div class="flesh-list">

        <!-- ── New argument rows ──────────────────────────────── -->
        <div id="new-arg-zone">
            <div class="flesh-row lineItem pct0_0 half1" id="flesh-new-0">
                <div class="wrapper"
                     onclick="if(inCircle(event,this)) fleshBumpNew(0)"
                     oncontextmenu="fleshUnpinNew(0);return false;">
                    <div class="pointBtn arc1"></div>
                    <div class="pointBtn arc2"></div>
                </div>
                <div class="flesh-text-col">
                    <span class="inLinePct"></span>
                    <input type="text" class="new-arg-text" placeholder="Type a new argument…">
                </div>
<?php if ($showRecipCol): ?>
                <label class="switch flesh-reciprocate" title="Reciprocate">
                    <input type="checkbox" class="reciprocate-toggle" checked>
                    <span class="toggle round"></span>
                </label>
<?php endif; ?>
            </div>
        </div>

        <!-- ── Pinned existing args jump here ────────────────── -->
        <div id="pinned-zone"></div>

        <!-- ── Full neighbourhood list ───────────────────────── -->
<?php foreach ($results as $item): ?>
        <div class="flesh-row lineItem pct0_0 half1"
             id="flesh-ex-<?php echo $item[0]; ?>"
             data-arg-id="<?php echo $item[0]; ?>">
            <div class="wrapper"
                 onclick="if(inCircle(event,this)) fleshBumpExisting(<?php echo $item[0]; ?>)"
                 oncontextmenu="fleshUnpinExisting(<?php echo $item[0]; ?>);return false;">
                <div class="pointBtn arc1"></div>
                <div class="pointBtn arc2"></div>
            </div>
            <p class="assocArg">
                <span class="inLinePct"></span>
                <a href="<?php echo $baseURL; ?>?arg=<?php echo $item[0]; ?>">
                    <?php echo htmlspecialchars($item[2]); ?>
                </a>
            </p>
<?php if ($showRecipCol): ?>
            <label class="switch flesh-reciprocate" title="Reciprocate">
                <input type="checkbox" class="reciprocate-toggle" checked>
                <span class="toggle round"></span>
            </label>
<?php endif; ?>
        </div>
<?php endforeach; ?>

    </div><!-- .flesh-list -->

    <div class="flesh-footer">
        <form method="POST"
              action="/flesh_out.php?arg=<?php echo $argIDEsc; ?>&amp;type=<?php echo urlencode($type); ?>"
              id="flesh-form"
              onsubmit="return fleshSerialize()">
            <input type="hidden" name="csrfToken" value="<?php echo $csrfToken; ?>"/>
            <input type="hidden" name="type"      value="<?php echo $typeLabel; ?>"/>
            <input type="hidden" name="argID"     value="<?php echo $argIDEsc; ?>"/>
            <input type="hidden" name="pinnedData" id="pinnedData" value=""/>
            <button type="submit" class="button flesh-submit" id="flesh-submit" disabled>
                Endorse
            </button>
        </form>
    </div>

</div><!-- #flesh-out -->

<script>
// ── flesh_out.php inline JS ───────────────────────────────────────────────────

// inCircle is defined inside init() in script_vestigette.js and is not global.
// Redefine it here so inline onclick handlers can call it.
function inCircle(evt, el) {
    var rect    = el.getBoundingClientRect();
    var radius  = (rect.right - rect.left) / 2;
    var centerX = rect.left + radius;
    var centerY = rect.top  + radius;
    var d = Math.sqrt(Math.pow(evt.clientX - centerX, 2) +
                      Math.pow(evt.clientY - centerY, 2));
    return d < radius;
}

var fleshPool        = [];   // [{id: 'new-0'|'ex-123', clicks: N}]
var fleshTotalClicks = 0;
var fleshNewCounter  = 0;    // index of the next new-arg slot to create
var showRecipCol     = <?php echo $showRecipCol ? 'true' : 'false'; ?>;

// ── Core weight helpers ───────────────────────────────────────────────────────

function fleshGetPct(id) {
    if (fleshTotalClicks === 0) return 0;
    var item = fleshPool.find(function(x) { return x.id === id; });
    return item ? (item.clicks / fleshTotalClicks) * 100 : 0;
}

function fleshPctClass(pct) {
    var whole = Math.floor(pct);
    var dec   = Math.round((pct - whole) * 10);
    return 'pct' + whole + '_' + dec;
}

function fleshUpdateAll() {
    fleshPool.forEach(function(item) {
        var el = document.getElementById('flesh-' + item.id);
        if (!el) return;
        var pct  = fleshGetPct(item.id);
        var half = pct > 50 ? 'half2' : 'half1';

        // Remove old pct/half classes
        el.className = el.className
            .replace(/pct\d+_\d+/g, '')
            .replace(/half\d/g, '')
            .replace(/\s+/g, ' ')
            .trim();
        el.classList.add(fleshPctClass(pct), half);

        var span = el.querySelector('.inLinePct');
        if (span) span.textContent = pct.toFixed(2) + '% – ';
    });

    // Also zero out anything in the pool that's lost clicks (shouldn't happen
    // but be safe)

    document.getElementById('flesh-submit').disabled = (fleshPool.length === 0);
}

// ── Existing-arg handlers ─────────────────────────────────────────────────────

function fleshBumpExisting(argID) {
    var id   = 'ex-' + argID;
    var item = fleshPool.find(function(x) { return x.id === id; });

    if (!item) {
        // First click: animate then move row to pinned zone
        var row        = document.getElementById('flesh-' + id);
        var pinnedZone = document.getElementById('pinned-zone');
        row.classList.add('departing');
        row.addEventListener('animationend', function() {
            row.classList.remove('departing');
            pinnedZone.appendChild(row);
            fleshPool.push({id: id, clicks: 1});
            fleshTotalClicks++;
            fleshUpdateAll();
        }, { once: true });
        return;
    } else {
        item.clicks++;
    }
    fleshTotalClicks++;
    fleshUpdateAll();
}

function fleshUnpinExisting(argID) {
    var id  = 'ex-' + argID;
    var idx = fleshPool.findIndex(function(x) { return x.id === id; });
    if (idx === -1) return;

    fleshTotalClicks -= fleshPool[idx].clicks;
    fleshPool.splice(idx, 1);

    // Return row to top of arg pool (below the pinned zone)
    var row     = document.getElementById('flesh-' + id);
    var argPool = document.getElementById('pinned-zone').nextElementSibling;
    if (argPool) {
        argPool.parentNode.insertBefore(row, argPool);
    }

    // Reset visual state
    row.className = row.className
        .replace(/pct\d+_\d+/g, '')
        .replace(/half\d/g, '')
        .replace(/\s+/g, ' ')
        .trim();
    row.classList.add('pct0_0', 'half1');
    var span = row.querySelector('.inLinePct');
    if (span) span.textContent = '';

    fleshUpdateAll();
}

// ── New-arg handlers ──────────────────────────────────────────────────────────

function fleshBumpNew(n) {
    var id   = 'new-' + n;
    var item = fleshPool.find(function(x) { return x.id === id; });

    if (!item) {
        // Suggestion already showing for this row — don't stack another
        if (document.getElementById('similar-' + n)) return;

        var row  = document.getElementById('flesh-new-' + n);
        var text = row ? row.querySelector('.new-arg-text').value.trim() : '';

        if (text.length >= 10) {
            if (similarCache[n] === null) { fleshAwaitSuggestion(n); return; }
            if (similarCache[n] && similarCache[n].length > 0) {
                fleshShowSuggestion(n, similarCache[n]); return;
            }
        }
        fleshDoPinNew(n);
    } else {
        item.clicks++;
        fleshTotalClicks++;
        fleshUpdateAll();
    }
}

function fleshDoPinNew(n) {
    var id = 'new-' + n;
    fleshPool.push({id: id, clicks: 1});
    fleshNewCounter++;
    fleshAddNewRow(fleshNewCounter, document.getElementById('flesh-new-' + n));
    fleshTotalClicks++;
    fleshUpdateAll();
}

function fleshUnpinNew(n) {
    var id  = 'new-' + n;
    var idx = fleshPool.findIndex(function(x) { return x.id === id; });
    if (idx === -1) return;   // Not yet pinned — nothing to undo

    fleshTotalClicks -= fleshPool[idx].clicks;
    fleshPool.splice(idx, 1);

    // Reset visual state (row stays in place)
    var row = document.getElementById('flesh-' + id);
    row.className = row.className
        .replace(/pct\d+_\d+/g, '')
        .replace(/half\d/g, '')
        .replace(/\s+/g, ' ')
        .trim();
    row.classList.add('pct0_0', 'half1');
    var span = row.querySelector('.inLinePct');
    if (span) span.textContent = '';

    fleshUpdateAll();
}

function fleshAddNewRow(n, beforeEl) {
    var recipHtml = showRecipCol
        ? '<label class="switch flesh-reciprocate" title="Reciprocate">'
        + '<input type="checkbox" class="reciprocate-toggle" checked>'
        + '<span class="toggle round"></span></label>'
        : '';

    var row       = document.createElement('div');
    row.className = 'flesh-row lineItem pct0_0 half1';
    row.id        = 'flesh-new-' + n;
    row.innerHTML =
        '<div class="wrapper"'
        + ' onclick="if(inCircle(event,this)) fleshBumpNew(' + n + ')"'
        + ' oncontextmenu="fleshUnpinNew(' + n + ');return false;">'
        + '<div class="pointBtn arc1"></div>'
        + '<div class="pointBtn arc2"></div>'
        + '</div>'
        + '<div class="flesh-text-col">'
        + '<span class="inLinePct"></span>'
        + '<input type="text" class="new-arg-text" placeholder="Type a new argument…">'
        + '</div>'
        + recipHtml;

    beforeEl.parentNode.insertBefore(row, beforeEl);
}

// ── Serialise & submit ────────────────────────────────────────────────────────

function fleshSerialize() {
    if (fleshPool.length === 0) return false;

    var total      = fleshTotalClicks;
    var items      = [];
    var runningSum = 0;
    var last       = fleshPool.length - 1;

    fleshPool.forEach(function(poolItem, i) {
        var weight = (i === last)
            ? parseFloat((100 - runningSum).toFixed(5))
            : parseFloat(((poolItem.clicks / total) * 100).toFixed(5));
        if (i !== last) runningSum += weight;

        if (poolItem.id.indexOf('new-') === 0) {
            var n       = poolItem.id.replace('new-', '');
            var row     = document.getElementById('flesh-new-' + n);
            var text    = row ? row.querySelector('.new-arg-text').value.trim() : '';
            var toggle  = row ? row.querySelector('.reciprocate-toggle') : null;
            var recip   = toggle ? toggle.checked : false;
            items.push({type: 'new', text: text, weight: weight, reciprocate: recip});
        } else {
            var argID  = parseInt(poolItem.id.replace('ex-', ''), 10);
            var exRow  = document.getElementById('flesh-ex-' + argID);
            var exTog  = exRow ? exRow.querySelector('.reciprocate-toggle') : null;
            var exRec  = exTog ? exTog.checked : false;
            items.push({type: 'existing', argID: argID, weight: weight, reciprocate: exRec});
        }
    });

    document.getElementById('pinnedData').value = JSON.stringify(items);
    return true;
}

// ── Duplicate detection ───────────────────────────────────────────────────────

var similarCache  = {}; // n → null (in-flight) | [] (no results) | [{argID, phrasing}, …]
var similarFlight = {}; // n → XHR (to cancel on re-type)

function escapeHtml(str) {
    var d = document.createElement('div');
    d.appendChild(document.createTextNode(str || ''));
    return d.innerHTML;
}

// Prefetch on blur so results are ready before the user clicks the circle
document.getElementById('new-arg-zone').addEventListener('focusout', function(e) {
    if (!e.target.classList.contains('new-arg-text')) return;
    var row = e.target;
    while (row && !row.classList.contains('flesh-row')) row = row.parentNode;
    if (!row) return;
    var n    = parseInt(row.id.replace('flesh-new-', ''), 10);
    var text = e.target.value.trim();

    if (text.length < 10) { similarCache[n] = []; return; }
    if (similarFlight[n]) { similarFlight[n].abort(); delete similarFlight[n]; }

    similarCache[n] = null; // mark in-flight
    var xhr = new XMLHttpRequest();
    similarFlight[n] = xhr;
    xhr.open('POST', '/find_similar.php', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function() {
        try { similarCache[n] = xhr.status === 200 ? JSON.parse(xhr.responseText) : []; }
        catch (err) { similarCache[n] = []; }
        delete similarFlight[n];
    };
    xhr.onerror = function() { similarCache[n] = []; delete similarFlight[n]; };
    xhr.send('q=' + encodeURIComponent(text) + '&arg=<?php echo $argIDEsc; ?>');
});

function fleshShowSuggestion(n, matches) {
    fleshClearSuggestion(n);
    var row = document.getElementById('flesh-new-' + n);
    if (!row) return;

    var panel = document.createElement('div');
    panel.className = 'similar-suggestion';
    panel.id = 'similar-' + n;

    var listHtml = '<ul class="similar-matches">';
    matches.forEach(function(match) {
        listHtml += '<li class="similar-match">'
            + '<span class="similar-phrasing">' + escapeHtml(match.phrasing) + '</span>'
            + '<button type="button" class="similar-use">Use this</button>'
            + '</li>';
    });
    listHtml += '</ul>';

    panel.innerHTML =
        '<div class="similar-header">'
        + '<span class="similar-label">Existing similar arguments</span>'
        + '<button type="button" class="similar-keep">Keep mine</button>'
        + '<button type="button" class="similar-cancel">Try again</button>'
        + '</div>'
        + listHtml;

    panel.querySelectorAll('.similar-use').forEach(function(btn, i) {
        btn.addEventListener('click', function() {
            fleshUseSuggestion(n, matches[i].argID, matches[i].phrasing);
        });
    });
    panel.querySelector('.similar-keep').addEventListener('click', function() {
        fleshDismissSuggestion(n);
    });
    panel.querySelector('.similar-cancel').addEventListener('click', function() {
        fleshCancelNew(n);
    });

    row.parentNode.insertBefore(panel, row.nextSibling);
}

function fleshClearSuggestion(n) {
    var panel = document.getElementById('similar-' + n);
    if (panel) panel.parentNode.removeChild(panel);
}

function fleshDismissSuggestion(n) {
    fleshClearSuggestion(n);
    fleshDoPinNew(n);
}

function fleshCancelNew(n) {
    fleshClearSuggestion(n);
    similarCache[n] = [];
    var row = document.getElementById('flesh-new-' + n);
    if (row) {
        var input = row.querySelector('.new-arg-text');
        if (input) { input.value = ''; input.focus(); }
    }
}

function fleshUseSuggestion(n, argID, phrasing) {
    fleshClearSuggestion(n);
    // Clear the typed text so the input row resets cleanly for new entries
    var srcRow = document.getElementById('flesh-new-' + n);
    if (srcRow) {
        var input = srcRow.querySelector('.new-arg-text');
        if (input) input.value = '';
    }
    similarCache[n] = [];
    // If this arg isn't in the neighbourhood list, create a row for it so
    // fleshBumpExisting can find and move it to the pinned zone
    if (!document.getElementById('flesh-ex-' + argID)) {
        var recip = showRecipCol
            ? '<label class="switch flesh-reciprocate" title="Reciprocate">'
            + '<input type="checkbox" class="reciprocate-toggle" checked>'
            + '<span class="toggle round"></span></label>'
            : '';
        var exRow = document.createElement('div');
        exRow.className = 'flesh-row lineItem pct0_0 half1';
        exRow.id = 'flesh-ex-' + argID;
        exRow.setAttribute('data-arg-id', String(argID));
        exRow.innerHTML =
            '<div class="wrapper"'
            + ' onclick="if(inCircle(event,this)) fleshBumpExisting(' + argID + ')"'
            + ' oncontextmenu="fleshUnpinExisting(' + argID + ');return false;">'
            + '<div class="pointBtn arc1"></div><div class="pointBtn arc2"></div></div>'
            + '<p class="assocArg"><span class="inLinePct"></span>'
            + '<a href="/?arg=' + argID + '">' + escapeHtml(phrasing) + '</a></p>'
            + recip;
        document.querySelector('.flesh-list').appendChild(exRow);
    }
    fleshBumpExisting(argID);
}

function fleshAwaitSuggestion(n) {
    var row = document.getElementById('flesh-new-' + n);
    if (row) row.classList.add('similar-loading');
    var checks = 0;
    var poll = setInterval(function() {
        checks++;
        if (similarCache[n] !== null || checks > 40) {
            clearInterval(poll);
            if (row) row.classList.remove('similar-loading');
            if (similarCache[n] && similarCache[n].length > 0) {
                fleshShowSuggestion(n, similarCache[n]);
            } else {
                similarCache[n] = [];
                fleshDoPinNew(n);
            }
        }
    }, 50);
}
</script>

</body>
</html>
