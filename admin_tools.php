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

$arg    = isset($_GET['arg']) ? intval($_GET['arg']) : 75;
$saved  = isset($_GET['saved']);
$merged = isset($_GET['merged']) ? intval($_GET['merged']) : null;
$errors = [];
$mergePreview = null;

// ---------- Handle form submissions ----------
if (isset($_POST['adminAction'])) {
	switch ($_POST['adminAction']) {

		case 'savePickerSettings':
			$type = $_POST['pickerType'] ?? 'none';
			if (!in_array($type, ['none', 'manual', 'auto'], true)) $type = 'none';
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
	}
}

// ---------- Load current settings ----------
$invitesSaved = isset($_GET['invites']);
$settRow        = mysqli_fetch_assoc(mysqli_query($db,
	"SELECT pickerEnabled, pickerType, pickerProfiles FROM ADMIN_SETTINGS WHERE profileID=$realProfileID"));
$pickerType     = $settRow ? ($settRow['pickerType'] ?? 'none') : 'none';
$pickerProfiles = $settRow ? ($settRow['pickerProfiles'] ?? '') : '';

$mergeArgA = intval($_POST['mergeArgA'] ?? 0) ?: '';
$mergeArgB = intval($_POST['mergeArgB'] ?? 0) ?: '';

// Load invite codes
$inviteResult = mysqli_query($db,
	"SELECT i.inviteID, i.code, i.createdAt, i.expiresAt, i.usedAt,
	        CONCAT(up.firstName, ' ', up.lastName) AS usedByName
	 FROM INVITATION i
	 LEFT JOIN USER_PROFILE up ON up.profileID = i.usedBy
	 WHERE i.createdBy = $realProfileID
	 ORDER BY i.createdAt DESC
	 LIMIT 100");
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
	</style>
</head>
<body>

<h1>Admin Tools</h1>
<nav>
	<a href="/?arg=<?php echo $arg; ?>">← Back to site</a>
	<a href="/Profile.php?arg=<?php echo $arg; ?>">Profile</a>
	<a href="/logout.php?arg=<?php echo $arg; ?>">Logout</a>
</nav>

<?php if ($saved): ?>
<div class="notice">Settings saved.</div>
<?php endif; ?>

<?php if ($merged): ?>
<div class="notice">Merge complete. Argument #<?php echo $merged; ?> is now the consolidated record. <a href="/?arg=<?php echo $merged; ?>">View it →</a></div>
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
		<label><input type="radio" name="pickerType" value="manual"
			<?php if ($pickerType === 'manual') echo 'checked'; ?>> Manual list — the specific profiles you list below</label>
		<label><input type="radio" name="pickerType" value="auto"
			<?php if ($pickerType === 'auto') echo 'checked'; ?>> Personas with an opinion — every persona (IDs 1&ndash;26) that has an opinion on the argument being viewed, plus you</label>
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
<p class="desc">Generate single-use invitation links. Each code expires 7 days after creation.</p>

<?php if ($invitesSaved): ?>
<div class="notice">Invite codes generated.</div>
<?php endif; ?>

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
			<th style="padding:0.35rem 0.5rem;">Link</th>
			<th style="padding:0.35rem 0.5rem;">Created</th>
			<th style="padding:0.35rem 0.5rem;">Expires</th>
			<th style="padding:0.35rem 0.5rem;">Status</th>
			<th style="padding:0.35rem 0.5rem;"></th>
		</tr>
	</thead>
	<tbody>
	<?php foreach ($invites as $inv):
		$used    = $inv['usedAt'] !== null;
		$expired = !$used && strtotime($inv['expiresAt']) < time();
		$status  = $used ? '✓ Used by ' . htmlspecialchars($inv['usedByName']) : ($expired ? 'Expired' : 'Pending');
		$rowColor = $used ? '#f6fff6' : ($expired ? '#fff6f6' : '#fff');
		$link    = 'https://agitate-discourse.org/register.php?code=' . $inv['code'];
	?>
	<tr style="border-bottom:1px solid #eee;background:<?php echo $rowColor; ?>">
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

</body>
</html>
