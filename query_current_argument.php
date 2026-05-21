<?php
$argID = $_SESSION['currentArg'];
$opinion = 0;
$sql = "CALL getAssociated($argID);";
$sql .= "CALL getDetail($argID);";
$sql .= "CALL getExplication($argID);";
if (isset($_SESSION['profile'])) {
  $proID = $_SESSION['profile'];
  $sql .= "CALL getOpinion($argID,$proID);";
  $sql .= "CALL getUserAssociated($argID,$proID);";
}
$sql .= "CALL getAltPhrasing($argID)";

if (mysqli_multi_query($db, $sql)) {
  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) {
    $assocArgs = array();
    $because = array();
    $therefore = array();
    $rebuttal = array();
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
			'title'     => '/<meta[^>]+property=["\']og:title["\'][^>]+content=["\'](.*?)["\']/is',
			'title_rev' => '/<meta[^>]+content=["\'](.*?)["\'][^>]+property=["\']og:title["\']/is',
			'image'     => '/<meta[^>]+property=["\']og:image["\'][^>]+content=["\'](.*?)["\']/is',
			'image_rev' => '/<meta[^>]+content=["\'](.*?)["\'][^>]+property=["\']og:image["\']/is',
			'desc'      => '/<meta[^>]+property=["\']og:description["\'][^>]+content=["\'](.*?)["\']/is',
			'desc_rev'  => '/<meta[^>]+content=["\'](.*?)["\'][^>]+property=["\']og:description["\']/is',
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
		if (!$meta['description'] && preg_match('/<meta[^>]+name=["\']description["\'][^>]+content=["\'](.*?)["\']/is', $html, $m))
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

function storeOgMeta($db, $url, $explicationID) {
	$og = fetchOgMeta($url);
	$id = intval($explicationID);
	$t  = mysqli_real_escape_string($db, mb_substr($og['title'] ?? '', 0, 300));
	$i  = mysqli_real_escape_string($db, mb_substr($og['image'] ?? '', 0, 500));
	$d  = mysqli_real_escape_string($db, $og['description'] ?? '');
	mysqli_query($db, "UPDATE EXPLICATION SET og_title='$t', og_image='$i', og_description='$d', og_fetched_at=NOW() WHERE explicationID=$id");
}
?>