<?php
session_start();

// Stripe mode (drives the sandbox notice). Missing config = donations not yet wired.
$stripeMode = null;
$stripeReady = false;
$stripeCfgPath = "${_SERVER['DOCUMENT_ROOT']}/includes/stripe.local.php";
if (file_exists($stripeCfgPath)) {
	$cfg = require $stripeCfgPath;
	$stripeReady = !empty($cfg['secret_key']) && strpos($cfg['secret_key'], 'REPLACE') === false;
	$stripeMode  = $cfg['mode'] ?? 'test';
}

$canceled = isset($_GET['canceled']);
$error    = isset($_GET['error']);
$flashErr = $_SESSION['donateError'] ?? null;
unset($_SESSION['donateError']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Support Agitate</title>
	<style>
		:root {
			--red: #af1a17; --green: #10a020; --blue: #2d58a8;
			--ink: #161616; --muted: #555; --line: #e2e2e2; --bg: #fafafa;
		}
		* { box-sizing: border-box; }
		body { margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
			color: var(--ink); background: var(--bg); line-height: 1.55; }
		a { color: var(--blue); }
		.masthead { background: #0e0e0e; padding: 0.6rem 1rem; }
		.masthead a { color: #fff; text-decoration: none; font-weight: 800; letter-spacing: 0.06em; font-size: 1.1rem; }
		.wrap { max-width: 640px; margin: 0 auto; padding: 1.5rem 1.25rem 3rem; }
		h1 { font-size: 1.7rem; margin: 1rem 0 0.5rem; }
		h2 { font-size: 1.05rem; margin: 1.75rem 0 0.4rem; }
		p { margin: 0.6rem 0; }
		.lede { font-size: 1.05rem; color: #222; }
		.status { background: #fff; border: 1px solid var(--line); border-left: 4px solid var(--red);
			border-radius: 6px; padding: 0.85rem 1rem; margin: 1.25rem 0; font-size: 0.95rem; }
		.status strong { color: var(--red); }
		.notice { border-radius: 6px; padding: 0.6rem 0.85rem; margin: 1rem 0; font-size: 0.9rem; }
		.notice.sandbox { background: #fff7e6; border: 1px solid #e0b020; color: #6a4e00; }
		.notice.warn { background: #fff0f0; border: 1px solid #e3a0a0; color: #8a1f1f; }
		.notice.info { background: #eef3ff; border: 1px solid #b9c7ee; color: #2a3f78; }
		ul { margin: 0.5rem 0 0.6rem; padding-left: 1.2rem; }
		li { margin: 0.25rem 0; }
		.card { background: #fff; border: 1px solid var(--line); border-radius: 8px; padding: 1.1rem 1.15rem; margin-top: 1rem; }
		fieldset { border: none; margin: 0 0 1rem; padding: 0; }
		legend { font-weight: 700; font-size: 0.95rem; margin-bottom: 0.5rem; padding: 0; }
		.seg { display: inline-flex; border: 1px solid var(--line); border-radius: 8px; overflow: hidden; }
		.seg label { padding: 0.5rem 1.1rem; cursor: pointer; font-size: 0.95rem; background: #fff; }
		.seg label.sel { background: var(--blue); color: #fff; }
		.seg input { position: absolute; opacity: 0; pointer-events: none; }
		.amounts { display: flex; flex-wrap: wrap; gap: 0.5rem; }
		.amounts label { border: 1px solid var(--line); border-radius: 8px; padding: 0.55rem 0.9rem;
			cursor: pointer; background: #fff; font-size: 1rem; min-width: 4rem; text-align: center; }
		.amounts label.sel { border-color: var(--blue); background: #eef3ff; color: var(--blue); font-weight: 700; }
		.amounts input[type="radio"] { position: absolute; opacity: 0; pointer-events: none; }
		.custom-row { margin-top: 0.7rem; display: flex; align-items: center; gap: 0.4rem; }
		.custom-row .dollar { color: var(--muted); font-size: 1.1rem; }
		#customAmount { width: 8rem; font-size: 1rem; padding: 0.5rem 0.6rem; border: 1px solid #bbb; border-radius: 6px; }
		.give-btn { margin-top: 1.2rem; width: 100%; background: var(--green); color: #fff; border: none;
			border-radius: 8px; padding: 0.8rem 1rem; font-size: 1.05rem; font-weight: 700; cursor: pointer; }
		.give-btn:hover { background: #0c8a1b; }
		.give-btn:disabled { background: #9bbf9f; cursor: not-allowed; }
		.fineprint { color: var(--muted); font-size: 0.82rem; margin-top: 0.8rem; }
		.foot { color: var(--muted); font-size: 0.82rem; margin-top: 2rem; border-top: 1px solid var(--line); padding-top: 1rem; }
	</style>
</head>
<body>
	<div class="masthead"><a href="/">AGITATE</a></div>
	<div class="wrap">
		<h1>Support Agitate</h1>
		<p class="lede">Agitate is a tool for mapping where people stand on contested questions &mdash; and <em>why</em>: the reasons behind a claim, what follows from it, and what rebuts it. It's built and run independently, and your support keeps it going and growing.</p>

		<div class="status">
			<strong>Where things stand (please read):</strong>
			Agitate is an independent project I intend to operate as a nonprofit. It is <strong>not yet incorporated as a nonprofit</strong> and does <strong>not have 501(c)(3) tax-exempt status</strong>, so <strong>donations are not tax-deductible</strong>. I'm working toward formal nonprofit status and the required registrations, and I'll update this page as that progresses.
		</div>

<?php if ($canceled): ?>
		<div class="notice info">No problem &mdash; your donation was canceled and you weren't charged.</div>
<?php endif; ?>
<?php if ($error || $flashErr): ?>
		<div class="notice warn"><?php echo htmlspecialchars($flashErr ?: 'Something went wrong starting the donation. Please try again.'); ?></div>
<?php endif; ?>

		<h2>How your donation is used</h2>
		<ul>
			<li>Hosting and infrastructure that keep the site running.</li>
			<li>Ongoing development &mdash; new features, fixes, and improvements.</li>
			<li>Data and AI costs for the dialectic-scaffolding system that seeds sparse discussions.</li>
			<li>The cost of doing this right &mdash; incorporating as a nonprofit and completing the registrations needed to operate transparently.</li>
		</ul>

		<h2>Make a donation</h2>
<?php if ($stripeMode === 'test'): ?>
		<div class="notice sandbox"><strong>Sandbox/test mode.</strong> This is wired to Stripe's test environment &mdash; no real charges. Use a test card like <code>4242&nbsp;4242&nbsp;4242&nbsp;4242</code>, any future expiry, any CVC.</div>
<?php endif; ?>
<?php if (!$stripeReady): ?>
		<div class="notice warn">Donations aren't switched on just yet &mdash; check back soon.</div>
<?php else: ?>
		<form class="card" method="POST" action="/create_donation_session.php" id="donateForm">
			<fieldset>
				<legend>Frequency</legend>
				<div class="seg" id="freqSeg">
					<label class="sel"><input type="radio" name="frequency" value="once" checked> One-time</label>
					<label><input type="radio" name="frequency" value="monthly"> Monthly</label>
				</div>
			</fieldset>

			<fieldset>
				<legend>Amount (USD)</legend>
				<div class="amounts" id="amounts">
					<label><input type="radio" name="amount" value="10"> $10</label>
					<label class="sel"><input type="radio" name="amount" value="25" checked> $25</label>
					<label><input type="radio" name="amount" value="50"> $50</label>
					<label><input type="radio" name="amount" value="100"> $100</label>
					<label><input type="radio" name="amount" value="custom"> Custom</label>
				</div>
				<div class="custom-row">
					<span class="dollar">$</span>
					<input type="number" id="customAmount" name="customAmount" min="1" max="50000" step="1" placeholder="Other amount">
				</div>
			</fieldset>

			<button type="submit" class="give-btn" id="giveBtn">Donate <span id="giveAmt">$25</span></button>
			<p class="fineprint">Payments are processed securely by <strong>Stripe</strong> on their hosted checkout page &mdash; your card details never touch our servers. You'll get a receipt by email. Monthly donations can be canceled anytime.</p>
		</form>
<?php endif; ?>

		<div class="foot">
			Questions about Agitate or this page? <a href="/?arg=75">Start here</a>.
			Thank you for considering it &mdash; it genuinely helps.
		</div>
	</div>

	<script>
		(function () {
			var freqSeg = document.getElementById('freqSeg');
			var amounts = document.getElementById('amounts');
			var custom  = document.getElementById('customAmount');
			var giveAmt = document.getElementById('giveAmt');
			if (!amounts) return;

			function fmt(n) { return '$' + (Math.round(n * 100) / 100).toLocaleString(); }
			function selectedPreset() {
				var r = amounts.querySelector('input[name="amount"]:checked');
				return r ? r.value : '25';
			}
			function refresh() {
				// segmented highlight
				freqSeg.querySelectorAll('label').forEach(function (l) {
					l.classList.toggle('sel', l.querySelector('input').checked);
				});
				// amount highlight
				amounts.querySelectorAll('label').forEach(function (l) {
					l.classList.toggle('sel', l.querySelector('input').checked);
				});
				// button label
				var val = selectedPreset();
				var amt = (val === 'custom') ? (parseFloat(custom.value) || 0) : parseFloat(val);
				var freq = freqSeg.querySelector('input:checked').value === 'monthly' ? '/mo' : '';
				giveAmt.textContent = (amt > 0 ? fmt(amt) : '') + freq;
			}
			freqSeg.addEventListener('change', refresh);
			amounts.addEventListener('change', refresh);
			custom.addEventListener('input', function () {
				// typing a custom amount selects the Custom radio
				var c = amounts.querySelector('input[value="custom"]');
				if (c) c.checked = true;
				refresh();
			});
			refresh();
		})();
	</script>
</body>
</html>
