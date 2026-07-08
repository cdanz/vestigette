<?php
// Stripe redirects here after a successful donation. No secret key needed —
// Stripe emails the receipt; this is just a thank-you.
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Thank you — Agitate</title>
	<style>
		* { box-sizing: border-box; }
		body { margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
			color: #161616; background: #fafafa; line-height: 1.6; }
		@import url('https://fonts.googleapis.com/css2?family=Anton&display=swap');
		.masthead { background: #0e0e0e; padding: 0.6rem 1rem; }
		.masthead a { font-family: 'Anton', Impact, 'Arial Black', Arial, sans-serif; color: #fff; text-decoration: none; font-weight: normal; font-size: 1.5rem;
			text-shadow: 0.4em 0em 0.05em #af1a17, 0em -0.4em 0.05em #2d58a8, 0em 0.4em 0.05em #10a020; }
		.masthead a .exclaim { color: #d4a017; }
		.wrap { max-width: 560px; margin: 0 auto; padding: 3rem 1.25rem; text-align: center; }
		.check { width: 64px; height: 64px; border-radius: 50%; background: #10a020; color: #fff;
			display: inline-flex; align-items: center; justify-content: center; font-size: 2rem; margin-bottom: 1rem; }
		h1 { font-size: 1.6rem; margin: 0.25rem 0 0.5rem; }
		p { margin: 0.6rem 0; color: #333; }
		.muted { color: #666; font-size: 0.9rem; }
		.btn { display: inline-block; margin-top: 1.4rem; background: #2d58a8; color: #fff; text-decoration: none;
			padding: 0.7rem 1.3rem; border-radius: 8px; font-weight: 700; }
	</style>
</head>
<body>
	<div class="masthead"><a href="/">AGITATE<span class="exclaim">!</span></a></div>
	<div class="wrap">
		<div class="check">&#10003;</div>
		<h1>Thank you.</h1>
		<p>Your support means a lot &mdash; it directly keeps Agitate running and improving.</p>
		<p class="muted">A receipt is on its way to your email from Stripe. If you set up a monthly gift, you can cancel anytime from the link in that receipt.</p>
		<a class="btn" href="/?arg=75">Back to Agitate</a>
	</div>
</body>
</html>
