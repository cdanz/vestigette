<?php 
session_start();
switch ($_POST["buttonClicked"]) {
	case "jumpTo":
		header('Location: /?arg='.$_POST["jumpTo"]);	
		break;
}
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
$_SESSION['currentArg'] = intval($_GET["arg"]); 
$baseURL = "/";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
$sql = "CALL getMostEndorsed();";
$sql .= "CALL getAllTheRest()";
mysqli_multi_query($db, $sql);
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Agitate - Explore</title>
		<meta charset="utf-8"/>
		<meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic polling, self-guided polling, opposition research, best reason why, best reason not"/>
		<meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA" />
		<meta name="robots" content="follow" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>" />
		<script language="javascript" src="script_vestigette.js"></script>
		<script language="javascript">
			let arg = <?php echo isset($arg) ? $arg : 'undefined'; ?>,
				profile = <?php echo isset($profile) ? $profile : 'undefined'; ?>,
				opinion = <?php echo isset($opinion) ? $opinion : 'undefined'; ?>,
				assoc = <?php echo isset($assocWeights) ? "JSON.parse(" + $assocWeights + ")" : 'undefined'; ?>, //not used
				because = <?php echo json_encode(isset($because) ? $because : null); ?>,
				therefore = <?php echo json_encode(isset($therefore) ? $therefore : null); ?>,
				rebuttal = <?php echo json_encode(isset($rebuttal) ? $rebuttal : null); ?>;
		</script>
	</head>
	<body>

		<div id="mastHead" class="container">
			<h1><a href="/?arg=<?php echo $_SESSION['currentArg'];?>">AGITATE</a></h1>
			<div>
				<a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a>
				<a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>"><span style="text-decoration: underline;">Explore</span></a></span>
				<a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a>
				<a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a>
				<a href="#" class="closenav" onclick="closeNav()">&times;</a>
			</div> 
			
			<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
		</div>

		<div id="because" class="accordion container">
			<h2>Common Entry Points</h2>
			<div class="panel" data-container-id="because">
				<?php
				$entryPoints = [
					['Abortion',                  '/?arg=124'],
					['Black Lives Matter',         '/?arg=546'],
					['Cancel Culture',             '/?arg=288'],
					['Capitalism as a System',     '/?arg=136'],
					['Catholic Church Abuse',      '/?arg=983'],
					['Christianity &amp; Faith',   '/?arg=1385'],
					['Climate Change',             '/?arg=123'],
					['Conspiracy Theories',        '/?arg=1714'],
					['COVID Mandates',             '/?arg=1396'],
					['Cryptocurrency',             '/?arg=808'],
					['Environmental Policy',       '/?arg=757'],
					['Gender &amp; Trans Rights',  '/?arg=791'],
					['GMO Crops',                  '/?arg=5'],
					['Government &amp; Free Markets', '/?arg=400'],
					['Gun Rights',                 '/?arg=140'],
					['Housing &amp; Homelessness', '/?arg=682'],
					['Immigration Policy',         '/?arg=612'],
					['Informal Debates',           '/?arg=58'],
					['Israel &amp; Palestine',     '/?arg=1627'],
					['Labor &amp; Unions',         '/?arg=494'],
					['Media &amp; Social Media',   '/?arg=367'],
					['Policing in America',        '/?arg=561'],
					['Pop Culture',                '/?arg=1016'],
					['Public Health',              '/?arg=427'],
					['Race &amp; Racism',          '/?arg=1192'],
					['Republican Politics &amp; Trump', '/?arg=120'],
					['Sports &amp; Athletics',     '/?arg=883'],
					['The Supreme Court',          '/?arg=1443'],
					['Voting Rights',              '/?arg=182'],
					['War &amp; Military',         '/?arg=1479'],
					['Wealth &amp; Taxation',      '/?arg=265'],
				];
				echo "<ul>\n";
				foreach ($entryPoints as $i => $entry) {
					$bg = ($i % 2 === 1) ? ' style="background-color: var(--cddbLiteGrey)"' : '';
					echo "\t\t\t\t\t<li class='lineItem'$bg>"
					   . "<p class=\"assocArg\"><a href=\"{$entry[1]}\">{$entry[0]}</a></p>"
					   . "</li>\n";
				}
				echo "</ul>\n";
				?>
			</div>
		</div>
		<div id="argument" class="accordion container">
			<h2>Recent Assertions</h2>
			<div class="panel expanded" data-container-id="argument">
				<?php
					$result = mysqli_store_result($db);
					$lineColorIterator = 0;
					echo "<ul>\n";
					while($row = mysqli_fetch_row($result)) {
						if ($lineColorIterator % 2  == 0) {
						echo "<li class=\"lineItem\">";
						}
						else{
						echo "<li class=\"lineItem\" style=\"background-color: var(--cddbLiteGrey);\">";
						}
						$lineColorIterator++;
						echo "<p class=\"assocArg\"><a href=".$baseURL."?arg=".$row[0].">".htmlspecialchars($row[2])."</a></p>
						</li>";
					}
					echo "</ul>\n";
					unset($row);
					mysqli_free_result($result);
					mysqli_next_result($db);
					mysqli_next_result($db);
					mysqli_next_result($db);
				?>
			</div>
		</div>
		<div id="rebuttal" class="accordion container">
			<h2>Most Endorsed</h2>
			<div class="panel" data-container-id="rebuttal">
				<?php
					$result = mysqli_store_result($db);
					$lineColorIterator = 0;
					echo "<ul>\n";
					while($row = mysqli_fetch_row($result)) {
						if ($lineColorIterator % 2  == 0) {
						echo "<li class=\"lineItem\">";
						}
						else{
						echo "<li class=\"lineItem\" style=\"background-color: var(--cddbLiteGrey);\">";
						}
						$lineColorIterator++;
						echo "<p class=\"assocArg\"><a href=".$baseURL."?arg=".$row[0].">".htmlspecialchars($row[2])."</a></p>
						</li>";
					}
					echo "</ul>\n";
					unset($row);
					while (mysqli_more_results($db)) {
						mysqli_next_result($db);
					}
				?>
			</div>
		</div>
		<div id="therefore" class="accordion container">
			<h2>Go to Argument ID</h2>
			<div class="panel expanded" data-container-id="therefore">
				<div class="assert">
					<form class="form-inline" method="POST">
						<label for="jumpToID">Jump to: </label>
						<input type="text" id="jumpToID" placeholder="Argument ID" name="jumpTo">
						<button type="submit" class="button instead" name="buttonClicked" value="jumpTo">Go</button>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>