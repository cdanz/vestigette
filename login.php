<?php 
	session_start();
	include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

	if(isset($_POST) && !empty($_POST)){
    echo "<pre>POST received</pre>";
    
    $email = mysqli_real_escape_string($db, $_POST['email']);
    $password = hash('sha256',$_POST['password'],false);
    
    echo "<pre>Email: " . $email . "</pre>";
    echo "<pre>Password Hash: " . $password . "</pre>";
    
    $stmt = $db->prepare("SELECT profileID FROM USER_PROFILE WHERE email = ? AND securityCode = ? ");	
    $stmt->bind_param("ss", $email, $password);
    $stmt->execute();
    $result = $stmt->get_result()->fetch_all(MYSQLI_NUM);
    
    echo "<pre>Query Result: ";
    print_r($result);
    echo "</pre>";
    echo "<pre>Result count: " . count($result) . "</pre>";
    
    if (count($result) > 0 && isset($result[0][0])) {
        $_SESSION['profile'] = $result[0][0];
        $_SESSION['email']=$email;
        if(!isset($_SESSION['currentArg'])){
            $_SESSION['currentArg'] = intval($_GET["arg"]); 
        }
        header('Location: /index.php?arg='.$_SESSION['currentArg']);
    }
    else {
        $fmsg = "Invalid Email/Password";
    }
    
    $stmt->close();
}
	if(isset($_SESSION['profile'])){
			$smsg = "Already logged in as ".$_SESSION['email'].":&nbsp;";
			if(!isset($_SESSION['currentArg'])){
				$_SESSION['currentArg'] = intval($_GET["arg"]); 
			}
			$logoutURL = "/logout.php?arg=".$_SESSION['currentArg']; 
		}	
	if (!isset($_SESSION['currentArg'])) {
		$_SESSION['currentArg'] = null; 
	}
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Agitate - Login</title>
		<meta charset="utf-8"/>
		<meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic polling, self-guided polling, opposition research, best reason why, best reason not"/>
		<meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA" />
		<meta name="robots" content="follow" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="style_vestigette.css" />
		<!--<script language="javascript" src="script_vestigette.js"></script>
		<script language="javascript">
			let arg = <?php echo isset($arg) ? $arg : 'undefined'; ?>,
				profile = <?php echo isset($profile) ? $profile : 'undefined'; ?>,
				opinion = <?php echo isset($opinion) ? $opinion : 'undefined'; ?>,
				assoc = <?php echo isset($assocWeights) ? "JSON.parse(" + $assocWeights + ")" : 'undefined'; ?>, //not used
				because = <?php echo json_encode($because); ?>,
				therefore = <?php echo json_encode($therefore); ?>,
				rebuttal = <?php echo json_encode($rebuttal); ?>;
		</script>-->
	</head>
	<body>

		<div id="mastHead" class="container">
			<h1><a href="index.php?arg=<?php echo $_SESSION['currentArg'];?>">Agitate</a></h1>
			<div>
				<a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a>
				<a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a>
				<a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a>
				<a href="login.php?arg=<?php echo $_SESSION['currentArg'];?>"><span style="text-decoration: underline;">Login</span></a>
				<a href="#" class="closenav" onclick="closeNav()">&times;</a>
			</div>
			<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
		</div>

		<div id="because" class="accordion container">
			<h2>Request Access</h2>

			<div class="panel" data-container-id="because">
				<br>
				<p>To request to become a beta user, email your request to <a href="mailto:craig@vestigette.org">craig@vestigette.org</a></p>
				<br>
			</div>
		</div>
		<div id="argument" class="accordion container">
			<h2>Please Login</h2>
			<div class="panel expanded">
				<form id="login" method="POST">
					<?php if(isset($smsg)) { ?><div id="alert-success" role="alert"><?php echo $smsg; ?> <a href=<?php echo $logoutURL ?>>Log Out</a></div>
					<?php }?>
					<?php if(isset($fmsg)) { ?><div id="alert-danger" role="alert"><?php echo $fmsg; ?> </div>
					<?php }?>
					<input type="text" placeholder="Email Address" name="email">
					<input type="password" placeholder="Password" name="password">
					<button type="submit" name="buttonClicked">Login</button>
					<div class="form-group">
						<input type="checkbox" name="keepLoggedIn" checked>
  						<label for="keepLoggedIn"> Keep me logged in 30 days</label>
  					</div>
				</form>
			</div>
		</div>

		<div id="rebuttal" class="accordion container">
			<h2>Privacy Policy</h2>
			<div class="panel" data-container-id="because">
				<br>
				<p>TL;DR: Agitate's privacy goals are lofty but shortcuts will be taken during initial development. 
				<br>
				<br>
				Agitate is nonprofit and expects to remain that way. No user data will be sold nor will your user behavior be monitized in any way. It is a core part of the Agitate ethos that there is no bias built into what the systems serves you and that would be ruined the moment money got involved. 
				<br>
				<br>
				Agitate also aims to use demographic data differently. Initially just location and age will be used as conditions for filtering results. That list of two may increase but Agitate is not eager to define groups rather would prefer to use the framework for users to define it for themselves. 
				<br>
				</p>
				<br>
			</div>
		</div> 


	</body>
</html>