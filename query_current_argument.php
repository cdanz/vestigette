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
// Current argument's cached median (negotiable-term value), NULL for non-term args.
// The index header substitutes this into the phrasing's [[value]] token with a halo;
// list/associated sites bake it at the SQL source via ntPhrasing() instead.
$currentTermValue = null;
$hasNegotiableTerm = 0;
$termDistribution = array();   // all active submitted values (MVP: unscoped), for the dialog plot
$ctvRes = mysqli_query($db,
  "SELECT hasNegotiableTerm, currentTermValue FROM ARGUMENT WHERE argumentID = " . intval($argID));
if ($ctvRes && ($ctvRow = mysqli_fetch_row($ctvRes))) {
  $hasNegotiableTerm = intval($ctvRow[0]);
  $currentTermValue  = $ctvRow[1];
  mysqli_free_result($ctvRes);
}
if ($hasNegotiableTerm) {
  $tdRes = mysqli_query($db,
    "SELECT value FROM TERM_VALUE WHERE argumentID = " . intval($argID) . " AND active = TRUE ORDER BY value ASC");
  if ($tdRes) {
    while ($tdRow = mysqli_fetch_row($tdRes)) { $termDistribution[] = (float) $tdRow[0]; }
    mysqli_free_result($tdRes);
  }
}

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
          ntPhrasing(COALESCE(a.currentPhrasing,
                   (SELECT phrasing FROM PHRASING
                    WHERE argumentID = a.argumentID
                    ORDER BY createdDate ASC LIMIT 1)), a.currentTermValue)
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

require_once __DIR__ . '/includes/og_meta.php';

?>