<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

if (!isset($_SESSION['currentArg'])) {
    $_SESSION['currentArg'] = isset($_GET['arg']) ? intval($_GET['arg']) : 75;
}
$arg     = $_SESSION['currentArg'];
$profile = $_SESSION['profile'] ?? null;

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
        header('Location: /?arg=' . $arg);
        exit;
    } else {
        $fmsg = "Invalid email or password.";
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
    <h1><a href="/?arg=<?php echo $arg; ?>">AGITATE</a></h1>
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

<main class="about-main">

    <div class="accordion container about-section">
        <h2>Login</h2>
        <div class="panel expanded">
            <?php if (isset($profile)): ?>
                <p>Logged in as <strong><?php echo htmlspecialchars($_SESSION['email']); ?></strong>. <a href="/logout.php?arg=<?php echo $arg; ?>">Log out</a></p>
            <?php else: ?>
                <?php if (isset($fmsg)): ?>
                    <p class="login-error"><?php echo htmlspecialchars($fmsg); ?></p>
                <?php endif; ?>
                <form class="login-form" method="POST">
                    <input type="email" placeholder="Email address" name="email" autocomplete="email" required>
                    <input type="password" placeholder="Password" name="password" autocomplete="current-password" required>
                    <label class="login-remember">
                        <input type="checkbox" name="keepLoggedIn" checked>
                        Keep me logged in for 30 days
                    </label>
                    <button type="submit">Login</button>
                </form>
            <?php endif; ?>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>New Users</h2>
        <div class="panel">
            <p>Agitate is currently in alpha. New accounts require an invitation code. If you have one, <a href="/register.php?arg=<?php echo $arg; ?>">create your account here</a>.</p>
        </div>
    </div>

    <div class="accordion container about-section">
        <h2>Privacy Policy</h2>
        <div class="panel">
            <p>Agitate is nonprofit and expects to remain that way. No user data will be sold nor will your behavior be monetized in any way. It is a core part of the Agitate ethos that there is no bias built into what the system serves you.</p>
            <p>Agitate uses demographic data minimally. Initially just location and age are used as conditions for filtering results. That list may grow but Agitate is not eager to define groups — it would prefer to let users define those for themselves.</p>
        </div>
    </div>

    <footer class="about-footer">
        <p>Agitate was created by Craig Danz of Seattle, WA, U.S.A. &copy; <?php echo date('Y'); ?></p>
    </footer>

</main>

</body>
</html>
