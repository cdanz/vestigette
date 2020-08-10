<?php 
	session_start();
    //print_r($_SESSION); //Testing
	include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
	if(isset($_POST) && !empty($_POST)){
		$email = mysqli_real_escape_string($db, $_POST['email']);
		$password = hash('sha256',$_POST['password'],false);

		$stmt = $db->prepare("SELECT profileID FROM USER_PROFILE WHERE email = ? AND securityCode = ? ");	
   		$stmt->bind_param("ss", $email, $password);
		$stmt->execute();
		$result = $stmt->get_result()->fetch_all(MYSQLI_NUM);

		if ($result[1][0] == NULL && isset($result[0][0])) {
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
			$smsg = "Already logged in as ".$_SESSION['email'].". ";
			if(!isset($_SESSION['currentArg'])){
				$_SESSION['currentArg'] = intval($_GET["arg"]); 
			}
			$logoutURL = "/logout.php?arg=".$_SESSION['currentArg']; 
		}	
?>

<!DOCTYPE html>
<html>
<head>
	<title>Vestigette User Login</title>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	 
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<link rel="stylesheet" type="test/css" href="styles.css">

</head>
<body>
	<div class="container">
		<?php if(isset($smsg)) { ?><div class="alert alert-success" role="alert"><?php echo $smsg; ?> <a href=<?php echo $logoutURL ?>>Log Out</a></div>
        <?php }?>
        <?php if(isset($fmsg)) { ?><div class="alert alert-danger" role="alert"><?php echo $fmsg; ?> </div>
        <?php }?>
		<form class="form-signin" method="POST">
	    	<h2 class="form-signin-heading">Please Login</h2>
	    	<div class="input-group">
				<label for="inputEmail" class="sr-only">Email</label>
				<input type="email" name="email" class="form-control" placeholder="Email" required autofocus>
			    <label for="inputPassword" class="sr-only">Password</label>
			    <input type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>
			    <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
			    
			</div>
	    </form>
	</div>
<!-- TODO Create a request form -->
</body>
</html>