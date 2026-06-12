<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php");

$slug = isset($_GET['slug']) ? trim($_GET['slug']) : '';
$post = null;
if ($slug !== '') {
	$stmt = $db->prepare(
		"SELECT title, summary, body, tags, createdAt, updatedAt
		 FROM CONTENT WHERE slug=? AND status='published' LIMIT 1");
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
echo '<div class="meta">' . date('F j, Y', strtotime($post['updatedAt'] ?: $post['createdAt'])) . '</div>';

$tags = content_parse_tags($post['tags']);
if ($tags) {
	echo '<div class="tags">';
	foreach ($tags as $t) {
		echo '<a class="tag" href="/blog.php?tag=' . urlencode($t) . '">' . htmlspecialchars($t) . '</a>';
	}
	echo '</div>';
}

echo '<div class="prose">' . content_render_markdown($post['body']) . '</div>';
content_footer();
