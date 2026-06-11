<?php
// og_image.php — dynamic Open Graph / Twitter share image for an argument.
// Renders a 1200×630 PNG: the assertion text + the live accept stat, branded.
// Output is cached in the system temp dir with a short TTL.

session_start();

$argID = isset($_GET['arg']) ? intval($_GET['arg']) : 0;

// ── Cache check ───────────────────────────────────────────────────────────
$cacheDir = sys_get_temp_dir() . '/agitate_og';
if (!is_dir($cacheDir)) { @mkdir($cacheDir, 0775, true); }
$cacheFile = $cacheDir . "/arg_{$argID}.png";
$ttl = 1800; // 30 minutes — platforms cache far longer than this anyway

if ($argID > 0 && is_file($cacheFile) && (time() - filemtime($cacheFile)) < $ttl) {
    header('Content-Type: image/png');
    header('Cache-Control: public, max-age=86400');
    readfile($cacheFile);
    exit;
}

// ── Fetch argument data (same source as the main page: getDetail) ─────────
$phrasing   = 'Join the debate on Agitate';
$assertions = 0;
$ratePct    = null;

include("{$_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

if ($argID > 0 && mysqli_multi_query($db, "CALL getDetail($argID)")) {
    $result = mysqli_store_result($db);
    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_row($result);
        // row: [1]=phrasing, [3]=assertion count, [4]=accept rate (0–1)
        if (!empty($row[1])) $phrasing = $row[1];
        $assertions = (int) $row[3];
        $ratePct    = (int) round($row[4] * 100);
    }
    if ($result) mysqli_free_result($result);
    while (mysqli_more_results($db)) {
        mysqli_next_result($db);
        if ($r = mysqli_store_result($db)) mysqli_free_result($r);
    }
}
mysqli_close($db);

// ── Canvas + palette ──────────────────────────────────────────────────────
$W = 1200; $H = 630;
$font     = '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf';
$fontBold = '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf';

$img = imagecreatetruecolor($W, $H);

$cBlack = imagecolorallocate($img, 14, 14, 14);    // #0e0e0e
$cWhite = imagecolorallocate($img, 255, 255, 255);
$cGrey  = imagecolorallocate($img, 147, 147, 147); // #939393
$cRed   = imagecolorallocate($img, 175, 26, 23);   // #af1a17
$cGreen = imagecolorallocate($img, 16, 160, 32);   // #10a020
$cBlue  = imagecolorallocate($img, 45, 88, 168);   // #2d58a8

imagefilledrectangle($img, 0, 0, $W, $H, $cBlack);

// Tri-color top bar (blue / red / green thirds)
imagefilledrectangle($img, 0,   0, 400, 12, $cBlue);
imagefilledrectangle($img, 400, 0, 800, 12, $cRed);
imagefilledrectangle($img, 800, 0, $W,  12, $cGreen);

// ── Wordmark: AGITATE with the brand's tri-color offset shadow ────────────
$wmSize = 40; $wmX = 60; $wmY = 105; $wm = 'AGITATE';
imagettftext($img, $wmSize, 0, $wmX + 6, $wmY,     $cRed,   $fontBold, $wm); // right
imagettftext($img, $wmSize, 0, $wmX,     $wmY - 6, $cBlue,  $fontBold, $wm); // up
imagettftext($img, $wmSize, 0, $wmX,     $wmY + 6, $cGreen, $fontBold, $wm); // down
imagettftext($img, $wmSize, 0, $wmX,     $wmY,     $cWhite, $fontBold, $wm); // face

// ── Assertion text: word-wrapped, auto-fit to the middle band ─────────────
$marginX  = 60;
$maxWidth = $W - 2 * $marginX;
$topY     = 180;
$bottomY  = 485;
$availH   = $bottomY - $topY;

$chosen = null;
foreach ([56, 50, 44, 38, 32] as $sz) {
    $lines = ogWrap($sz, $fontBold, $phrasing, $maxWidth);
    $lineH = $sz * 1.32;
    if (count($lines) * $lineH <= $availH) { $chosen = [$sz, $lines, $lineH]; break; }
}
if ($chosen === null) {
    $sz = 32;
    $lines = ogWrap($sz, $fontBold, $phrasing, $maxWidth);
    $lineH = $sz * 1.32;
    $maxLines = max(1, (int) floor($availH / $lineH));
    if (count($lines) > $maxLines) {
        $lines = array_slice($lines, 0, $maxLines);
        $lines[$maxLines - 1] = rtrim($lines[$maxLines - 1]) . '…';
    }
    $chosen = [$sz, $lines, $lineH];
}
list($sz, $lines, $lineH) = $chosen;

// Vertically center the wrapped block within [topY, bottomY]
$blockH = count($lines) * $lineH;
$y = $topY + ($availH - $blockH) / 2 + $sz; // +$sz → first baseline
foreach ($lines as $line) {
    imagettftext($img, $sz, 0, $marginX, (int) $y, $cWhite, $fontBold, $line);
    $y += $lineH;
}

// ── Stat block (bottom-left): big % colored by sentiment ──────────────────
$statY = 568;
if ($ratePct !== null && $assertions > 0) {
    $pctText  = $ratePct . '%';
    $pctColor = $ratePct >= 50 ? $cGreen : $cRed;
    imagettftext($img, 52, 0, $marginX, $statY, $pctColor, $fontBold, $pctText);

    $bbox = imagettfbbox(52, 0, $fontBold, $pctText);
    $pctW = abs($bbox[2] - $bbox[0]);

    $noun = $assertions === 1 ? 'person accepts' : 'people accept';
    imagettftext($img, 24, 0, $marginX + $pctW + 18, $statY, $cGrey, $font,
                 "of {$assertions} {$noun}");
}

// Domain (bottom-right)
$domain = 'agitate-discourse.org';
$dbbox  = imagettfbbox(24, 0, $font, $domain);
$dW     = abs($dbbox[2] - $dbbox[0]);
imagettftext($img, 24, 0, $W - $marginX - $dW, $statY, $cGrey, $font, $domain);

// ── Output + cache ────────────────────────────────────────────────────────
if ($argID > 0) { @imagepng($img, $cacheFile); }
header('Content-Type: image/png');
header('Cache-Control: public, max-age=86400');
imagepng($img);
imagedestroy($img);

// ── Helpers ───────────────────────────────────────────────────────────────
function ogWrap($size, $fontFile, $text, $maxWidth) {
    $words = preg_split('/\s+/', trim($text));
    $lines = [];
    $cur   = '';
    foreach ($words as $w) {
        $try  = $cur === '' ? $w : $cur . ' ' . $w;
        $bbox = imagettfbbox($size, 0, $fontFile, $try);
        $width = abs($bbox[2] - $bbox[0]);
        if ($width > $maxWidth && $cur !== '') {
            $lines[] = $cur;
            $cur = $w;
        } else {
            $cur = $try;
        }
    }
    if ($cur !== '') $lines[] = $cur;
    return $lines;
}
