<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php");
// The Data Promise sits front-and-center in onboarding once published.
$dataPromiseLive = content_page_is_published('data-promise');

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
		"SELECT inviteID, createdBy, affiliationID FROM INVITATION
		 WHERE code = ?
		   AND (expiresAt IS NULL OR expiresAt > NOW())
		   AND (usesRemaining IS NULL OR usesRemaining > 0)"
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
			"INSERT INTO USER_PROFILE (firstName, lastName, email, securityCode, activeAffiliationID)
			 VALUES (?, ?, ?, ?, ?)"
		);
		$allPublicAffID = ALL_PUBLIC_AFF_ID;
		$ins->bind_param("ssssi", $firstName, $lastName, $email, $hash, $allPublicAffID);
		$ins->execute();
		$newProfileID = $ins->insert_id;
		$ins->close();

		// Enroll new user in "All Users - Public"
		$mem = $db->prepare("INSERT INTO MEMBER (affiliationID, profileID, dateAdded) VALUES (?, ?, NOW())");
		$mem->bind_param("ii", $allPublicAffID, $newProfileID);
		$mem->execute();
		$mem->close();

		// If the invite is tied to a group, enroll in that group and make it the active affiliation
		$groupAffID = !empty($inviteRow['affiliationID']) ? intval($inviteRow['affiliationID']) : 0;
		if ($groupAffID > 0) {
			$gmem = $db->prepare("INSERT IGNORE INTO MEMBER (affiliationID, profileID, dateAdded) VALUES (?, ?, NOW())");
			$gmem->bind_param("ii", $groupAffID, $newProfileID);
			$gmem->execute();
			$gmem->close();

			$upd2 = $db->prepare("UPDATE USER_PROFILE SET activeAffiliationID = ? WHERE profileID = ?");
			$upd2->bind_param("ii", $groupAffID, $newProfileID);
			$upd2->execute();
			$upd2->close();
		}

		// Decrement usesRemaining for limited codes (NULL = unlimited); stamp
		// usedBy/usedAt only on the use that exhausts the code, so multi-use
		// codes stay valid. usedBy is assigned before usesRemaining, so its
		// CASE sees the pre-decrement value (MySQL applies SET left to right).
		$upd = $db->prepare(
			"UPDATE INVITATION
			 SET usedBy = CASE WHEN usesTotal = 1 OR usesRemaining = 1 THEN ? ELSE usedBy END,
			     usedAt = CASE WHEN usesTotal = 1 OR usesRemaining = 1 THEN NOW() ELSE usedAt END,
			     usesRemaining = CASE WHEN usesRemaining IS NOT NULL THEN GREATEST(0, usesRemaining - 1) ELSE NULL END
			 WHERE inviteID = ?"
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
	<title>Agitate – Create Account</title>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>" />
	<script src="script_vestigette.js?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/script_vestigette.js'); ?>"></script>
	<script>
		let arg     = <?php echo intval($_SESSION['currentArg']); ?>,
		    profile = undefined,
		    opinion = undefined, because = null, therefore = null, rebuttal = null;
	</script>
</head>
<body class="content-page">

<div id="mastHead" class="container">
	<h1><a href="/?arg=<?php echo $_SESSION['currentArg']; ?>">AGITATE<span class="exclaim">!</span></a></h1>
	<div>
		<a href="About.php?arg=<?php echo $_SESSION['currentArg']; ?>">About</a>
		<a href="Explore.php?arg=<?php echo $_SESSION['currentArg']; ?>">Explore</a>
		<a href="login.php?arg=<?php echo $_SESSION['currentArg']; ?>">Login</a>
		<a href="#" class="closenav" onclick="closeNav()">&times;</a>
	</div>
	<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
</div>

<main class="about-main reg-main">

<div class="container about-section login-card">
	<h2><?php echo $inviteRow ? 'Create Your Account' : 'Invitation Needed'; ?></h2>
	<div class="panel expanded">

		<?php if ($dataPromiseLive && $inviteRow): ?>
		<div class="reg-pledge">
			<strong>The Data Promise.</strong> Creating an account binds <em>us</em>, not you:
			your data is never sold, never advertised against, and never used to train AI.
			Your opinions are shown to others only in aggregate, and you can have everything
			deleted just by asking. <a href="/data-promise">Read the full promise</a> &mdash;
			it's short, and it's binding.
		</div>
		<?php endif; ?>

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
			<p>Have a code? Enter it on the <a href="/login.php?arg=<?php echo $_SESSION['currentArg']; ?>">login page</a> &mdash; it also explains how to get an invite if you don't have one yet.</p>
		<?php endif; ?>

	</div>
</div>

</main>

</body>
</html>
