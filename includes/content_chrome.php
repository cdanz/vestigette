<?php
// Shared layout + Markdown rendering for the content pages (blog.php, post.php,
// page.php) plus helpers for file-based standing pages (pages/*.md).
//
// Two content types:
//   - Posts: dated writing, stored in the CONTENT table, listed on /blog.php.
//   - Standing pages: undated, amendable policy documents (e.g. /ai-policy-pledge).
//     Source of truth is pages/<slug>.md in git — commit history is the
//     verifiable twin of each page's Amendment Log. Never listed on /blog.php.

/** Render Markdown to safe HTML (raw HTML in the source is escaped). */
function content_render_markdown($md) {
	static $pd = null;
	if ($pd === null) {
		require_once __DIR__ . '/Parsedown.php'; // lazy: index.php includes this file for page helpers only
		$pd = new Parsedown();
		$pd->setSafeMode(true);     // escape any raw HTML in the source
		$pd->setBreaksEnabled(true); // single newline -> <br> (friendlier authoring)
	}
	return $pd->text((string) $md);
}

/**
 * Render Markdown and give every h2–h4 a stable anchor id.
 * A heading may pin its id explicitly — "## Article V — How Personas Die {#article-v}" —
 * otherwise the id is slugified from the heading text. Pinned ids survive rewording,
 * so standing pages should pin every id before first publication (published anchor
 * ids must never change). A hover "#" link is appended for easy copying.
 */
function content_render_markdown_with_anchors($md) {
	$html = content_render_markdown($md);
	$seen = [];
	return preg_replace_callback('/<h([2-4])>(.*?)<\/h\1>/s', function ($m) use (&$seen) {
		$level = $m[1];
		$inner = $m[2];
		if (preg_match('/\s*\{#([A-Za-z0-9][A-Za-z0-9_-]*)\}\s*$/', $inner, $idm)) {
			$id    = strtolower($idm[1]);
			$inner = preg_replace('/\s*\{#[A-Za-z0-9][A-Za-z0-9_-]*\}\s*$/', '', $inner);
		} else {
			$text = html_entity_decode(strip_tags($inner), ENT_QUOTES, 'UTF-8');
			$id   = trim(preg_replace('/[^a-z0-9]+/', '-', strtolower($text)), '-');
			if ($id === '') $id = 'section';
		}
		while (isset($seen[$id])) { $id .= '-2'; } // dedupe within the page
		$seen[$id] = true;
		return '<h' . $level . ' id="' . htmlspecialchars($id) . '">' . $inner
			. ' <a class="hanchor" href="#' . htmlspecialchars($id) . '" aria-label="Link to this section">#</a></h' . $level . '>';
	}, $html);
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

// ---------------------------------------------------------------------------
// Standing pages (pages/*.md)
// ---------------------------------------------------------------------------

function content_pages_dir() {
	return $_SERVER['DOCUMENT_ROOT'] . '/pages';
}

/**
 * Read a standing page. Returns null if the slug is unsafe or the file is
 * missing; otherwise ['slug','title','description','status','body'].
 * Front matter is a leading "---" block of "key: value" lines.
 */
function content_page_read($slug) {
	if (!preg_match('/^[a-z0-9][a-z0-9-]{0,79}$/', (string) $slug)) return null;
	$file = content_pages_dir() . '/' . $slug . '.md';
	if (!is_file($file)) return null;
	$raw = (string) file_get_contents($file);

	$page = ['slug' => $slug, 'title' => $slug, 'description' => '', 'status' => 'draft', 'body' => $raw];
	if (preg_match('/^---\s*\n(.*?)\n---\s*\n?(.*)$/s', $raw, $m)) {
		foreach (preg_split('/\n/', $m[1]) as $line) {
			if (preg_match('/^([A-Za-z_-]+)\s*:\s*(.*)$/', trim($line), $kv)) {
				$page[strtolower($kv[1])] = trim($kv[2]);
			}
		}
		$page['body'] = $m[2];
	}
	$page['status'] = ($page['status'] === 'published') ? 'published' : 'draft';
	return $page;
}

function content_page_is_published($slug) {
	$p = content_page_read($slug);
	return $p !== null && $p['status'] === 'published';
}

/** All published standing pages, as slug => title (for footers/nav). */
function content_list_published_pages() {
	$out = [];
	foreach (glob(content_pages_dir() . '/*.md') ?: [] as $file) {
		$slug = basename($file, '.md');
		$p = content_page_read($slug);
		if ($p && $p['status'] === 'published') $out[$slug] = $p['title'];
	}
	ksort($out);
	return $out;
}

/**
 * Newest date in the page's Amendment Log ("- **YYYY-MM-DD** — change").
 * The log is reverse-chronological content, so the first date after the
 * "Amendment Log" heading is the latest amendment. Returns 'YYYY-MM-DD' or null.
 */
function content_page_last_amended($body) {
	$pos = stripos((string) $body, 'Amendment Log');
	if ($pos === false) return null;
	if (preg_match('/(\d{4}-\d{2}-\d{2})/', substr($body, $pos), $m)) return $m[1];
	return null;
}

// ---------------------------------------------------------------------------
// Layout
// ---------------------------------------------------------------------------

/**
 * Page <head> + masthead + opening wrapper.
 * $meta (all optional): 'description' (meta + og:description), 'canonical'
 * (link rel=canonical + og:url), 'og_title' (defaults to $title).
 */
function content_header($title, $meta = []) {
	$t = htmlspecialchars($title);
	$extra = '';
	$ogTitle = htmlspecialchars($meta['og_title'] ?? $title);
	$extra .= "\t<meta property=\"og:title\" content=\"{$ogTitle}\">\n";
	$extra .= "\t<meta property=\"og:type\" content=\"website\">\n";
	$extra .= "\t<meta name=\"twitter:card\" content=\"summary\">\n";
	if (!empty($meta['description'])) {
		$d = htmlspecialchars($meta['description']);
		$extra .= "\t<meta name=\"description\" content=\"{$d}\">\n";
		$extra .= "\t<meta property=\"og:description\" content=\"{$d}\">\n";
	}
	if (!empty($meta['canonical'])) {
		$c = htmlspecialchars($meta['canonical']);
		$extra .= "\t<link rel=\"canonical\" href=\"{$c}\">\n";
		$extra .= "\t<meta property=\"og:url\" content=\"{$c}\">\n";
	}
	echo <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>{$t}</title>
{$extra}	<style>
		:root { --red:#af1a17; --green:#10a020; --blue:#2d58a8; --ink:#1c1c1c; --muted:#666; --line:#e4e4e4; --bg:#fafafa; }
		* { box-sizing: border-box; }
		body { margin:0; font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif; color:var(--ink); background:var(--bg); line-height:1.62; }
		a { color: var(--blue); }
		@font-face { font-family:'Anton'; font-style:normal; font-weight:400; font-display:swap; src:url('/fonts/anton.woff2') format('woff2'); }
		@font-face { font-family:'Cabin'; font-style:normal; font-weight:500; font-display:swap; src:url('/fonts/cabin-500.woff2') format('woff2'); }
		.masthead { background:#0e0e0e; padding:0.6rem 1rem; }
		.masthead a { display:inline-flex; align-items:center; gap:0.34em; font-family:'Cabin','Gill Sans','Helvetica Neue',Arial,sans-serif; color:#fff; text-decoration:none; font-weight:500; font-size:1.5rem; letter-spacing:0.1em; text-transform:uppercase; line-height:0.9; }
		.masthead a .agi-ring { display:block; flex:0 0 auto; width:0.96em; height:0.96em; }
		.wrap { max-width:720px; margin:0 auto; padding:1.75rem 1.25rem 2.5rem; }
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
		.prose .hanchor { text-decoration:none; color:#b8bec9; font-size:0.85em; visibility:hidden; }
		.prose h2:hover .hanchor, .prose h3:hover .hanchor, .prose h4:hover .hanchor { visibility:visible; }
		.post-list { list-style:none; padding:0; margin:1.25rem 0 0; }
		.post-list li { padding:1rem 0; border-bottom:1px solid var(--line); }
		.post-list a.title { font-size:1.2rem; font-weight:700; text-decoration:none; color:var(--ink); }
		.post-list a.title:hover { color:var(--blue); }
		.back { display:inline-block; margin-bottom:0.5rem; font-size:0.9rem; }
		.empty { color:var(--muted); }
		.content-footer { max-width:720px; margin:0 auto; padding:1rem 1.25rem 3rem; border-top:1px solid var(--line); color:var(--muted); font-size:0.85rem; }
		.content-footer a { color:var(--muted); margin-right:1.1rem; }
	</style>
</head>
<body>
	<div class="masthead"><a href="/"><img class="agi-ring" src="/agitate-ring.svg" alt="Agitate">AGITATE</a></div>
	<div class="wrap">

HTML;
}

function content_footer() {
	echo "\n\t</div>\n\t<div class=\"content-footer\">\n";
	echo "\t\t<a href=\"/blog.php\">Writing</a>";
	foreach (content_list_published_pages() as $slug => $title) {
		echo "<a href=\"/" . htmlspecialchars($slug) . "\">" . htmlspecialchars($title) . "</a>";
	}
	echo "\n\t</div>\n</body>\n</html>\n";
}
