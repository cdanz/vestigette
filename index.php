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
// Follow ARGUMENT_REDIRECT chain (up to 5 hops) for merged arguments
if ($_SESSION['currentArg'] > 0) {
	$_redirCheck = $_SESSION['currentArg'];
	for ($_hop = 0; $_hop < 5; $_hop++) {
		$_redirRow = mysqli_fetch_row(mysqli_query($db,
			"SELECT newArgumentID FROM ARGUMENT_REDIRECT WHERE oldArgumentID=$_redirCheck"));
		if ($_redirRow) {
			$_redirCheck = intval($_redirRow[0]);
		} else {
			break;
		}
	}
	if ($_redirCheck !== $_SESSION['currentArg']) {
		header("Location: /?arg=$_redirCheck");
		exit;
	}
}
// End redirect check
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
	$_SESSION['history'][0] = array(75,0,"This is my first visit to Agitate"); //Start off with welcome arg
	$arr = array($_SESSION['currentArg'],$opinion,$phrasing);
	array_push($_SESSION['history'],$arr);
}
//To aid in seeding with fake user endorsements - display profile for those users
if (isset($_SESSION['profile']) && ($_SESSION['profile'] < 26)) {
	echo "Seed User: ".$_SESSION['profile'];
}
//End of seeding ids
$baseURL = "/";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
// made obsolete $opinion = isset($_SESSION['opinion']) ? $_SESSION['opinion'] : null;
$assocWeights = isset($_SESSION['assocWeights']) ? $_SESSION['assocWeights'] : null; //not used


if (isset($_POST["buttonClicked"])) {
	include("${_SERVER['DOCUMENT_ROOT']}/functions.php");
}
// Lazy-fetch OG data for the winning explication before closing the DB connection
if (isset($links[0][3]) && $links[0][3] !== '' && $links[0][8] === null && $links[0][9] === null) {
	storeOgMeta($db, $links[0][3], $links[0][2]);
	$ogRow = mysqli_fetch_row(mysqli_query($db, "SELECT og_title, og_image, og_description FROM EXPLICATION WHERE explicationID=" . intval($links[0][2])));
	if ($ogRow) { $links[0][8] = $ogRow[0]; $links[0][9] = $ogRow[1]; $links[0][10] = $ogRow[2]; }
}
// --- Admin setup (runs on every GET, results cached in session) ---
$isAdmin            = false;
$adminPickerEnabled = false;
$adminPickerData    = []; // [{profileID, lastName}] ordered: real profile first

if (isset($_SESSION['profile'])) {
	// Anchor the real (logged-in) profile once per session
	if (!isset($_SESSION['realProfile'])) {
		$_SESSION['realProfile'] = $_SESSION['profile'];
	}
	$realProfileID = intval($_SESSION['realProfile']);

	// Cache admin flag in session so we don't query every page load
	if (!isset($_SESSION['isAdmin'])) {
		$adminChk = mysqli_fetch_row(mysqli_query($db, "SELECT isAdmin FROM USER_PROFILE WHERE profileID=$realProfileID"));
		$_SESSION['isAdmin'] = ($adminChk && intval($adminChk[0]) === 1);
	}
	$isAdmin = (bool)$_SESSION['isAdmin'];

	if ($isAdmin) {
		$settRow = mysqli_fetch_assoc(mysqli_query($db,
			"SELECT pickerEnabled, pickerProfiles FROM ADMIN_SETTINGS WHERE profileID=$realProfileID"));
		$adminPickerEnabled = $settRow ? (bool)$settRow['pickerEnabled'] : false;

		if ($adminPickerEnabled) {
			$pickerIDs = [$realProfileID];
			if ($settRow && $settRow['pickerProfiles']) {
				$extra = array_filter(array_map('intval', explode(',', $settRow['pickerProfiles'])));
				$pickerIDs = array_unique(array_merge($pickerIDs, $extra));
			}
			$idList = implode(',', $pickerIDs);
			$pickerResult = mysqli_query($db,
				"SELECT profileID, lastName FROM USER_PROFILE WHERE profileID IN ($idList)");
			$byID = [];
			while ($row = mysqli_fetch_assoc($pickerResult)) {
				$byID[intval($row['profileID'])] = $row['lastName'];
			}
			foreach ($pickerIDs as $pid) {
				if (isset($byID[$pid])) {
					$adminPickerData[] = ['profileID' => $pid, 'lastName' => $byID[$pid]];
				}
			}
		}
	}
}
// --- End admin setup ---
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
            
                    // avgWeight is already a 0-100 value (SUM/endorserCount from SQL)
            $percentage = isset($line[0]) ? floatval($line[0]) : 0;

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
			// avgWeight is already a 0-100 value (SUM/endorserCount from SQL)
			$percentage = isset($line[0]) ? floatval($line[0]) : 0;
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
		<script>
			let arg = <?php echo isset($arg) ? intval($arg) : 'null'; ?>,
				profile = <?php echo isset($profile) ? intval($profile) : 'null'; ?>,
				opinion = <?php echo isset($opinion) ? intval($opinion) : 'null'; ?>,
				because = <?php echo json_encode(isset($because) ? $because : null); ?>,
				therefore = <?php echo json_encode(isset($therefore) ? $therefore : null); ?>,
				rebuttal = <?php echo json_encode(isset($rebuttal) ? $rebuttal : null); ?>;
		</script>
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

<?php if ($isAdmin && $adminPickerEnabled && !empty($adminPickerData)): ?>
<div id="adminPickerBar">
	<span class="admin-bar-label">Admin — Viewing as:</span>
	<form method="POST" id="adminPickerForm" action="/?arg=<?php echo $_SESSION['currentArg']; ?>">
		<input type="hidden" name="buttonClicked" value="adminSwitchProfile">
		<?php foreach ($adminPickerData as $p): ?>
		<label class="admin-picker-option">
			<input type="radio" name="pickerProfile" value="<?php echo intval($p['profileID']); ?>"
				<?php if (intval($_SESSION['profile']) === intval($p['profileID'])) echo 'checked'; ?>
				onchange="this.form.submit()">
			<?php echo htmlspecialchars($p['lastName']); ?>
		</label>
		<?php endforeach; ?>
	</form>
	<a class="admin-bar-tools-link" href="/admin_tools.php?arg=<?php echo $_SESSION['currentArg']; ?>">⚙ Tools</a>
</div>
<?php endif; ?>

<?php if (!empty($_SESSION['formError'])): ?>
		<div class="form-error-banner" role="alert">
			<?php echo htmlspecialchars($_SESSION['formError']); unset($_SESSION['formError']); ?>
		</div>
<?php endif; ?>

		<div id="mastHead" class="container">
			<h1><a href="/?arg=<?php echo $_SESSION['currentArg'];?>">AGITATE</a></h1>
			<div>
				<a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a>
				<a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a>
				<a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a>
				<?php if ($isAdmin): ?>
				<a href="/admin_tools.php?arg=<?php echo $_SESSION['currentArg']; ?>">Admin</a>
				<?php endif; ?>
				<a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a>
				<a href="#" class="closenav" onclick="closeNav()">&times;</a>
			</div>
			
			<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
		</div>

		<div id="because" class="accordion container">
			<h2>Because</h2>
<?php
$canWeightBecause = isset($opinion) && ($opinion > 0);
?>
	<div class="buttons">
<?php if ($canWeightBecause): ?>
		<form method="POST" accept-charset="utf-8">
			<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighBecause" data-container-id="because">Endorse</button>
			<input type="hidden" name="becauseWeighInWith" id="becauseWeighInWith" value="" />
			<?php addCSRFtoken() ?>
		</form>
		<button class="button reset hidden" data-container-id="because">&#x21BA;</button>
		<button class="button myWeights hidden" data-container-id="because" title="Load my previous weights">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18" height="18" aria-hidden="true">
				<circle cx="12" cy="8" r="4"/>
				<path d="M4 20c0-3.866 3.582-7 8-7s8 3.134 8 7" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round"/>
			</svg>
		</button>
		<span class="section-lock unlocked" title="Because is unlocked — click a circle to start weighting">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
				<rect x="3" y="11" width="18" height="12" rx="2.5" fill="white"/>
				<path d="M7 12V8a5 5 0 0 1 10 0V3" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"/>
			</svg>
		</span>
<?php else: ?>
		<span class="section-lock locked" title="Accept the argument to weight this section">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
				<rect x="3" y="11" width="18" height="12" rx="2.5" fill="white"/>
				<path d="M7 12V8a5 5 0 0 1 10 0v4" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"/>
			</svg>
		</span>
<?php endif; ?>
	</div>
			<div class="panel" data-container-id="because">
<?php
if (isset($because)) {
	generateTypeLines("because", $because);
}
else {
	echo "No Results - Accept the argument to be the first to endorse";
}
?>
<?php if ((isset($opinion)) && ($opinion > 0)): ?>
				<div class="bulk-add-bar">
					<a href="/flesh_out.php?arg=<?php echo $arg; ?>&type=Because" class="button bulk-add-btn">+ More to Say</a>
				</div>
<?php endif; ?>
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
					<button class="altPhraseBtn" name="buttonClicked" value="altPhrasing" title="Alternate phrasings">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor" aria-hidden="true">
							<path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a1 1 0 0 0 0-1.41l-2.34-2.34a1 1 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
						</svg>
					</button>
				</div>
				<div class="explicationBox">
<?php
if (isset($links[0][3]) && $links[0][3] !== '') {
	$expUrl    = $links[0][3];
	$expID     = $links[0][2];
	$ogTitle   = $links[0][8] ?? null;
	$ogImage   = $links[0][9] ?? null;
	$ogDesc    = $links[0][10] ?? null;
	$host = @parse_url($expUrl, PHP_URL_HOST) ?: $expUrl;
	if ($ogTitle || $ogImage || $ogDesc) {
?>
				<a href="<?php echo htmlspecialchars($expUrl); ?>" target="_blank" class="link-preview">
<?php if ($ogImage) { ?>				<img src="<?php echo htmlspecialchars($ogImage); ?>" class="link-preview-img" alt="" loading="lazy">
<?php } ?>				<div class="link-preview-text">
					<span class="link-preview-title"><?php echo htmlspecialchars($ogTitle ?: $host); ?></span>
<?php if ($ogDesc) { ?>				<span class="link-preview-desc"><?php echo htmlspecialchars($ogDesc); ?></span>
<?php } ?>				<span class="link-preview-domain"><?php echo htmlspecialchars($host); ?></span>
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
$canWeightRebuttal = isset($opinion) && ($opinion < 0);
?>
	<div class="buttons">
<?php if ($canWeightRebuttal): ?>
		<form method="POST" accept-charset="utf-8">
			<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighRebuttal" data-container-id="rebuttal">Endorse</button>
			<input type="hidden" name="rebuttalWeighInWith" id="rebuttalWeighInWith" value="" />
			<?php addCSRFtoken() ?>
		</form>
		<button class="button reset hidden" data-container-id="rebuttal">&#x21BA;</button>
		<button class="button myWeights hidden" data-container-id="rebuttal" title="Load my previous weights">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18" height="18" aria-hidden="true">
				<circle cx="12" cy="8" r="4"/>
				<path d="M4 20c0-3.866 3.582-7 8-7s8 3.134 8 7" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round"/>
			</svg>
		</button>
		<span class="section-lock unlocked" title="Rebuttal is unlocked — click a circle to start weighting">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
				<rect x="3" y="11" width="18" height="12" rx="2.5" fill="white"/>
				<path d="M7 12V8a5 5 0 0 1 10 0V3" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"/>
			</svg>
		</span>
<?php else: ?>
		<span class="section-lock locked" title="Reject the argument to weight this section">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
				<rect x="3" y="11" width="18" height="12" rx="2.5" fill="white"/>
				<path d="M7 12V8a5 5 0 0 1 10 0v4" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"/>
			</svg>
		</span>
<?php endif; ?>
	</div>
			<div class="panel" data-container-id="rebuttal">
<?php
if (isset($rebuttal)) {
	generateTypeLines("rebuttal", $rebuttal);
}
else {
	echo "No Results - Reject the argument to be the first to endorse";
}
?>
<?php if ((isset($opinion)) && ($opinion < 0)): ?>
				<div class="bulk-add-bar">
					<a href="/flesh_out.php?arg=<?php echo $arg; ?>&type=Rebuttal" class="button bulk-add-btn">+ More to Say</a>
				</div>
<?php endif; ?>
			</div>
		</div>

		<div id="therefore" class="accordion container">
			<h2>Therefore</h2>
<?php
$canWeightTherefore = isset($opinion) && ($opinion > 0);
?>
	<div class="buttons">
<?php if ($canWeightTherefore): ?>
		<form method="POST" accept-charset="utf-8">
			<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighTherefore" data-container-id="therefore">Endorse</button>
			<input type="hidden" name="thereforeWeighInWith" id="thereforeWeighInWith" value="" />
			<?php addCSRFtoken() ?>
		</form>
		<button class="button reset hidden" data-container-id="therefore">&#x21BA;</button>
		<button class="button myWeights hidden" data-container-id="therefore" title="Load my previous weights">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18" height="18" aria-hidden="true">
				<circle cx="12" cy="8" r="4"/>
				<path d="M4 20c0-3.866 3.582-7 8-7s8 3.134 8 7" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round"/>
			</svg>
		</button>
		<span class="section-lock unlocked" title="Therefore is unlocked — click a circle to start weighting">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
				<rect x="3" y="11" width="18" height="12" rx="2.5" fill="white"/>
				<path d="M7 12V8a5 5 0 0 1 10 0V3" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"/>
			</svg>
		</span>
<?php else: ?>
		<span class="section-lock locked" title="Accept the argument to weight this section">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
				<rect x="3" y="11" width="18" height="12" rx="2.5" fill="white"/>
				<path d="M7 12V8a5 5 0 0 1 10 0v4" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"/>
			</svg>
		</span>
<?php endif; ?>
	</div>
			<div class="panel" data-container-id="therefore">
<?php
	if (isset($therefore)) {
		generateTypeLines("therefore", $therefore);
	}
	else {
		echo "No Results - Accept the argument to be the first to endorse";
	}
?>
<?php if ((isset($opinion)) && ($opinion > 0)): ?>
				<div class="bulk-add-bar">
					<a href="/flesh_out.php?arg=<?php echo $arg; ?>&type=Therefore" class="button bulk-add-btn">+ More to Say</a>
				</div>
<?php endif; ?>
			</div>
		</div>

		<div id="find" class="accordion container">
			<h2>Find</h2>
			<div class="panel" data-container-id="filter">
				<div class="find">
					<div class="find-section">
						<div class="find-toggle">Last Visited</div>
						<div class="find-content">
<?php
if (isset($_SESSION['history'])) {
	$arr = array_reverse($_SESSION['history']);
	generateFindLines($arr);
}
?>
						</div>
					</div>
					<div class="find-section">
						<div class="find-toggle">Recent Assertions</div>
						<div class="find-content">
<?php
if (isset($recent)) {
	generateFindLines($recent);
}
?>
						</div>
					</div>
					<div class="find-section">
						<div class="find-toggle">Go to ID</div>
						<div class="find-content">
							<ul><li class="lineItem">
								<form class="form-inline" id="form" method="get">
									<input type="text" id="jumpToID" name="arg" placeholder="Argument ID" onchange="document.getElementById('form').action = '<?php echo $baseURL; ?>?arg=' + this.value;">
									<button type="submit" class="button instead" value="jumpTo">Go</button>
								</form>
							</li></ul>
						</div>
					</div>
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
            <form method="POST" accept-charset="utf-8">
                <button type="submit" class="button endorse hidden" name="buttonClicked" value="weighPhrasing" data-container-id="phrasing">Endorse</button>
                <input type="hidden" name="phrasingWeighInWith" id="phrasingWeighInWith" value="" />
                <?php addCSRFtoken() ?>
            </form>
            <button class="button reset hidden" data-container-id="phrasing">&#x21BA;</button>
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
            <div class="assert">
                <form class="form-inline" method="POST" accept-charset="utf-8">
                    <input type="text" id="newPutForthInput" placeholder="Better said..." name="newPutForth" maxlength="300">
                    <button type="submit" class="button addNew" name="buttonClicked" value="newPutForth">Introduce</button>
                    <?php addCSRFtoken() ?>
                </form>
                <span id="phrasingError" class="validation-error hidden" role="alert"></span>
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
					<form method="POST" accept-charset="utf-8">
						<button type="submit" class="button endorse hidden" name="buttonClicked" value="weighExplication" data-container-id="explication">Endorse</button>
						<input type="hidden" name="explicWeighInWith" id="explicWeighInWith" value="" />
						<?php addCSRFtoken() ?>
					</form>
					<button class="button reset hidden" data-container-id="explication">&#x21BA;</button>
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
						<div class="assert">
							<form class="form-inline" method="POST" accept-charset="utf-8">
								<input type="text" id="promoteExplicationInput" placeholder="https://... a study, article, chart, or anything that expands upon the argument" name="promoteExplication">
								<button type="submit" class="button addNew" name="buttonClicked" value="promoteExplication">Introduce</button>
								<?php addCSRFtoken() ?>
							</form>
							<span id="explicError" class="validation-error hidden" role="alert"></span>
						</div>
<?php
}
?>
					</div>
				</div>
			</div>


	</body>
</html>