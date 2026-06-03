<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

if (!isset($_SESSION['currentArg'])) {
	$_SESSION['currentArg'] = isset($_GET['arg']) ? intval($_GET['arg']) : 75;
}

// Handle login form submission
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

		// Keep me logged in — store token in REMEMBER_ME and set cookie
		if (isset($_POST['keepLoggedIn'])) {
			$token = bin2hex(random_bytes(32));
			$stmt2 = $db->prepare("INSERT INTO REMEMBER_ME (profileID, email, token) VALUES (?, ?, ?)");
			$stmt2->bind_param("iss", $row['profileID'], $email, $token);
			$stmt2->execute();
			$stmt2->close();
			setcookie('rememberMe', $token, time() + (30 * 24 * 60 * 60), '/', '', true, true);
		}

		mysqli_close($db);
		header('Location: /?arg=' . $_SESSION['currentArg']);
		exit;
	} else {
		$fmsg = "Invalid email or password.";
	}
}

mysqli_close($db);

if (isset($_SESSION['profile'])) {
	$smsg    = "Already logged in as " . htmlspecialchars($_SESSION['email']) . ":&nbsp;";
	$logoutURL = "/logout.php?arg=" . $_SESSION['currentArg'];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Agitate - Login</title>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>" />
</head>
<body>

<div id="mastHead" class="container">
	<h1><a href="/?arg=<?php echo $_SESSION['currentArg']; ?>">AGITATE</a></h1>
	<div>
		<a href="About.php?arg=<?php echo $_SESSION['currentArg']; ?>">About</a>
		<a href="Explore.php?arg=<?php echo $_SESSION['currentArg']; ?>">Explore</a>
		<a href="Profile.php?arg=<?php echo $_SESSION['currentArg']; ?>">Profile</a>
		<a href="login.php?arg=<?php echo $_SESSION['currentArg']; ?>"><span style="text-decoration: underline;">Login</span></a>
		<a href="#" class="closenav" onclick="closeNav()">&times;</a>
	</div>
	<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
</div>

<div id="argument" class="accordion container">
	<h2>Please Login</h2>
	<div class="panel expanded">
		<form id="login" method="POST">
			<?php if (isset($smsg)): ?>
				<div id="alert-success" role="alert"><?php echo $smsg; ?> <a href="<?php echo $logoutURL; ?>">Log Out</a></div>
			<?php endif; ?>
			<?php if (isset($fmsg)): ?>
				<div id="alert-danger" role="alert"><?php echo htmlspecialchars($fmsg); ?></div>
			<?php endif; ?>
			<input type="email" placeholder="Email Address" name="email" autocomplete="email" required>
			<input type="password" placeholder="Password" name="password" autocomplete="current-password" required>
			<div class="form-group">
				<input type="checkbox" name="keepLoggedIn" id="keepLoggedIn" checked>
				<label for="keepLoggedIn"> Keep me logged in 30 days</label>
			</div>
			<button type="submit">Login</button>
		</form>
	</div>
</div>

<div id="because" class="accordion container">
	<h2>New Users</h2>
	<div class="panel" data-container-id="because">
		<br>
		<p>Agitate is currently in alpha. New accounts require an invitation code. If you have one, <a href="/register.php?arg=<?php echo $_SESSION['currentArg']; ?>">create your account here</a>.</p>
		<br>
	</div>
</div>

<div id="rebuttal" class="accordion container">
	<h2>Privacy Policy</h2>
	<div class="panel" data-container-id="rebuttal">
		<br>
		<p>TL;DR: Agitate's privacy goals are lofty but shortcuts will be taken during initial development.</p>
		<br>
		<p>Agitate is nonprofit and expects to remain that way. No user data will be sold nor will your user behavior be monetized in any way. It is a core part of the Agitate ethos that there is no bias built into what the system serves you, and that would be ruined the moment money got involved.</p>
		<br>
		<p>Agitate also aims to use demographic data differently. Initially just location and age will be used as conditions for filtering results. That list may increase but Agitate is not eager to define groups — it would prefer to use the framework for users to define it for themselves.</p>
		<br>
	</div>
</div>

</body>
</html>
