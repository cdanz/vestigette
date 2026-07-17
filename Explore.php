<?php
session_start();

if (!empty($_POST['buttonClicked']) && $_POST['buttonClicked'] === 'jumpTo') {
    $dest = intval($_POST['jumpTo'] ?? 0);
    if ($dest > 0) {
        header('Location: /?arg=' . $dest);
        exit;
    }
}

include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

$_SESSION['currentArg'] = intval($_GET['arg'] ?? 0);
$arg     = $_SESSION['currentArg'];
$profile = $_SESSION['profile'] ?? null;

// Trending
$trending = [];
$res = mysqli_query($db, 'CALL getTrending()');
if ($res) {
    while ($row = mysqli_fetch_assoc($res)) { $trending[] = $row; }
    mysqli_free_result($res);
    while (mysqli_more_results($db)) { mysqli_next_result($db); }
}

// Most Contested
$contested = [];
$res = mysqli_query($db, 'CALL getMostContested()');
if ($res) {
    while ($row = mysqli_fetch_assoc($res)) { $contested[] = $row; }
    mysqli_free_result($res);
    while (mysqli_more_results($db)) { mysqli_next_result($db); }
}

$activeGroupName = '';
if ($profile) {
    $realPID = intval($_SESSION['realProfile'] ?? $_SESSION['profile'] ?? 0);
    if ($realPID > 0) {
        $agRow = mysqli_fetch_row(mysqli_query($db,
            "SELECT a.orgName FROM USER_PROFILE up
             JOIN AFFILIATION a ON a.affiliationID = up.activeAffiliationID
             WHERE up.profileID = $realPID
             AND up.activeAffiliationID != " . ALL_PUBLIC_AFF_ID . " LIMIT 1"));
        if ($agRow) $activeGroupName = $agRow[0];
    }
}
mysqli_close($db);

$entryPoints = [
    ['Abortion',                      '/?arg=124'],
    ['Black Lives Matter',             '/?arg=546'],
    ['Cancel Culture',                 '/?arg=288'],
    ['Capitalism as a System',         '/?arg=136'],
    ['Catholic Church Abuse',          '/?arg=983'],
    ['Christianity &amp; Faith',       '/?arg=1385'],
    ['Climate Change',                 '/?arg=123'],
    ['Conspiracy Theories',            '/?arg=1714'],
    ['COVID Mandates',                 '/?arg=1396'],
    ['Cryptocurrency',                 '/?arg=808'],
    ['Environmental Policy',           '/?arg=757'],
    ['Gender &amp; Trans Rights',      '/?arg=791'],
    ['GMO Crops',                      '/?arg=5'],
    ['Government &amp; Free Markets',  '/?arg=400'],
    ['Gun Rights',                     '/?arg=140'],
    ['Housing &amp; Homelessness',     '/?arg=682'],
    ['Immigration Policy',             '/?arg=612'],
    ['Informal Debates',               '/?arg=58'],
    ['Israel &amp; Palestine',         '/?arg=1627'],
    ['Labor &amp; Unions',             '/?arg=494'],
    ['Media &amp; Social Media',       '/?arg=367'],
    ['Policing in America',            '/?arg=561'],
    ['Pop Culture',                    '/?arg=1016'],
    ['Public Health',                  '/?arg=427'],
    ['Race &amp; Racism',              '/?arg=1192'],
    ['Republican Politics &amp; Trump','/?arg=120'],
    ['Sports &amp; Athletics',         '/?arg=883'],
    ['The Supreme Court',              '/?arg=1443'],
    ['Voting Rights',                  '/?arg=182'],
    ['War &amp; Military',             '/?arg=1479'],
    ['Wealth &amp; Taxation',          '/?arg=265'],
];
?>
<!DOCTYPE html>
<html>
<head>
    <title>Agitate – Explore</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="robots" content="follow"/>
    <link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>"/>
    <script src="script_vestigette.js?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/script_vestigette.js'); ?>"></script>
    <script>
        let arg     = <?php echo $arg     ?? 'undefined'; ?>,
            profile = <?php echo $profile ?? 'undefined'; ?>,
            opinion = undefined, because = null, therefore = null, rebuttal = null;
    </script>
</head>
<body class="content-page">

<div id="mastHead" class="container">
    <h1><a href="/?arg=<?php echo $arg; ?>">AGITATE<span class="exclaim">!</span></a></h1>
    <?php if ($profile && $activeGroupName !== ''): ?>
    <a href="/Profile.php?arg=<?php echo intval($arg); ?>" class="group-badge" title="<?php echo htmlspecialchars($activeGroupName); ?>"><?php echo htmlspecialchars($activeGroupName); ?></a>
    <?php endif; ?>
    <div>
        <a href="About.php?arg=<?php echo $arg; ?>">About</a>
        <a href="Explore.php?arg=<?php echo $arg; ?>" style="text-decoration:underline;">Explore</a>
        <a href="Profile.php?arg=<?php echo $arg; ?>">Profile</a>
        <a href="<?php echo $profile ? 'logout' : 'login'; ?>.php?arg=<?php echo $arg; ?>"><?php echo $profile ? 'Logout' : 'Login'; ?></a>
        <a href="#" class="closenav" onclick="closeNav()">&times;</a>
    </div>
    <a href="/donate.php" class="donate-btn">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="14" height="14" aria-hidden="true"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
        Donate
    </a>
    <a href="#" class="opennav" onclick="openNav()">&equiv;</a>
</div>

<main class="explore-main">

    <!-- ── Common Entry Points ─────────────────────────────────────────────── -->
    <div class="accordion container explore-section">
        <h2>Common Entry Points</h2>
        <div class="panel">
            <ul class="explore-entry-grid">
            <?php foreach ($entryPoints as $entry): ?>
                <li><a href="<?php echo $entry[1]; ?>"><?php echo $entry[0]; ?></a></li>
            <?php endforeach; ?>
            </ul>
        </div>
    </div>

    <!-- ── Trending ────────────────────────────────────────────────────── -->
        <div class="accordion container explore-section">
            <h2>Trending</h2>
            <div class="panel">
                <?php if (empty($trending)): ?>
                    <p style="color:var(--cddbGrey);font-size:0.9rem;">No recent activity yet.</p>
                <?php else: ?>
                    <ul class="explore-list">
                    <?php foreach ($trending as $row): ?>
                        <li class="explore-item">
                            <a href="/?arg=<?php echo intval($row['argumentID']); ?>">
                                <?php echo htmlspecialchars($row['phrased'] ?? '(untitled)'); ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                    </ul>
                <?php endif; ?>
            </div>
        </div>

        <!-- ── Most Contested ──────────────────────────────────────────────── -->
        <div class="accordion container explore-section">
            <h2>Most Contested</h2>
            <div class="panel">
                <?php if (empty($contested)): ?>
                    <p style="color:var(--cddbGrey);font-size:0.9rem;">Not enough votes yet.</p>
                <?php else: ?>
                    <ul class="explore-list">
                    <?php foreach ($contested as $row):
                        $total  = intval($row['total_votes']);
                        $accept = intval($row['accept_count']);
                        $reject = $total - $accept;
                    ?>
                        <li class="explore-item">
                            <a href="/?arg=<?php echo intval($row['argumentID']); ?>">
                                <?php echo htmlspecialchars($row['phrased'] ?? '(untitled)'); ?>
                            </a>
                            <div class="explore-item-meta"><?php echo $accept; ?> accept &middot; <?php echo $reject; ?> reject</div>
                        </li>
                    <?php endforeach; ?>
                    </ul>
                <?php endif; ?>
            </div>
        </div>

    <!-- ── Search ──────────────────────────────────────────────────────────── -->
    <div class="accordion container explore-section">
        <h2>Search</h2>
        <div class="panel">
            <input type="search" class="explore-search-input" placeholder="Search arguments…" autocomplete="off" oninput="exploreSearch(this.value)">
            <ul class="explore-list" id="explore-search-results"></ul>
        </div>
    </div>

    <!-- ── Jump to Argument ID ─────────────────────────────────────────────── -->
    <div class="accordion container explore-section">
        <h2>Go to Argument</h2>
        <div class="panel">
            <form class="explore-jump" method="POST">
                <input type="text" name="jumpTo" placeholder="Argument ID" inputmode="numeric" pattern="[0-9]*">
                <button type="submit" name="buttonClicked" value="jumpTo">Go</button>
            </form>
        </div>
    </div>

    <p style="color:var(--cddbGrey);font-size:0.85rem;padding:0 1rem;">As you explore, some arguments carry a &#x1F916; badge — AI Seed Users scaffolded them while human engagement was still thin. The rules they follow are in the <a href="/ai-policy-pledge" style="text-decoration:underline;">AI Policy and Pledge</a>; all 26 are described in the <a href="/seed-user-roster" style="text-decoration:underline;">Seed User Roster</a>.</p>

</main>

<script>
(function() {
    var _timer = null;
    window.exploreSearch = function(q) {
        clearTimeout(_timer);
        var out = document.getElementById('explore-search-results');
        if (!out) return;
        q = q.trim();
        if (q.length < 3) { out.innerHTML = ''; return; }
        _timer = setTimeout(function() {
            var fd = new FormData();
            fd.append('q', q);
            fd.append('mode', 'explore');
            fetch('/find_similar.php', { method: 'POST', body: fd })
                .then(function(r) { return r.json(); })
                .then(function(matches) {
                    out.innerHTML = '';
                    if (!matches.length) {
                        var li = document.createElement('li');
                        li.className = 'explore-search-empty';
                        li.textContent = 'No matches found.';
                        out.appendChild(li);
                        return;
                    }
                    matches.forEach(function(m) {
                        var li = document.createElement('li');
                        li.className = 'explore-item';
                        var a = document.createElement('a');
                        a.href = '/?arg=' + m.argID;
                        a.textContent = m.phrasing || '(untitled)';
                        li.appendChild(a);
                        out.appendChild(li);
                    });
                });
        }, 300);
    };
}());
</script>
</body>
</html>
