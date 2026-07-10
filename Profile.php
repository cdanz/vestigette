<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

$_SESSION['currentArg'] = intval($_GET['arg'] ?? 0);
$arg           = $_SESSION['currentArg'];
$profile       = $_SESSION['profile'] ?? null;
$realProfileID = $profile ? intval($_SESSION['realProfile'] ?? $profile) : null;

// Handle group activation posted from this page
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'switchGroup' && $realProfileID) {
    $newAffID = intval($_POST['affiliationID'] ?? 0);
    if ($newAffID > 0) {
        $chk = $db->prepare("SELECT 1 FROM MEMBER WHERE affiliationID = ? AND profileID = ? LIMIT 1");
        $chk->bind_param("ii", $newAffID, $realProfileID);
        $chk->execute();
        if ($chk->get_result()->fetch_row()) {
            $upd = $db->prepare("UPDATE USER_PROFILE SET activeAffiliationID = ? WHERE profileID = ?");
            $upd->bind_param("ii", $newAffID, $realProfileID);
            $upd->execute();
            $upd->close();
        }
        $chk->close();
    }
    mysqli_close($db);
    header('Location: /Profile.php?arg=' . $arg);
    exit;
}

$stats       = null;
$topPct      = null;
$recent      = [];
$heterodox   = [];
$groups      = [];
$activeGroup = null;
$otherGroups = [];
$activeGroupName = '';

if ($profile) {
    // Opinion summary: total count and accept split
    $stmt = $db->prepare(
        "SELECT COUNT(*) AS total,
                SUM(CASE WHEN acceptance = TRUE THEN 1 ELSE 0 END) AS accepts
         FROM OPINION WHERE profileID = ?"
    );
    $stmt->bind_param('i', $profile);
    $stmt->execute();
    $stats = $stmt->get_result()->fetch_assoc();
    $stmt->close();

    // Percentile rank among human users (profileID > 26)
    if ($stats && $stats['total'] > 0) {
        $myCount = intval($stats['total']);
        $stmt = $db->prepare(
            "SELECT COUNT(*) AS pool,
                    SUM(CASE WHEN cnt < ? THEN 1 ELSE 0 END) AS below
             FROM (
                 SELECT COUNT(*) AS cnt
                 FROM OPINION
                 WHERE profileID > 26
                 GROUP BY profileID
             ) AS user_counts"
        );
        $stmt->bind_param('i', $myCount);
        $stmt->execute();
        $row = $stmt->get_result()->fetch_assoc();
        $stmt->close();
        if ($row && $row['pool'] >= 3) {
            $pct    = $row['pool'] > 0 ? round(100 * $row['below'] / $row['pool']) : 0;
            $topPct = max(1, 100 - $pct);
        }
    }

    // Recent activity: last 10 arguments with an opinion
    $stmt = $db->prepare(
        "SELECT O.argumentID,
                COALESCE(A.currentPhrasing,
                    (SELECT phrasing FROM PHRASING
                     WHERE argumentID = A.argumentID ORDER BY createdDate ASC LIMIT 1)
                ) AS phrased,
                O.acceptance,
                O.lastVisit
         FROM OPINION O
         JOIN ARGUMENT A ON O.argumentID = A.argumentID
         WHERE O.profileID = ?
         ORDER BY O.lastVisit DESC
         LIMIT 10"
    );
    $stmt->bind_param('i', $profile);
    $stmt->execute();
    $res = $stmt->get_result();
    while ($row = $res->fetch_assoc()) { $recent[] = $row; }
    $stmt->close();

    // Most Heterodox
    $res = mysqli_query($db, "CALL getHeterodox($profile)");
    if ($res) {
        while ($row = mysqli_fetch_assoc($res)) { $heterodox[] = $row; }
        mysqli_free_result($res);
    }
    while (mysqli_more_results($db)) { mysqli_next_result($db); }

    // Group memberships — active group first, then All Users - Public, then alpha
    $res = mysqli_query($db,
        "SELECT a.affiliationID, a.orgName, a.description, a.public,
                m.isCaptain,
                (up.activeAffiliationID = a.affiliationID) AS isActive
         FROM MEMBER m
         JOIN AFFILIATION a ON a.affiliationID = m.affiliationID
         JOIN USER_PROFILE up ON up.profileID = $realProfileID
         WHERE m.profileID = $realProfileID
         ORDER BY (up.activeAffiliationID = a.affiliationID) DESC,
                  (a.orgName = 'All Users - Public') DESC,
                  a.orgName ASC"
    );
    while ($row = mysqli_fetch_assoc($res)) { $groups[] = $row; }

    // Pending invite codes for any group where the user is captain
    foreach ($groups as &$g) {
        $g['pendingInvites'] = [];
        if (intval($g['isCaptain'])) {
            $affID  = intval($g['affiliationID']);
            $invRes = mysqli_query($db,
                "SELECT code FROM INVITATION
                 WHERE affiliationID = $affID
                   AND usedBy IS NULL
                   AND (expiresAt IS NULL OR expiresAt > NOW())
                 ORDER BY createdAt ASC
                 LIMIT 100"
            );
            while ($inv = mysqli_fetch_assoc($invRes)) {
                $g['pendingInvites'][] = $inv['code'];
            }
        }
    }
    unset($g);

    $activeGroup     = !empty($groups) ? $groups[0] : null;
    $otherGroups     = array_slice($groups, 1);
    $activeGroupName = ($activeGroup && intval($activeGroup['affiliationID']) !== ALL_PUBLIC_AFF_ID) ? $activeGroup['orgName'] : '';
}

mysqli_close($db);

// Shared copy-icon SVG
$copyIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="13" height="13" aria-hidden="true"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Agitate – Profile</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="robots" content="noindex"/>
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
    <a href="/Profile.php?arg=<?php echo $arg; ?>" class="group-badge" title="<?php echo htmlspecialchars($activeGroupName); ?>"><?php echo htmlspecialchars($activeGroupName); ?></a>
    <?php endif; ?>
    <div>
        <a href="About.php?arg=<?php echo $arg; ?>">About</a>
        <a href="Explore.php?arg=<?php echo $arg; ?>">Explore</a>
        <a href="Profile.php?arg=<?php echo $arg; ?>" style="text-decoration:underline;">Profile</a>
        <a href="<?php echo $profile ? 'logout' : 'login'; ?>.php?arg=<?php echo $arg; ?>"><?php echo $profile ? 'Logout' : 'Login'; ?></a>
        <a href="#" class="closenav" onclick="closeNav()">&times;</a>
    </div>
    <a href="/donate.php" class="donate-btn">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="14" height="14" aria-hidden="true"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
        Donate
    </a>
    <a href="#" class="opennav" onclick="openNav()">&equiv;</a>
</div>

<main class="about-main">

<?php if (!$profile): ?>

    <div class="accordion container about-section">
        <h2>Your Profile</h2>
        <div class="panel expanded">
            <p>Agitate is anonymous. There are no public profiles, no follower counts, and nothing tied to your name. Your voice on Agitate is equal to everyone else's — no louder, no quieter. What little we keep, and what we will never do with it, is spelled out in the <a href="/data-promise">Data Promise</a>.</p>
            <p><a href="/login.php?arg=<?php echo $arg; ?>">Log in</a> to see your participation summary, recent activity, and where your positions diverge most from the rest of the graph.</p>
        </div>
    </div>

<?php else: ?>

    <!-- ── Your Participation ─────────────────────────────────────────────────── -->
    <?php if ($stats && $stats['total'] > 0):
        $total     = intval($stats['total']);
        $accepts   = intval($stats['accepts']);
        $rejects   = $total - $accepts;
        $acceptPct = round(100 * $accepts / $total);
    ?>
    <div class="accordion container about-section">
        <h2>Your Participation</h2>
        <div class="panel">
        <div class="profile-summary">
            <div class="profile-stat">
                <span class="profile-stat-value"><?php echo $total; ?></span>
                <span class="profile-stat-label">arguments weighed in on</span>
            </div>
            <div class="profile-stat">
                <span class="profile-stat-value"><?php echo $acceptPct; ?>%</span>
                <span class="profile-stat-label">acceptance rate</span>
            </div>
            <?php if ($topPct !== null): ?>
            <div class="profile-stat">
                <span class="profile-stat-value">top <?php echo $topPct; ?>%</span>
                <span class="profile-stat-label">of contributors</span>
            </div>
            <?php endif; ?>
        </div>
        </div>
    </div>
    <?php endif; ?>

    <!-- ── Groups ────────────────────────────────────────────────────────────── -->
    <div class="accordion container about-section">
        <h2>Groups</h2>
        <div class="panel expanded">
        <?php if (empty($groups)): ?>
            <p style="color:var(--cddbGrey);font-size:0.9rem;">You are not a member of any groups.</p>
        <?php else: ?>

            <p class="group-section-label">Current Group Enabled</p>
            <div class="group-list">
                <div class="group-row group-row-active">
                    <div class="group-info">
                        <span class="group-name"><?php echo htmlspecialchars($activeGroup['orgName']); ?></span>
                        <?php if (!empty($activeGroup['description'])): ?>
                        <span class="group-desc"><?php echo htmlspecialchars($activeGroup['description']); ?></span>
                        <?php endif; ?>
                    </div>
                    <?php if (intval($activeGroup['isCaptain'])):
                        $cnt       = count($activeGroup['pendingInvites']);
                        $firstCode = $activeGroup['pendingInvites'][0] ?? null;
                    ?>
                    <div class="group-actions">
                        <?php if ($cnt > 0): ?>
                        <button class="copy-invite-btn" data-code="<?php echo htmlspecialchars($firstCode); ?>">
                            <?php echo $cnt; ?> Invite Code<?php echo $cnt !== 1 ? 's' : ''; ?> Remaining
                            <?php echo $copyIcon; ?>
                        </button>
                        <?php else: ?>
                        <span class="no-invites">No invite codes remaining</span>
                        <?php endif; ?>
                    </div>
                    <?php endif; ?>
                </div>
            </div>

            <?php if (!empty($otherGroups)): ?>
            <div class="group-list group-list-others">
                <?php foreach ($otherGroups as $g):
                    $cnt       = count($g['pendingInvites'] ?? []);
                    $firstCode = ($g['pendingInvites'] ?? [])[0] ?? null;
                ?>
                <div class="group-row">
                    <div class="group-info">
                        <span class="group-name"><?php echo htmlspecialchars($g['orgName']); ?></span>
                        <?php if (!empty($g['description'])): ?>
                        <span class="group-desc"><?php echo htmlspecialchars($g['description']); ?></span>
                        <?php endif; ?>
                    </div>
                    <div class="group-actions">
                        <form method="POST" action="/Profile.php?arg=<?php echo $arg; ?>">
                            <input type="hidden" name="action" value="switchGroup">
                            <input type="hidden" name="affiliationID" value="<?php echo intval($g['affiliationID']); ?>">
                            <button type="submit" class="group-activate-btn">Activate</button>
                        </form>
                        <?php if (intval($g['isCaptain'])): ?>
                        <?php if ($cnt > 0): ?>
                        <button class="copy-invite-btn" data-code="<?php echo htmlspecialchars($firstCode); ?>">
                            <?php echo $cnt; ?> Invite Code<?php echo $cnt !== 1 ? 's' : ''; ?> Remaining
                            <?php echo $copyIcon; ?>
                        </button>
                        <?php else: ?>
                        <span class="no-invites">No invite codes remaining</span>
                        <?php endif; ?>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>

        <?php endif; ?>
        </div>
    </div>

    <!-- ── Recent Activity ───────────────────────────────────────────────────── -->
    <?php if (!empty($recent)): ?>
    <div class="accordion container about-section">
        <h2>Recent Activity</h2>
        <div class="panel">
        <ul class="explore-list">
        <?php foreach ($recent as $row):
            $label = $row['acceptance'] ? 'Accept' : 'Reject';
            $cls   = $row['acceptance'] ? 'profile-accept' : 'profile-reject';
        ?>
            <li class="explore-item">
                <a href="/?arg=<?php echo intval($row['argumentID']); ?>">
                    <?php echo htmlspecialchars($row['phrased'] ?? '(untitled)'); ?>
                </a>
                <div class="explore-item-meta <?php echo $cls; ?>"><?php echo $label; ?></div>
            </li>
        <?php endforeach; ?>
        </ul>
        </div>
    </div>
    <?php endif; ?>

    <!-- ── Your Data ─────────────────────────────────────────────────────────── -->
    <div class="accordion container about-section">
        <h2>Your Data</h2>
        <div class="panel expanded">
            <p>Everything on this page — and everything else Agitate keeps about you — is listed, exhaustively, in the <a href="/data-promise">Data Promise</a>. Your opinions are shown to other users only in aggregate, never sold, never advertised against, and never used to train AI. You can get a copy of it all, or have it deleted, just by asking.</p>
        </div>
    </div>

    <!-- ── Most Heterodox ────────────────────────────────────────────────────── -->
    <div class="accordion container about-section">
        <h2>Most Heterodox</h2>
        <div class="panel">
        <?php if (empty($heterodox)): ?>
            <p style="color:var(--cddbGrey);font-size:0.9rem;">No heterodox positions yet — your opinions align with the majority so far, or you haven't weighed in enough to diverge.</p>
        <?php else: ?>
            <ul class="explore-list">
            <?php foreach ($heterodox as $row):
                $accepted    = (bool)$row['acceptance'];
                $majorityPct = round($row['Percent'] * 100);
                $minorityPct = 100 - $majorityPct;
                $userVerb    = $accepted ? 'Accept' : 'Reject';
                $crowdVerb   = $accepted ? 'reject' : 'accept';
                $cls         = $accepted ? 'profile-accept' : 'profile-reject';
            ?>
                <li class="explore-item">
                    <a href="/?arg=<?php echo intval($row['argumentID']); ?>">
                        <?php echo htmlspecialchars($row['phrased'] ?? '(untitled)'); ?>
                    </a>
                    <div class="explore-item-meta <?php echo $cls; ?>">
                        You <?php echo $userVerb; ?> &middot; <?php echo $majorityPct; ?>% <?php echo $crowdVerb; ?>
                    </div>
                </li>
            <?php endforeach; ?>
            </ul>
        <?php endif; ?>
        </div>
    </div>

<?php endif; ?>

    <footer class="about-footer">
        <p>Agitate was created by Craig Danz of Seattle, WA, U.S.A. &copy; <?php echo date('Y'); ?></p>
    </footer>

</main>

<script>
document.querySelectorAll('.copy-invite-btn').forEach(function(btn) {
    btn.addEventListener('click', function() {
        var code = this.dataset.code;
        var url  = 'https://agitate-discourse.org/register.php?code=' + code;
        var self = this;
        var orig = self.innerHTML;
        function showCopied() {
            self.textContent = 'Copied!';
            setTimeout(function() { self.innerHTML = orig; }, 2000);
        }
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(url).then(showCopied).catch(function() {
                fallbackCopy(url, showCopied);
            });
        } else {
            fallbackCopy(url, showCopied);
        }
    });
});
function fallbackCopy(text, cb) {
    var ta = document.createElement('textarea');
    ta.value = text;
    ta.style.position = 'fixed';
    ta.style.opacity  = '0';
    document.body.appendChild(ta);
    ta.focus();
    ta.select();
    try { document.execCommand('copy'); cb(); } catch(e) {}
    document.body.removeChild(ta);
}
</script>

</body>
</html>
