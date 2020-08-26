<?php 
session_start();
$_SESSION['currentArg'] = intval($_GET["arg"]); 
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/query_current_argument.php");
$baseURL = "/index.php";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
// made obsolete $opinion = isset($_SESSION['opinion']) ? $_SESSION['opinion'] : null;
$assocWeights = isset($_SESSION['assocWeights']) ? $_SESSION['assocWeights'] : null;


if(isset($_POST["buttonClicked"])) {
  include("${_SERVER['DOCUMENT_ROOT']}/functions.php");
	}
mysqli_close($db);


function generateTypeLines($type, $typeArray) {
	global $baseURL;
	global $opinion;
	if (sizeof($typeArray) > 0) {
		echo "<ul>\n";
		foreach ($typeArray as $line) {
			if (isset($_SESSION['profile']) AND ($opinion != 0)) {
				if ((($type == "rebuttal") AND ($opinion < 0)) OR (($type != "rebuttal") AND ($opinion > 0))) {
					$onClick = "onclick=\"firstClick" . ucfirst($type) . "(" . $line[0] . ")\"";
				}
			}
unset($onClick);
			if ($line[1] <= 50) {
				$half = "half1";
			} else {
				$half = "half2";
			}
			$pct = strval(number_format($line[1], 1, '_', ''));
			echo "			<li class=\"lineItem\">
				<div class=\"wrapper ${half} pct${pct} ${type}\" " . ((isset($onClick)) ? $onClick : "") . ">
					<div class=\"pointBtn arc1\"></div>
					<div class=\"pointBtn arc2\"></div>
				</div>
				<p class=\"assocArg\"><span class=\"inLinePct\">" . strval(number_format($line[1], 2, '.', '')) . "% - </span><a href=\"${baseURL}?arg=${line[0]}\">${line[2]}</a></p>
			</li>";
		}
		echo "</ul>\n";
		unset($line);
	} else {
		echo "0 results";
	}
}
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

		<div class="mastHead container">
			<h1>Vestigette</h1>
			<div><a href="http://www.vestigette.org/About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a></div>
			<div><a href="http://www.vestigette.org/Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a></div>
			<div><a href="http://www.vestigette.org/Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a></div>
			<div><a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a></div> 
		</div>

		<div class="accordion container because">
			<h2>Because</h2>
<?php
if ((isset($opinion)) && ($opinion > 0)) { 
?>
	<div class="buttons">
		<button onclick="becauseClearData()" class="button because reset hidden" name="buttonClicked" value="weighBecause"><span>&#x27F2;</span></button> 
		<form method="POST"> 
			<button type="submit" class="button because endorse hidden" name="buttonClicked" value="weighBecause">Endorse</button>
<!-- This hidden field has its value updated with an array as a string serving as the "weigh in" input -->
			<input type="hidden" name="becauseWeighInWith" id="becauseWeighInWith" value="" /> 
		</form>
		<button class="button because weighIn" name="buttonClicked" value="weighInBecause">Weigh In</button>
	</div>
<?php
} 
?>
			<div class="panel">
<?php
if (isset($because)) {
	generateTypeLines("because", $because);
}
?>
			</div>
		</div>


		<div class="accordion container argument">
			<h2>Argument ID</h2>
			<div class="opinion">
<?php /* refactored */
$accept = 'Open';
$reject = 'Set';
if (isset($_SESSION['profile'])) {
	echo "<form method=\"POST\" class=\"buttons\" >";
	if ($opinion == 0) { 
		$reject = 'Open';
	}
	else if ($opinion > 0) { 
		$accept = 'Set';
		$reject = 'Open';
	}
	echo "
		<button type=\"submit\" class=\"button accept accept$accept\" name=\"buttonAccept\" value=\"accept\">Accept" . (($accept == 'Set') ? "ed" : "") . "</button>
		<button type=\"submit\" class=\"button reject reject$reject\" name=\"buttonReject\" value=\"reject\">Reject" . (($reject == 'Set') ? "ed" : "") . "</button>";
} else {
	echo "<form method=\"GET\" class=\"buttons\" action=\"login.php?arg=" . $_SESSION['currentArg'] . "\">
	<button type=\"submit\" class=\"button accept acceptOpen\" name=\"buttonClicked\">Accept</button>
	<button type=\"submit\" class=\"button reject rejectOpen\" name=\"buttonClicked\">Reject</button>";
}
echo "\n</form>";
?>
			</div>
			<div class="panel expanded">
				<div class="rate_phrase">
					<div class="stat">
						<span class="statBig"><?php echo explode('.', $rate)[0]; ?></span>
						<span class="statSmall">.<?php echo explode('.', $rate)[1]; ?>%</span>
						<span class="statDetail">of <?php echo $assertions . (($assertions == 1) ? " user accept\n" : " users accept\n"); ?></span>
					</div>
					<p><?php echo $phrasing; ?></p>
					<button class="altPhraseBtn" name="buttonClicked" value="altPhrasing">&#x270e;</button>
				</div>
				<div class="explicationBox">
					<a href="<?php echo $links[0][1]; ?>" target="_blank"><?php echo $links[0][1]; ?></a>
					<button class="altExplicationBtn" name="buttonClicked" value="altExplication">&#x2318;</button>
				</div>
			</div>
		</div>

		<div class="accordion container rebuttal">
			<h2>Rebuttal</h2>
			<div class="panel">
<?php
if (isset($rebuttal)) {
	generateTypeLines("rebuttal", $rebuttal);
}
?>
			</div>
		</div> 

		<div class="accordion container therefore">
			<h2>Therefore</h2>
			<div class="panel">
<?php
if (isset($therefore)) {
	generateTypeLines("therefore", $therefore);
}
?>
			</div>
		</div>

		<div class="accordion container filter">
			<h2>Filter</h2>
			<div class="panel">
				<p>Coming "Soon"<br/><br/></p>
			</div>
		</div>

	</body>
</html>