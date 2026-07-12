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
$demoMode           = false;

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
			"SELECT pickerType, pickerProfiles, demoMode FROM ADMIN_SETTINGS WHERE profileID=$realProfileID"));
		$pickerType = $settRow ? ($settRow['pickerType'] ?? 'none') : 'none';
		$adminPickerEnabled = ($pickerType !== 'none');

		if ($pickerType === 'manual') {
			// Manual list: the admin's own profile + the specific IDs designated.
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
					$adminPickerData[] = ['profileID' => $pid, 'label' => $byID[$pid]];
				}
			}
		} elseif ($pickerType === 'auto') {
			// Personas (IDs 1-26) with an opinion on the current argument, plus the
			// admin's own profile. Labelled by last-name initial.
			$pickerResult = mysqli_query($db,
				"SELECT u.profileID, u.lastName
				 FROM USER_PROFILE u
				 WHERE u.profileID = $realProfileID
				    OR (u.profileID BETWEEN 1 AND 26
				        AND EXISTS (SELECT 1 FROM OPINION o
				                    WHERE o.profileID = u.profileID
				                      AND o.argumentID = " . intval($arg) . "))
				 ORDER BY (u.profileID = $realProfileID) DESC, u.lastName ASC");
			while ($row = mysqli_fetch_assoc($pickerResult)) {
				$ln = (string)$row['lastName'];
				$adminPickerData[] = [
					'profileID' => intval($row['profileID']),
					'label'     => ($ln !== '' ? mb_substr($ln, 0, 1) : '#' . intval($row['profileID'])),
				];
			}
		}
	}
}
// Demo mode: check if any admin has it enabled (applies to all users)
$dmRow = mysqli_fetch_assoc(mysqli_query($db,
	"SELECT demoMode FROM ADMIN_SETTINGS WHERE demoMode = 1 LIMIT 1"));
$demoMode = $dmRow && intval($dmRow['demoMode']) === 1;
// --- End admin setup ---

// Active group name for masthead badge (uses real profile, not persona)
$activeGroupName = '';
if (isset($realProfileID)) {
	$agRow = mysqli_fetch_row(mysqli_query($db,
		"SELECT a.orgName FROM USER_PROFILE up
		 JOIN AFFILIATION a ON a.affiliationID = up.activeAffiliationID
		 WHERE up.profileID = $realProfileID
		 AND up.activeAffiliationID != " . ALL_PUBLIC_AFF_ID . " LIMIT 1"));
	if ($agRow) $activeGroupName = $agRow[0];
}

// --- Resolve active filter labels for rendering tags ---
$filterTagData = ['opinions' => [], 'affiliations' => [], 'time' => null];
if (isset($_SESSION['filters'])) {
	if (!empty($_SESSION['filters']['opinions'])) {
		foreach ($_SESSION['filters']['opinions'] as $opf) {
			$oaID = intval($opf['argumentID']);
			$pRow = mysqli_fetch_row(mysqli_query($db,
				"SELECT COALESCE(currentPhrasing, (SELECT phrasing FROM PHRASING WHERE argumentID=$oaID ORDER BY createdDate ASC LIMIT 1))
				 FROM ARGUMENT WHERE argumentID=$oaID"));
			$filterTagData['opinions'][] = [
				'argumentID' => $oaID,
				'acceptance' => intval($opf['acceptance']),
				'phrasing'   => $pRow ? mb_substr($pRow[0], 0, 40) : "Arg #$oaID",
			];
		}
	}
	if (!empty($_SESSION['filters']['affiliations'])) {
		$affIDs = array_map('intval', $_SESSION['filters']['affiliations']);
		$affList = implode(',', $affIDs);
		$affRes = mysqli_query($db,
			"SELECT affiliationID, orgName FROM AFFILIATION WHERE affiliationID IN ($affList)");
		while ($row = mysqli_fetch_assoc($affRes)) {
			$filterTagData['affiliations'][] = [
				'affiliationID' => intval($row['affiliationID']),
				'orgName'       => $row['orgName'],
			];
		}
	}
	if (!empty($_SESSION['filters']['time']['date'])) {
		$filterTagData['time'] = $_SESSION['filters']['time'];
	}
}

// --- This user's active flag on the current argument (drives the flag control) ---
$userFlag = null;
if ($profile && $arg) {
	$ufRow = mysqli_fetch_assoc(mysqli_query($db,
		"SELECT reasonCategory, comment FROM ARGUMENT_FLAG
		 WHERE argumentID=" . intval($arg) . " AND profileID=" . intval($profile) . " AND isActive=1 LIMIT 1"));
	if ($ufRow) { $userFlag = $ufRow; }
}

// --- Most-opined argument the logged-in user has NOT yet opined on (Find > Go to ID > Popular) ---
$popularArgID = null;
if ($profile) {
	$popRow = mysqli_fetch_row(mysqli_query($db,
		"SELECT o.argumentID
		 FROM OPINION o
		 WHERE o.argumentID <> " . intval($arg) . "
		   AND NOT EXISTS (SELECT 1 FROM OPINION me
		                   WHERE me.argumentID = o.argumentID AND me.profileID = " . intval($profile) . ")
		 GROUP BY o.argumentID
		 ORDER BY COUNT(*) DESC, o.argumentID ASC
		 LIMIT 1"));
	if ($popRow) { $popularArgID = intval($popRow[0]); }
}

// --- AI-persona transparency: does any persona (IDs 1-26) hold an opinion here? ---
$hasPersonaOpinion = false;
if ($arg) {
	$ppRow = mysqli_fetch_row(mysqli_query($db,
		"SELECT EXISTS(SELECT 1 FROM OPINION
		               WHERE argumentID = " . intval($arg) . " AND profileID BETWEEN 1 AND 26)"));
	$hasPersonaOpinion = $ppRow && intval($ppRow[0]) === 1;
}

// --- Hub detection for the share card (see includes/hub_metrics.php) ---
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/hub_metrics.php");
$hubShare = hubMetrics($db, intval($_SESSION['currentArg']));

mysqli_close($db);

// --- Standing pages (pages/*.md) — the persona badge links to the AI policy once published ---
require_once("${_SERVER['DOCUMENT_ROOT']}/includes/content_chrome.php");
$aiPolicyLive = content_page_is_published('ai-policy-pledge');
	

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
<?php
		// ── Social share (Open Graph / Twitter Card) values ──────────────
		$shareArgID = intval($_SESSION['currentArg']);
		$shareValid = isset($phrasing) && $phrasing !== 'Invalid Argument Identifier';
		$shareTitle = $shareValid ? $phrasing : 'Agitate — structured public debate';
		// Social proof only once enough real humans have weighed in
		// (SOCIAL_PROOF_MIN_HUMANS in dbconnect.php) — persona-inflated
		// headcounts on shared links are a credibility risk.
		if ($shareValid && isset($rate) && $rate !== 'N/A.N/A' && isset($assertions) && $assertions > 0
		    && isset($humanOpinions) && $humanOpinions >= SOCIAL_PROOF_MIN_HUMANS) {
			$shareNoun = ($assertions == 1) ? 'person accepts' : 'people accept';
			$shareDesc = "{$rate}% of {$assertions} {$shareNoun} this. Where do you stand?";
		} elseif ($shareValid) {
			$shareDesc = 'See the strongest cases for and against — and weigh in. Where do you stand?';
		} else {
			$shareDesc = 'Agitate maps what people actually believe — and why. Weigh in.';
		}
		$shareURL   = 'https://agitate-discourse.org/?arg=' . $shareArgID;
		// Version param: Bluesky/Twitter cache cards per-URL, so bust it when
		// the card's inputs move (verdict, top Because/Rebuttal, phrasing,
		// hub mode and its top Therefore positions).
		$shareVer = substr(md5(implode('|', array(
			isset($rate) ? $rate : '',
			isset($assertions) ? $assertions : '',
			isset($because[0]) ? $because[0][0] . ':' . $because[0][1] : '',
			isset($rebuttal[0]) ? $rebuttal[0][0] . ':' . $rebuttal[0][1] : '',
			$shareTitle,
			!empty($hubShare['fires'])
				? 'hub:' . $hubShare['kids'] . ':' . implode(',', array_map(
					function ($t) { return $t['argID'] . '.' . $t['ops']; }, $hubShare['top']))
				: '',
		))), 0, 10);
		$shareImage = 'https://agitate-discourse.org/og_image.php?arg=' . $shareArgID . '&v=' . $shareVer;
		$e = function ($s) { return htmlspecialchars($s, ENT_QUOTES, 'UTF-8'); };
		$titleText  = $shareValid ? mb_strimwidth($phrasing, 0, 70, '…') . ' — Agitate' : 'Agitate';
?>
		<title><?php echo $e($titleText); ?></title>
		<meta charset="utf-8"/>
		<meta name="description" content="<?php echo $e($shareDesc); ?>" />
		<meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic polling, self-guided polling, opposition research, best reason why, best reason not"/>
		<meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA" />
		<meta name="robots" content="follow" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0<?php if ($demoMode) echo ', interactive-widget=resizes-content'; ?>" />
		<link rel="canonical" href="<?php echo $e($shareURL); ?>" />

		<!-- Open Graph -->
		<meta property="og:type" content="article" />
		<meta property="og:site_name" content="Agitate" />
		<meta property="og:title" content="<?php echo $e($shareTitle); ?>" />
		<meta property="og:description" content="<?php echo $e($shareDesc); ?>" />
		<meta property="og:url" content="<?php echo $e($shareURL); ?>" />
		<meta property="og:image" content="<?php echo $e($shareImage); ?>" />
		<meta property="og:image:type" content="image/png" />
		<meta property="og:image:width" content="1200" />
		<meta property="og:image:height" content="630" />
		<meta property="og:image:alt" content="<?php echo $e($shareTitle); ?>" />

		<!-- Twitter Card -->
		<meta name="twitter:card" content="summary_large_image" />
		<meta name="twitter:title" content="<?php echo $e($shareTitle); ?>" />
		<meta name="twitter:description" content="<?php echo $e($shareDesc); ?>" />
		<meta name="twitter:image" content="<?php echo $e($shareImage); ?>" />
		<link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>" />
		<script language="javascript" src="script_vestigette.js?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/script_vestigette.js'); ?>"></script>
		<script>
			let arg = <?php echo isset($arg) ? intval($arg) : 'null'; ?>,
				profile = <?php echo isset($profile) ? intval($profile) : 'null'; ?>,
				opinion = <?php echo isset($opinion) ? intval($opinion) : 'null'; ?>,
				because = <?php echo json_encode(isset($because) ? $because : null); ?>,
				therefore = <?php echo json_encode(isset($therefore) ? $therefore : null); ?>,
				rebuttal = <?php echo json_encode(isset($rebuttal) ? $rebuttal : null); ?>,
				demoMode = <?php echo $demoMode ? 'true' : 'false'; ?>,
				csrfToken = <?php echo json_encode($csrfToken); ?>;
		</script>
	</head>
	<body<?php if ($demoMode) echo ' class="demo-mode"'; ?>>

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
			<?php echo htmlspecialchars($p['label']); ?>
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

	<div id="left-col">

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
			<div class="arg-header">
				<div class="arg-header-text">
					<div class="arg-phrasing-wrap">
						<p class="arg-phrasing"><?php echo htmlspecialchars($phrasing); ?></p>
						<a href="#" class="arg-phrasing-more hidden">(more)</a>
					</div>
					<div class="arg-meta">
						<span class="arg-id">Argument ID: <?php echo intval($arg); ?></span>
<?php if ($hasPersonaOpinion):
	// Once the AI Policy and Pledge is published the badge links to the policy itself.
	$personaBadgeSvg = '<svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
								<line x1="12" y1="2.6" x2="12" y2="5"/>
								<circle cx="12" cy="2" r="1.05" fill="currentColor" stroke="none"/>
								<rect x="4.5" y="5" width="15" height="13" rx="3"/>
								<path d="M4.5 9.5 H2.6 a1.1 1.1 0 0 0 -1.1 1.1 v1.8 a1.1 1.1 0 0 0 1.1 1.1 H4.5"/>
								<path d="M19.5 9.5 H21.4 a1.1 1.1 0 0 1 1.1 1.1 v1.8 a1.1 1.1 0 0 1 -1.1 1.1 H19.5"/>
								<circle cx="9.5" cy="10.6" r="1.25" fill="currentColor" stroke="none"/>
								<circle cx="14.5" cy="10.6" r="1.25" fill="currentColor" stroke="none"/>
								<rect x="8.4" y="13.6" width="7.2" height="2.6" rx="1.3"/>
							</svg>';
	if ($aiPolicyLive) {
		echo "\t\t\t\t\t\t<a class=\"persona-badge\" href=\"/ai-policy-pledge\" title=\"AI persona activity on this argument &mdash; read the policy\" aria-label=\"AI persona activity on this argument &mdash; read the policy\">{$personaBadgeSvg}</a>\n";
	} else {
		echo "\t\t\t\t\t\t<span class=\"persona-badge\" title=\"AI personas are active on this argument &mdash; its state is not yet fully human\" aria-label=\"AI personas active on this argument\">{$personaBadgeSvg}</span>\n";
	}
endif; ?>
<?php
$filterCount = 0;
if ($hasOpinionFilters)    $filterCount += count($activeFilters['opinions']);
if ($hasAffiliationFilters) $filterCount += count($activeFilters['affiliations']);
if ($hasTimeFilter)         $filterCount += 1;
if ($filterCount > 0):
?>
						<a href="#filter" class="filter-badge" onclick="if(typeof applyDesktopState==='function'){applyDesktopState(true);}" title="<?php echo $filterCount; ?> active filter<?php echo $filterCount !== 1 ? 's' : ''; ?> — click to adjust" aria-label="<?php echo $filterCount; ?> active filter<?php echo $filterCount !== 1 ? 's' : ''; ?>">
							<svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg><?php if ($filterCount > 1): ?><span class="filter-badge-count"><?php echo $filterCount; ?></span><?php endif; ?>
						</a>
<?php endif; ?>
					</div>
				</div>
				<div class="arg-header-side">
					<div class="arg-rate">
						<span class="arg-rate-num"><?php echo (strpos((string)$rate, 'N/A') === false) ? htmlspecialchars($rate) . '%' : '&mdash;'; ?></span>
						<span class="arg-rate-detail">of <?php echo intval($assertions) . (($assertions == 1) ? ' user' : ' users'); ?></span>
					</div>
					<div class="opinion">
<?php
$accept = 'Open';
$reject = 'Set';
$svgCheck = '<svg viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="20 6 9 17 4 12"/></svg>';
$svgX     = '<svg viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>';
if (isset($_SESSION['profile'])) {
	echo "<form method=\"POST\" class=\"buttons\" accept-charset=\"utf-8\">";
	if ($opinion == 0) {
		$reject = 'Open';
	} else if ($opinion > 0) {
		$accept = 'Set';
		$reject = 'Open';
	}
	echo "
		<button type=\"submit\" class=\"button accept accept$accept\" name=\"buttonClicked\" value=\"accept\" aria-label=\"Accept\">$svgCheck</button>
		<button type=\"submit\" class=\"button reject reject$reject\" name=\"buttonClicked\" value=\"reject\" aria-label=\"Reject\">$svgX</button>";
} else {
	// GET form data replaces the action's query string, so arg rides as a hidden input
	echo "<form method=\"GET\" class=\"buttons\" action=\"login.php\" accept-charset=\"utf-8\">
	<input type=\"hidden\" name=\"arg\" value=\"" . intval($_SESSION['currentArg']) . "\">
	<button type=\"submit\" class=\"button accept acceptOpen\" name=\"intent\" value=\"accept\" aria-label=\"Accept\">$svgCheck</button>
	<button type=\"submit\" class=\"button reject rejectOpen\" name=\"intent\" value=\"reject\" aria-label=\"Reject\">$svgX</button>";
}
addCSRFtoken();
echo "\n</form>";
?>
					</div>
				</div>
			</div>
			<div class="panel expanded" data-container-id="argument">
<?php
// ── Phrasing carousel (an argument always has ≥1 phrasing) ──────────────────
$phrasingList  = isset($altPhrasings) ? array_values($altPhrasings) : [];
$phrasingCount = count($phrasingList);
?>
				<div class="phrasingBox carousel-box">
					<div class="carousel-content">
<?php if ($phrasingCount > 1): ?>
						<div class="carousel-track">
							<div class="carousel-slides">
<?php foreach ($phrasingList as $pline): ?>
								<div class="carousel-slide"><p class="phrasing-slide"><?php echo htmlspecialchars($pline[2]); ?></p></div>
<?php endforeach; ?>
							</div>
						</div>
						<div class="carousel-footer">
							<button class="carousel-prev" aria-label="Previous phrasing">&#8592;</button>
							<span class="carousel-count" data-label="alternative phrasings">1 of <?php echo $phrasingCount; ?> alternative phrasings</span>
							<button class="carousel-next" aria-label="Next phrasing">&#8594;</button>
						</div>
<?php else: ?>
						<p class="carousel-empty">No alternative phrasing - accept the argument to provide one.</p>
<?php endif; ?>
					</div>
					<button class="altPhraseBtn" name="buttonClicked" value="altPhrasing" title="Alternate phrasings" aria-label="Alternate phrasings">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="22" height="22" fill="currentColor" aria-hidden="true"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a1 1 0 0 0 0-1.41l-2.34-2.34a1 1 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/></svg>
					</button>
				</div>
				<div class="explicationBox carousel-box">
<?php
$carouselLinks = isset($links) ? array_values(array_filter($links, function($l) { return !empty($l[3]); })) : [];
$carouselCount = count($carouselLinks);
?>
					<div class="carousel-content">
<?php if ($carouselCount > 0): ?>
						<div class="carousel-track">
							<div class="carousel-slides">
<?php foreach ($carouselLinks as $ci => $clink):
	$cUrl   = $clink[3];
	$cHost  = @parse_url($cUrl, PHP_URL_HOST) ?: $cUrl;
	$cOgT   = $clink[8] ?? null;
	$cOgI   = $clink[9] ?? null;
	$cOgD   = $clink[10] ?? null;
	$showOg = ($ci < 5) && ($cOgT || $cOgI || $cOgD);
?>
								<div class="carousel-slide">
<?php if ($showOg): ?>
									<a href="<?php echo htmlspecialchars($cUrl); ?>" target="_blank" class="link-preview">
<?php if ($cOgI): ?>										<img src="<?php echo htmlspecialchars($cOgI); ?>" class="link-preview-img" alt="" loading="lazy">
<?php endif; ?>										<div class="link-preview-text">
											<span class="link-preview-title"><?php echo htmlspecialchars($cOgT ?: $cHost); ?></span>
<?php if ($cOgD): ?>											<span class="link-preview-desc"><?php echo htmlspecialchars($cOgD); ?></span>
<?php endif; ?>											<span class="link-preview-domain"><?php echo htmlspecialchars($cHost); ?></span>
										</div>
									</a>
<?php else: ?>
									<a href="<?php echo htmlspecialchars($cUrl); ?>" target="_blank"><?php echo htmlspecialchars($cUrl); ?></a>
<?php endif; ?>
								</div>
<?php endforeach; ?>
							</div>
						</div>
<?php if ($carouselCount > 1): ?>
						<div class="carousel-footer">
							<button class="carousel-prev" aria-label="Previous link">&#8592;</button>
							<span class="carousel-count" data-label="explication links">1 of <?php echo $carouselCount; ?> explication links</span>
							<button class="carousel-next" aria-label="Next link">&#8594;</button>
						</div>
<?php endif; ?>
<?php else: ?>
						<p class="carousel-empty">No explication links yet &mdash; accept the argument to add one.</p>
<?php endif; ?>
					</div>
					<button class="altExplicationBtn" aria-label="Explication links">&#x2318;</button>
				</div>
				<div class="flag-row">
<?php if ($profile): ?>
					<button type="button" class="flagBtn<?php echo $userFlag ? ' flagged' : ''; ?>" aria-label="<?php echo $userFlag ? 'You flagged this argument — edit or remove your flag' : 'Flag this argument'; ?>" title="<?php echo $userFlag ? 'You flagged this argument' : 'Flag this argument'; ?>"><svg class="flag-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="13" height="13" aria-hidden="true"><path d="M6 2a1 1 0 0 0-1 1v18a1 1 0 0 0 2 0v-6.6l11.3.001a.6.6 0 0 0 .5-.93L16 9l2.8-4.47a.6.6 0 0 0-.5-.93H7V3a1 1 0 0 0-1-1z"/></svg></button>
					<span class="flag-label"><?php echo $userFlag ? 'Flagged' : 'Flag'; ?></span>
<?php else: ?>
					<a class="flagBtn" href="/login.php?arg=<?php echo intval($arg); ?>&intent=flag" title="Log in to flag this argument" aria-label="Log in to flag this argument"><svg class="flag-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="13" height="13" aria-hidden="true"><path d="M6 2a1 1 0 0 0-1 1v18a1 1 0 0 0 2 0v-6.6l11.3.001a.6.6 0 0 0 .5-.93L16 9l2.8-4.47a.6.6 0 0 0-.5-.93H7V3a1 1 0 0 0-1-1z"/></svg></a>
					<span class="flag-label">Flag</span>
<?php endif; ?>
				</div>
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

	</div>

	<div id="right-col">

		<div id="mastHead" class="container">
			<h1><a href="/?arg=<?php echo $_SESSION['currentArg'];?>">AGITATE<span class="exclaim">!</span></a></h1>
			<?php if ($profile && $activeGroupName !== ''): ?>
			<a href="/Profile.php?arg=<?php echo intval($arg); ?>" class="group-badge" title="<?php echo htmlspecialchars($activeGroupName); ?>"><?php echo htmlspecialchars($activeGroupName); ?></a>
			<?php endif; ?>
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
			<a href="/donate.php" class="donate-btn">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="14" height="14" aria-hidden="true"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
				Donate
			</a>
			<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
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

		<div id="find" class="accordion container">
			<h2>Find</h2>
			<div class="panel" data-container-id="filter">
				<div class="find">
					<div class="find-section">
						<div class="find-toggle collapsed" data-find-key="neighborhood">Neighborhood</div>
						<div class="find-content collapsed" id="neighborhoodContent" data-arg="<?php echo intval($arg); ?>" data-loaded="0">
							<ul><li class="lineItem"><span class="find-loading">Open to load nearby arguments&hellip;</span></li></ul>
						</div>
					</div>
					<div class="find-section">
						<div class="find-toggle collapsed" data-find-key="lastVisited">Last Visited</div>
						<div class="find-content collapsed">
<?php
if (isset($_SESSION['history'])) {
	$arr = array_reverse($_SESSION['history']);
	generateFindLines($arr);
}
?>
						</div>
					</div>
					<div class="find-section">
						<div class="find-toggle collapsed" data-find-key="recentAssertions">Recent Assertions</div>
						<div class="find-content collapsed">
<?php
if (isset($recent)) {
	generateFindLines($recent);
}
?>
						</div>
					</div>
					<div class="find-section">
						<div class="find-toggle collapsed" data-find-key="goToId">Go to ID</div>
						<div class="find-content collapsed">
							<ul><li class="lineItem find-nav">
								<form class="form-inline" id="form" method="get">
									<a class="find-nav-btn" href="<?php echo $baseURL; ?>?arg=<?php echo max(1, intval($arg) - 1); ?>" title="Previous argument (ID &minus;1)" aria-label="Previous argument">&larr;</a>
									<a class="find-nav-btn" href="<?php echo $baseURL; ?>?arg=<?php echo intval($arg) + 1; ?>" title="Next argument (ID +1)" aria-label="Next argument">&rarr;</a>
<?php if ($profile && $popularArgID): ?>
									<a class="find-nav-btn find-popular" href="<?php echo $baseURL; ?>?arg=<?php echo $popularArgID; ?>" title="Most-discussed argument you haven't weighed in on yet">Popular</a>
<?php endif; ?>
									<input type="text" id="jumpToID" name="arg" placeholder="Argument ID" onchange="document.getElementById('form').action = '<?php echo $baseURL; ?>?arg=' + this.value;">
									<button type="submit" class="button instead" value="jumpTo">Go</button>
								</form>
							</li></ul>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div id="filter" class="accordion container">
			<h2>Filter</h2>
			<div class="panel" data-container-id="filter">
				<div class="filter-inner">

					<div class="filter-section">
						<div class="filter-section-label">Filter other arguments by who accepts or rejects this one:</div>
						<div class="filter-opinion-controls">
							<form method="POST" action="/?arg=<?php echo intval($arg); ?>">
								<input type="hidden" name="buttonClicked" value="addOpinionFilter">
								<input type="hidden" name="argumentID" value="<?php echo intval($arg); ?>">
								<button type="submit" name="acceptance" value="1" class="filter-add-btn filter-accept">Acceptors</button>
								<button type="submit" name="acceptance" value="0" class="filter-add-btn filter-reject">Rejectors</button>
								<?php addCSRFtoken() ?>
							</form>
						</div>
						<a href="#" id="openFilterOverlay" class="filter-advanced-link">Advanced Filter Options</a>
					</div>

					<div class="filter-section">
						<div class="filter-section-label">
							Active Opinion Filters
<?php if (!empty($filterTagData['opinions'])): ?>
							<form method="POST" action="/?arg=<?php echo intval($arg); ?>" class="filter-clear-form">
								<input type="hidden" name="buttonClicked" value="clearAllFilters">
								<button type="submit" class="filter-clear-btn">Clear All</button>
								<?php addCSRFtoken() ?>
							</form>
<?php endif; ?>
						</div>
						<div class="filter-tags">
<?php foreach ($filterTagData['opinions'] as $otag): ?>
							<form method="POST" action="/?arg=<?php echo intval($arg); ?>" class="filter-tag-form">
								<input type="hidden" name="buttonClicked" value="removeOpinionFilter">
								<input type="hidden" name="argumentID" value="<?php echo $otag['argumentID']; ?>">
								<span class="filter-tag <?php echo $otag['acceptance'] ? 'filter-tag-accept' : 'filter-tag-reject'; ?>">
									<?php echo $otag['acceptance'] ? 'Accepts' : 'Rejects'; ?>: <?php echo htmlspecialchars($otag['phrasing']); ?>
									<button type="submit" class="filter-tag-x">&times;</button>
								</span>
								<?php addCSRFtoken() ?>
							</form>
<?php endforeach; ?>
<?php if (empty($filterTagData['opinions'])): ?>
							<span class="filter-none">None</span>
<?php endif; ?>
						</div>
					</div>

					<div class="filter-section">
						<div class="filter-section-label">Active Group Filters</div>
						<div class="filter-tags">
<?php foreach ($filterTagData['affiliations'] as $atag): ?>
							<form method="POST" action="/?arg=<?php echo intval($arg); ?>" class="filter-tag-form">
								<input type="hidden" name="buttonClicked" value="removeAffiliationFilter">
								<input type="hidden" name="affiliationID" value="<?php echo $atag['affiliationID']; ?>">
								<span class="filter-tag filter-tag-group">
									<?php echo htmlspecialchars($atag['orgName']); ?>
									<button type="submit" class="filter-tag-x">&times;</button>
								</span>
								<?php addCSRFtoken() ?>
							</form>
<?php endforeach; ?>
<?php if (empty($filterTagData['affiliations'])): ?>
							<span class="filter-none">None</span>
<?php endif; ?>
						</div>
					</div>

					<div class="filter-section">
						<div class="filter-section-label">Active Time Filter</div>
						<div class="filter-tags">
<?php if (!empty($filterTagData['time'])): ?>
<?php
	$tDir = ucfirst($filterTagData['time']['direction']);
	$tDateFmt = date('M j, Y', strtotime($filterTagData['time']['date']));
?>
							<form method="POST" action="/?arg=<?php echo intval($arg); ?>" class="filter-tag-form">
								<input type="hidden" name="buttonClicked" value="clearTimeFilter">
								<span class="filter-tag filter-tag-time">
									<?php echo htmlspecialchars("$tDir $tDateFmt"); ?>
									<button type="submit" class="filter-tag-x">&times;</button>
								</span>
								<?php addCSRFtoken() ?>
							</form>
<?php else: ?>
							<span class="filter-none">None</span>
<?php endif; ?>
						</div>
					</div>

				</div>
			</div>
		</div>

	</div>

<!-- Phrasing Modal -->
<div id="overlayP" class="hidden">
    <div id="phrasing" class="container hidden">
        <div class="overlay-header">
            <h2>Put Another Way</h2>
<?php
if ((isset($opinion)) && ($opinion > 0)) {
?>
            <div class="overlay-actions">
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
            <button id="closeP" class="button">X</button>
        </div>
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
					<div class="overlay-header">
						<h2>Explication Links</h2>
<?php
if ((isset($opinion)) && ($opinion > 0)) {
?>
					<div class="overlay-actions">
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
					<button id="closeE" class="button">X</button>
					</div>
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


<?php if ($profile):
	$ufCat     = $userFlag ? $userFlag['reasonCategory'] : '';
	$ufComment = $userFlag ? (string)$userFlag['comment'] : '';
	$flagCats  = [
		'offensive'         => 'Offensive or inappropriate',
		'phrasing_mismatch' => "Top phrasing doesn't make the same assertion",
		'duplicate_assoc'   => 'Duplicated association(s)',
		'spam'              => 'Spam or off-topic',
		'incoherent'        => 'Incomprehensible or nonsensical',
		'other'             => 'Other',
	];
?>
<!-- Flag Modal -->
<div id="overlayF" class="hidden">
	<div id="flagModal" class="container hidden">
		<h2><?php echo $userFlag ? 'Your flag' : 'Flag this argument'; ?></h2>
		<div class="buttons">
			<button id="closeF" class="button">X</button>
		</div>
		<div class="panel expanded">
			<p class="flag-intro"><?php echo $userFlag ? 'You flagged this argument. Update your reason or remove your flag.' : 'Tell the moderators what’s wrong with this argument.'; ?></p>
			<form method="POST" accept-charset="utf-8" id="flagForm">
				<fieldset class="flag-reasons">
<?php foreach ($flagCats as $val => $label): ?>
					<label class="flag-reason"><input type="radio" name="flagCategory" value="<?php echo $val; ?>"<?php echo ($ufCat === $val) ? ' checked' : ''; ?>> <span><?php echo htmlspecialchars($label); ?></span></label>
<?php endforeach; ?>
				</fieldset>
				<textarea name="flagComment" id="flagComment" maxlength="300" placeholder="Add a comment (required if you pick &ldquo;Other&rdquo;)"><?php echo htmlspecialchars($ufComment); ?></textarea>
				<span id="flagError" class="validation-error hidden" role="alert">Please add a comment explaining the issue.</span>
				<div class="flag-actions">
					<button type="submit" class="flag-submit-btn" name="buttonClicked" value="flagArgument"><?php echo $userFlag ? 'Update flag' : 'Submit flag'; ?></button>
<?php if ($userFlag): ?>
					<button type="submit" class="flag-remove-btn" name="buttonClicked" value="unflagArgument" formnovalidate>Remove flag</button>
<?php endif; ?>
				</div>
				<?php addCSRFtoken() ?>
			</form>
		</div>
	</div>
</div>
<?php endif; ?>

<div id="overlayFilter" class="hidden">
	<div id="filterModal" class="container">
		<h2>Filter Options</h2>
		<button id="closeFilter" class="button">X</button>
		<div class="panel expanded" data-container-id="filterModal">
			<div class="filter-modal-section">
				<div class="filter-modal-label">Time Filter</div>
				<form method="POST" action="/?arg=<?php echo intval($arg); ?>" class="filter-time-form">
					<input type="hidden" name="buttonClicked" value="setTimeFilter">
					<div class="filter-time-row">
						<select name="timeDirection" class="filter-time-select">
							<option value="before"<?php echo (!empty($filterTagData['time']) && $filterTagData['time']['direction'] === 'before') ? ' selected' : ''; ?>>Before</option>
							<option value="after"<?php echo (!empty($filterTagData['time']) && $filterTagData['time']['direction'] === 'after') ? ' selected' : ''; ?>>After</option>
						</select>
						<input type="date" name="timeDate" class="filter-time-date" placeholder="Date" value="<?php echo htmlspecialchars($filterTagData['time']['date'] ?? ''); ?>" required>
						<button type="submit" class="filter-add-btn">Apply</button>
					</div>
					<?php addCSRFtoken() ?>
				</form>
			</div>
			<div class="filter-modal-section">
				<label for="affiliationSearch" class="filter-modal-label">Search Public Groups</label>
				<input type="text" class="filter-search" id="affiliationSearch" placeholder="Search Public Groups" autocomplete="off">
				<ul id="affiliationResults" class="filter-results"></ul>
			</div>
		</div>
	</div>
</div>
	</body>
</html>