<?php
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php");

$tag = isset($_GET['tag']) ? strtolower(trim($_GET['tag'])) : '';

if ($tag !== '') {
	// tags stored as a comma-separated list (no spaces) -> FIND_IN_SET matches a whole tag
	$stmt = $db->prepare(
		"SELECT slug, title, summary, tags, createdAt, updatedAt
		 FROM CONTENT WHERE status='published' AND FIND_IN_SET(?, tags)
		 ORDER BY updatedAt DESC");
	$stmt->bind_param("s", $tag);
} else {
	$stmt = $db->prepare(
		"SELECT slug, title, summary, tags, createdAt, updatedAt
		 FROM CONTENT WHERE status='published' ORDER BY updatedAt DESC");
}
$stmt->execute();
$res = $stmt->get_result();
$posts = [];
while ($row = $res->fetch_assoc()) { $posts[] = $row; }
$stmt->close();
mysqli_close($db);

content_header(($tag !== '' ? 'Tagged: ' . $tag . ' — ' : '') . 'Agitate — Writing');

if ($tag !== '') {
	echo '<a class="back" href="/blog.php">&larr; All writing</a>';
	echo '<h1>Tagged: ' . htmlspecialchars($tag) . '</h1>';
} else {
	echo '<h1>Writing</h1>';
	echo '<p class="summary">FAQs, a glossary, the anatomy of an argument, and notes on how Agitate works &mdash; including its use of AI.</p>';
}

if (empty($posts)) {
	echo '<p class="empty">Nothing here yet.</p>';
} else {
	echo '<ul class="post-list">';
	foreach ($posts as $p) {
		echo '<li>';
		echo '<a class="title" href="/post.php?slug=' . urlencode($p['slug']) . '">' . htmlspecialchars($p['title']) . '</a>';
		echo '<div class="meta">' . date('M j, Y', strtotime($p['updatedAt'] ?: $p['createdAt'])) . '</div>';
		if (!empty($p['summary'])) {
			echo '<div class="summary">' . htmlspecialchars($p['summary']) . '</div>';
		}
		$tg = content_parse_tags($p['tags']);
		if ($tg) {
			echo '<div class="tags">';
			foreach ($tg as $t) {
				echo '<a class="tag" href="/blog.php?tag=' . urlencode($t) . '">' . htmlspecialchars($t) . '</a>';
			}
			echo '</div>';
		}
		echo '</li>';
	}
	echo '</ul>';
}
content_footer();
