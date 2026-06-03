<?php
	if(session_status()!=PHP_SESSION_ACTIVE) session_start();
	//print_r($_SESSION); //Testing
	$currentArgID = intval($_GET["arg"]);
	setcookie("rememberMe", "", time() - 3600);
	session_destroy();
	header('Location: /?arg='.$currentArgID);
?>