<?php
// OG-metadata fetch/store helpers (shared by query_current_argument.php and bots/refetch_og.php).
function fetchOgMeta($url) {
	$meta = ['title' => null, 'image' => null, 'description' => null];
	if (!filter_var($url, FILTER_VALIDATE_URL)) return $meta;

	// --- Attempt 1: direct fetch ---
	$ch = curl_init();
	curl_setopt_array($ch, [
		CURLOPT_URL            => $url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_MAXREDIRS      => 5,
		CURLOPT_TIMEOUT        => 6,
		CURLOPT_CONNECTTIMEOUT => 4,
		CURLOPT_USERAGENT      => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
		CURLOPT_SSL_VERIFYPEER => false,
		CURLOPT_HTTPHEADER     => [
			'Accept: text/html,application/xhtml+xml',
			'Accept-Language: en-US,en;q=0.9',
		],
	]);
	$html = curl_exec($ch);
	$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	curl_close($ch);

	if ($html && $httpCode === 200) {
		$patterns = [
			// Capture groups exclude '<' and '>' so a lazy match can't span across
			// tag boundaries (with the /s flag '.' would otherwise swallow '/><meta...'
			// and pull raw head markup into the value).
			'title'     => '/<meta[^>]+property=["\']og:title["\'][^>]+content=["\']([^<>]*?)["\']/is',
			'title_rev' => '/<meta[^>]+content=["\']([^<>]*?)["\'][^>]+property=["\']og:title["\']/is',
			'image'     => '/<meta[^>]+property=["\']og:image["\'][^>]+content=["\']([^<>]*?)["\']/is',
			'image_rev' => '/<meta[^>]+content=["\']([^<>]*?)["\'][^>]+property=["\']og:image["\']/is',
			'desc'      => '/<meta[^>]+property=["\']og:description["\'][^>]+content=["\']([^<>]*?)["\']/is',
			'desc_rev'  => '/<meta[^>]+content=["\']([^<>]*?)["\'][^>]+property=["\']og:description["\']/is',
		];
		if (preg_match($patterns['title'], $html, $m) || preg_match($patterns['title_rev'], $html, $m))
			$meta['title'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');
		if (preg_match($patterns['image'], $html, $m) || preg_match($patterns['image_rev'], $html, $m))
			$meta['image'] = trim($m[1]);
		if (preg_match($patterns['desc'], $html, $m) || preg_match($patterns['desc_rev'], $html, $m))
			$meta['description'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');
		// Plain-HTML fallbacks
		if (!$meta['title'] && preg_match('/<title[^>]*>(.*?)<\/title>/is', $html, $m))
			$meta['title'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');
		if (!$meta['description'] && preg_match('/<meta[^>]+name=["\']description["\'][^>]+content=["\']([^<>]*?)["\']/is', $html, $m))
			$meta['description'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');
	}

	// --- Attempt 2: noembed.com oEmbed aggregator (NYT, YouTube, Vimeo, Twitter, etc.) ---
	if (!$meta['title'] && !$meta['image']) {
		$ch = curl_init();
		curl_setopt_array($ch, [
			CURLOPT_URL            => 'https://noembed.com/embed?url=' . urlencode($url),
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_TIMEOUT        => 8,
			CURLOPT_CONNECTTIMEOUT => 4,
			CURLOPT_SSL_VERIFYPEER => false,
			CURLOPT_HTTPHEADER     => ['Accept: application/json'],
		]);
		$response = curl_exec($ch);
		curl_close($ch);
		if ($response) {
			$data = json_decode($response, true);
			if ($data && empty($data['error'])) {
				if (!$meta['title'])       $meta['title']       = $data['title'] ?? null;
				if (!$meta['description']) $meta['description'] = $data['summary'] ?? null;
				if (!$meta['image'])       $meta['image']       = $data['thumbnail_url'] ?? null;
			}
		}
	}

	// --- Attempt 3: Microlink API (headless browser fallback for everything else) ---
	if (!$meta['title'] && !$meta['image']) {
		$ch = curl_init();
		curl_setopt_array($ch, [
			CURLOPT_URL            => 'https://api.microlink.io/?url=' . urlencode($url),
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_TIMEOUT        => 10,
			CURLOPT_CONNECTTIMEOUT => 5,
			CURLOPT_SSL_VERIFYPEER => false,
			CURLOPT_HTTPHEADER     => ['Accept: application/json'],
		]);
		$response = curl_exec($ch);
		curl_close($ch);
		if ($response) {
			$data = json_decode($response, true);
			if ($data && ($data['status'] ?? '') === 'success') {
				$d = $data['data'] ?? [];
				if (!$meta['title'])       $meta['title']       = $d['title'] ?? null;
				if (!$meta['description']) $meta['description'] = $d['description'] ?? null;
				if (!$meta['image'])       $meta['image']       = $d['image']['url'] ?? ($d['screenshot']['url'] ?? null);
			}
		}
	}

	return $meta;
}

// Sanitize a scraped OG text value (title/description). The parser regexes can
// occasionally over-capture across tag boundaries and pull in raw HTML fragments
// (e.g. `IE=edge" http-equiv="X-UA-Compatible"/><meta ...`). Reject anything that
// still looks like markup, strip stray tags, collapse whitespace, and cap length.
function cleanOgText($val, $maxLen) {
	if ($val === null) return '';
	$val = (string) $val;
	// Hard reject values that are clearly botched scrapes of page <head> markup.
	if (strpos($val, '<') !== false || stripos($val, 'http-equiv') !== false) {
		return '';
	}
	// Defensive: strip any tags that slipped through, collapse whitespace.
	$val = trim(preg_replace('/\s+/', ' ', strip_tags($val)));
	return mb_substr($val, 0, $maxLen);
}

// Validate a scraped OG image value: it must be a clean absolute http(s) URL.
// Anything containing markup, http-equiv, or that fails URL validation is dropped
// so we never store (or render) a broken link-preview image.
function cleanOgImage($val) {
	if ($val === null) return '';
	$val = trim((string) $val);
	if ($val === ''
		|| strpos($val, '<') !== false
		|| stripos($val, 'http-equiv') !== false
		|| !preg_match('#^https?://#i', $val)
		|| !filter_var($val, FILTER_VALIDATE_URL)) {
		return '';
	}
	return mb_substr($val, 0, 500);
}

function storeOgMeta($db, $url, $explicationID) {
	$og = fetchOgMeta($url);
	// Guard: YouTube's generic homepage placeholder (returned while a video is still
	// processing, or when the fetch hits a consent interstitial). Don't cache it —
	// leave the fields empty so the card shows the clean domain and the link stays
	// eligible for a later re-fetch instead of sticking with misleading text.
	$titleLc = strtolower(trim($og['title'] ?? ''));
	if ($titleLc === 'youtube' || $titleLc === '- youtube'
	    || stripos($og['description'] ?? '', 'Enjoy the videos and music you love') === 0) {
		$og = ['title' => null, 'image' => null, 'description' => null];
	}
	$id = intval($explicationID);
	$t  = mysqli_real_escape_string($db, cleanOgText($og['title'] ?? '', 300));
	$i  = mysqli_real_escape_string($db, cleanOgImage($og['image'] ?? ''));
	$d  = mysqli_real_escape_string($db, cleanOgText($og['description'] ?? '', 1000));
	mysqli_query($db, "UPDATE EXPLICATION SET og_title='$t', og_image='$i', og_description='$d', og_fetched_at=NOW() WHERE explicationID=$id");
}
