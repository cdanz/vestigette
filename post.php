<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php");

// Admins may preview any post (including drafts); everyone else sees only published.
$viewerAdmin = false;
$realID = isset($_SESSION['realProfile']) ? intval($_SESSION['realProfile'])
        : (isset($_SESSION['profile']) ? intval($_SESSION['profile']) : 0);
if ($realID) {
	if (isset($_SESSION['isAdmin'])) {
		$viewerAdmin = (bool) $_SESSION['isAdmin'];
	} else {
		$chk = mysqli_fetch_row(mysqli_query($db, "SELECT isAdmin FROM USER_PROFILE WHERE profileID=$realID"));
		$viewerAdmin = ($chk && intval($chk[0]) === 1);
	}
}

$slug = isset($_GET['slug']) ? trim($_GET['slug']) : '';
$post = null;
if ($slug !== '') {
	$sql = $viewerAdmin
		? "SELECT title, summary, body, tags, status, createdAt, updatedAt FROM CONTENT WHERE slug=? LIMIT 1"
		: "SELECT title, summary, body, tags, status, createdAt, updatedAt FROM CONTENT WHERE slug=? AND status='published' LIMIT 1";
	$stmt = $db->prepare($sql);
	$stmt->bind_param("s", $slug);
	$stmt->execute();
	$post = $stmt->get_result()->fetch_assoc();
	$stmt->close();
}
mysqli_close($db);

if (!$post) {
	http_response_code(404);
	content_header('Not found — Agitate');
	echo '<a class="back" href="/blog.php">&larr; All writing</a>';
	echo '<h1>Not found</h1><p class="empty">That page doesn\'t exist or isn\'t published yet.</p>';
	content_footer();
	exit;
}

content_header($post['title'] . ' — Agitate');
echo '<a class="back" href="/blog.php">&larr; All writing</a>';
echo '<h1>' . htmlspecialchars($post['title']) . '</h1>';
if (($post['status'] ?? '') === 'draft') {
	echo '<div style="background:#fff7e6;border:1px solid #e0b020;color:#6a4e00;border-radius:6px;padding:0.5rem 0.75rem;margin:0.5rem 0 1rem;font-size:0.9rem;"><strong>Draft preview</strong> &mdash; only you (admin) can see this; it isn\'t public yet.</div>';
}
echo '<div class="meta">' . date('F j, Y', strtotime($post['updatedAt'] ?: $post['createdAt'])) . '</div>';

$tags = content_parse_tags($post['tags']);
if ($tags) {
	echo '<div class="tags">';
	foreach ($tags as $t) {
		echo '<a class="tag" href="/blog.php?tag=' . urlencode($t) . '">' . htmlspecialchars($t) . '</a>';
	}
	echo '</div>';
}

echo '<div class="prose">' . content_render_markdown_with_anchors($post['body']) . '</div>';
content_footer();
