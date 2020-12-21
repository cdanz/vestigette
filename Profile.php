<?php 
session_start();
$_SESSION['currentArg'] = intval($_GET["arg"]); 
$baseURL = "/index.php";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Vestigette - Profile</title>
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
			<h1>Vestigette</h1>
			<div><a href="index.php?arg=<?php echo $_SESSION['currentArg'];?>">Return to Previous</a></div>
			<div><a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a></div>
			<div><a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a></div>
			<div><a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a></div> 
		</div>

		<div id="because" class="accordion container">
			<h2>This isn't a profile you're expecting</h2>

			<div class="panel" data-container-id="because">
				<br>
				<p>Vestigette is anonymous. There are not profile pictures or details about your life here. The only thing Vestigette cares about is that you actually exist and if you exist you deserve a voice. A voice that is exactly as loud as everyone else’s.
				<br>
				Basic information such as geographic location and age and maybe a few other things that haven’t been firmly decided should be available to filter upon but a name does not matter here.</p>
				<br>
			</div>
		</div>

		<div id="rebuttal" class="accordion container">
			<h2>So why is there a page dedicated to a non-profile profile?</h2>
			<div class="panel" data-container-id="because">
				<br>
				<p style="white-space:normal;">Your profile - this page - will be used for advanced features that haven't been released. Features enabling you to better clarify or revisit postions you have taken.
				<br>
				You may be just one anonymous voice but it matters and it should be as clear and nuanced as desired.</p>
				<br>
			</div>
		</div> 

		<div id="therefore" class="accordion container">
			<h2>Is there any reason to be here?</h2>
			<div class="panel" data-container-id="because">
				<br>
				<p>Not now, this is just a placeholder.</p>
				<br>
			</div>
		</div>
		<div id="argument" class="accordion container">
			<div class="panel expanded" data-container-id="argument">
				<br>
				<p>Vestigette was created by Craig Danz of Seattle, WA, U.S.A. Copyright 2015</p>
				<br>
			</div>
		</div>

	</body>
</html>