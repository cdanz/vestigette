<?php
session_start();
/* no security while developing
if($_POST['csrfToken'] != $_SESSION['csrfToken']) {
	die("Unauthorized source!");
}
*/
$_SESSION['currentArg'] = 77;
$baseURL = "/index.php";
$argID = $_SESSION['currentArg'];
//$type = strtolower($_POST["type"]);
$type = 'because'; //TESTING
if(!isset($_SESSION['profile'])){
	header('Location: /index.php?arg='.$_SESSION['currentArg']);
}
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/query_current_argument.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/graph_search.php");

function IsNullOrEmptyString($str) {
	return (!isset($str) || trim($str) === '');	
}

/* Checkpoint style had no use for buttons 
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
*/
/*Replace checkpoint style results with more full featured results like these originally forked from index.php*/
function generateTypeLines($type, $typeArray) {
	global $baseURL;
	global $opinion;
	global $alreadyEndorsed;
	global $results;
	$fullArray = array_merge($typeArray, $results); 
	echo "<ul>\n";
	foreach ($fullArray as $line) {
		/*What does this do, Craig? Why? Maybe comment on your code, jerk.*/
		if (isset($_SESSION['profile']) AND ($opinion != 0)) {
			if ((($type == "rebuttal") AND ($opinion < 0)) OR (($type != "rebuttal") AND ($opinion > 0))) {
				$onClick = "onclick=\"firstClick" . ucfirst($type) . "(" . $line[0] . ")\"";
			}
		}
		unset($onClick);
		if ($alreadyEndorsed) {
			if (isset($line[3]) && is_numeric($line[3])) {
				$lineWeight = $line[3];
			} else {
				$lineWeight = 0;
			}
		} else {
			$lineWeight = $line[1];
		}
		if ($lineWeight <= 50) {
			$half = "half1";
		} else {
			$half = "half2";
		}
		$pct = strval(number_format($lineWeight, 1, '_', ''));
		echo "			<li class=\"lineItem ${half} pct${pct}\" data-arg-id=\"${line[0]}\" data-aggregate-weight=\"" . strval(number_format($lineWeight, 2, '.', '')) . "\">
			<div class=\"wrapper\"" . ((isset($onClick)) ? $onClick : "") . ">
				<div class=\"pointBtn arc1\"></div>
				<div class=\"pointBtn arc2\"></div>
			</div>
			<p class=\"assocArg\"><span class=\"inLinePct\">" . strval(number_format($lineWeight, 2, '.', '')) . "% - </span><a href=\"${baseURL}?arg=${line[0]}\">".htmlspecialchars($line[2])."</a></p>
		</li>";
	}
	echo "</ul>\n";
	unset($line);
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
	<body>
		<div id=<?php echo "\"".$type."\"";?> class="accordion container">
			<h2><?php if ($type == 'rebutal'){
				echo "Reject: ".htmlspecialchars($phrasing)." because...";
			} 
			else {echo htmlspecialchars($phrasing)." ".$type."...";} ?></h2>
			<button class="button reset" name="buttonClicked" value="weighBecause" data-container-id="because"><span>&#x27F2;</span></button>
			<div class="panel standalone"> <!-- standalone needs a max-height that adjusts to the screen so it doesn't get too big -->
<?php
/* Kill this and consider making reciprocation standard for this action
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
*/
?>
<?php
if (isset($because)) {
	generateTypeLines($type,$because);
}
?>
			</div>
		</div>
	</body>
</html>

