<?php
// Standing pages — undated, amendable policy documents (Persona Constitution,
// Data Promise). Source: pages/<slug>.md in git (see pages/README.md).
// Reached as /<slug> via the .htaccess rewrite; /page.php?slug=x 301s to /x.
//
// Contract for these pages (do not weaken):
//   - URLs and heading anchor ids are permanent once published.
//   - No publication date; shows "Last amended:" from the Amendment Log.
//   - Never listed on /blog.php or any future feed.
session_start();
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php");

$slug = isset($_GET['slug']) ? strtolower(trim($_GET['slug'])) : '';
$page = content_page_read($slug);

// Drafts are visible to admins only (same rule as post.php).
$isDraft = ($page !== null && $page['status'] !== 'published');
if ($isDraft) {
	$viewerAdmin = false;
	$realID = isset($_SESSION['realProfile']) ? intval($_SESSION['realProfile'])
	        : (isset($_SESSION['profile']) ? intval($_SESSION['profile']) : 0);
	if ($realID) {
		if (isset($_SESSION['isAdmin'])) {
			$viewerAdmin = (bool) $_SESSION['isAdmin'];
		} else {
			include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
			$chk = mysqli_fetch_row(mysqli_query($db, "SELECT isAdmin FROM USER_PROFILE WHERE profileID=$realID"));
			$viewerAdmin = ($chk && intval($chk[0]) === 1);
			$_SESSION['isAdmin'] = $viewerAdmin;
			mysqli_close($db);
		}
	}
	if (!$viewerAdmin) $page = null;
}

if (!$page) {
	http_response_code(404);
	content_header('Not found — Agitate');
	echo '<a class="back" href="/">&larr; Agitate</a>';
	echo '<h1>Not found</h1><p class="empty">That page doesn\'t exist or isn\'t published yet.</p>';
	content_footer();
	exit;
}

// Canonicalize: the permanent URL is /<slug>, never /page.php?slug=<slug>.
if (strpos($_SERVER['REQUEST_URI'] ?? '', '/page.php') === 0) {
	header('Location: /' . $slug, true, 301);
	exit;
}

$canonical = 'https://agitate-discourse.org/' . $slug;
content_header($page['title'] . ' — Agitate', [
	'description' => $page['description'],
	'canonical'   => $canonical,
]);

echo '<a class="back" href="/">&larr; Agitate</a>';
echo '<h1>' . htmlspecialchars($page['title']) . '</h1>';
if ($isDraft) {
	echo '<div style="background:#fff7e6;border:1px solid #e0b020;color:#6a4e00;border-radius:6px;padding:0.5rem 0.75rem;margin:0.5rem 0 1rem;font-size:0.9rem;"><strong>Draft preview</strong> &mdash; only you (admin) can see this; it isn\'t public yet.</div>';
}
$amended = content_page_last_amended($page['body']);
if ($amended) {
	echo '<div class="meta">Last amended: ' . date('F j, Y', strtotime($amended)) . '</div>';
}

echo '<div class="prose">' . content_render_markdown_with_anchors($page['body']) . '</div>';
content_footer();
