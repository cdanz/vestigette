<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

// Arriving with ?arg= always retargets the session — engagement intercepts
// (accept/reject/flag while logged out) depend on landing back on the same argument.
if (isset($_GET['arg']) && intval($_GET['arg']) > 0) {
    $_SESSION['currentArg'] = intval($_GET['arg']);
} elseif (!isset($_SESSION['currentArg'])) {
    $_SESSION['currentArg'] = 75;
}
$arg     = $_SESSION['currentArg'];
$profile = $_SESSION['profile'] ?? null;

// Engagement intent carried from the argument page (accept / reject / flag)
$intentVerbs = ['accept' => 'accept', 'reject' => 'reject', 'flag' => 'flag'];
$intent = $_GET['intent'] ?? $_POST['intent'] ?? '';
if (!isset($intentVerbs[$intent])) $intent = '';

if (isset($_POST['email']) && isset($_POST['password'])) {
    $email = trim($_POST['email']);
    $stmt = $db->prepare("SELECT profileID, securityCode FROM USER_PROFILE WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $row = $stmt->get_result()->fetch_assoc();
    $stmt->close();

    if ($row && password_verify($_POST['password'], $row['securityCode'])) {
        $_SESSION['profile'] = $row['profileID'];
        $_SESSION['email']   = $email;

        if (isset($_POST['keepLoggedIn'])) {
            $token = bin2hex(random_bytes(32));
            $stmt2 = $db->prepare(
                "INSERT INTO REMEMBER_ME (profileID, email, token, expiry)
                 VALUES (?, ?, ?, DATE_ADD(NOW(), INTERVAL 30 DAY))"
            );
            $stmt2->bind_param("iss", $row['profileID'], $email, $token);
            $stmt2->execute();
            $stmt2->close();
            setcookie('rememberMe', $token, time() + (30 * 24 * 60 * 60), '/', '', true, true);
        }

        mysqli_close($db);
        // Resume the action they were trying to take before the login wall
        header('Location: /?arg=' . $arg . ($intent !== '' ? '&resume=' . $intent : ''));
        exit;
    } else {
        $fmsg = "Invalid email or password.";
    }
}

// Argument context for the intent banner
$intentPhrasing = '';
if ($intent !== '' && !$profile) {
    $pStmt = $db->prepare("SELECT currentPhrasing FROM ARGUMENT WHERE argumentID = ?");
    $pStmt->bind_param("i", $arg);
    $pStmt->execute();
    $pRow = $pStmt->get_result()->fetch_assoc();
    $pStmt->close();
    if ($pRow) $intentPhrasing = $pRow['currentPhrasing'];
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
<html lang="en">
<head>
    <title>Agitate – Login</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>"/>
    <script src="script_vestigette.js?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/script_vestigette.js'); ?>"></script>
    <script>
        let arg     = <?php echo $arg ?? 'undefined'; ?>,
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
        <a href="Explore.php?arg=<?php echo $arg; ?>">Explore</a>
        <a href="Profile.php?arg=<?php echo $arg; ?>">Profile</a>
        <a href="login.php?arg=<?php echo $arg; ?>" style="text-decoration:underline;"><?php echo $profile ? 'Logout' : 'Login'; ?></a>
        <a href="#" class="closenav" onclick="closeNav()">&times;</a>
    </div>
    <a href="/donate.php" class="donate-btn">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="14" height="14" aria-hidden="true"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
        Donate
    </a>
    <a href="#" class="opennav" onclick="openNav()">&equiv;</a>
</div>

<main class="about-main login-main">

<?php if ($profile): ?>

    <div class="container about-section login-card">
        <h2>Login</h2>
        <div class="panel expanded">
            <p>Logged in as <strong><?php echo htmlspecialchars($_SESSION['email']); ?></strong>. <a href="/logout.php?arg=<?php echo $arg; ?>">Log out</a></p>
        </div>
    </div>

<?php else: ?>

    <?php if ($intent !== '' && $intentPhrasing !== ''): ?>
    <div class="intent-banner intent-<?php echo $intent; ?>">
        <p class="intent-lead">To <strong><?php echo $intentVerbs[$intent]; ?></strong> an argument, you need an account:</p>
        <blockquote class="intent-phrasing"><?php echo htmlspecialchars($intentPhrasing); ?></blockquote>
        <p class="intent-followup">Log in or get an invite below &mdash; you'll land right back on this argument.</p>
    </div>
    <?php endif; ?>

    <div class="login-grid">

        <div class="container about-section login-card">
            <h2>Log In</h2>
            <div class="panel expanded">
                <?php if (isset($fmsg)): ?>
                    <p class="login-error"><?php echo htmlspecialchars($fmsg); ?></p>
                <?php endif; ?>
                <form class="login-form" method="POST" action="/login.php">
                    <?php if ($intent !== ''): ?><input type="hidden" name="intent" value="<?php echo htmlspecialchars($intent); ?>"><?php endif; ?>
                    <input type="email" placeholder="Email address" name="email" autocomplete="email" required>
                    <input type="password" placeholder="Password" name="password" autocomplete="current-password" required>
                    <label class="login-remember">
                        <input type="checkbox" name="keepLoggedIn" checked>
                        Keep me logged in for 30 days
                    </label>
                    <button type="submit">Login</button>
                </form>
            </div>
        </div>

        <div class="container about-section login-card">
            <h2>New Here?</h2>
            <div class="panel expanded">
                <p>Agitate is in invite-only alpha while we keep every profile <a href="/ai-policy-pledge">one real human</a>.</p>

                <form class="invite-code-form" method="GET" action="/register.php">
                    <input type="hidden" name="arg" value="<?php echo $arg; ?>">
                    <label for="inviteCode">Have an invite code?</label>
                    <div class="invite-code-row">
                        <input type="text" id="inviteCode" name="code" placeholder="Paste your code" autocomplete="off" required>
                        <button type="submit">Continue</button>
                    </div>
                </form>

                <div class="join-divider"><span>no code yet?</span></div>

                <a class="bluesky-follow" href="https://bsky.app/profile/agitate-discourse.org" target="_blank" rel="noopener">&#x1F98B; Get an invite on Bluesky</a>
                <p class="bluesky-context">Follow <strong>@agitate-discourse.org</strong> and reply to the pinned post &mdash; or DM &mdash; with an argument you'd weigh in on. A human reads every request and sends codes, usually within a day.</p>
            </div>
        </div>

    </div>

<?php endif; ?>

    <div class="accordion container about-section">
        <h2>Privacy Policy</h2>
        <div class="panel">
            <p>Agitate is nonprofit and expects to remain that way. No user data will be sold nor will your behavior be monetized in any way. It is a core part of the Agitate ethos that there is no bias built into what the system serves you.</p>
            <p>Agitate uses demographic data minimally. Initially just location and age are used as conditions for filtering results. That list may grow but Agitate is not eager to define groups &mdash; it would prefer to let users define those for themselves.</p>
        </div>
    </div>

    <footer class="about-footer">
        <p>Agitate was created by Craig Danz of Seattle, WA, U.S.A. &copy; <?php echo date('Y'); ?></p>
    </footer>

</main>

</body>
</html>
