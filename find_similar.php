<?php
// find_similar.php — AJAX endpoint for two modes:
//   Default (flesh_out duplicate detection): POST {q, arg}, limit 3, excludes current arg,
//     requires login, min 10 chars.
//   Explore search (mode=explore): POST {q, mode}, limit 20, no exclusion, min 3 chars.
// Requires a one-time FULLTEXT index on PHRASING.phrasing — run once on the server:
//   mysql vestigette -e "ALTER TABLE PHRASING ADD FULLTEXT INDEX ft_phrasing (phrasing);"

session_start();

header('Content-Type: application/json');

$mode  = trim($_POST['mode'] ?? '');
$isExplore = ($mode === 'explore');

if (!$isExplore && !isset($_SESSION['profile'])) {
    http_response_code(401);
    echo json_encode([]);
    exit;
}

$q     = trim($_POST['q'] ?? '');
$argID = intval($_POST['arg'] ?? 0);

// Negotiable-term duplicate check (from flesh_out): the [[value]] token must not
// drive matching, and candidates are limited to other term-bearing arguments.
$isNT     = !empty($_POST['nt']);
$ntFilter = '';
if ($isNT) {
    $q = trim(str_replace('[[value]]', ' ', $q));
    $ntFilter = ' AND a.hasNegotiableTerm = 1';
}

$minLen = $isExplore ? 3 : 10;
if (mb_strlen($q) < $minLen) {
    echo json_encode([]);
    exit;
}

// Build a BOOLEAN MODE query with wildcard suffixes so "impeach" matches "impeached",
// "tax" matches "taxes", etc. Each word >= 3 chars gets a trailing * for prefix matching.
$words     = preg_split('/\s+/u', mb_strtolower($q, 'UTF-8'));
$terms     = [];
foreach ($words as $word) {
    $word = preg_replace('/[^\p{L}\p{N}]/u', '', $word); // strip punctuation
    if (mb_strlen($word, 'UTF-8') >= 3) {
        $terms[] = $word . '*';
    }
}

if (empty($terms)) {
    echo json_encode([]);
    exit;
}

$boolQuery = implode(' ', $terms);

include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

$limit = $isExplore ? 20 : 3;
$sql = $isExplore
    ? "SELECT a.argumentID,
              ntPhrasing(COALESCE(a.currentPhrasing,
                  (SELECT p2.phrasing FROM PHRASING p2
                   WHERE p2.argumentID = a.argumentID
                   ORDER BY p2.createdDate ASC LIMIT 1)
              ), a.currentTermValue) AS bestPhrasing,
              MAX(MATCH(p.phrasing) AGAINST (? IN BOOLEAN MODE)) AS score
       FROM PHRASING p
       JOIN ARGUMENT a ON p.argumentID = a.argumentID
       WHERE MATCH(p.phrasing) AGAINST (? IN BOOLEAN MODE)
       GROUP BY a.argumentID
       ORDER BY score DESC
       LIMIT $limit"
    : "SELECT a.argumentID,
              ntPhrasing(COALESCE(a.currentPhrasing,
                  (SELECT p2.phrasing FROM PHRASING p2
                   WHERE p2.argumentID = a.argumentID
                   ORDER BY p2.createdDate ASC LIMIT 1)
              ), a.currentTermValue) AS bestPhrasing,
              MAX(MATCH(p.phrasing) AGAINST (? IN BOOLEAN MODE)) AS score
       FROM PHRASING p
       JOIN ARGUMENT a ON p.argumentID = a.argumentID
       WHERE MATCH(p.phrasing) AGAINST (? IN BOOLEAN MODE)
         AND a.argumentID != ?$ntFilter
       GROUP BY a.argumentID
       ORDER BY score DESC
       LIMIT $limit";

$stmt = mysqli_prepare($db, $sql);

$matches = [];
if ($stmt) {
    if ($isExplore) {
        mysqli_stmt_bind_param($stmt, 'ss', $boolQuery, $boolQuery);
    } else {
        mysqli_stmt_bind_param($stmt, 'ssi', $boolQuery, $boolQuery, $argID);
    }
    if (mysqli_stmt_execute($stmt)) {
        $result = mysqli_stmt_get_result($stmt);
        while ($row = mysqli_fetch_assoc($result)) {
            $matches[] = [
                'argID'    => intval($row['argumentID']),
                'phrasing' => $row['bestPhrasing'],
            ];
        }
        mysqli_free_result($result);
    }
    mysqli_stmt_close($stmt);
}

mysqli_close($db);
echo json_encode($matches);
