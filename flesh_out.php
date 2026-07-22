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
            mysqli_query($db, "INSERT IGNORE INTO SCOPE_PHRASE_ENDORSE (profileID, argumentID, affiliationID) VALUES ($profileID, $freshArgID, @active_aff_id)");

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
    $query .= "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES($profileID, $postArgID, @active_aff_id);";
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
                mysqli_query($db, "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES ($profileID, " . $w['argID'] . ", @active_aff_id)");
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

$dmRow = mysqli_fetch_assoc(mysqli_query($db,
    "SELECT demoMode FROM ADMIN_SETTINGS WHERE demoMode = 1 LIMIT 1"));
$demoMode = $dmRow && intval($dmRow['demoMode']) === 1;

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
    <title><?php echo htmlspecialchars($focalPhrasing); ?> – Agitate</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0<?php if ($demoMode) echo ', interactive-widget=resizes-content'; ?>"/>
    <link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>"/>
    <script language="javascript" src="script_vestigette.js?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/script_vestigette.js'); ?>"></script>
    <script>var demoMode = <?php echo $demoMode ? 'true' : 'false'; ?>;</script>
</head>
<body class="flesh-out-page weigh-page<?php if ($demoMode) echo ' demo-mode'; ?>">

<div id="mastHead" class="container">
    <h1><a href="/?arg=<?php echo $argIDEsc; ?>">AGITATE<span class="exclaim">!</span></a></h1>
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

    <div class="flesh-col-labels">
        <span class="flesh-col-weight">Weight</span>
        <span class="flesh-col-phrasing">Assertion</span>
    </div>

    <div class="flesh-list">

        <!-- ── New argument rows ──────────────────────────────── -->
        <div id="new-arg-zone">
            <div class="flesh-row lineItem pct0_0 half1" id="flesh-new-0">
                <div class="wrapper">
                    <span class="glyph"></span>
                    <span class="val">0%</span>
                </div>
                <div class="flesh-text-col">
                    <textarea class="new-arg-text" placeholder="Type a new argument…" rows="1"></textarea>
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
        <div id="pinned-zone">
            <div class="pinned-label hidden">
                <span>Weighted</span>
<?php if ($showRecipCol): ?>
                <span class="pinned-label-recip">Reciprocate</span>
<?php endif; ?>
            </div>
        </div>

        <div class="available-label" id="available-label">Available</div>
        <!-- ── Full neighbourhood list ───────────────────────── -->
<?php foreach ($results as $item): ?>
        <div class="flesh-row lineItem pct0_0 half1"
             id="flesh-ex-<?php echo $item[0]; ?>"
             data-arg-id="<?php echo $item[0]; ?>">
            <div class="wrapper">
                <span class="glyph"></span>
                <span class="val">0%</span>
            </div>
            <p class="assocArg"><?php echo htmlspecialchars($item[2]); ?></p>
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
        <div class="flesh-footer-left">
            <button type="button" class="button flesh-reset hidden" id="flesh-reset"
                    onclick="fleshReset()" title="Reset">&#x21BA;</button>
            <button type="button" class="button flesh-myweights hidden" id="flesh-myweights"
                    onclick="fleshLoadMyWeights()" title="Load my previous weights">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18" height="18" aria-hidden="true">
                    <circle cx="12" cy="8" r="4"/>
                    <path d="M4 20c0-3.866 3.582-7 8-7s8 3.134 8 7" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </button>
        </div>
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
var fleshStoredWeights = {}; // argID → past-endorsement pct, loaded from sessionStorage context
var fleshArgID       = <?php echo $argIDEsc; ?>;
var fleshType        = '<?php echo $typeLabel; ?>';

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
        var pct = fleshGetPct(item.id);
        el.style.setProperty('--pct', pct.toFixed(2));
        var val = el.querySelector('.val');
        if (val) val.textContent = Math.round(pct) + '%';
    });

    // Also zero out anything in the pool that's lost clicks (shouldn't happen
    // but be safe)

    document.getElementById('flesh-submit').disabled = (fleshPool.length === 0);

    var resetBtn = document.getElementById('flesh-reset');
    var myWtsBtn = document.getElementById('flesh-myweights');
    if (resetBtn) resetBtn.classList.toggle('hidden', fleshPool.length === 0);
    if (myWtsBtn) myWtsBtn.classList.toggle('hidden', Object.keys(fleshStoredWeights).length === 0);

    var pinnedLabel = document.querySelector('.pinned-label');
    var availLabel  = document.getElementById('available-label');
    var pinnedZone  = document.getElementById('pinned-zone');
    // Only show "Weighted" header when existing args have been moved into
    // pinned-zone. New typed args stay in new-arg-zone, so pinned-zone can
    // have items in fleshPool without having any .flesh-row children — in
    // that state the two consecutive grey bars ("Weighted" + "Available")
    // merged into a confusing double-height block.
    var hasPinnedRows = pinnedZone
        ? pinnedZone.querySelectorAll('.flesh-row').length > 0
        : false;
    if (pinnedLabel) {
        if (hasPinnedRows) {
            pinnedLabel.classList.remove('hidden');
        } else {
            pinnedLabel.classList.add('hidden');
        }
    }
    if (availLabel) {
        if (fleshPool.length > 0) {
            availLabel.classList.add('shown');
        } else {
            availLabel.classList.remove('shown');
        }
    }
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
            var nc = floorClicksForNew(fleshTotalClicks); // >= 1% of the resulting total
            fleshPool.push({id: id, clicks: nc});
            fleshTotalClicks += nc;
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

var similarAwaiting = {}; // n → true while a fleshAwaitSuggestion poll is already running

function fleshBumpNew(n) {
    var id   = 'new-' + n;
    var item = fleshPool.find(function(x) { return x.id === id; });

    if (!item) {
        // Suggestion already showing for this row — don't stack another
        if (document.getElementById('similar-' + n)) return;
        // Already waiting on the similarity check for this row — rapid
        // re-clicks while the request is in flight used to start a second
        // poll, which could pin the row (and add its follow-up empty row) twice
        if (similarAwaiting[n]) return;

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
    // Defensive: never double-pin the same row (e.g. if a stray duplicate
    // call slips through) — a second push would silently double-count its
    // clicks in fleshTotalClicks while fleshPool.find() only ever surfaces
    // the first entry, making the row's own weight look stuck.
    if (fleshPool.some(function(x) { return x.id === id; })) return;
    var nc = floorClicksForNew(fleshTotalClicks); // >= 1% of the resulting total
    fleshPool.push({id: id, clicks: nc});
    fleshTotalClicks += nc;
    fleshNewCounter++;
    var pinnedRow = document.getElementById('flesh-new-' + n);
    // Leave a fresh empty row up top (inserted before the one we're committing).
    fleshAddNewRow(fleshNewCounter, pinnedRow);
    // Move the just-coined argument down into the Weighted zone, so every
    // weighted item lives together once the user commits to their assertion.
    var pinnedZone = document.getElementById('pinned-zone');
    if (pinnedZone && pinnedRow) pinnedZone.appendChild(pinnedRow);
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
        '<div class="wrapper">'
        + '<span class="glyph"></span>'
        + '<span class="val">0%</span>'
        + '</div>'
        + '<div class="flesh-text-col">'
        + '<textarea class="new-arg-text" placeholder="Type a new argument…" rows="1"></textarea>'
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

// ── New-arg textarea auto-resize ─────────────────────────────────────────────

function autoResizeNewArg(ta) {
    ta.style.height = '0';
    ta.style.height = ta.scrollHeight + 'px';
}

document.getElementById('new-arg-zone').addEventListener('input', function(e) {
    if (e.target.classList.contains('new-arg-text')) autoResizeNewArg(e.target);
});

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
        if (input) { input.value = ''; autoResizeNewArg(input); input.focus(); }
    }
}

function fleshUseSuggestion(n, argID, phrasing) {
    fleshClearSuggestion(n);
    // Clear the typed text so the input row resets cleanly for new entries
    var srcRow = document.getElementById('flesh-new-' + n);
    if (srcRow) {
        var input = srcRow.querySelector('.new-arg-text');
        if (input) { input.value = ''; autoResizeNewArg(input); }
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
            '<div class="wrapper">'
            + '<span class="glyph"></span><span class="val">0%</span></div>'
            + '<p class="assocArg">'
            + '<a href="/?arg=' + argID + '">' + escapeHtml(phrasing) + '</a></p>'
            + recip;
        document.querySelector('.flesh-list').appendChild(exRow);
    }
    fleshBumpExisting(argID);
}

// ── Stored-weight → minimum integer clicks (mirrors index page pctToClicks) ──
// Finds the smallest integer click counts that preserve weight proportions so
// that adding one new item produces a fair starting share rather than ~1%.
// e.g. [100%] → [1 click], [70%,30%] → [7,3], [50%,50%] → [1,1].
function pctToFleshClicks(storedArr) {
    if (!storedArr.length) return [];
    var pcts = storedArr.map(function(s) { return s.pct; });
    var min = Math.min.apply(null, pcts);
    var splitBy = 1, commonMultiplier, isMultiple, number, whole, leftover;
    do {
        commonMultiplier = min / splitBy;
        isMultiple = true;
        for (var i = 0; i < pcts.length; i++) {
            number = pcts[i] / commonMultiplier;
            whole  = Math.round(number);
            leftover = Math.abs(number - whole);
            if (leftover > 0.0001) { isMultiple = false; break; }
        }
        splitBy++;
    } while (!isMultiple && splitBy < 1000);
    return storedArr.map(function(s) {
        return {argID: s.argID, clicks: Math.max(1, Math.round(s.pct / commonMultiplier))};
    });
}

// ── Reset / load-my-weights ───────────────────────────────────────────────────

function fleshReset() {
    var listEl = document.querySelector('.flesh-list');
    var newArgZone = document.getElementById('new-arg-zone');
    fleshPool.forEach(function(item) {
        var row = document.getElementById('flesh-' + item.id);
        if (!row) return;
        row.style.setProperty('--pct', '0');
        var val = row.querySelector('.val');
        if (val) val.textContent = '0%';
        if (item.id.indexOf('ex-') === 0) {
            // neighbourhood rows return to the available pool
            listEl.appendChild(row);
        } else if (item.id.indexOf('new-') === 0 && newArgZone) {
            // coined rows return above the Weighted line, keeping their typed
            // text; pressing them again re-runs the similarity check (their
            // similarCache is untouched) before they re-enter Weighted.
            newArgZone.appendChild(row);
        }
    });
    fleshPool = [];
    fleshTotalClicks = 0;
    fleshUpdateAll();
}

function fleshLoadMyWeights() {
    var keys = Object.keys(fleshStoredWeights);
    if (!keys.length) return;
    fleshReset();
    var pinnedZone = document.getElementById('pinned-zone');
    var storedArr = keys.map(function(k) { return {argID: parseInt(k, 10), pct: fleshStoredWeights[k]}; })
        .sort(function(a, b) { return b.pct - a.pct; });
    pctToFleshClicks(storedArr).forEach(function(item) {
        var row = document.getElementById('flesh-ex-' + item.argID);
        if (!row) return;
        pinnedZone.appendChild(row);
        fleshPool.push({id: 'ex-' + item.argID, clicks: item.clicks});
        fleshTotalClicks += item.clicks;
    });
    fleshUpdateAll();
}

// ── Joystick weighting for pinned args (mirrors the index page) ───────────────
// The first press of an unpinned arg keeps the existing bring-into-the-mix flow
// (fleshBumpExisting animate+pin, or fleshBumpNew similarity modal/pin). Once an
// arg is pinned, a press-and-hold runs the full joystick: accelerate up,
// two-phase reduce down, enlarge/lift. The engine (startHold/stopHold + its
// global pointerup/move listeners) lives in script_vestigette.js.
function fleshReducePinned(item) {
    if (item.clicks > 1) { item.clicks -= 1; fleshTotalClicks -= 1; fleshUpdateAll(); return; }
    var raised = false;
    fleshPool.forEach(function(x) { if (x !== item && x.clicks > 0) { x.clicks += 1; fleshTotalClicks += 1; raised = true; } });
    if (raised) fleshUpdateAll();
}
function fleshSetReceiving(on, activeId) {
    document.querySelectorAll('.flesh-row.receiving').forEach(function(r) { r.classList.remove('receiving'); });
    if (!on) return;
    fleshPool.forEach(function(x) {
        if (x.id === activeId || x.clicks <= 0) return;
        var row = document.getElementById('flesh-' + x.id);
        if (row) row.classList.add('receiving');
    });
}
document.querySelector('.flesh-list').addEventListener('pointerdown', function(e) {
    if (!e.isPrimary) return;
    if (e.pointerType === 'mouse' && e.button !== 0) return;
    var w = e.target.closest('.wrapper');
    if (!w) return;
    var row = w.closest('.flesh-row');
    if (!row) return;
    var id = row.id.replace('flesh-', '');                 // 'new-0' | 'ex-123'
    var item = fleshPool.find(function(x) { return x.id === id; });
    if (!item) {
        // not pinned yet — run the existing first-press flow (may open a modal)
        if (id.indexOf('new-') === 0) {
            // pointerdown fires BEFORE the textarea would blur, so the similarity
            // prefetch (which runs on the textarea's focusout) hasn't started.
            // Blur it now so the "similar existing arguments" check actually fires.
            var ta = row.querySelector('.new-arg-text');
            if (ta && document.activeElement === ta) ta.blur();
            fleshBumpNew(parseInt(id.slice(4), 10));
        } else if (id.indexOf('ex-') === 0) {
            fleshBumpExisting(parseInt(id.slice(3), 10));
        }
        return;
    }
    // already pinned — full joystick
    e.preventDefault();
    try { w.setPointerCapture(e.pointerId); } catch (err) {}
    var up   = function() { item.clicks++; fleshTotalClicks++; fleshUpdateAll(); };
    var down = function() { fleshReducePinned(item); };
    var canReduce = function() { return fleshPool.some(function(x) { return x.id !== id && x.clicks > 0; }); };
    var receiving = function(on) { fleshSetReceiving(on, id); };
    up(); // the press counts as one add (tap = +1)
    startHold({ ring: w, line: row, originY: e.clientY, up: up, down: down, canReduce: canReduce, receiving: receiving });
});

// ── Apply context from index page "More to Say" button ────────────────────────
(function() {
    try {
        var raw = sessionStorage.getItem('fleshOutContext');
        if (!raw) return;
        var ctx = JSON.parse(raw);
        if (ctx.argID !== fleshArgID || ctx.type !== fleshType) return;
        sessionStorage.removeItem('fleshOutContext');

        // Populate stored weights map (used by "Load my weights" button)
        (ctx.stored || []).forEach(function(s) { fleshStoredWeights[s.argID] = s.pct; });

        // Sort available rows: manual-weighted args first (desc clicks),
        // then stored-weighted args (desc pct), then unweighted
        var listEl = document.querySelector('.flesh-list');
        var rows = Array.from(listEl.querySelectorAll(':scope > .flesh-row[data-arg-id]'));
        var manualMap = {};
        (ctx.manual || []).forEach(function(m) { manualMap[m.argID] = m.clicks; });
        rows.sort(function(a, b) {
            var aID = parseInt(a.dataset.argId, 10);
            var bID = parseInt(b.dataset.argId, 10);
            var aC = manualMap[aID] || 0, bC = manualMap[bID] || 0;
            if (aC && !bC) return -1;
            if (!aC && bC) return 1;
            if (aC && bC) return bC - aC;
            return (fleshStoredWeights[bID] || 0) - (fleshStoredWeights[aID] || 0);
        });
        rows.forEach(function(row) { listEl.appendChild(row); });

        // Auto-pin: use manual weights if present, otherwise use stored weights
        var pinnedZone = document.getElementById('pinned-zone');
        var toPinArr;
        if (ctx.manual && ctx.manual.length > 0) {
            toPinArr = ctx.manual.slice().sort(function(a, b) { return b.clicks - a.clicks; });
        } else {
            toPinArr = pctToFleshClicks(
                (ctx.stored || []).slice().sort(function(a, b) { return b.pct - a.pct; })
            );
        }

        toPinArr.forEach(function(m) {
            var row = document.getElementById('flesh-ex-' + m.argID);
            if (!row) return;
            pinnedZone.appendChild(row);
            fleshPool.push({id: 'ex-' + m.argID, clicks: m.clicks});
            fleshTotalClicks += m.clicks;
        });

        fleshUpdateAll();
    } catch (e) {}
})();

function fleshAwaitSuggestion(n) {
    var row = document.getElementById('flesh-new-' + n);
    if (row) row.classList.add('similar-loading');
    similarAwaiting[n] = true;
    var checks = 0;
    var poll = setInterval(function() {
        checks++;
        if (similarCache[n] !== null || checks > 40) {
            clearInterval(poll);
            delete similarAwaiting[n];
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
