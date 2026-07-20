<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

// Anchor real profile
if (isset($_SESSION['profile']) && !isset($_SESSION['realProfile'])) {
	$_SESSION['realProfile'] = $_SESSION['profile'];
}
$realProfileID = isset($_SESSION['realProfile']) ? intval($_SESSION['realProfile']) : 0;

// Require login
if (!$realProfileID) {
	header('Location: /login.php');
	exit;
}

// Verify and cache admin flag
if (!isset($_SESSION['isAdmin'])) {
	$adminChk = mysqli_fetch_row(mysqli_query($db, "SELECT isAdmin FROM USER_PROFILE WHERE profileID=$realProfileID"));
	$_SESSION['isAdmin'] = ($adminChk && intval($adminChk[0]) === 1);
}
if (!$_SESSION['isAdmin']) {
	header('Location: /');
	exit;
}

// ─────────────────────────────────────────────────────────────────────────────
// User removal ("excommunication")
//
// Deleting a user must never destroy content other people are relying on. So:
//   • Purely personal participation (opinions, endorsements, flags, the various
//     *_ENDORSE and SCOPE_* rows, memberships, login tokens, admin settings,
//     invites they generated) is hard-deleted.
//   • Arguments they authored are KEPT if any other user has engaged with them
//     (opinion, endorsement, an alternate phrasing, explication, phrase-endorse,
//     or flag); only truly untouched arguments are hard-deleted.
//   • Phrasings they coined that sit on a surviving argument are KEPT — this is
//     the case where they wrote the live phrasing and later acceptors never
//     supplied an alternative; the words must not vanish.
// Kept content is reassigned to a reserved, login-impossible "[deleted user]"
// sentinel so the NOT-NULL author foreign keys (ARGUMENT.createdBy,
// PHRASING_ARCHIVE.coinedBy) stay valid. Finally the USER_PROFILE row itself is
// deleted, which blocks any future login.
// ─────────────────────────────────────────────────────────────────────────────

// The reserved profile that owns anonymized content. Created on first use.
// securityCode is NULL, so password_verify() can never succeed against it.
define('DELETED_USER_EMAIL', 'deleted-user@agitate.local');

function agitate_get_sentinel_id(mysqli $db): int {
	$email = DELETED_USER_EMAIL;
	$stmt = $db->prepare("SELECT profileID FROM USER_PROFILE WHERE email = ? LIMIT 1");
	$stmt->bind_param("s", $email);
	$stmt->execute();
	$row = $stmt->get_result()->fetch_assoc();
	$stmt->close();
	if ($row) return intval($row['profileID']);

	$fn = '[deleted'; $ln = 'user]'; $aff = ALL_PUBLIC_AFF_ID;
	$ins = $db->prepare(
		"INSERT INTO USER_PROFILE (firstName, lastName, email, securityCode, activeAffiliationID)
		 VALUES (?, ?, ?, NULL, ?)"
	);
	$ins->bind_param("sssi", $fn, $ln, $email, $aff);
	$ins->execute();
	$id = intval($ins->insert_id);
	$ins->close();
	return $id;
}

// Resolve an admin-entered identifier (numeric profileID or email) to a profile
// row, or null. Never resolves the sentinel.
function agitate_resolve_user(mysqli $db, string $query): ?array {
	$query = trim($query);
	if ($query === '') return null;
	if (ctype_digit($query)) {
		$stmt = $db->prepare("SELECT profileID, firstName, lastName, email, isAdmin FROM USER_PROFILE WHERE profileID = ?");
		$id = intval($query);
		$stmt->bind_param("i", $id);
	} else {
		$stmt = $db->prepare("SELECT profileID, firstName, lastName, email, isAdmin FROM USER_PROFILE WHERE email = ?");
		$stmt->bind_param("s", $query);
	}
	$stmt->execute();
	$row = $stmt->get_result()->fetch_assoc();
	$stmt->close();
	if (!$row) return null;
	if ($row['email'] === DELETED_USER_EMAIL) return null;
	return $row;
}

// Count what a deletion would touch, for the confirm screen. The "preserved"
// count uses the same load-bearing test the deletion itself applies.
function agitate_preview_user_deletion(mysqli $db, int $T): array {
	$q = function (string $sql) use ($db): int {
		$r = mysqli_fetch_row(mysqli_query($db, $sql));
		return $r ? intval($r[0]) : 0;
	};
	$authored  = $q("SELECT COUNT(*) FROM ARGUMENT WHERE createdBy = $T");
	$preserved = $q(
		"SELECT COUNT(*) FROM ARGUMENT a WHERE a.createdBy = $T AND (
		    EXISTS(SELECT 1 FROM OPINION o        WHERE o.argumentID=a.argumentID AND o.profileID<>$T)
		 OR EXISTS(SELECT 1 FROM ENDORSEMENT e    WHERE (e.targArgID=a.argumentID OR e.supportingArgID=a.argumentID) AND e.profileID<>$T)
		 OR EXISTS(SELECT 1 FROM PHRASING p       WHERE p.argumentID=a.argumentID AND (p.coinedBy IS NULL OR p.coinedBy<>$T))
		 OR EXISTS(SELECT 1 FROM EXPLICATION x    WHERE x.argumentID=a.argumentID AND x.profileID<>$T)
		 OR EXISTS(SELECT 1 FROM PHRASE_ENDORSE pe WHERE pe.argumentID=a.argumentID AND pe.profileID<>$T)
		 OR EXISTS(SELECT 1 FROM ARGUMENT_FLAG f  WHERE f.argumentID=a.argumentID AND f.profileID<>$T)
		)");
	return [
		'authored'     => $authored,
		'preserved'    => $preserved,
		'deletedArgs'  => $authored - $preserved,
		'phrasings'    => $q("SELECT COUNT(*) FROM PHRASING WHERE coinedBy = $T"),
		'opinions'     => $q("SELECT COUNT(*) FROM OPINION WHERE profileID = $T"),
		'endorsements' => $q("SELECT COUNT(*) FROM ENDORSEMENT WHERE profileID = $T"),
		'flags'        => $q("SELECT COUNT(*) FROM ARGUMENT_FLAG WHERE profileID = $T"),
		'explications' => $q("SELECT COUNT(*) FROM EXPLICATION WHERE profileID = $T"),
		'groupsAdmin'  => $q("SELECT COUNT(*) FROM AFFILIATION WHERE adminID = $T"),
	];
}

// Execute the full removal in one transaction. Returns [deletedArgs, keptArgs].
function agitate_delete_user(mysqli $db, int $T, int $S): array {
	// Force exception-on-error for the duration so any failed statement aborts
	// the whole transaction rather than silently continuing (prod runs with
	// mysqli reporting off).
	mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
	mysqli_begin_transaction($db);
	try {
		// A. Sweep T's personal participation (T as participant, not author).
		mysqli_query($db, "DELETE FROM OPINION            WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM ENDORSEMENT        WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM PHRASE_ENDORSE     WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM EXPLICATION_ENDORSE WHERE profileID = $T");
		// Endorsements (by anyone) of the explications T authored, then those explications.
		mysqli_query($db, "DELETE FROM EXPLICATION_ENDORSE WHERE explicationID IN (SELECT explicationID FROM EXPLICATION WHERE profileID = $T)");
		mysqli_query($db, "DELETE FROM EXPLICATION        WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM ARGUMENT_FLAG      WHERE profileID = $T");
		mysqli_query($db, "UPDATE ARGUMENT_FLAG SET resolvedBy = NULL WHERE resolvedBy = $T");
		mysqli_query($db, "DELETE FROM SCOPE_OPINION            WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM SCOPE_ENDORSEMENT        WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM SCOPE_EXPLICATION_ENDORSE WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM SCOPE_PHRASE_ENDORSE     WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM MEMBER        WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM REMEMBER_ME   WHERE profileID = $T");
		mysqli_query($db, "DELETE FROM ADMIN_SETTINGS WHERE profileID = $T");

		// B. Decide the fate of T's authored arguments. T's own participation is
		//    already gone, so any remaining footprint below belongs to others.
		$res = mysqli_query($db,
			"SELECT a.argumentID,
			  (EXISTS(SELECT 1 FROM OPINION o        WHERE o.argumentID=a.argumentID)
			OR EXISTS(SELECT 1 FROM ENDORSEMENT e    WHERE e.targArgID=a.argumentID OR e.supportingArgID=a.argumentID)
			OR EXISTS(SELECT 1 FROM PHRASING p       WHERE p.argumentID=a.argumentID AND (p.coinedBy IS NULL OR p.coinedBy<>$T))
			OR EXISTS(SELECT 1 FROM EXPLICATION x    WHERE x.argumentID=a.argumentID)
			OR EXISTS(SELECT 1 FROM PHRASE_ENDORSE pe WHERE pe.argumentID=a.argumentID)
			OR EXISTS(SELECT 1 FROM ARGUMENT_FLAG f  WHERE f.argumentID=a.argumentID)) AS loadBearing
			 FROM ARGUMENT a WHERE a.createdBy = $T");
		$toDelete = []; $keptCount = 0;
		while ($r = mysqli_fetch_assoc($res)) {
			if (intval($r['loadBearing'])) $keptCount++;
			else $toDelete[] = intval($r['argumentID']);
		}

		// Hard-delete each orphaned argument, children first (FK-safe order).
		foreach ($toDelete as $aid) {
			mysqli_query($db, "DELETE FROM PHRASE_ENDORSE       WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM EXPLICATION_ENDORSE  WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM EXPLICATION          WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM OPINION              WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM ENDORSEMENT          WHERE targArgID = $aid OR supportingArgID = $aid");
			mysqli_query($db, "DELETE FROM ARGUMENT_FLAG        WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM SCOPE_OPINION            WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM SCOPE_ENDORSEMENT        WHERE targArgID = $aid");
			mysqli_query($db, "DELETE FROM SCOPE_EXPLICATION_ENDORSE WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM SCOPE_PHRASE_ENDORSE     WHERE argumentID = $aid");
			mysqli_query($db, "UPDATE ARGUMENT SET currentPhrasingID = NULL WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM PHRASING          WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM PHRASING_ARCHIVE  WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM PUT_FORTH_ARCHIVE WHERE argumentID = $aid");
			mysqli_query($db, "DELETE FROM ARGUMENT          WHERE argumentID = $aid");
		}

		// C. Preserve remaining authored content by reassigning it to the sentinel.
		mysqli_query($db, "UPDATE ARGUMENT         SET createdBy = $S WHERE createdBy = $T");
		mysqli_query($db, "UPDATE PHRASING         SET coinedBy  = $S WHERE coinedBy  = $T");
		mysqli_query($db, "UPDATE PHRASING_ARCHIVE SET coinedBy  = $S WHERE coinedBy  = $T");

		// D. Any group ownership passes to the sentinel (flagged to the admin).
		mysqli_query($db, "UPDATE AFFILIATION SET adminID   = $S WHERE adminID   = $T");
		mysqli_query($db, "UPDATE AFFILIATION SET createdBy = $S WHERE createdBy = $T");

		// E. Invitations: unlink T as consumer/captain; drop the ones T created.
		mysqli_query($db, "UPDATE INVITATION SET usedBy = NULL           WHERE usedBy = $T");
		mysqli_query($db, "UPDATE INVITATION SET captainProfileID = NULL WHERE captainProfileID = $T");
		mysqli_query($db, "DELETE FROM INVITATION WHERE createdBy = $T");

		// F. Remove the profile — blocks all future login.
		mysqli_query($db, "DELETE FROM USER_PROFILE WHERE profileID = $T");

		mysqli_commit($db);
	} catch (\Throwable $ex) {
		mysqli_rollback($db);
		mysqli_report(MYSQLI_REPORT_OFF);
		throw $ex;
	}
	mysqli_report(MYSQLI_REPORT_OFF);
	return ['deletedArgs' => count($toDelete), 'keptArgs' => $keptCount];
}

$arg    = isset($_GET['arg']) ? intval($_GET['arg']) : 75;
$saved  = isset($_GET['saved']);
$merged       = isset($_GET['merged']) ? intval($_GET['merged']) : null;
$groupCreated = isset($_GET['groupCreated']) ? $_GET['groupCreated'] : null;
$errors = [];
$mergePreview = null;
$deletePreview = null;
$userDeleted  = isset($_GET['userDeleted']);

// ---------- Handle form submissions ----------
if (isset($_POST['adminAction'])) {
	switch ($_POST['adminAction']) {

		case 'savePickerSettings':
			$type = $_POST['pickerType'] ?? 'none';
			if (!in_array($type, ['none', 'all', 'manual', 'auto'], true)) $type = 'none';
			$enabled = ($type !== 'none') ? 1 : 0;
			$raw     = trim($_POST['pickerProfiles'] ?? '');
			$ids     = [];
			if ($raw !== '') {
				$ids = array_slice(
					array_unique(array_filter(array_map('intval', preg_split('/[\s,]+/', $raw)))),
					0, 10
				);
				$ids = array_values(array_filter($ids, fn($id) => $id !== $realProfileID && $id > 0));
			}
			$profilesStr = implode(',', $ids);
			$stmt = $db->prepare(
				"INSERT INTO ADMIN_SETTINGS (profileID, pickerEnabled, pickerType, pickerProfiles)
				 VALUES (?, ?, ?, ?)
				 ON DUPLICATE KEY UPDATE pickerEnabled  = VALUES(pickerEnabled),
				                         pickerType     = VALUES(pickerType),
				                         pickerProfiles = VALUES(pickerProfiles)"
			);
			$stmt->bind_param("iiss", $realProfileID, $enabled, $type, $profilesStr);
			$stmt->execute();
			mysqli_close($db);
			header("Location: /admin_tools.php?arg=$arg&saved=1");
			exit;

		case 'saveDemoSettings':
			$demoOn = isset($_POST['demoMode']) ? 1 : 0;
			$stmt = $db->prepare(
				"INSERT INTO ADMIN_SETTINGS (profileID, demoMode)
				 VALUES (?, ?)
				 ON DUPLICATE KEY UPDATE demoMode = VALUES(demoMode)"
			);
			$stmt->bind_param("ii", $realProfileID, $demoOn);
			$stmt->execute();
			mysqli_close($db);
			header("Location: /admin_tools.php?arg=$arg&saved=1");
			exit;

		case 'executeMerge':
			$keepID = intval($_POST['mergeArgA'] ?? 0);
			$dropID = intval($_POST['mergeArgB'] ?? 0);
			if ($keepID <= 0 || $dropID <= 0 || $keepID === $dropID) {
				$errors[] = 'Invalid argument IDs for merge.';
				break;
			}
			$result = mysqli_query($db, "CALL mergeArguments($keepID, $dropID)");
			if ($result !== false) {
				while (mysqli_more_results($db)) { mysqli_next_result($db); }
				mysqli_close($db);
				header("Location: /admin_tools.php?arg=$arg&merged=$keepID");
				exit;
			} else {
				$errors[] = 'Merge failed: ' . mysqli_error($db);
			}
			break;

		case 'previewMerge':
			$argA = intval($_POST['mergeArgA'] ?? 0);
			$argB = intval($_POST['mergeArgB'] ?? 0);
			if ($argA <= 0 || $argB <= 0)  { $errors[] = 'Both argument IDs are required.'; break; }
			if ($argA === $argB)            { $errors[] = 'The two argument IDs must be different.'; break; }
			$rowA = mysqli_fetch_assoc(mysqli_query($db,
				"SELECT argumentID, currentPhrasing FROM ARGUMENT WHERE argumentID=$argA"));
			$rowB = mysqli_fetch_assoc(mysqli_query($db,
				"SELECT argumentID, currentPhrasing FROM ARGUMENT WHERE argumentID=$argB"));
			if (!$rowA) { $errors[] = "Argument ID $argA not found."; break; }
			if (!$rowB) { $errors[] = "Argument ID $argB not found."; break; }
			$mergePreview = ['a' => $rowA, 'b' => $rowB];
			break;

		case 'createGroup':
			$groupName  = trim($_POST['groupName']  ?? '');
			$groupDesc  = trim($_POST['groupDesc']  ?? '');
			$groupPublic = intval($_POST['groupPublic'] ?? 1) ? 1 : 0;
			$memberCap  = min(200, max(1, intval($_POST['memberCapacity'] ?? 10)));
			$captainEmail = trim($_POST['captainEmail'] ?? '');

			if ($groupName === '')  { $errors[] = 'Group name is required.'; break; }
			if (strlen($groupName) > 100) { $errors[] = 'Group name must be 100 characters or less.'; break; }
			if ($captainEmail === '') { $errors[] = 'Captain email is required.'; break; }

			$cStmt = $db->prepare("SELECT profileID FROM USER_PROFILE WHERE email = ? LIMIT 1");
			$cStmt->bind_param("s", $captainEmail);
			$cStmt->execute();
			$captainRow = $cStmt->get_result()->fetch_assoc();
			$cStmt->close();
			if (!$captainRow) { $errors[] = 'No account found for email: ' . htmlspecialchars($captainEmail); break; }
			$captainProfileID = intval($captainRow['profileID']);

			$gStmt = $db->prepare(
				"INSERT INTO AFFILIATION (orgName, public, description, adminID, createdBy, createdDate)
				 VALUES (?, ?, ?, ?, ?, NOW())"
			);
			$gStmt->bind_param("sisii", $groupName, $groupPublic, $groupDesc, $realProfileID, $realProfileID);
			$gStmt->execute();
			$newAffID = intval($gStmt->insert_id);
			$gStmt->close();

			$mStmt = $db->prepare(
				"INSERT INTO MEMBER (affiliationID, profileID, dateAdded, isCaptain) VALUES (?, ?, NOW(), 1)"
			);
			$mStmt->bind_param("ii", $newAffID, $captainProfileID);
			$mStmt->execute();
			$mStmt->close();

			$iStmt = $db->prepare(
				"INSERT INTO INVITATION (code, createdBy, affiliationID, usesTotal, usesRemaining, captainProfileID)
				 VALUES (?, ?, ?, 1, 1, ?)"
			);
			for ($i = 0; $i < $memberCap; $i++) {
				$code = bin2hex(random_bytes(16));
				$iStmt->bind_param("siii", $code, $realProfileID, $newAffID, $captainProfileID);
				$iStmt->execute();
			}
			$iStmt->close();
			mysqli_close($db);
			header("Location: /admin_tools.php?arg=$arg&groupCreated=" . urlencode($groupName));
			exit;

		case 'generateInvites':
			$qty = min(20, max(1, intval($_POST['inviteQty'] ?? 1)));
			$stmt = $db->prepare(
				"INSERT INTO INVITATION (code, createdBy) VALUES (?, ?)"
			);
			for ($i = 0; $i < $qty; $i++) {
				$code = bin2hex(random_bytes(16));
				$stmt->bind_param("si", $code, $realProfileID);
				$stmt->execute();
			}
			mysqli_close($db);
			header("Location: /admin_tools.php?arg=$arg&invites=1");
			exit;

		case 'revokeInvite':
			$inviteID = intval($_POST['inviteID'] ?? 0);
			if ($inviteID > 0) {
				$stmt = $db->prepare(
					"DELETE FROM INVITATION WHERE inviteID = ? AND usedBy IS NULL AND createdBy = ?"
				);
				$stmt->bind_param("ii", $inviteID, $realProfileID);
				$stmt->execute();
			}
			mysqli_close($db);
			header("Location: /admin_tools.php?arg=$arg");
			exit;

		case 'resolveFlags':
			$flagArgID = intval($_POST['flagArgID'] ?? 0);
			if ($flagArgID > 0) {
				mysqli_query($db, "CALL resolveArgumentFlags($flagArgID, $realProfileID)");
				while (mysqli_more_results($db)) { mysqli_next_result($db); }
			}
			mysqli_close($db);
			header("Location: /admin_tools.php?arg=$arg&resolved=$flagArgID");
			exit;

		case 'previewDeleteUser':
			$target = agitate_resolve_user($db, $_POST['deleteUserQuery'] ?? '');
			if (!$target) {
				$errors[] = 'No account found for that profile ID or email.';
				break;
			}
			if (intval($target['profileID']) === $realProfileID) {
				$errors[] = 'You cannot remove your own account here.';
				break;
			}
			if (intval($target['isAdmin']) === 1) {
				$errors[] = 'That account is an admin. Remove its admin flag in the database before deleting it.';
				break;
			}
			$deletePreview = [
				'target' => $target,
				'counts' => agitate_preview_user_deletion($db, intval($target['profileID'])),
			];
			break;

		case 'executeDeleteUser':
			$targetID   = intval($_POST['deleteUserID'] ?? 0);
			$confirmTxt = trim($_POST['confirmEmail'] ?? '');
			$target = $targetID > 0 ? agitate_resolve_user($db, (string)$targetID) : null;

			if (!$target) {
				$errors[] = 'That account no longer exists.';
				break;
			}
			if ($targetID === $realProfileID) {
				$errors[] = 'You cannot remove your own account here.';
				break;
			}
			if (intval($target['isAdmin']) === 1) {
				$errors[] = 'That account is an admin. Remove its admin flag before deleting it.';
				break;
			}
			if (strcasecmp($confirmTxt, $target['email']) !== 0) {
				$errors[] = 'Confirmation text did not match the account email. Nothing was deleted.';
				$deletePreview = ['target' => $target, 'counts' => agitate_preview_user_deletion($db, $targetID)];
				break;
			}

			$sentinelID = agitate_get_sentinel_id($db);
			try {
				$res = agitate_delete_user($db, $targetID, $sentinelID);
			} catch (\Throwable $ex) {
				$errors[] = 'Deletion failed and was rolled back: ' . $ex->getMessage();
				break;
			}
			$dName = trim(($target['firstName'] ?? '') . ' ' . ($target['lastName'] ?? ''));
			mysqli_close($db);
			header("Location: /admin_tools.php?arg=$arg&userDeleted=1"
				. "&dName=" . urlencode($dName !== '' ? $dName : $target['email'])
				. "&dArgs=" . intval($res['deletedArgs'])
				. "&kArgs=" . intval($res['keptArgs']));
			exit;
	}
}

// ---------- Load current settings ----------
$invitesSaved = isset($_GET['invites']);
$settRow        = mysqli_fetch_assoc(mysqli_query($db,
	"SELECT pickerEnabled, pickerType, pickerProfiles, demoMode FROM ADMIN_SETTINGS WHERE profileID=$realProfileID"));
$pickerType     = $settRow ? ($settRow['pickerType'] ?? 'none') : 'none';
$pickerProfiles = $settRow ? ($settRow['pickerProfiles'] ?? '') : '';
$demoMode       = $settRow ? intval($settRow['demoMode'] ?? 0) : 0;

$mergeArgA = intval($_POST['mergeArgA'] ?? 0) ?: '';
$mergeArgB = intval($_POST['mergeArgB'] ?? 0) ?: '';

// Load invite codes
$inviteResult = mysqli_query($db,
	"SELECT i.inviteID, i.code, i.createdAt, i.expiresAt, i.usedAt,
	        i.affiliationID,
	        CONCAT(up.firstName, ' ', up.lastName) AS usedByName,
	        a.orgName AS groupName
	 FROM INVITATION i
	 LEFT JOIN USER_PROFILE up ON up.profileID = i.usedBy
	 LEFT JOIN AFFILIATION a ON a.affiliationID = i.affiliationID
	 WHERE i.createdBy = $realProfileID
	 ORDER BY COALESCE(i.affiliationID, 0) DESC, i.createdAt DESC
	 LIMIT 500");
$invites = [];
while ($row = mysqli_fetch_assoc($inviteResult)) { $invites[] = $row; }

// Load active flags, grouped by argument (newest flag first within each group)
$flagResult = mysqli_query($db,
	"SELECT f.argumentID, a.currentPhrasing, f.profileID,
	        CONCAT(up.firstName, ' ', up.lastName) AS flaggerName,
	        f.reasonCategory, f.comment, f.createdAt
	 FROM ARGUMENT_FLAG f
	 JOIN ARGUMENT a ON a.argumentID = f.argumentID
	 LEFT JOIN USER_PROFILE up ON up.profileID = f.profileID
	 WHERE f.isActive = 1
	 ORDER BY f.createdAt DESC");
$flagged = [];
while ($row = mysqli_fetch_assoc($flagResult)) {
	$aid = intval($row['argumentID']);
	if (!isset($flagged[$aid])) {
		$flagged[$aid] = ['argumentID' => $aid, 'phrasing' => $row['currentPhrasing'], 'flags' => []];
	}
	$flagged[$aid]['flags'][] = $row;
}
// Most-flagged argument first
uasort($flagged, fn($a, $b) => count($b['flags']) <=> count($a['flags']));

$flagCatLabels = [
	'offensive'         => 'Offensive / inappropriate',
	'phrasing_mismatch' => 'Phrasing mismatch',
	'duplicate_assoc'   => 'Duplicated associations',
	'spam'              => 'Spam / off-topic',
	'incoherent'        => 'Incomprehensible',
	'other'             => 'Other',
];

mysqli_close($db);
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Admin Tools — Agitate</title>
	<style>
		body { font-family: sans-serif; font-size: 15px; margin: 0; padding: 1rem 1.5rem; color: #111; background: #fff; }
		a { color: #2d58a8; }
		h1 { font-size: 1.3rem; margin: 0 0 0.25rem; }
		h2 { font-size: 1rem; margin: 1.75rem 0 0.4rem; border-bottom: 1px solid #ddd; padding-bottom: 0.25rem; }
		p.desc { color: #555; font-size: 0.875rem; margin: 0 0 0.75rem; }
		label { display: block; font-size: 0.875rem; margin-bottom: 0.2rem; }
		input[type="text"], input[type="number"] { border: 1px solid #bbb; border-radius: 3px; font-size: 0.9rem; padding: 0.35rem 0.5rem; }
		input[type="text"] { width: 280px; max-width: 100%; }
		input[type="number"] { width: 90px; }
		/* Merge ID fields: no spinner arrows (they get bumped by stray clicks/touches) */
		#mergeArgA, #mergeArgB { -moz-appearance: textfield; appearance: textfield; }
		#mergeArgA::-webkit-outer-spin-button, #mergeArgA::-webkit-inner-spin-button,
		#mergeArgB::-webkit-outer-spin-button, #mergeArgB::-webkit-inner-spin-button {
			-webkit-appearance: none; margin: 0;
		}
		.field { margin-bottom: 0.85rem; }
		button { font-size: 0.875rem; padding: 0.35rem 0.85rem; cursor: pointer; }
		.notice { background: #eef; border: 1px solid #99b; border-radius: 3px; padding: 0.5rem 0.75rem; margin-bottom: 1rem; font-size: 0.875rem; }
		.notice.error { background: #fee; border-color: #f99; }
		.merge-preview { border: 1px solid #ddd; border-radius: 4px; margin: 1rem 0; padding: 0.75rem 1rem; background: #fafafa; }
		.merge-preview p { margin: 0.25rem 0; font-size: 0.9rem; }
		.merge-preview strong { font-size: 0.8rem; text-transform: uppercase; color: #555; }
		hr.divider { border: none; border-top: 1px solid #eee; margin: 1rem 0; }
		nav { margin-bottom: 1.25rem; font-size: 0.875rem; }
		nav a { margin-right: 1.25rem; }
		.flag-card { border: 1px solid #ddd; border-radius: 4px; margin: 0.5rem 0; background: #fff; }
		.flag-card summary { cursor: pointer; padding: 0.5rem 0.75rem; list-style: none; display: flex; align-items: baseline; gap: 0.6rem; }
		.flag-card summary::-webkit-details-marker { display: none; }
		.flag-count { display: inline-block; min-width: 1.5rem; text-align: center; background: #af1a17; color: #fff; border-radius: 10px; font-size: 0.8rem; font-weight: bold; padding: 0.05rem 0.4rem; }
		.flag-arg { font-size: 0.9rem; }
		.flag-card-body { padding: 0 0.75rem 0.75rem; }
		.flag-card-body table { width: 100%; border-collapse: collapse; font-size: 0.82rem; margin: 0.4rem 0 0.6rem; }
		.flag-card-body th, .flag-card-body td { text-align: left; padding: 0.3rem 0.5rem; border-bottom: 1px solid #eee; vertical-align: top; }
		.flag-cat-tag { display: inline-block; background: #eee; border-radius: 3px; padding: 0.05rem 0.4rem; font-size: 0.78rem; white-space: nowrap; }
		h3.sub-h3 { font-size: 0.9rem; font-weight: 600; margin: 1.1rem 0 0.2rem; color: #333; }
		.danger-h2 { color: #af1a17; border-bottom-color: #f0b3b2; }
		.danger-preview { border-color: #e0a0a0; background: #fdf4f4; }
		.danger-btn { background: #af1a17; color: #fff; border: 1px solid #8f1512; border-radius: 3px; font-weight: 600; }
	</style>
</head>
<body>

<h1>Admin Tools</h1>
<nav>
	<a href="/?arg=<?php echo $arg; ?>">← Back to site</a>
	<a href="/admin_content.php">Content</a>
	<a href="/Profile.php?arg=<?php echo $arg; ?>">Profile</a>
	<a href="/logout.php?arg=<?php echo $arg; ?>">Logout</a>
</nav>

<?php if ($saved): ?>
<div class="notice">Settings saved.</div>
<?php endif; ?>

<?php if ($merged): ?>
<div class="notice">Merge complete. Argument #<?php echo $merged; ?> is now the consolidated record. <a href="/?arg=<?php echo $merged; ?>">View it →</a></div>
<?php endif; ?>

<?php if ($userDeleted): ?>
<div class="notice">
	Removed <strong><?php echo htmlspecialchars($_GET['dName'] ?? 'the account'); ?></strong>.
	<?php $ka = intval($_GET['kArgs'] ?? 0); $da = intval($_GET['dArgs'] ?? 0); ?>
	<?php echo $ka; ?> argument<?php echo $ka === 1 ? '' : 's'; ?> preserved and anonymized;
	<?php echo $da; ?> untouched argument<?php echo $da === 1 ? '' : 's'; ?> deleted.
	Their personal data and login are gone.
</div>
<?php endif; ?>

<?php if (!empty($errors)): ?>
<div class="notice error">
	<?php foreach ($errors as $e) echo '<p>' . htmlspecialchars($e) . '</p>'; ?>
</div>
<?php endif; ?>

<!-- ── Profile Picker ─────────────────────────── -->
<h2>Profile Picker</h2>
<p class="desc">A bar at the top of each page lets you quickly switch which profile you view and act as. Choose one mode (the two cannot be on at once).</p>

<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>">
	<input type="hidden" name="adminAction" value="savePickerSettings">

	<div class="field">
		<label><input type="radio" name="pickerType" value="none"
			<?php if ($pickerType === 'none') echo 'checked'; ?>> Off</label>
		<label><input type="radio" name="pickerType" value="all"
			<?php if ($pickerType === 'all') echo 'checked'; ?>> All personas — all 26 seed users arranged left-to-right by ideology, color-coded</label>
		<label><input type="radio" name="pickerType" value="auto"
			<?php if ($pickerType === 'auto') echo 'checked'; ?>> Personas with an opinion — every persona (IDs 1&ndash;26) that has an opinion on the argument being viewed, plus you</label>
		<label><input type="radio" name="pickerType" value="manual"
			<?php if ($pickerType === 'manual') echo 'checked'; ?>> Manual list — the specific profiles you list below</label>
	</div>

	<div class="field">
		<label for="pickerProfiles">Manual list — additional profile IDs (comma-separated, up to 10 — your own is always included)</label>
		<input type="text" id="pickerProfiles" name="pickerProfiles"
			placeholder="e.g. 3, 7, 12"
			value="<?php echo htmlspecialchars($pickerProfiles); ?>">
	</div>

	<div class="field">
		<button type="submit">Save picker settings</button>
	</div>
</form>

<hr class="divider">

<!-- ── Demo Mode ───────────────────────────── -->
<h2>Demo Mode</h2>
<p class="desc">Stabilizes the mobile view for screen recording. Suppresses iOS auto-zoom on inputs, scroll-to-focus jumps, and rubber-band overscroll. Applies site-wide while enabled.</p>

<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>">
	<input type="hidden" name="adminAction" value="saveDemoSettings">

	<div class="field">
		<label><input type="checkbox" name="demoMode" value="1"
			<?php if ($demoMode) echo 'checked'; ?>> Enable demo mode</label>
	</div>

	<div class="field">
		<button type="submit">Save demo settings</button>
	</div>
</form>

<hr class="divider">

<!-- ── Merge Arguments ───────────────────────── -->
<h2>Merge Arguments</h2>
<p class="desc">Consolidate two duplicate arguments into one. Preview both before committing the merge.</p>

<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>">
	<input type="hidden" name="adminAction" value="previewMerge">
	<div class="field">
		<label for="mergeArgA">Argument A — keep this one</label>
		<input type="number" id="mergeArgA" name="mergeArgA" placeholder="ID" min="1"
			value="<?php echo htmlspecialchars($mergeArgA); ?>">
	</div>
	<div class="field">
		<label for="mergeArgB">Argument B — absorb into A</label>
		<input type="number" id="mergeArgB" name="mergeArgB" placeholder="ID" min="1"
			value="<?php echo htmlspecialchars($mergeArgB); ?>">
	</div>
	<div class="field">
		<button type="submit">Preview merge</button>
	</div>
</form>

<?php if ($mergePreview): ?>
<div class="merge-preview">
	<strong>Keep — #<?php echo $mergePreview['a']['argumentID']; ?></strong>
	<p><?php echo htmlspecialchars($mergePreview['a']['currentPhrasing']); ?></p>
	<p><a href="/?arg=<?php echo $mergePreview['a']['argumentID']; ?>" target="_blank">View argument ↗</a></p>
	<hr class="divider">
	<strong>Absorb into A — #<?php echo $mergePreview['b']['argumentID']; ?></strong>
	<p><?php echo htmlspecialchars($mergePreview['b']['currentPhrasing']); ?></p>
	<p><a href="/?arg=<?php echo $mergePreview['b']['argumentID']; ?>" target="_blank">View argument ↗</a></p>
</div>
<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>">
	<input type="hidden" name="adminAction" value="executeMerge">
	<input type="hidden" name="mergeArgA" value="<?php echo $mergePreview['a']['argumentID']; ?>">
	<input type="hidden" name="mergeArgB" value="<?php echo $mergePreview['b']['argumentID']; ?>">
	<div class="field">
		<button type="submit" onclick="return confirm('Merge argument #<?php echo $mergePreview['b']['argumentID']; ?> into #<?php echo $mergePreview['a']['argumentID']; ?>? This cannot be undone.')">Confirm merge</button>
	</div>
</form>
<?php endif; ?>

<hr class="divider">

<!-- ── Invite Codes ───────────────────────────── -->
<h2>Invite Codes</h2>

<?php if ($groupCreated): ?>
<div class="notice">Group "<?php echo htmlspecialchars($groupCreated); ?>" created with invite codes.</div>
<?php endif; ?>

<?php if ($invitesSaved): ?>
<div class="notice">Platform invite codes generated.</div>
<?php endif; ?>

<h3 class="sub-h3">Create a Group</h3>
<p class="desc">Creates a group, designates a captain by email, and generates invite codes up to the member capacity.</p>

<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>">
	<input type="hidden" name="adminAction" value="createGroup">
	<div class="field">
		<label for="groupName">Group name</label>
		<input type="text" id="groupName" name="groupName" placeholder="e.g. Socratic Debate Club" maxlength="100">
	</div>
	<div class="field">
		<label for="groupDesc">Description</label>
		<input type="text" id="groupDesc" name="groupDesc" placeholder="Optional" maxlength="500" style="width:400px;max-width:100%;">
	</div>
	<div class="field">
		<label>Visibility</label>
		<label><input type="radio" name="groupPublic" value="1" checked> Public — discoverable in group search</label>
		<label><input type="radio" name="groupPublic" value="0"> Private — invite-only, not listed</label>
	</div>
	<div class="field">
		<label for="memberCapacity">Member capacity — invite codes to generate (max 200)</label>
		<input type="number" id="memberCapacity" name="memberCapacity" value="10" min="1" max="200">
	</div>
	<div class="field">
		<label for="captainEmail">Captain email</label>
		<input type="text" id="captainEmail" name="captainEmail" placeholder="captain@example.com">
	</div>
	<div class="field">
		<button type="submit">Create group</button>
	</div>
</form>

<hr class="divider">

<h3 class="sub-h3">Platform Invites</h3>
<p class="desc">Single-use links for registering a new account, not tied to any group. Each code expires 7 days after creation.</p>

<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>">
	<input type="hidden" name="adminAction" value="generateInvites">
	<div class="field">
		<label for="inviteQty">Number of codes to generate (max 20)</label>
		<input type="number" id="inviteQty" name="inviteQty" value="1" min="1" max="20">
	</div>
	<div class="field">
		<button type="submit">Generate</button>
	</div>
</form>

<?php if (!empty($invites)): ?>
<table style="width:100%;border-collapse:collapse;font-size:0.85rem;margin-top:0.75rem;">
	<thead>
		<tr style="text-align:left;border-bottom:1px solid #ddd;">
			<th style="padding:0.35rem 0.5rem;">Group</th>
			<th style="padding:0.35rem 0.5rem;">Link</th>
			<th style="padding:0.35rem 0.5rem;">Created</th>
			<th style="padding:0.35rem 0.5rem;">Expires</th>
			<th style="padding:0.35rem 0.5rem;">Status</th>
			<th style="padding:0.35rem 0.5rem;"></th>
		</tr>
	</thead>
	<tbody>
	<?php foreach ($invites as $inv):
		$used      = $inv['usedAt'] !== null;
		$expired   = !$used && strtotime($inv['expiresAt']) < time();
		$status    = $used ? '✓ Used by ' . htmlspecialchars($inv['usedByName']) : ($expired ? 'Expired' : 'Pending');
		$rowColor  = $used ? '#f6fff6' : ($expired ? '#fff6f6' : '#fff');
		$link      = 'https://agitate-discourse.org/register.php?code=' . $inv['code'];
		$groupLabel = $inv['groupName'] ? htmlspecialchars($inv['groupName']) : '<span style="color:#aaa;">Platform</span>';
	?>
	<tr style="border-bottom:1px solid #eee;background:<?php echo $rowColor; ?>">
		<td style="padding:0.35rem 0.5rem;white-space:nowrap;"><?php echo $groupLabel; ?></td>
		<td style="padding:0.35rem 0.5rem;word-break:break-all;">
			<?php if (!$used && !$expired): ?>
				<a href="<?php echo $link; ?>" target="_blank"><?php echo $link; ?></a>
			<?php else: ?>
				<span style="color:#aaa;"><?php echo $link; ?></span>
			<?php endif; ?>
		</td>
		<td style="padding:0.35rem 0.5rem;white-space:nowrap;"><?php echo date('M j, Y', strtotime($inv['createdAt'])); ?></td>
		<td style="padding:0.35rem 0.5rem;white-space:nowrap;"><?php echo date('M j, Y', strtotime($inv['expiresAt'])); ?></td>
		<td style="padding:0.35rem 0.5rem;white-space:nowrap;"><?php echo $status; ?></td>
		<td style="padding:0.35rem 0.5rem;">
			<?php if (!$used && !$expired): ?>
			<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>" style="margin:0;">
				<input type="hidden" name="adminAction" value="revokeInvite">
				<input type="hidden" name="inviteID" value="<?php echo intval($inv['inviteID']); ?>">
				<button type="submit" onclick="return confirm('Revoke this invite?')" style="font-size:0.75rem;padding:0.2rem 0.5rem;">Revoke</button>
			</form>
			<?php endif; ?>
		</td>
	</tr>
	<?php endforeach; ?>
	</tbody>
</table>
<?php endif; ?>

<hr class="divider">

<!-- ── Flagged Arguments ─────────────────────── -->
<h2>Flagged Arguments</h2>
<p class="desc">Arguments users have flagged, most-flagged first. Expand a row to see each flag, then resolve them all in one click. Resolved flags are kept for audit.</p>

<?php if (isset($_GET['resolved'])): ?>
<div class="notice">Flags resolved for argument #<?php echo intval($_GET['resolved']); ?>.</div>
<?php endif; ?>

<?php if (empty($flagged)): ?>
<p class="desc">No active flags.</p>
<?php else: ?>
<?php foreach ($flagged as $fa): $cnt = count($fa['flags']); ?>
<details class="flag-card">
	<summary>
		<span class="flag-count"><?php echo $cnt; ?></span>
		<span class="flag-arg">#<?php echo $fa['argumentID']; ?> — <?php echo htmlspecialchars($fa['phrasing']); ?></span>
	</summary>
	<div class="flag-card-body">
		<p><a href="/?arg=<?php echo $fa['argumentID']; ?>" target="_blank">View argument ↗</a></p>
		<table>
			<thead>
				<tr><th>Who</th><th>Reason</th><th>Comment</th><th>When</th></tr>
			</thead>
			<tbody>
			<?php foreach ($fa['flags'] as $fl):
				$catLabel = $flagCatLabels[$fl['reasonCategory']] ?? $fl['reasonCategory'];
			?>
				<tr>
					<td><?php echo htmlspecialchars(trim($fl['flaggerName']) ?: ('#' . $fl['profileID'])); ?></td>
					<td><span class="flag-cat-tag"><?php echo htmlspecialchars($catLabel); ?></span></td>
					<td><?php echo $fl['comment'] !== null && $fl['comment'] !== '' ? htmlspecialchars($fl['comment']) : '<span style="color:#aaa;">—</span>'; ?></td>
					<td style="white-space:nowrap;"><?php echo date('M j, Y', strtotime($fl['createdAt'])); ?></td>
				</tr>
			<?php endforeach; ?>
			</tbody>
		</table>
		<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>" style="margin:0;">
			<input type="hidden" name="adminAction" value="resolveFlags">
			<input type="hidden" name="flagArgID" value="<?php echo $fa['argumentID']; ?>">
			<button type="submit" onclick="return confirm('Resolve all <?php echo $cnt; ?> flag(s) for argument #<?php echo $fa['argumentID']; ?>?')">Resolve all flags</button>
		</form>
	</div>
</details>
<?php endforeach; ?>
<?php endif; ?>

<hr class="divider">

<!-- ── Remove a User ─────────────────────────── -->
<h2 class="danger-h2">Remove a User</h2>
<p class="desc">
	Permanently removes an account and blocks any future login. Their opinions,
	endorsements, flags, group memberships, and personal profile are deleted.
	Arguments they wrote are <strong>kept and anonymized</strong> if anyone else has
	engaged with them, and any phrasing they coined on a surviving argument is kept —
	otherwise untouched arguments are deleted outright. This cannot be undone.
</p>

<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>">
	<input type="hidden" name="adminAction" value="previewDeleteUser">
	<div class="field">
		<label for="deleteUserQuery">Profile ID or email</label>
		<input type="text" id="deleteUserQuery" name="deleteUserQuery" placeholder="e.g. 87 or someone@example.com">
	</div>
	<div class="field">
		<button type="submit">Preview removal</button>
	</div>
</form>

<?php if ($deletePreview):
	$t = $deletePreview['target']; $c = $deletePreview['counts'];
	$tName = trim(($t['firstName'] ?? '') . ' ' . ($t['lastName'] ?? ''));
?>
<div class="merge-preview danger-preview">
	<strong>About to remove — #<?php echo intval($t['profileID']); ?></strong>
	<p><?php echo htmlspecialchars($tName !== '' ? $tName : '(no name)'); ?> &lt;<?php echo htmlspecialchars($t['email']); ?>&gt;</p>
	<ul style="margin:0.5rem 0 0.75rem 1.1rem;font-size:0.875rem;">
		<li><strong><?php echo $c['preserved']; ?></strong> authored argument<?php echo $c['preserved'] === 1 ? '' : 's'; ?> kept &amp; anonymized (others have engaged)</li>
		<li><strong><?php echo $c['deletedArgs']; ?></strong> untouched argument<?php echo $c['deletedArgs'] === 1 ? '' : 's'; ?> deleted entirely</li>
		<li><strong><?php echo $c['phrasings']; ?></strong> coined phrasing<?php echo $c['phrasings'] === 1 ? '' : 's'; ?> (kept where the argument survives)</li>
		<li><strong><?php echo $c['opinions']; ?></strong> opinion<?php echo $c['opinions'] === 1 ? '' : 's'; ?>, <strong><?php echo $c['endorsements']; ?></strong> endorsement<?php echo $c['endorsements'] === 1 ? '' : 's'; ?>, <strong><?php echo $c['flags']; ?></strong> flag<?php echo $c['flags'] === 1 ? '' : 's'; ?>, <strong><?php echo $c['explications']; ?></strong> source<?php echo $c['explications'] === 1 ? '' : 's'; ?> removed</li>
		<?php if ($c['groupsAdmin'] > 0): ?>
		<li style="color:#af1a17;">⚠ Administers <strong><?php echo $c['groupsAdmin']; ?></strong> group<?php echo $c['groupsAdmin'] === 1 ? '' : 's'; ?> — ownership will pass to the "[deleted user]" placeholder. Reassign a real admin afterward.</li>
		<?php endif; ?>
	</ul>
	<form method="POST" action="/admin_tools.php?arg=<?php echo $arg; ?>" style="margin:0;">
		<input type="hidden" name="adminAction" value="executeDeleteUser">
		<input type="hidden" name="deleteUserID" value="<?php echo intval($t['profileID']); ?>">
		<div class="field">
			<label for="confirmEmail">Type <strong><?php echo htmlspecialchars($t['email']); ?></strong> to confirm</label>
			<input type="text" id="confirmEmail" name="confirmEmail" autocomplete="off" placeholder="<?php echo htmlspecialchars($t['email']); ?>">
		</div>
		<button type="submit" class="danger-btn"
			onclick="return confirm('Permanently remove #<?php echo intval($t['profileID']); ?> (<?php echo htmlspecialchars($t['email']); ?>)? This cannot be undone.')">
			Remove permanently
		</button>
	</form>
</div>
<?php endif; ?>

</body>
</html>
