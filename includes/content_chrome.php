<?php
// Shared layout + Markdown rendering for the content pages (blog.php, post.php).

require_once __DIR__ . '/Parsedown.php';

/** Render Markdown to safe HTML (raw HTML in the source is escaped). */
function content_render_markdown($md) {
	static $pd = null;
	if ($pd === null) {
		$pd = new Parsedown();
		$pd->setSafeMode(true);     // escape any raw HTML in the source
		$pd->setBreaksEnabled(true); // single newline -> <br> (friendlier authoring)
	}
	return $pd->text((string) $md);
}

/** Comma-separated tag string -> clean array of lowercased tags. */
function content_parse_tags($tagStr) {
	$out = [];
	foreach (explode(',', (string) $tagStr) as $t) {
		$t = strtolower(trim($t));
		if ($t !== '') $out[] = $t;
	}
	return array_values(array_unique($out));
}

/** Page <head> + masthead + opening wrapper. */
function content_header($title) {
	$t = htmlspecialchars($title);
	echo <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>{$t}</title>
	<style>
		:root { --red:#af1a17; --green:#10a020; --blue:#2d58a8; --ink:#1c1c1c; --muted:#666; --line:#e4e4e4; --bg:#fafafa; }
		* { box-sizing: border-box; }
		body { margin:0; font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif; color:var(--ink); background:var(--bg); line-height:1.62; }
		a { color: var(--blue); }
		.masthead { background:#0e0e0e; padding:0.6rem 1rem; }
		.masthead a { color:#fff; text-decoration:none; font-weight:800; letter-spacing:0.06em; font-size:1.1rem; }
		.wrap { max-width:720px; margin:0 auto; padding:1.75rem 1.25rem 4rem; }
		h1 { font-size:1.85rem; line-height:1.2; margin:0.75rem 0 0.4rem; }
		.meta { color:var(--muted); font-size:0.85rem; margin-bottom:1.25rem; }
		.summary { color:#333; font-size:1.05rem; }
		.tags { margin:0.4rem 0; }
		.tag { display:inline-block; background:#eef0f4; color:#3a4a6b; border-radius:999px; padding:0.1rem 0.6rem; font-size:0.78rem; margin:0.15rem 0.3rem 0.15rem 0; text-decoration:none; }
		.tag:hover { background:#e2e6ee; }
		.prose { font-size:1.04rem; }
		.prose h2 { font-size:1.35rem; margin:1.8rem 0 0.5rem; }
		.prose h3 { font-size:1.12rem; margin:1.4rem 0 0.4rem; }
		.prose p { margin:0.85rem 0; }
		.prose ul, .prose ol { margin:0.6rem 0 0.9rem; padding-left:1.4rem; }
		.prose li { margin:0.3rem 0; }
		.prose blockquote { margin:1rem 0; padding:0.4rem 1rem; border-left:3px solid var(--line); color:#444; }
		.prose code { background:#f0f0f0; padding:0.1rem 0.35rem; border-radius:4px; font-size:0.92em; }
		.prose pre { background:#f4f4f4; padding:0.8rem 1rem; border-radius:6px; overflow:auto; }
		.prose hr { border:none; border-top:1px solid var(--line); margin:1.6rem 0; }
		.prose img { max-width:100%; height:auto; }
		.post-list { list-style:none; padding:0; margin:1.25rem 0 0; }
		.post-list li { padding:1rem 0; border-bottom:1px solid var(--line); }
		.post-list a.title { font-size:1.2rem; font-weight:700; text-decoration:none; color:var(--ink); }
		.post-list a.title:hover { color:var(--blue); }
		.back { display:inline-block; margin-bottom:0.5rem; font-size:0.9rem; }
		.empty { color:var(--muted); }
	</style>
</head>
<body>
	<div class="masthead"><a href="/">AGITATE</a></div>
	<div class="wrap">

HTML;
}

function content_footer() {
	echo "\n\t</div>\n</body>\n</html>\n";
}
