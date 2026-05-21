<?php 
session_start();
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
$_SESSION['currentArg'] = intval($_GET["arg"]); 
$baseURL = "/index.php";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
if (isset($profile)) {
	$sql = "CALL getHeterodox($profile)";
	mysqli_multi_query($db, $sql);
}
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Agitate - Profile</title>
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
			<h1><a href="index.php?arg=<?php echo $_SESSION['currentArg'];?>">Agitate</a></h1>
			<div>
				<a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a>
				<a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a>
				<a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>"><span style="text-decoration: underline;">Profile</span></a>
				<a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a>
				<a href="#" class="closenav" onclick="closeNav()">&times;</a>
			</div> 
			
			<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
		</div>

		<div id="because" class="accordion container">
			<h2>Agitate Profiles</h2>

			<div class="panel" data-container-id="because">
				<br>
				<p>Agitate is anonymous. There are not profile pictures, person details, nor people to follow. The only thing Agitate cares about is that you actually exist and if you exist you deserve a voice. But that voice is only ever as loud as everyone else’s on Agitate.
				<br>
				<br>
				The Agitate profile is mostly about refining your contribution to the collective whole. Basic information such as geographic location and age (and maybe a few other things that haven’t been firmly decided) should be available to filter upon but your name does not matter here.
				<br>
				<br>
				Only one feature is available currently: "Most Heterodox" the arguments where you go most against the grain of every other user on here. New features will focus on enabling you to better clarify or revisit postions you have taken.
				<br>
				<br>
				You may be just one anonymous voice but it matters and it should be as clear and nuanced as desired.</p>
				<br>
			</div>
		</div>

		<div id="rebuttal" class="accordion container">
			<h2>Most Heterodox</h2>
			<div class="panel" data-container-id="because">
				<?php
					if (isset($profile)) {
						$result = mysqli_store_result($db);
						if (mysqli_num_rows($result) > 0) {
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
								$aOrR = ($row[1]==1) ? "Accept" : "Reject";
								$doOrDont = ($row[1]==1) ? "don't" : "do";
								echo "<p class=\"assocArg\">You ".$aOrR.": <a href=".$baseURL."?arg=".$row[0].">".htmlspecialchars($row[6])."</a> ".($row[4]*100)."% ".$doOrDont."</p>
								</li>";
							}
							echo "</ul>\n";
							unset($row);
							while (mysqli_more_results($db)) {
								mysqli_next_result($db);
							}
						}
					}
					else {
							echo "No results - Log in to see results. If you ARE logged in... well go be controversial already! For the sake of seeding the database.";
						}
				?>
			</div>
		</div> 

		<div id="therefore" class="accordion container">
			<h2>Profile Actions</h2>
			<div class="panel" data-container-id="because">
				<br>
				<p>None of these have been built yet. But thanks for visiting.</p>
				<br>
			</div>
		</div>
		<div id="argument" class="accordion container">
			<div class="panel expanded" data-container-id="argument">
				<br>
				<p>Agitate was created by Craig Danz of Seattle, WA, U.S.A. Copyright <?php echo date("Y"); ?></p>
				<a href="https://twitter.com/vestigette?ref_src=twsrc%5Etfw" class="twitter-follow-button" data-show-count="false">Follow @vestigette</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
				<br>
			</div>
		</div>

	</body>
</html>