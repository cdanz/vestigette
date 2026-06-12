<?php
// ── Stripe config (EXAMPLE) ───────────────────────────────────────────────
// Copy this file to  includes/stripe.local.php  (which is gitignored) and fill
// in your keys. Create it on BOTH your local machine and the production droplet
// (/var/www/html/includes/stripe.local.php) — it is never deployed by git/scp.
//
// Start with TEST keys (sk_test_...) while in the Stripe sandbox. Switch to live
// keys (sk_live_...) and mode = 'live' only when you're ready to accept real
// donations.
//
// Only the SECRET key is needed for hosted Checkout; the publishable key isn't
// used server-side. Never commit the real file or paste keys into chat.

return [
    'secret_key' => 'sk_test_REPLACE_WITH_YOUR_TEST_SECRET_KEY',
    'mode'       => 'test', // 'test' or 'live' — drives the sandbox notice on the page
];
