<?php 
session_start();
switch ($_POST["buttonClicked"]) {
	case "jumpTo":
		header('Location: /index.php?arg='.$_POST["jumpTo"]);	
		break;
}
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
$_SESSION['currentArg'] = intval($_GET["arg"]); 
$baseURL = "/index.php";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
$sql = "CALL getMostEndorsed();";
$sql .= "CALL getAllTheRest()";
mysqli_multi_query($db, $sql);
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Vestigette - Explore</title>
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
				assoc = <?php echo isset($assocWeights) ? "JSON.parse(" + $assocWeights + ")" : 'undefined'; ?>, //not used
				because = <?php echo json_encode($because); ?>,
				therefore = <?php echo json_encode($therefore); ?>,
				rebuttal = <?php echo json_encode($rebuttal); ?>;
		</script>
	</head>
	<body>

		<div id="mastHead" class="container">
			<h1><a href="index.php?arg=<?php echo $_SESSION['currentArg'];?>">Vestigette</a></h1>
			<div><a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a></div>
			<div style="border-bottom: .2rem solid var(--cddbWhite);">Explore</div>
			<div><a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a></div>
			<div><a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a></div> 
		</div>

		<div id="because" class="accordion container">
			<h2>Most Endorsed</h2>

			<div class="panel" data-container-id="because">
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
			<h2>Recent Assertions</h2>
			<div class="panel" data-container-id="because">
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
			<h2>Common Entry Points</h2>
			<div class="panel" data-container-id="because">
				<ul>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=422">Free Speech</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=123">Global Warming</a></p>
					</li>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=110">Class Struggle</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=238">Racism</a></p>
					</li>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=403">Role of Government</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=376">Media</a></p>
					</li>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=128">Abortion</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=423">Misogyny</a></p>
					</li>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=80">Donald Trump</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=90">The GOP</a></p>
					</li>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=104">The Democratic Party</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=413">COVID-19 School Reopening</a></p>
					</li>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=424">Vaccines</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=161">Existence of God</a></p>
					</li>
					<li class='lineItem'>
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=328">Gun Control</a></p>
					</li>
					<li class='lineItem' style="background-color: var(--cddbLiteGrey)">
						<p class="assocArg"><a href="http://www.vestigette.org/?arg=278">LGBTQ Acceptance</a></p>
					</li>
		        </ul>
			</div>
		</div>
		<div id="argument" class="accordion container">
			<h2>Go to Argument ID</h2>
			<div class="panel expanded" data-container-id="argument">
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