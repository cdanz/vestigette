<?php 
session_start();
$csrfToken = md5(uniqid(mt_rand(),true));
$_SESSION['csrfToken'] = $csrfToken;
$_SESSION['currentArg'] = intval($_GET["arg"]);
//Send to help arg (75) if no other arg selected
if ($_SESSION['currentArg'] == 0){
	$_SESSION['currentArg'] = 75; 
}
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
//Keep me logged in cookie - get value before querying current argument
if(isset($_COOKIE['rememberMe']) && !isset($_SESSION['profile'])) {
	$stmt = $db->prepare("SELECT profileID, email FROM REMEMBER_ME WHERE token = ? ");	
	$stmt->bind_param("s", $_COOKIE['rememberMe']);
	$stmt->execute();
	$result = $stmt->get_result()->fetch_all(MYSQLI_NUM);
	if (!isset($result[1][0]) && isset($result[0][0])) {
		$_SESSION['profile'] = $result[0][0];
		$_SESSION['email'] = $result[0][1];
	}
}
//End cookie
require_once("${_SERVER['DOCUMENT_ROOT']}/query_current_argument.php");
//To do history - add to array of past arguments visited
if (isset($_SESSION['history'])) {
	$limit = sizeof($_SESSION['history']);
	for ($i = 0; $i < $limit; $i++) { //remove previous instances of current arg
		if($_SESSION['history'][$i][0] == $_SESSION['currentArg']) {
			array_splice($_SESSION['history'], $i, 1);
			break;
		}
	}
	$arr = array($_SESSION['currentArg'],$opinion,$phrasing);
	array_push($_SESSION['history'],$arr);
	if(sizeof($_SESSION['history']) >= 10) {
		$_SESSION['history'] = array_slice($_SESSION['history'], -9); //no more than 
	}
	
}
else {
	$_SESSION['history'] = array();
	$_SESSION['history'][0] = array(75,0,"This is my first visit to Vestigette"); //Start off with welcome arg
	$arr = array($_SESSION['currentArg'],$opinion,$phrasing);
	array_push($_SESSION['history'],$arr);
}
//To aid in seeding with fake user endorsements - display profile for those users
if (isset($_SESSION['profile']) && ($_SESSION['profile'] < 26)) {
	echo "Seed User: ".$_SESSION['profile'];
}
//End of seeding ids
$baseURL = "/index.php";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
// made obsolete $opinion = isset($_SESSION['opinion']) ? $_SESSION['opinion'] : null;
$assocWeights = isset($_SESSION['assocWeights']) ? $_SESSION['assocWeights'] : null; //not used


if (isset($_POST["buttonClicked"])) {
	include("${_SERVER['DOCUMENT_ROOT']}/functions.php");
}
mysqli_close($db);
	

function addCSRFtoken() {
	global $csrfToken;
	echo "\n<input type=\"hidden\" name=\"csrfToken\" value=\"" . $csrfToken . "\" />";
}

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
			echo "			<li class=\"lineItem ${half} pct${pct}\" data-arg-id=\"${line[0]}\" data-aggregate-weight=\"" . strval(number_format($line[1], 2, '.', '')) . "\" data-user-weight=\"" . ((isset($line[3])) ? strval(number_format($line[3], 2, '.', '')) : "0.00") . "\">
				<div class=\"wrapper\"" . ((isset($onClick)) ? $onClick : "") . ">
					<div class=\"pointBtn arc1\"></div>
					<div class=\"pointBtn arc2\"></div>
				</div>
				<p class=\"assocArg\"><span class=\"inLinePct\">" . strval(number_format($line[1], 2, '.', '')) . "% - </span><a href=\"${baseURL}?arg=${line[0]}\">".htmlspecialchars($line[2])."</a></p>
			</li>";
		}
		echo "</ul>\n";
		unset($line);
	} else {
		if ($type == "rebuttal") {
			echo "No Results - Reject the argument to be the first to endorse";
		}
		else {
			echo "No Results - Accept the argument to be the first to endorse";
		}
	}
}
function generatePhrasingLines($alts) {
    global $opinion;
    global $userPhrasingID;
    global $baseURL;
    
    if (sizeof($alts) > 0) {
        echo "<ul>\n";
        foreach ($alts as $line) {
            // $line[0] = totalWeight (aggregate)
            // $line[1] = endorsementCount
            // $line[2] = phrasing text
            // $line[3] = phrasingID
            
                    // Calculate percentage for display
            $totalWeight = isset($line[0]) ? floatval($line[0]) : 0;
            $maxWeight = 100;
            $percentage = $maxWeight > 0 ? ($totalWeight / $maxWeight) * 100 : 0;

            if ($percentage <= 50) {
                $half = "half1";
            } else {
                $half = "half2";
            }

            $pct = strval(number_format($percentage, 1, '_', ''));
            $userWeight = 0;

            $isUserChoice = (isset($userPhrasingID) && ($userPhrasingID == $line[3]));
            $userLabel = $isUserChoice ? " <span style=\"color: var(--cddbGrey);font-size: 0.75rem;\">(your preference)</span>" : "";

            echo "            <li class=\"lineItem ${half} pct${pct}\" data-phrasing-id=\"${line[3]}\" data-aggregate-weight=\"" . strval(number_format($percentage, 2, '.', '')) . "\" data-user-weight=\"" . strval(number_format($userWeight, 2, '.', '')) . "\">
                <div class=\"wrapper\">
                    <div class=\"pointBtn arc1\"></div>
                    <div class=\"pointBtn arc2\"></div>
                </div>
                <p class=\"assocArg\"><span class=\"inLinePct\">" . strval(number_format($percentage, 2, '.', '')) . "% - </span>" . htmlspecialchars($line[2]) . $userLabel . "</p>
            </li>";
        }
        echo "</ul>\n";
        unset($line);
    } else {
        echo "No alternative phrasings yet - be the first to introduce one!";
    }
}
function generateLinkLines($links) {
	global $opinion;
	if (sizeof($links) > 0) {
		echo "<ul>\n";
		foreach ($links as $line) {
			// $line[0] = totalWeight, [1] = endorsementCount, [2] = explicationID
			// [3] = hyperlink, [4] = publisher, [5] = authorFName, [6] = authorLName, [7] = title
			if ($line[3] === NULL) continue;
			$totalWeight = isset($line[0]) ? floatval($line[0]) : 0;
			$maxWeight = 100;
			$percentage = $maxWeight > 0 ? ($totalWeight / $maxWeight) * 100 : 0;
			$half = $percentage <= 50 ? "half1" : "half2";
			$pct = strval(number_format($percentage, 1, '_', ''));
			$userWeight = 0;
			$label = ($line[7] !== NULL && $line[7] !== '') ? htmlspecialchars($line[7]) : htmlspecialchars($line[3]);

			echo "			<li class=\"lineItem ${half} pct${pct}\" data-explication-id=\"${line[2]}\" data-aggregate-weight=\"" . strval(number_format($percentage, 2, '.', '')) . "\" data-user-weight=\"" . strval(number_format($userWeight, 2, '.', '')) . "\">
				<div class=\"wrapper\">
					<div class=\"pointBtn arc1\"></div>
					<div class=\"pointBtn arc2\"></div>
				</div>
				<p class=\"assocArg\"><span class=\"inLinePct\">" . strval(number_format($percentage, 2, '.', '')) . "% - </span><a href=\"${line[3]}\" target=\"_blank\">${label}</a></p>
			</li>";
		}
		echo "</ul>\n";
		unset($line);
	} else {
		echo "No explication links yet - be the first to introduce one!";
	}
}
function generateFindLines($results) {
	global $baseURL;
	global $arg;
	if (sizeof($results) > 0) {
		echo "<ul>\n";
		foreach ($results as $line) {
			//Exclude the current arg lest argument would be circular
			if ($line[0] != $arg) {
				if ($line[1] > 0) {
					$color = "style=\"color: var(--cddbGreen);\"";
				}
				else if ($line[1] < 0) {
					$color = "style=\"color: var(--cddbRed);\"";
				}
				else {
					$color = "style=\"color: var(--cddbblack);\"";
				}
				echo "			<li class=\"lineItem\" ${color} data-arg-id=\"${line[0]}\">
					<a href=\"${baseURL}?arg=${line[0]}\">".htmlspecialchars($line[2])."</a>
				</li>";
			}
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
		<title>Agitate</title>
		<meta charset="utf-8"/>
		<meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic polling, self-guided polling, opposition research, best reason why, best reason not"/>
		<meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA" />
		<meta name="robots" content="follow" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>" />
		<script language="javascript" src="script_vestigette.js?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/script_vestigette.js'); ?>"></script>
		<!--<script language="javascript">
			let arg = <?php echo isset($arg) ? $arg : 'undefined'; ?>,
				profile = <?php echo isset($profile) ? $profile : 'undefined'; ?>,
				opinion = <?php echo isset($opinion) ? $opinion : 'undefined'; ?>,
				assoc = <?php echo isset($assocWeights) ? "JSON.parse(" + $assocWeights + ")" : 'undefined'; ?>
				because = <?php echo json_encode($because); ?>,
				therefore = <?php echo json_encode($therefore); ?>,
				rebuttal = <?php echo json_encode($rebuttal); ?>;
		</script>-->
		<!-- Global site tag (gtag.js) - Google Analytics -->
		<script async src="https://www.googletagmanager.com/gtag/js?id=G-38LM87XMGN"></script>
		<script>
			window.dataLayer = window.dataLayer || [];
			function gtag(){dataLayer.push(arguments);}
			gtag('js', new Date());
			gtag('config', 'G-38LM87XMGN');
		</script>
	</head>
	<body>

		<div id="mastHead" class="container">
			<h1><a href="index.php?arg=<?php echo $_SESSION['currentArg'];?>">AGITATE</a></h1>
			<div>
				<a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a>
				<a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a>
				<a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a>
				<a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a>
				<a href="#" class="closenav" onclick="closeNav()">&times;</a>
			</div> 
			
			<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
		</div>

		<div id="because" class="accordion container">
			<h2>Because</h2>
<?php
if ((isset($opinion)) && ($opinion > 0)) { 
?>
	<div class="buttons">
		<button class="button reset hidden" name="buttonClicked" value="weighBecause" data-container-id="because"><span>&#x27F2;</span></button>
		<form method="POST" accept-charset="utf-8">
			<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighBecause" data-container-id="because">Endorse</button>
<!-- This hidden field has its value updated with an array as a string serving as the "weigh in" input -->
			<input type="hidden" name="becauseWeighInWith" id="becauseWeighInWith" value="" />
			<?php addCSRFtoken() ?>
		</form>
		<button class="button weighIn" data-container-id="because">Weigh In</button>
	</div>
<?php
} 
?>
			<div class="panel" data-container-id="because">
<?php
if (isset($because)) {
	generateTypeLines("because", $because);
}
else {
	echo "No Results - Accept the argument to be the first to endorse";
}
?>
				<div class="assert hidden">
					<form class="form-inline" method="POST" action="checkpoint.php" accept-charset="utf-8">
						<label for="assertion">Add Unique:</label>
						<input type="text" placeholder="An assertion not yet listed here" name="assertion">
						<input type="hidden" name="type" value="Because" />
						<button type="submit" class="button addNew" name="buttonClicked" value="addAssertion" data-container-id="because">Submit</button>
						<?php addCSRFtoken() ?>
					</form>
				</div>
			</div>
		</div>


		<div id="argument" class="accordion container">
			<h2>Argument <?php echo $arg; ?></h2>
			<div class="opinion">
<?php /* refactored */
$accept = 'Open';
$reject = 'Set';
if (isset($_SESSION['profile'])) {
	echo "<form method=\"POST\" class=\"buttons\" accept-charset=\"utf-8\">";
	if ($opinion == 0) { 
		$reject = 'Open';
	}
	else if ($opinion > 0) { 
		$accept = 'Set';
		$reject = 'Open';
	}
	echo "
		<button type=\"submit\" class=\"button accept accept$accept\" name=\"buttonClicked\" value=\"accept\">Accept" . (($accept == 'Set') ? "ed" : "") . "</button>
		<button type=\"submit\" class=\"button reject reject$reject\" name=\"buttonClicked\" value=\"reject\">Reject" . (($reject == 'Set') ? "ed" : "") . "</button>";
} else {
	echo "<form method=\"GET\" class=\"buttons\" action=\"login.php?arg=" . $_SESSION['currentArg'] . "\" accept-charset=\"utf-8\">
	<button type=\"submit\" class=\"button accept acceptOpen\" name=\"buttonClicked\">Accept</button>
	<button type=\"submit\" class=\"button reject rejectOpen\" name=\"buttonClicked\">Reject</button>";
}
addCSRFtoken();
echo "\n</form>";
?>
			</div>
			<div class="panel expanded" data-container-id="argument">
				<div class="rate_phrase">
					<div class="stat">
						<span class="statBig"><?php echo explode('.', $rate)[0]; ?></span>
						<span class="statSmall">.<?php echo explode('.', $rate)[1]; ?>%</span>
						<span class="statDetail">of <?php echo $assertions . (($assertions == 1) ? " user accept\n" : " users accept\n"); ?></span>
					</div>
					<p><?php echo htmlspecialchars($phrasing); ?></p>
					<button class="altPhraseBtn" name="buttonClicked" value="altPhrasing">&#x270e;</button>
				</div>
				<div class="explicationBox">
<?php
if (isset($links[0][3]) && $links[0][3] !== '') {
	$expUrl    = $links[0][3];
	$expID     = $links[0][2];
	$ogTitle   = $links[0][8] ?? null;
	$ogImage   = $links[0][9] ?? null;
	$ogDesc    = $links[0][10] ?? null;
	// Lazy-fetch OG data for existing links that predate the og_ columns
	if ($ogTitle === null && $ogImage === null) {
		storeOgMeta($db, $expUrl, $expID);
		$ogRow = mysqli_fetch_row(mysqli_query($db, "SELECT og_title, og_image, og_description FROM EXPLICATION WHERE explicationID=" . intval($expID)));
		if ($ogRow) { $ogTitle = $ogRow[0]; $ogImage = $ogRow[1]; $ogDesc = $ogRow[2]; }
	}
	$host = @parse_url($expUrl, PHP_URL_HOST) ?: $expUrl;
	if ($ogTitle || $ogImage || $ogDesc) {
?>
				<a href="<?php echo htmlspecialchars($expUrl); ?>" target="_blank" class="link-preview">
<?php if ($ogImage) { ?>				<img src="<?php echo htmlspecialchars($ogImage); ?>" class="link-preview-img" alt="" loading="lazy">
<?php } ?>				<div class="link-preview-text">
					<span class="link-preview-title"><?php echo htmlspecialchars($ogTitle ?: $host); ?></span>
<?php if ($ogDesc) { ?>				<span class="link-preview-desc"><?php echo htmlspecialchars($ogDesc); ?></span>
<?php } ?>					<span class="link-preview-domain"><?php echo htmlspecialchars($host); ?></span>
				</div>
				</a>
<?php } else { ?>
				<a href="<?php echo htmlspecialchars($expUrl); ?>" target="_blank"><?php echo htmlspecialchars($expUrl); ?></a>
<?php } } ?>
					<button class="altExplicationBtn" name="buttonClicked" value="altExplication">&#x2318;</button>
				</div>
			</div>
		</div>

		<div id="rebuttal" class="accordion container">
			<h2>Rebuttal</h2>
<?php
if ((isset($opinion)) && ($opinion < 0)) { 
?>
	<div class="buttons">
		<button class="button reset hidden" name="buttonClicked" value="weighRebuttal" data-container-id="rebuttal"><span>&#x27F2;</span></button>
		<form method="POST" accept-charset="utf-8">
			<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighRebuttal" data-container-id="rebuttal">Endorse</button>
<!-- This hidden field has its value updated with an array as a string serving as the "weigh in" input -->
			<input type="hidden" name="rebuttalWeighInWith" id="rebuttalWeighInWith" value="" />
			<?php addCSRFtoken() ?>
		</form>
		<button class="button weighIn" data-container-id="rebuttal">Weigh In</button>
	</div>
<?php
} 
?>
			<div class="panel" data-container-id="rebuttal">
<?php
if (isset($rebuttal)) {
	generateTypeLines("rebuttal", $rebuttal);
}
else {
	echo "No Results - Reject the argument to be the first to endorse";
}
?>
				<div class="assert hidden">
					<form class="form-inline" method="POST" action="checkpoint.php" accept-charset="utf-8">
						<label for="assertion">Add Unique:</label>
						<input type="text" placeholder="An assertion not yet listed here" name="assertion">
						<input type="hidden" name="type" value="Rebuttal" />
						<button type="submit" class="button addNew" name="buttonClicked" value="addAssertion" data-container-id="rebuttal">Submit</button>
						<?php addCSRFtoken() ?>
					</form>
				</div>
			</div>
		</div> 

		<div id="therefore" class="accordion container">
			<h2>Therefore</h2>
<?php
if ((isset($opinion)) && ($opinion > 0)) { 
?>
	<div class="buttons">
		<button class="button reset hidden" name="buttonClicked" value="weighTherefore" data-container-id="therefore"><span>&#x27F2;</span></button>
		<form method="POST" accept-charset="utf-8">
			<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighTherefore" data-container-id="therefore">Endorse</button>
<!-- This hidden field has its value updated with an array as a string serving as the "weigh in" input -->
			<input type="hidden" name="thereforeWeighInWith" id="thereforeWeighInWith" value="" />
			<?php addCSRFtoken() ?>
		</form>
		<button class="button weighIn" data-container-id="therefore">Weigh In</button>
	</div>
<?php
} 
?>
			<div class="panel" data-container-id="therefore">
<?php
	if (isset($therefore)) {
		generateTypeLines("therefore", $therefore);
	}
	else {
		echo "No Results - Accept the argument to be the first to endorse";
	}
?>
				<div class="assert hidden">
					<form class="form-inline" method="POST" action="checkpoint.php" accept-charset="utf-8">
						<label for="assertion">Add Unique:</label>
						<input type="text" placeholder="An assertion not yet listed here" name="assertion">
						<input type="hidden" name="type" value="Therefore" />
						<button type="submit" class="button addNew" name="buttonClicked" value="addAssertion" data-container-id="therefore">Submit</button>
						<?php addCSRFtoken() ?>
					</form>
				</div>
			</div>
		</div>

		<div id="find" class="accordion container">
			<h2>Find</h2>
			<div class="panel" data-container-id="filter">
				<div class="find">
					<ul><li class="strong">Last Visited</li><ul>
<?php
if (isset($_SESSION['history'])) {

	$arr = array_reverse($_SESSION['history']); //more recent listed first
	generateFindLines($arr);
}
?>
					<ul><li class="strong">Recent Assertions</li><ul>
<?php
if (isset($recent)) {
	generateFindLines($recent);
}
?>
					<ul><li class="strong">Go to ID</li><ul>
					<ul><li class="lineItem">
						<form class="form-inline" id="form" method="get">
							<input type="text" id="jumpToID" name="arg" placeholder="Argument ID" onchange="document.getElementById('form').action = <?php echo "${baseURL}?arg="; ?> + this.value;">
							<button type="submit" class="button instead" value="jumpTo">Go</button>
						</form>
					</li><ul>
				</div>

			</div>
		</div>

		<!-- You not ready for this -->
		<div id="filter" class="accordion container hidden">
			<h2>Filter</h2>
			<div class="panel" data-container-id="filter">
				<div class="filter">
					<div class="filterLabel" id="filter1A">All Users</div>
					<label class="switch" id="filter1">	
						<input type="checkbox" id="check1">
						<span class="toggle round"></span>
					</label>
					<div class="filterLabel" id="filter1B">Current User</div>
				</div>

			</div>
		</div>

<!-- Phrasing Modal -->
<div id="overlayP" class="hidden">
    <div id="phrasing" class="container hidden">
        <h2>Put Another Way</h2>
        <div class="buttons">
            <button id="closeP" class="button">X</button> 
        </div>
<?php
if ((isset($opinion)) && ($opinion > 0)) { 
?>
        <div class="buttons">
            <button class="button reset hidden" name="buttonClicked" value="weighPhrasing" data-container-id="phrasing">&#x27F2;</button>
            <form method="POST" accept-charset="utf-8">
                <button type="submit" class="button endorse hidden" name="buttonClicked" value="weighPhrasing" data-container-id="phrasing">Endorse</button>
                <input type="hidden" name="phrasingWeighInWith" id="phrasingWeighInWith" value="" />
                <?php addCSRFtoken() ?>
            </form>
            <button class="button weighIn" data-container-id="phrasing">Weigh In</button>
        </div>
<?php
} 
?>
        <div class="panel expanded" data-container-id="phrasing">
<?php
    if (isset($altPhrasings)) {
        generatePhrasingLines($altPhrasings);
    }
?>
<?php
if ((isset($opinion)) && ($opinion > 0)) { 
?>
            <div class="assert hidden">
                <form class="form-inline" method="POST" accept-charset="utf-8">
                    <input type="text" placeholder="Better said..." name="newPutForth">
                    <button type="submit" class="button addNew" name="buttonClicked" value="newPutForth">Introduce</button>
                    <?php addCSRFtoken() ?>
                </form>
            </div>
<?php
} 
?>
        </div>
    </div>
</div>

			<div id="overlayE" class="hidden">
				<div id="explication" class="container hidden">
					<h2>Explication Links</h2>
					<div class="buttons">
						<button id="closeE" class="button">X</button>
					</div>
<?php
if ((isset($opinion)) && ($opinion > 0)) {
?>
				<div class="buttons">
					<button class="button reset hidden" name="buttonClicked" value="weighExplication" data-container-id="explication">&#x27F2;</button>
					<form method="POST" accept-charset="utf-8">
						<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighExplication" data-container-id="explication">Endorse</button>
						<input type="hidden" name="explicWeighInWith" id="explicWeighInWith" value="" />
						<?php addCSRFtoken() ?>
					</form>
					<button class="button weighIn" data-container-id="explication">Weigh In</button>
				</div>
<?php
}
?>
					<div class="panel expanded" data-container-id="explication">

<?php
	if (isset($links) && sizeof($links) > 0) {
		generateLinkLines($links);
	}
?>
<?php
if ((isset($opinion)) && ($opinion > 0)) {
?>
						<div class="assert hidden">
							<form class="form-inline" method="POST" accept-charset="utf-8">
								<input type="text" placeholder="Link a study, article, chart, meme, anything that expands upon or illuminates the argument" name="promoteExplication">
								<button type="submit" class="button addNew" name="buttonClicked" value="promoteExplication">Introduce</button>
								<?php addCSRFtoken() ?>
							</form>
						</div>
<?php
}
?>
					</div>
				</div>
			</div>


	</body>
</html>