<?php
	if(session_status()!=PHP_SESSION_ACTIVE) session_start();
	//print_r($_SESSION); //Testing
	$currentArgID = intval($_GET["arg"]);
	session_destroy();
	header('Location: /index.php?arg='.$currentArgID);
?>