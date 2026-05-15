<?php
session_start();
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Vestigette - About</title>
		<meta charset="utf-8"/>
		<meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic polling, self-guided polling, opposition research, best reason why, best reason not"/>
		<meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA" />
		<meta name="robots" content="follow" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="style_vestigette.css" />
		<script language="javascript" src="script_vestigette.js"></script>
	</head>
	<body>
		<h1>Utilities</h1>

		<br>

		<h3>Add new user</h3>
			<form method="POST">
				<input type="text" placeholder="First Name" name="fName">
				<input type="text" placeholder="Last Name" name="lName">
				<input type="text" placeholder="Email Address" name="email">
				<input type="text" placeholder="Password" name="password">
				<input type="text" placeholder="City" name="city">
				<input type="text" placeholder="State Abbrv." name="state">
				<input type="text" placeholder="Country" name="country">
				<input type="text" placeholder="Postal Code" name="postcode">
				<button type="submit" name="buttonClicked">Add new</button>
				<div class="form-group">
					<input type="checkbox" name="badseed" checked>
					<label for="badseed">Give Badseed</label>
				</div>
			</form>

		<br><br><br>

		<h3>Merge Arguments</h3>
			<form method="POST">
				<input type="text" placeholder="This Argument ID" name="source">
				<input type="text" placeholder="Into this Argument ID" name="target">
				<button type="submit" name="buttonClicked">Merge</button>
			</form>

		<br><br><br>
	</body>
</html>