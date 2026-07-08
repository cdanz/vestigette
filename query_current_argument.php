<?php
$argID = $_SESSION['currentArg'];
$opinion = 0;

// --- Filter lens: resolve active filters into a temp table of profileIDs ---
$filtered = 0;
$activeFilters = isset($_SESSION['filters']) ? $_SESSION['filters'] : [];
$hasOpinionFilters = !empty($activeFilters['opinions']);
$hasAffiliationFilters = !empty($activeFilters['affiliations']);
$hasTimeFilter = !empty($activeFilters['time']) && !empty($activeFilters['time']['date']);

// Always initialize time-filter session vars to avoid stale values from prior requests
if ($hasTimeFilter) {
    $tDir = ($activeFilters['time']['direction'] === 'after') ? 2 : 1;
    $tDate = preg_replace('/[^0-9\-]/', '', $activeFilters['time']['date']);
    mysqli_query($db, "SET @vtime_dir = $tDir, @vtime_date = '$tDate'");
} else {
    mysqli_query($db, "SET @vtime_dir = 0, @vtime_date = NULL");
}

if ($hasOpinionFilters || $hasAffiliationFilters) {
  mysqli_query($db, "CREATE TEMPORARY TABLE IF NOT EXISTS FILTER_PROFILES (profileID INT UNSIGNED PRIMARY KEY)");
  mysqli_query($db, "CREATE TEMPORARY TABLE IF NOT EXISTS FILTER_PROFILES_2 (profileID INT UNSIGNED PRIMARY KEY)");
  mysqli_query($db, "TRUNCATE TABLE FILTER_PROFILES");
  mysqli_query($db, "TRUNCATE TABLE FILTER_PROFILES_2");

  $sets = [];

  if ($hasOpinionFilters) {
    $opClauses = [];
    foreach ($activeFilters['opinions'] as $opf) {
      $oArgID = intval($opf['argumentID']);
      $oAccept = intval($opf['acceptance']);
      $opClauses[] = "SELECT profileID FROM OPINION WHERE argumentID=$oArgID AND acceptance=$oAccept";
    }
    $sets[] = '(' . implode(' INTERSECT ', $opClauses) . ')';
  }

  if ($hasAffiliationFilters) {
    $affIDs = array_map('intval', $activeFilters['affiliations']);
    $affList = implode(',', $affIDs);
    $sets[] = "(SELECT DISTINCT profileID FROM (
        SELECT profileID FROM SCOPE_OPINION             WHERE affiliationID IN ($affList) AND argumentID = $argID
        UNION
        SELECT profileID FROM SCOPE_ENDORSEMENT         WHERE affiliationID IN ($affList) AND targArgID  = $argID
        UNION
        SELECT profileID FROM SCOPE_PHRASE_ENDORSE      WHERE affiliationID IN ($affList) AND argumentID = $argID
        UNION
        SELECT profileID FROM SCOPE_EXPLICATION_ENDORSE WHERE affiliationID IN ($affList) AND argumentID = $argID
    ) sc)";
  }

  if (count($sets) === 1) {
    $finalQuery = "INSERT INTO FILTER_PROFILES " . $sets[0];
  } else {
    $finalQuery = "INSERT INTO FILTER_PROFILES " . implode(' INTERSECT ', $sets);
  }

  mysqli_query($db, $finalQuery);
  mysqli_query($db, "INSERT INTO FILTER_PROFILES_2 SELECT profileID FROM FILTER_PROFILES");
  $filtered = 1;
}

$sql = "CALL getAssociated($argID, $filtered);";
$sql .= "CALL getDetail($argID, $filtered);";
$sql .= "CALL getExplication($argID, $filtered);";
if (isset($_SESSION['profile'])) {
  $proID = $_SESSION['profile'];
  $sql .= "CALL getOpinion($argID,$proID);";
  $sql .= "CALL getUserAssociated($argID,$proID);";
}
$sql .= "CALL getAltPhrasing($argID, $filtered)";

if (mysqli_multi_query($db, $sql)) {
  $assocArgs = array();
  $because = array();
  $therefore = array();
  $rebuttal = array();
  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) {
    $iterator = 0;
    $bIterator = 0;
    $tIterator = 0;
    $rIterator = 0;
    while ($row = mysqli_fetch_row($result)) {
      $assocArgs[$iterator] = array();
      $assocArgs[$iterator][0] = $row[1];
      $assocArgs[$iterator][1] = $row[2];
      $assocArgs[$iterator][2] = $row[3];
      $assocArgs[$iterator][3] = $row[4];
      $iterator++;
      switch ($row[1]) {
        case 'Because':
          $because[$bIterator] = array();
          $because[$bIterator][0] = $row[2];
          $because[$bIterator][1] = $row[3];
          $because[$bIterator][2] = $row[4];
          $bIterator++;
          break;
        case 'Therefore':
          $therefore[$tIterator] = array();
          $therefore[$tIterator][0] = $row[2];
          $therefore[$tIterator][1] = $row[3];
          $therefore[$tIterator][2] = $row[4];
          $tIterator++;
          break;
        case 'Rebuttal':
          $rebuttal[$rIterator] = array();
          $rebuttal[$rIterator][0] = $row[2];
          $rebuttal[$rIterator][1] = $row[3];
          $rebuttal[$rIterator][2] = $row[4];
          $rIterator++;
          break;
      }
    }
  }
  if ($result) mysqli_free_result($result);
  mysqli_next_result($db);
  mysqli_next_result($db);
  mysqli_next_result($db);

  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_row($result);
    $rate = number_format($row[4]*100,1);
    $phrasing = $row[1];
    $assertions = $row[3];
  } else {
    $rate = 'N/A.N/A';
    $phrasing = 'Invalid Argument Identifier';
    $assertions = 0;
  }
  if ($result) mysqli_free_result($result);
  mysqli_next_result($db);
  mysqli_next_result($db);
  mysqli_next_result($db);
  
  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) {
    $iterator = 0;
    $links = array();
    while ($row = mysqli_fetch_row($result)) {
      $links[$iterator] = array();
      $links[$iterator][0] = $row[0];  // totalWeight
      $links[$iterator][1] = $row[1];  // endorsementCount
      $links[$iterator][2] = $row[2];  // explicationID
      $links[$iterator][3] = $row[3];  // hyperlink
      $links[$iterator][4] = $row[4];  // publisher
      $links[$iterator][5] = $row[5];  // authorFName
      $links[$iterator][6] = $row[6];  // authorLName
      $links[$iterator][7] = $row[7];  // title
      $links[$iterator][8] = $row[8];  // og_title
      $links[$iterator][9] = $row[9];  // og_image
      $links[$iterator][10] = $row[10]; // og_description
      $iterator++;
    }
  } else {
    $links = array();
  }
  if ($result) mysqli_free_result($result);
  mysqli_next_result($db);
  mysqli_next_result($db);
  mysqli_next_result($db);
  
  if (isset($_SESSION['profile'])) {
    $result = mysqli_store_result($db);
    if ($result && mysqli_num_rows($result) > 0) {
      $row = mysqli_fetch_row($result);
      if ($row[0])
        $opinion = 1;
      else
        $opinion = -1;
    }
    if ($result) mysqli_free_result($result);
    mysqli_next_result($db);
    mysqli_next_result($db);
    mysqli_next_result($db);
    
    $result = mysqli_store_result($db);
    if ($result && mysqli_num_rows($result) > 0) {
      while ($row = mysqli_fetch_row($result)) {
        switch ($row[1]) {
          case 'Because':
            for ($i = 0; $i < count($because); $i++) {
              if ($because[$i][0] == $row[2]) {
                $because[$i][3] = $row[3];
                break;
              }
            }
            break;
          case 'Therefore':
            for ($i = 0; $i < count($therefore); $i++) {
              if ($therefore[$i][0] == $row[2]) {
                $therefore[$i][3] = $row[3];
                break;
              }
            }
            break;
          case 'Rebuttal':
            for ($i = 0; $i < count($rebuttal); $i++) {
              if ($rebuttal[$i][0] == $row[2]) {
                $rebuttal[$i][3] = $row[3];
                break;
              }
            }
            break;
        }
      }
    }
    if ($result) mysqli_free_result($result);
    mysqli_next_result($db);
    mysqli_next_result($db);
    mysqli_next_result($db);
  }
  
  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) { 
    $iterator = 0;
    $altPhrasings = array();
    while ($row = mysqli_fetch_row($result)) {
      $altPhrasings[$iterator] = array();
      $altPhrasings[$iterator][0] = $row[0];  // totalWeight
      $altPhrasings[$iterator][1] = $row[1];  // endorsementCount
      $altPhrasings[$iterator][2] = $row[2];  // phrasing text
      $altPhrasings[$iterator][3] = $row[3];  // phrasingID
      $iterator++;
    }
  }
  if ($result) mysqli_free_result($result);
  
  //Clear all remaining results from multi-query if any
  while (mysqli_more_results($db)) {
    mysqli_next_result($db);
    if ($result = mysqli_store_result($db)) {
      mysqli_free_result($result);
    }
  }
} else {
  echo "ERROR - MULTIPLE QUERIES FAILED";
}

// Human-opinion count for the current argument (personas = profileID 1–26,
// admin = 28). Gates the social-proof copy in index.php's og:description —
// headcounts only appear once SOCIAL_PROOF_MIN_HUMANS real humans have
// weighed in. og_image.php runs the same check for the card itself.
$humanOpinions = 0;
$hoRes = mysqli_query($db,
  "SELECT COUNT(*) FROM OPINION
   WHERE argumentID = " . intval($argID) . " AND profileID > 26 AND profileID <> 28");
if ($hoRes && ($hoRow = mysqli_fetch_row($hoRes))) {
  $humanOpinions = intval($hoRow[0]);
}

// Recent Assertions (Find section): the 20 newest arguments by creation date.
// Excludes bot-persona-created nodes (createdBy <= 26) so the list surfaces
// human/admin-authored arguments as navigation entry points rather than being
// flooded by bot scaffolding (rebuttals/becauses/therefores).
// Uses the currentPhrasing cache (falls back to oldest phrasing) so it stays cheap.
// The middle value (0) is the color/weight slot generateFindLines() expects; recent
// items carry no endorsement signal, so they render neutral.
$recent = array();
$recentRes = mysqli_query($db,
  "SELECT a.argumentID, 0,
          COALESCE(a.currentPhrasing,
                   (SELECT phrasing FROM PHRASING
                    WHERE argumentID = a.argumentID
                    ORDER BY createdDate ASC LIMIT 1))
   FROM ARGUMENT a
   WHERE a.createdBy > 26
   ORDER BY a.createdDate DESC
   LIMIT 20");
if ($recentRes) {
  while ($r = mysqli_fetch_row($recentRes)) {
    $recent[] = array($r[0], $r[1], $r[2]);
  }
  mysqli_free_result($recentRes);
}

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
	$id = intval($explicationID);
	$t  = mysqli_real_escape_string($db, cleanOgText($og['title'] ?? '', 300));
	$i  = mysqli_real_escape_string($db, cleanOgImage($og['image'] ?? ''));
	$d  = mysqli_real_escape_string($db, cleanOgText($og['description'] ?? '', 1000));
	mysqli_query($db, "UPDATE EXPLICATION SET og_title='$t', og_image='$i', og_description='$d', og_fetched_at=NOW() WHERE explicationID=$id");
}
?>