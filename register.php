<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

if (!isset($_SESSION['currentArg'])) {
	$_SESSION['currentArg'] = isset($_GET['arg']) ? intval($_GET['arg']) : 75;
}

$errors      = [];
$code        = trim($_GET['code'] ?? $_POST['code'] ?? '');
$inviteRow   = null;
$registered  = false;

// Validate the invite code
if ($code !== '') {
	$stmt = $db->prepare(
		"SELECT inviteID, createdBy FROM INVITATION
		 WHERE code = ? AND usedBy IS NULL AND expiresAt > NOW()"
	);
	$stmt->bind_param("s", $code);
	$stmt->execute();
	$inviteRow = $stmt->get_result()->fetch_assoc();
	$stmt->close();
	if (!$inviteRow) {
		$errors[] = "This invitation code is invalid or has already been used.";
	}
} else {
	$errors[] = "No invitation code provided. Please use the link from your invitation.";
}

// Handle registration form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $inviteRow) {
	$firstName = trim($_POST['firstName'] ?? '');
	$lastName  = trim($_POST['lastName']  ?? '');
	$email     = trim($_POST['email']     ?? '');
	$password  = $_POST['password']       ?? '';
	$confirm   = $_POST['confirmPassword'] ?? '';

	// Validate fields
	if ($firstName === '') $errors[] = "First name is required.";
	if ($lastName  === '') $errors[] = "Last name is required.";
	if (!filter_var($email, FILTER_VALIDATE_EMAIL)) $errors[] = "A valid email address is required.";
	if (strlen($password) < 8) $errors[] = "Password must be at least 8 characters.";
	if ($password !== $confirm) $errors[] = "Passwords do not match.";

	// Check email uniqueness
	if (empty($errors)) {
		$chk = $db->prepare("SELECT profileID FROM USER_PROFILE WHERE email = ?");
		$chk->bind_param("s", $email);
		$chk->execute();
		$chk->get_result()->fetch_assoc() && ($errors[] = "An account with that email already exists.");
		$chk->close();
	}

	// Create account
	if (empty($errors)) {
		$hash = password_hash($password, PASSWORD_BCRYPT);

		$ins = $db->prepare(
			"INSERT INTO USER_PROFILE (firstName, lastName, email, securityCode)
			 VALUES (?, ?, ?, ?)"
		);
		$ins->bind_param("ssss", $firstName, $lastName, $email, $hash);
		$ins->execute();
		$newProfileID = $ins->insert_id;
		$ins->close();

		// Mark invitation as used
		$upd = $db->prepare(
			"UPDATE INVITATION SET usedBy = ?, usedAt = NOW() WHERE inviteID = ?"
		);
		$upd->bind_param("ii", $newProfileID, $inviteRow['inviteID']);
		$upd->execute();
		$upd->close();

		// Log in as the new user — clear any inherited session state first
		$currentArg = $_SESSION['currentArg'] ?? 75;
		session_unset();
		$_SESSION['currentArg'] = $currentArg;
		$_SESSION['profile']    = $newProfileID;
		$_SESSION['email']      = $email;

		mysqli_close($db);
		header('Location: /?arg=' . $_SESSION['currentArg']);
		exit;
	}
}

mysqli_close($db);
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Agitate - Create Account</title>
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
		<a href="login.php?arg=<?php echo $_SESSION['currentArg']; ?>">Login</a>
		<a href="#" class="closenav" onclick="closeNav()">&times;</a>
	</div>
	<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
</div>

<style>
	.reg-form { max-width: 420px; }
	.reg-form .field { margin-bottom: 1rem; }
	.reg-form label { display: block; font-size: 0.8rem; margin-bottom: 0.3rem; opacity: 0.75; }
	.reg-form input[type="text"],
	.reg-form input[type="email"],
	.reg-form input[type="password"] {
		background: transparent;
		border: 1px solid var(--cddbWhite);
		border-radius: 3px;
		box-sizing: border-box;
		color: inherit;
		font-size: 0.95rem;
		padding: 0.45rem 0.6rem;
		width: 100%;
	}
	.reg-form input:focus { outline: 2px solid var(--cddbWhite); outline-offset: 1px; }
	.reg-name-row { display: flex; gap: 0.75rem; }
	.reg-name-row .field { flex: 1; }
	.reg-errors { background: rgba(255,80,80,0.15); border: 1px solid rgba(255,80,80,0.5); border-radius: 3px; font-size: 0.875rem; margin-bottom: 1rem; padding: 0.5rem 0.75rem; }
	.reg-errors p { margin: 0.2rem 0; }
	.reg-form button[type="submit"] { margin-top: 0.5rem; }
</style>

<div id="argument" class="accordion container">
	<h2>Create Your Account</h2>
	<div class="panel expanded">

		<?php if (!empty($errors)): ?>
			<div class="reg-errors">
				<?php foreach ($errors as $e): ?>
					<p><?php echo htmlspecialchars($e); ?></p>
				<?php endforeach; ?>
			</div>
		<?php endif; ?>

		<?php if ($inviteRow): ?>
		<form method="POST" action="/register.php?arg=<?php echo $_SESSION['currentArg']; ?>" class="reg-form">
			<input type="hidden" name="code" value="<?php echo htmlspecialchars($code); ?>">

			<div class="reg-name-row">
				<div class="field">
					<label for="firstName">First name</label>
					<input type="text" id="firstName" name="firstName"
						value="<?php echo htmlspecialchars($_POST['firstName'] ?? ''); ?>"
						autocomplete="given-name" required>
				</div>
				<div class="field">
					<label for="lastName">Last name</label>
					<input type="text" id="lastName" name="lastName"
						value="<?php echo htmlspecialchars($_POST['lastName'] ?? ''); ?>"
						autocomplete="family-name" required>
				</div>
			</div>

			<div class="field">
				<label for="email">Email address</label>
				<input type="email" id="email" name="email"
					value="<?php echo htmlspecialchars($_POST['email'] ?? ''); ?>"
					autocomplete="email" required>
			</div>

			<div class="field">
				<label for="password">Password <span style="opacity:0.55;">(8 characters minimum)</span></label>
				<input type="password" id="password" name="password"
					autocomplete="new-password" required>
			</div>

			<div class="field">
				<label for="confirmPassword">Confirm password</label>
				<input type="password" id="confirmPassword" name="confirmPassword"
					autocomplete="new-password" required>
			</div>

			<button type="submit">Create account</button>
		</form>
		<?php else: ?>
			<p>Please use the invitation link you were sent. If you believe this is an error, contact the person who invited you.</p>
		<?php endif; ?>

	</div>
</div>

</body>
</html>
