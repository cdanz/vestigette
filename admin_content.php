<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php"); // content_parse_tags()

// ---- Auth (admin only) ----
if (isset($_SESSION['profile']) && !isset($_SESSION['realProfile'])) {
	$_SESSION['realProfile'] = $_SESSION['profile'];
}
$realProfileID = isset($_SESSION['realProfile']) ? intval($_SESSION['realProfile']) : 0;
if (!$realProfileID) { header('Location: /login.php'); exit; }
if (!isset($_SESSION['isAdmin'])) {
	$chk = mysqli_fetch_row(mysqli_query($db, "SELECT isAdmin FROM USER_PROFILE WHERE profileID=$realProfileID"));
	$_SESSION['isAdmin'] = ($chk && intval($chk[0]) === 1);
}
if (!$_SESSION['isAdmin']) { header('Location: /'); exit; }

function slugify($s) {
	$s = strtolower(trim($s));
	$s = preg_replace('/[^a-z0-9]+/', '-', $s);
	$s = trim($s, '-');
	return $s !== '' ? $s : '';
}

$errors = [];

// ---- Actions ----
if (isset($_POST['adminAction'])) {
	switch ($_POST['adminAction']) {

		case 'saveContent':
			$id      = intval($_POST['contentID'] ?? 0);
			$title   = trim($_POST['title'] ?? '');
			$slug    = slugify($_POST['slug'] ?? '');
			if ($slug === '') $slug = slugify($title);
			$summary = trim($_POST['summary'] ?? '');
			$tags    = implode(',', content_parse_tags($_POST['tags'] ?? ''));
			$body    = (string) ($_POST['body'] ?? '');
			$status  = (($_POST['status'] ?? 'draft') === 'published') ? 'published' : 'draft';

			if ($title === '' || $slug === '') {
				$errors[] = 'A title is required (and it must yield a usable slug).';
				break;
			}
			try {
				if ($id > 0) {
					$stmt = $db->prepare("UPDATE CONTENT SET slug=?, title=?, summary=?, body=?, tags=?, status=? WHERE contentID=?");
					$stmt->bind_param("ssssssi", $slug, $title, $summary, $body, $tags, $status, $id);
				} else {
					$stmt = $db->prepare("INSERT INTO CONTENT (slug,title,summary,body,tags,status,authorID) VALUES (?,?,?,?,?,?,?)");
					$stmt->bind_param("ssssssi", $slug, $title, $summary, $body, $tags, $status, $realProfileID);
				}
				$stmt->execute();
				$savedId = $id > 0 ? $id : $db->insert_id;
				$stmt->close();
				mysqli_close($db);
				header("Location: /admin_content.php?edit=$savedId&saved=1");
				exit;
			} catch (mysqli_sql_exception $e) {
				$errors[] = ($e->getCode() == 1062)
					? 'That slug is already in use — pick a different one.'
					: 'Save failed: ' . $e->getMessage();
			}
			break;

		case 'deleteContent':
			$id = intval($_POST['contentID'] ?? 0);
			if ($id > 0) {
				$stmt = $db->prepare("DELETE FROM CONTENT WHERE contentID=?");
				$stmt->bind_param("i", $id);
				$stmt->execute();
				$stmt->close();
			}
			mysqli_close($db);
			header("Location: /admin_content.php?deleted=1");
			exit;
	}
}

// ---- Load the post being edited (if any) ----
$editing = null;
$editId  = isset($_GET['edit']) ? intval($_GET['edit']) : 0;
if ($editId > 0) {
	$stmt = $db->prepare("SELECT contentID, slug, title, summary, body, tags, status FROM CONTENT WHERE contentID=?");
	$stmt->bind_param("i", $editId);
	$stmt->execute();
	$editing = $stmt->get_result()->fetch_assoc();
	$stmt->close();
}

// ---- Load the list ----
$list = [];
$res = mysqli_query($db, "SELECT contentID, slug, title, status, updatedAt FROM CONTENT ORDER BY updatedAt DESC");
while ($row = mysqli_fetch_assoc($res)) { $list[] = $row; }
mysqli_close($db);

$f = function ($k, $d = '') use ($editing) { return htmlspecialchars($editing[$k] ?? $d); };
$arg = isset($_GET['arg']) ? intval($_GET['arg']) : 75;
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Content — Admin</title>
	<style>
		body { font-family: sans-serif; font-size: 15px; margin: 0; padding: 1rem 1.5rem; color: #111; background: #fff; }
		a { color: #2d58a8; }
		h1 { font-size: 1.3rem; margin: 0 0 0.25rem; }
		h2 { font-size: 1rem; margin: 1.5rem 0 0.5rem; border-bottom: 1px solid #ddd; padding-bottom: 0.25rem; }
		nav { margin-bottom: 1rem; font-size: 0.875rem; }
		nav a { margin-right: 1.1rem; }
		.notice { background:#eef; border:1px solid #99b; border-radius:3px; padding:0.5rem 0.75rem; margin-bottom:1rem; font-size:0.875rem; }
		.notice.error { background:#fee; border-color:#f99; }
		label { display:block; font-size:0.8rem; color:#555; margin:0.6rem 0 0.2rem; text-transform:uppercase; letter-spacing:0.03em; }
		input[type=text], textarea, select { width:100%; border:1px solid #bbb; border-radius:4px; font-size:0.95rem; padding:0.45rem 0.55rem; font-family:inherit; }
		textarea { min-height:360px; font-family:ui-monospace,Menlo,Consolas,monospace; font-size:0.9rem; line-height:1.5; }
		.row { display:flex; gap:1rem; flex-wrap:wrap; }
		.row > div { flex:1 1 220px; }
		.hint { color:#888; font-size:0.78rem; margin-top:0.15rem; }
		button { font-size:0.9rem; padding:0.45rem 1rem; cursor:pointer; }
		.btn-primary { background:#10a020; color:#fff; border:none; border-radius:5px; }
		.btn-danger { background:#fff; color:#af1a17; border:1px solid #e3a0a0; border-radius:5px; }
		table { width:100%; border-collapse:collapse; font-size:0.875rem; }
		th, td { text-align:left; padding:0.4rem 0.5rem; border-bottom:1px solid #eee; }
		.pill { font-size:0.72rem; padding:0.05rem 0.45rem; border-radius:999px; }
		.pill.published { background:#e7f6e9; color:#176b25; }
		.pill.draft { background:#f0f0f0; color:#666; }
		.actions { display:flex; gap:0.5rem; align-items:center; margin-top:1rem; }
		.img-uploader { display:flex; gap:0.5rem; align-items:center; flex-wrap:wrap; }
		.img-uploader input[type=file] { font-size:0.85rem; }
	</style>
</head>
<body>
	<h1>Content</h1>
	<nav>
		<a href="/admin_tools.php?arg=<?php echo $arg; ?>">← Admin tools</a>
		<a href="/blog.php" target="_blank">View blog ↗</a>
		<a href="/admin_content.php">+ New post</a>
	</nav>

<?php if (isset($_GET['saved'])): ?><div class="notice">Saved.</div><?php endif; ?>
<?php if (isset($_GET['deleted'])): ?><div class="notice">Post deleted.</div><?php endif; ?>
<?php if (!empty($errors)): ?>
	<div class="notice error"><?php foreach ($errors as $e) echo '<p style="margin:0.2rem 0;">' . htmlspecialchars($e) . '</p>'; ?></div>
<?php endif; ?>

	<h2><?php echo $editing ? 'Edit post' : 'New post'; ?></h2>
	<form method="POST" action="/admin_content.php">
		<input type="hidden" name="adminAction" value="saveContent">
		<input type="hidden" name="contentID" value="<?php echo $editing ? intval($editing['contentID']) : 0; ?>">

		<div class="row">
			<div>
				<label>Title</label>
				<input type="text" name="title" value="<?php echo $f('title'); ?>" required>
			</div>
			<div>
				<label>Slug (URL)</label>
				<input type="text" name="slug" value="<?php echo $f('slug'); ?>" placeholder="auto from title if blank">
				<div class="hint">/post.php?slug=<strong><?php echo $editing ? $f('slug') : '…'; ?></strong></div>
			</div>
		</div>

		<div class="row">
			<div>
				<label>Tags (comma-separated)</label>
				<input type="text" name="tags" value="<?php echo $f('tags'); ?>" placeholder="faq, glossary, ai">
				<div class="hint">Linkable later as /blog.php?tag=<em>tag</em></div>
			</div>
			<div>
				<label>Status</label>
				<select name="status">
					<option value="draft" <?php echo ($editing && $editing['status']==='draft') || !$editing ? 'selected' : ''; ?>>Draft (hidden)</option>
					<option value="published" <?php echo ($editing && $editing['status']==='published') ? 'selected' : ''; ?>>Published (public)</option>
				</select>
			</div>
		</div>

		<label>Summary (optional — shown in the list)</label>
		<input type="text" name="summary" value="<?php echo $f('summary'); ?>" maxlength="400">

		<label>Image</label>
		<div class="img-uploader">
			<input type="file" id="imgFile" accept="image/png,image/jpeg,image/gif,image/webp">
			<button type="button" id="imgUploadBtn" onclick="uploadContentImage()">Upload &amp; insert</button>
			<span id="imgStatus" class="hint"></span>
		</div>
		<div class="hint">PNG / JPG / GIF / WebP up to 5&nbsp;MB. The image's Markdown is inserted into the Body at your cursor &mdash; tweak the alt text in <code>![alt](&hellip;)</code> afterward.</div>

		<label>Body (Markdown)</label>
		<textarea name="body" placeholder="# Heading&#10;&#10;Write in Markdown — **bold**, _italic_, lists, [links](https://…), &gt; quotes."><?php echo $f('body'); ?></textarea>
		<div class="hint">Markdown supported (headings, lists, links, bold/italic, quotes, code). Raw HTML is escaped for safety.</div>

		<div class="actions">
			<button type="submit" class="btn-primary"><?php echo $editing ? 'Save changes' : 'Create post'; ?></button>
<?php if ($editing): ?>
			<a href="/post.php?slug=<?php echo urlencode($editing['slug']); ?>" target="_blank">Preview ↗</a>
<?php endif; ?>
		</div>
	</form>

<?php if ($editing): ?>
	<form method="POST" action="/admin_content.php" style="margin-top:0.8rem;"
		onsubmit="return confirm('Delete this post permanently?');">
		<input type="hidden" name="adminAction" value="deleteContent">
		<input type="hidden" name="contentID" value="<?php echo intval($editing['contentID']); ?>">
		<button type="submit" class="btn-danger">Delete post</button>
	</form>
<?php endif; ?>

	<h2>All posts</h2>
<?php if (empty($list)): ?>
	<p style="color:#888;">No posts yet.</p>
<?php else: ?>
	<table>
		<thead><tr><th>Title</th><th>Status</th><th>Updated</th><th></th></tr></thead>
		<tbody>
<?php foreach ($list as $p): ?>
			<tr>
				<td><a href="/admin_content.php?edit=<?php echo intval($p['contentID']); ?>"><?php echo htmlspecialchars($p['title']); ?></a></td>
				<td><span class="pill <?php echo $p['status']; ?>"><?php echo $p['status']; ?></span></td>
				<td style="white-space:nowrap;color:#666;"><?php echo date('M j, Y', strtotime($p['updatedAt'])); ?></td>
				<td><a href="/post.php?slug=<?php echo urlencode($p['slug']); ?>" target="_blank">view ↗</a></td>
			</tr>
<?php endforeach; ?>
		</tbody>
	</table>
<?php endif; ?>
	<script>
	function uploadContentImage() {
		var input  = document.getElementById('imgFile');
		var status = document.getElementById('imgStatus');
		var btn    = document.getElementById('imgUploadBtn');
		if (!input.files || !input.files.length) { status.textContent = 'Choose an image first.'; return; }
		var fd = new FormData();
		fd.append('image', input.files[0]);
		btn.disabled = true; status.textContent = 'Uploading…';
		fetch('/upload_image.php', { method: 'POST', body: fd })
			.then(function (r) { return r.json(); })
			.then(function (d) {
				btn.disabled = false;
				if (!d || !d.ok) { status.textContent = (d && d.error) ? d.error : 'Upload failed.'; return; }
				var ta = document.querySelector('textarea[name="body"]');
				var snippet = '\n\n' + d.markdown + '\n\n';
				var pos = (ta.selectionStart != null) ? ta.selectionStart : ta.value.length;
				ta.value = ta.value.slice(0, pos) + snippet + ta.value.slice(pos);
				ta.focus();
				status.innerHTML = 'Inserted &rarr; ' + d.url;
				input.value = '';
			})
			.catch(function () { btn.disabled = false; status.textContent = 'Upload failed.'; });
	}
	</script>
</body>
</html>
