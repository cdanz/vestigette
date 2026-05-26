<?php
session_start();
if($_POST['csrfToken'] != $_SESSION['csrfToken']) {
	die("Unauthorized source!");
}
if(!isset($_SESSION['profile'])){
	header('Location: /index.php?arg='.$_SESSION['currentArg']);
}
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
$baseURL = "/index.php";
$assertion = $_POST["assertion"];
$argID = $_SESSION['currentArg'];
$type = $_POST["type"];

function IsNullOrEmptyString($str) {
	return (!isset($str) || trim($str) === '');
}

function generateTypeLines($results) {
	global $baseURL;
	global $type;
	global $argID;
	if (sizeof($results) > 0) {
		echo "<ul>\n";
		foreach ($results as $line) {
			//Exclude the current arg lest argument would be circular
			if ($line[0] != $argID) {
				echo "			<li class=\"lineItem\" data-arg-id=\"${line[0]}\">
					<p class=\"assocArg\">".htmlspecialchars($line[2])."</p>
					<div class=\"opinion\">
					<form method=\"POST\" class=\"buttons\" action=\"index.php?arg=".$argID."\">
						<input type=\"hidden\" name=\"useInstead\" value=\"${line[0]}\" /> 
						<input type=\"hidden\" name=\"type\" value=\"".$type."\" />
						<button type=\"submit\" class=\"button instead\" name=\"buttonClicked\" value=\"useInstead\">Use Instead</button>
					</form>
				</div>
				</li>";
			}

		}
		echo "</ul>\n";
		unset($line);
	} else {
		echo "0 results";
	}
}

// getNeighborhood returns all args except focal, ordered by:
//   hop 1 (direct neighbors, score 10000) → hop 2 (score 100) → hop 3 (score 1)
//   → unvisited args by degree centrality (most connected first)
// Replaces: getAssociated + getAggrEndorse + getAllTheRest + PHP BFS traversal
$sql = "CALL getNeighborhood($argID)";

$results = array();
if (mysqli_multi_query($db, $sql)) {
	$result = mysqli_store_result($db);
	if ($result && mysqli_num_rows($result) > 0) {
		while ($row = mysqli_fetch_row($result)) {
			// row: [0]=argumentID, [1]=proximity_score, [2]=phrasing
			$results[] = array($row[0], $row[1], $row[2]);
		}
	}
	if ($result) mysqli_free_result($result);
	while (mysqli_more_results($db)) {
		mysqli_next_result($db);
	}
} else {
	echo "ERROR - getNeighborhood query failed";
}
?>

<!DOCTYPE html>
<html>
	<head>
		<title>Agitate</title>
		<meta charset="utf-8"/>
		<meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic polling, self-guided polling, opposition research, best reason why, best reason not"/>
		<meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA" />
		<meta name="robots" content="follow" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="style_vestigette.css" />
		<script language="javascript" src="script_vestigette.js"></script>
		<script language="javascript">
			let arg = <?php echo isset($arg) ? $arg : 'undefined'; ?>,
				profile = <?php echo isset($profile) ? $profile : 'undefined'; ?>,
				opinion = <?php echo isset($opinion) ? $opinion : 'undefined'; ?>,
				assoc = <?php echo isset($assocWeights) ? "JSON.parse(" + $assocWeights + ")" : 'undefined'; ?>;
		</script>
	</head>
	<body class="checkpoint-page">
		<div id="checkpoint" class="container">
			<div class="checkpoint-header">
				<h2><?php echo htmlspecialchars($assertion); ?></h2>
				<div class="opinion">
					<form method="POST" class="buttons" action=<?php echo "\"/index.php?arg=".$argID."\"";?>>
						<input type="hidden" name="assertion" value="<?php echo htmlspecialchars($assertion);?>">
						<input type="hidden" name="type" value=<?php echo "\"".$type."\"";?> />
						<button type="submit" class="stick" name="buttonClicked" value="addAssertion" data-container-id="because">STICK WITH THIS</button>
					</form>
				</div>
			</div>
			<div class="panel expanded">
<?php
if (isset($results)) {
	generateTypeLines($results);
}
?>
			</div>
<?php
if (($type == 'Because') || ($type == 'Therefore')) {
?>
			<div class="checkpoint-footer">
				<input type="checkbox" name="reciprocate" value="reciprocate" id="reciprocate">
				<label for="reciprocate">Reciprocate by linking new addition back to current argument</label>
			</div>
<?php
}
?>
		</div>
	</body>
</html>

