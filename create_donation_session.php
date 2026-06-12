<?php
// Creates a Stripe hosted Checkout Session for a donation and redirects to it.
// Card entry happens on Stripe's page; no card data touches this server.
session_start();

function fail($msg) {
	$_SESSION['donateError'] = $msg;
	header('Location: /donate.php?error=1');
	exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	header('Location: /donate.php');
	exit;
}

// --- Stripe secret key (gitignored config; never committed) ---
$cfgPath = "${_SERVER['DOCUMENT_ROOT']}/includes/stripe.local.php";
if (!file_exists($cfgPath)) {
	fail('Donations aren\'t configured yet. Please try again later.');
}
$cfg    = require $cfgPath;
$secret = $cfg['secret_key'] ?? '';
if ($secret === '' || strpos($secret, 'REPLACE') !== false) {
	fail('Donations aren\'t configured yet. Please try again later.');
}

// --- Frequency ---
$frequency = ($_POST['frequency'] ?? 'once') === 'monthly' ? 'monthly' : 'once';
$isMonthly = ($frequency === 'monthly');

// --- Amount (USD dollars -> integer cents) ---
$sel = $_POST['amount'] ?? '';
if ($sel === 'custom') {
	$dollars = (float) ($_POST['customAmount'] ?? 0);
} else {
	$dollars = (float) $sel;
}
$cents = (int) round($dollars * 100);
if ($cents < 100) {
	fail('Please choose a donation amount of at least $1.');
}
if ($cents > 5000000) { // $50,000 ceiling — sanity guard
	fail('That amount is over the online limit. Please get in touch for larger gifts.');
}

// --- Build the Checkout Session params ---
$scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$base   = $scheme . '://' . $_SERVER['HTTP_HOST'];

$priceData = [
	'currency'     => 'usd',
	'product_data' => ['name' => $isMonthly ? 'Monthly donation to Agitate' : 'Donation to Agitate'],
	'unit_amount'  => $cents,
];
if ($isMonthly) {
	$priceData['recurring'] = ['interval' => 'month'];
}

$params = [
	'mode'        => $isMonthly ? 'subscription' : 'payment',
	'line_items'  => [[ 'price_data' => $priceData, 'quantity' => 1 ]],
	'success_url' => $base . '/donate_success.php?session_id={CHECKOUT_SESSION_ID}',
	'cancel_url'  => $base . '/donate.php?canceled=1',
];
if (!$isMonthly) {
	$params['submit_type'] = 'donate'; // shows a "Donate" button (payment mode only)
}

// --- Call the Stripe API (form-encoded; http_build_query yields Stripe's bracket syntax) ---
$ch = curl_init('https://api.stripe.com/v1/checkout/sessions');
curl_setopt_array($ch, [
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_POST           => true,
	CURLOPT_POSTFIELDS     => http_build_query($params),
	CURLOPT_HTTPHEADER     => ['Authorization: Bearer ' . $secret],
	CURLOPT_TIMEOUT        => 20,
]);
$resp = curl_exec($ch);
$code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$cerr = curl_error($ch);
curl_close($ch);

if ($resp === false) {
	error_log('Stripe donation curl error: ' . $cerr);
	fail('Could not reach the payment processor. Please try again.');
}
$data = json_decode($resp, true);
if ($code === 200 && !empty($data['url'])) {
	header('Location: ' . $data['url']);
	exit;
}

// Log the real reason server-side; show the donor a generic message.
$reason = $data['error']['message'] ?? ('HTTP ' . $code);
error_log('Stripe donation session failed: ' . $reason);
fail('Something went wrong starting the donation. Please try again.');
