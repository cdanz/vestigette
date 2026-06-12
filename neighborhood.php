<?php
// Lazy-loaded neighborhood list for the Find > Neighborhood subsection.
// Returns an HTML <ul> of nearby arguments. Public graph data, no auth needed.
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

header('Content-Type: text/html; charset=utf-8');

$arg = isset($_GET['arg']) ? intval($_GET['arg']) : 0;
if ($arg <= 0) {
	echo '<ul><li class="lineItem"><span class="find-loading">No argument selected.</span></li></ul>';
	exit;
}

// Below this many neighbors from the cheap (hop-3 off) pass, expand to hop-3.
$MIN_RESULTS = 12;

function fetchNeighborhood($db, $arg, $includeHop3) {
	$rows = [];
	$sql = "CALL getNeighborhoodAll($arg, " . ($includeHop3 ? 1 : 0) . ")";
	if (mysqli_multi_query($db, $sql)) {
		$result = mysqli_store_result($db);
		if ($result) {
			while ($row = mysqli_fetch_row($result)) {
				$rows[] = [$row[0], $row[1], $row[2]]; // argID, score, phrasing
			}
			mysqli_free_result($result);
		}
		while (mysqli_more_results($db)) {
			mysqli_next_result($db);
			if ($r = mysqli_store_result($db)) mysqli_free_result($r);
		}
	}
	return $rows;
}

$rows = fetchNeighborhood($db, $arg, 0);
if (count($rows) < $MIN_RESULTS) {
	$deeper = fetchNeighborhood($db, $arg, 1);
	if (count($deeper) > count($rows)) {
		$rows = $deeper;
	}
}
mysqli_close($db);

if (empty($rows)) {
	echo '<ul><li class="lineItem"><span class="find-loading">No neighboring arguments yet.</span></li></ul>';
	exit;
}

echo "<ul>\n";
foreach ($rows as $r) {
	$id = intval($r[0]);
	if ($id === $arg) continue;
	echo '<li class="lineItem"><a href="/?arg=' . $id . '">' . htmlspecialchars($r[2]) . "</a></li>\n";
}
echo "</ul>\n";
