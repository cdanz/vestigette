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

$sql = "CALL getAssociated($argID);";
$sql .= "CALL getAllTheRest();";
$sql .= "CALL getAggrEndorse()";

if (mysqli_multi_query($db, $sql)) {
	$result = mysqli_store_result($db);
	$assoc = array();
	if (mysqli_num_rows($result) > 0) {
		$iterator = 0;
		while ($row = mysqli_fetch_row($result)) {
			$assoc[$iterator] = array();
			$assoc[$iterator][0] = $row[1];
			$assoc[$iterator][1] = $row[2];
			$assoc[$iterator][2] = $row[3];
			$assoc[$iterator][3] = $row[4];
			$iterator++;
		}
	}
	mysqli_free_result($result);
	mysqli_next_result($db);
	mysqli_next_result($db);
	mysqli_next_result($db);
	$result = mysqli_store_result($db);
	$leftovers = array();
	if (mysqli_num_rows($result) > 0) {
		$iterator = 0;
		while ($row = mysqli_fetch_row($result)) {
			$leftovers[$iterator] = array();
			$leftovers[$iterator][0] = $row[0];
			$leftovers[$iterator][1] = $row[1];
			$leftovers[$iterator][2] = $row[2];
			$leftovers[$iterator][3] = $row[3];
			$iterator++;
		}
	}
	mysqli_free_result($result);
	mysqli_next_result($db);
	mysqli_next_result($db);
	mysqli_next_result($db);
	$result = mysqli_store_result($db);
	$bigList = array();
	if (mysqli_num_rows($result) > 0) {
		$iterator = 0;
		while ($row = mysqli_fetch_row($result)) {
			$bigList[$iterator] = array();
			$bigList[$iterator][0] = $row[0];
			$bigList[$iterator][1] = $row[1];
			$bigList[$iterator][2] = $row[2];
			$bigList[$iterator][3] = $row[3];
			$bigList[$iterator][4] = $row[4];
			$iterator++;
		}
	}
	//Clear all remaining results from multi-query if any
	while (mysqli_more_results($db)) {
		mysqli_next_result($db);
	}
} else {
	echo "ERROR - MULTIPLE QUERIES FAILED";
}
$pending = array(); // argID, starting weight, phrasing
$results = array(); // argID, greatest weight, phrasing
if ($type == 'Because' || $type == 'Therefore') {
	$endIndex = 0; //continue to use from one loop to next
	//All associated args go into array of pending args
	foreach ($assoc as $tuple) {
		if($tuple[0] != 'Rebuttal') {
			$pending[$endIndex] = array();
			$pending[$endIndex][0] = $tuple[1];
			$pending[$endIndex][1] = $tuple[2];
			$pending[$endIndex][2] = $tuple[3];
			$endIndex++;
		}
	}
	//Any args that were supported by current arg go in pending too. 
	for ($i = 0; $i < count($bigList); $i++) {
		if ($bigList[$i][2] == $argID && $bigList[$i][1] != 'Rebuttal') {
			$pending[$endIndex] = array();
			$pending[$endIndex][0] = $bigList[$i][0];
			$pending[$endIndex][1] = $bigList[$i][2];
			$pending[$endIndex][2] = null; //TODO returned phrasing is for supporting not target will need to find phrasing elsewhere
			$endIndex++;
		}
	}
}
$startIndex = 0;
while ($startIndex < count($pending)) {
	//Look through the whole bigList looking for matches on the current pending arg
	for ($i = 0; $i < count($bigList); $i++) {
		//match and not a rebuttal
		if ($pending[$startIndex][0] == $bigList[$i][0] && $bigList[$i][1] != 'Rebuttal') {
			//find weighted weight - weight to the N
			$weightN = (($pending[$startIndex][1]/100) * ($bigList[$i][3]/100)) * 100;
			//check for existing arg in the results that was just matched
			$found = false;
			for ($j = 0; $j < count($results); $j++) {
				if ($bigList[$i][2] == $results[$j][0]) {
					$found = true;
					//if found see if its existing weight is less than current
					if ($results[$j][1] < $weightN){
						$results[$j][1] = $weightN;
						$results[$j][2] = $bigList[$i][4]; //might be impossible to be null - opportunity to populate
					}
				}
			}
			//If not found then add it to results
			if (!$found) {
				$newResult = array($bigList[$i][2], $weightN, $bigList[$i][4]);
				array_push($results, $newResult);
			}
			//check for existing arg in the pending that hasn't already been processed 
			$found = false;
			for ($j = 0; $j < count($pending); $j++) { //TODO Previously j= $startIndex and not sure why I thought that was goo. set to zero fixes infinite loop.
				if ($bigList[$i][2] == $pending[$j][0]) {
					$found = true;
					//if found see if its existing weight is less than current
					if ($pending[$j][1] < $weightN){
						$pending[$j][1] = $weightN;
						$pending[$j][2] = $bigList[$i][4];
					}
				}
			}
			//If not found then add it to results
			if (!$found) {
				$newResult = array($bigList[$i][2], $weightN, $bigList[$i][4]);
				array_push($pending, $newResult);
				$endIndex++;
			}
		}
	}
	$startIndex++;
}
//Sort results by weight
$weight = array(); //declare it here because there are not always results to define it
foreach ($results as $key => $row) {
    $weight[$key]  = $row[1];
}
array_multisort($weight, SORT_DESC, $results);

//All other options. remove related leaving only unused
for ($i = 0; $i < count($results); $i++) {
	for ($j = 0; $j < count($leftovers); $j++) {
		if (isset($results[$i][0]) && isset($leftovers[$j][0]) && $results[$i][0] == $leftovers[$j][0]){
			unset($leftovers[$j]);
			break;
		}
	}
}

//merge 
$results = array_merge($results, $leftovers);
?>

<!DOCTYPE html>
<html>
	<head>
		<title>Vestigette</title>
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
	<body>
		<div id="checkpoint" class="accordion container">
			<h2><?php echo htmlspecialchars($assertion); ?></h2>
			<div class="opinion">
				<form method="POST" class="buttons" action=<?php echo "\"/index.php?arg=".$argID."\"";?>>
					<input type="hidden" name="assertion" value="<?php echo htmlspecialchars($assertion);?>">
					<input type="hidden" name="type" value=<?php echo "\"".$type."\"";?> />
					<button type="submit" class="stick" name="buttonClicked" value="addAssertion" data-container-id="because">STICK WITH THIS</button>
				</form>
			</div>
			<div class="panel expanded">
<?php
if (($type == 'Because') || ($type == 'Therefore')) { 
?>
				<div>
					<form>
						<input type="checkbox" name="reciprocate" value="reciprocate">
  						<label for="reciprocate"> Reciprocate by linking new addition back to current argument</label><br>
					</form>
				</div>
<?php
} 
?>
<?php
if (isset($results)) {
	generateTypeLines($results);
}
?>
			</div>
		</div>
	</body>
</html>

