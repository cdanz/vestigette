<?php
session_start();
$_SESSION['currentArg'] = intval($_GET["arg"] ?? 0);
$baseURL  = "/";
$arg      = $_SESSION['currentArg'] ?? null;
$profile  = $_SESSION['profile']    ?? null;

include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php");

$posts = [];
$stmt = $db->prepare(
    "SELECT slug, title, summary, tags, createdAt, updatedAt
     FROM CONTENT WHERE status='published' ORDER BY updatedAt DESC"
);
if ($stmt) {
    $stmt->execute();
    $res = $stmt->get_result();
    while ($row = $res->fetch_assoc()) { $posts[] = $row; }
    $stmt->close();
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
?>
<!DOCTYPE html>
<html>
<head>
    <title>Agitate – About</title>
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
    <h1><a href="/?arg=<?php echo $arg; ?>"><img class="agi-ring" src="/agitate-ring.svg" alt="Agitate">AGITATE</a></h1>
    <?php if ($profile && $activeGroupName !== ''): ?>
    <a href="/Profile.php?arg=<?php echo intval($arg); ?>" class="group-badge" title="<?php echo htmlspecialchars($activeGroupName); ?>"><?php echo htmlspecialchars($activeGroupName); ?></a>
    <?php endif; ?>
    <div>
        <a href="About.php?arg=<?php echo $arg; ?>" style="text-decoration:underline;">About</a>
        <a href="Explore.php?arg=<?php echo $arg; ?>">Explore</a>
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

<main class="about-main">

    <div class="accordion container about-section">
        <h2>What is Agitate</h2>
        <div class="panel expanded">
            <p>Agitate maps public discourse as a weighted argument graph. Each node is a claim — accepted or rejected by users, connected to the reasons that support or follow from it, and the counterarguments that challenge it. The result is a living model of how people actually think, not a measure of what's loudest.</p>
            <p>There are no followers, no algorithmic feed, and no mechanism for amplifying outrage. What rises to the top is determined entirely by the proportional weight users assign to it — collectively, over time.</p>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>Why</h2>
        <div class="panel expanded">
            <p>There is a great deal of wisdom to be found among us. There is good sense and a genuine willingness to reason carefully. The problem is that what's right too rarely rises to the surface of public discourse.</p>
            <p>Agitate is built around a single question: how do we reliably draw out the best of what people have to offer? The answer it pursues is a persistent, open, and fair exercise in collective inquiry — one argument at a time. Through a dogged commitment to fair representation, it is the mission of Agitate to conduct the most extensive exercise in open inquiry in history.</p>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>Get Started</h2>
        <div class="panel expanded">
            <p>The best way to understand Agitate is to use it. <a href="/?arg=75">Argument #75</a> is a good place to start — it walks through the platform from the inside, as an argument itself.</p>
            <p>For a quick orientation, the <a href="https://youtube.com/shorts/LD45DZA6ZIc?feature=share">video tutorial</a> covers the basics.</p>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>Blog</h2>
        <div class="panel expanded">
            <?php if (empty($posts)): ?>
                <p>Nothing here yet.</p>
            <?php else: ?>
                <ul class="about-post-list">
                <?php foreach ($posts as $p): ?>
                    <li class="about-post-item">
                        <a class="about-post-title" href="/post.php?slug=<?php echo urlencode($p['slug']); ?>"><?php echo htmlspecialchars($p['title']); ?></a>
                        <div class="about-post-meta"><?php echo date('M j, Y', strtotime($p['updatedAt'] ?: $p['createdAt'])); ?></div>
                        <?php if (!empty($p['summary'])): ?>
                            <div class="about-post-summary"><?php echo htmlspecialchars($p['summary']); ?></div>
                        <?php endif; ?>
                        <?php $tg = content_parse_tags($p['tags']); if ($tg): ?>
                            <div class="about-post-tags">
                            <?php foreach ($tg as $t): ?>
                                <a class="about-post-tag" href="/blog.php?tag=<?php echo urlencode($t); ?>"><?php echo htmlspecialchars($t); ?></a>
                            <?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
                </ul>
            <?php endif; ?>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>AI Transparency</h2>
        <div class="panel expanded">
            <p>Arguments in the early stages of human engagement may display a <span class="about-robot-badge">&#x1F916; robot badge</span>. This indicates that AI "Seed Users" contributed to the argument's initial scaffolding — seeding Because, Therefore, and Rebuttal connections so new users encounter a populated graph rather than an empty room. Clicking the badge takes you to the policy that governs them.</p>
            <p>These contributions are temporary by design. As genuine human engagement grows on an argument, Seed User input phases out automatically. When the badge disappears, the argument is fully human-driven. The badge exists to be honest about when that transition is still in progress.</p>
            <p>None of this runs on trust alone. The <a href="/ai-policy-pledge">AI Policy and Pledge</a> is the binding document — what Seed Users are, when they may act, what they may never do, and how they retire — and it is never edited silently. The <a href="/seed-user-roster">Seed User Roster</a> describes all 26 personas in full detail, because nothing about them needs to be hidden.</p>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>Privacy</h2>
        <div class="panel expanded">
            <p>Agitate has no public profiles, no follower counts, and no social graph. Your positions are recorded to your account for continuity of your own experience, but they are not displayed as a public identity and are not associated with your name.</p>
            <p>There is no feed designed to hold your attention, no mechanism for content to go viral, and no advertising. There are no trackers either — loading Agitate, your browser talks to agitate-discourse.org and no one else. What you see is a function of the argument graph — not of who you are or what keeps you engaged longest.</p>
            <p>These are not just design choices; they are commitments. The <a href="/data-promise">Data Promise</a> lists everything we collect, everything we will never do with it — never sold, never advertised against, never used to train AI — and how to have your data handed over or deleted just by asking.</p>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>Contribute</h2>
        <div class="panel expanded">
            <p>Agitate is in active alpha development, run on a non-profit basis and funded by donations — no ads, no investors, no monetizing your attention. The graph is live and growing. The most valuable thing you can do right now is use it honestly and bring others into the conversation.</p>
            <a class="bluesky-follow" href="https://bsky.app/profile/agitate-discourse.org" target="_blank" rel="noopener">🦋 Follow @agitate-discourse.org on Bluesky</a>
            <p class="bluesky-context">Arguments worth arguing about — follow for updates, debate, and a direct line to the people building this. Feedback, bug reports, and questions are all welcome there.</p>
            <p>Software development guidance, legal assistance, and financial support are also accepted gratefully.</p>
        </div>
    </div>

    <footer class="about-footer">
        <p>Agitate was created by Craig Danz of Seattle, WA, U.S.A. &copy; <?php echo date('Y'); ?></p>
    </footer>

</main>

</body>
</html>
