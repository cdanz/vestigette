<?php
// og_image.php — dynamic Open Graph / Twitter share image for an argument.
// Dialectic card, 1200×630 PNG: the assertion text, an accept/reject verdict
// strip, and the strongest Because / strongest Rebuttal panels — or, for hub
// arguments (includes/hub_metrics.php), a full-width panel listing the top
// Therefore positions. Cached in the system temp dir with a short TTL.
//
// Social-proof gate: percentages render only when the argument has at least
// SOCIAL_PROOF_MIN_HUMANS human opinions (personas = profileID 1–26, admin =
// 28). Persona-inflated headcounts on a publicly shared card are a
// credibility risk, so below the threshold the verdict bar is unlabeled.
//
// The renderer is a plain function so a CLI harness can include this file and
// render fixture data; the web flow at the bottom only runs under a web SAPI.

require_once __DIR__ . '/includes/negotiable_term.php';

// ── Data fetch ────────────────────────────────────────────────────────────
function ogFetchData($db, $argID) {
    $d = [
        'argID'      => $argID,
        'phrasing'   => null,
        'acceptPct'  => null,   // 0–100, from getDetail (public scope)
        'assertions' => 0,
        'humans'     => 0,
        'because'    => null,   // strongest Because phrasing
        'rebuttal'   => null,   // strongest Rebuttal phrasing
    ];

    // getDetail/getAssociated reference @vtime_dir/@vtime_date (time filter);
    // they must be set to the no-filter state or every predicate is NULL and
    // the counts come back empty.
    mysqli_query($db, "SET @vtime_dir = 0, @vtime_date = NULL");

    ogFirstResult($db, "CALL getDetail($argID, 0)", function ($res) use (&$d) {
        if ($row = mysqli_fetch_row($res)) {
            // row: [1]=phrasing, [3]=assertion count, [4]=accept rate (0–1)
            if (!empty($row[1])) $d['phrasing'] = $row[1];
            $d['assertions'] = (int) $row[3];
            $d['acceptPct']  = $d['assertions'] > 0 ? $row[4] * 100 : null;
        }
    });

    // Bake a negotiable-term [[value]] token into the title (Because/Rebuttal
    // already arrive baked via getAssociated's ntPhrasing wrap).
    if (nt_has_token($d['phrasing'])) {
        $ctv = null;
        if ($cRes = mysqli_query($db, "SELECT currentTermValue FROM ARGUMENT WHERE argumentID = " . intval($argID))) {
            if ($cRow = mysqli_fetch_row($cRes)) $ctv = $cRow[0];
            mysqli_free_result($cRes);
        }
        $d['phrasing'] = nt_substitute_text($d['phrasing'], $ctv);
    }

    // Rows arrive grouped by type, AggWeight DESC within each — the first
    // Because/Rebuttal row is the strongest.
    ogFirstResult($db, "CALL getAssociated($argID, 0)", function ($res) use (&$d) {
        while ($row = mysqli_fetch_row($res)) {
            if ($row[1] === 'Because'  && $d['because']  === null) $d['because']  = $row[4];
            if ($row[1] === 'Rebuttal' && $d['rebuttal'] === null) $d['rebuttal'] = $row[4];
        }
    });

    // Human opinions: personas are profileID 1–26, admin is 28.
    $hRes = mysqli_query($db,
        "SELECT COUNT(*) FROM OPINION
         WHERE argumentID = $argID AND profileID > 26 AND profileID <> 28");
    if ($hRes && ($hRow = mysqli_fetch_row($hRes))) $d['humans'] = (int) $hRow[0];

    return $d;
}

// Run a CALL, hand the first result set to $cb, drain the rest.
function ogFirstResult($db, $sql, $cb) {
    if (!mysqli_multi_query($db, $sql)) return;
    $first = true;
    do {
        if ($res = mysqli_store_result($db)) {
            if ($first) { $cb($res); $first = false; }
            mysqli_free_result($res);
        }
    } while (mysqli_more_results($db) && mysqli_next_result($db));
}

// ── Renderer ──────────────────────────────────────────────────────────────
function ogRenderCard($d) {
    $W = 1200; $H = 630; $mX = 60;
    $font     = ogFontPath(false);
    $fontBold = ogFontPath(true);

    $img = imagecreatetruecolor($W, $H);

    $cBlack  = imagecolorallocate($img, 14, 14, 14);    // #0e0e0e
    $cPanel  = imagecolorallocate($img, 26, 28, 31);    // --n-800 #1a1c1f
    $cWhite  = imagecolorallocate($img, 255, 255, 255);
    $cGrey   = imagecolorallocate($img, 154, 160, 168); // --n-400 #9aa0a8
    $cRed    = imagecolorallocate($img, 175, 26, 23);   // --cddbRed
    $cGreen  = imagecolorallocate($img, 16, 160, 32);   // --cddbGreen
    $cBlue   = imagecolorallocate($img, 45, 88, 168);   // --cddbBlue
    $cYellow = imagecolorallocate($img, 212, 160, 23);  // --cddbYellow

    imagefilledrectangle($img, 0, 0, $W, $H, $cBlack);

    // Tri-color top bar (blue / red / green thirds)
    imagefilledrectangle($img, 0,   0, 400, 12, $cBlue);
    imagefilledrectangle($img, 400, 0, 800, 12, $cRed);
    imagefilledrectangle($img, 800, 0, $W,  12, $cGreen);

    // Wordmark: tri-color ring mark + clean AGITATE — matches the current site
    // logo and drops the old RGB-split "glitch" shadow for the calmer register.
    $wmSize = 30; $wmY = 84; $wm = 'AGITATE';
    $ringPath = __DIR__ . '/agitate-ring-mark.png';
    $textX = $mX;
    if (is_file($ringPath) && ($ring = @imagecreatefrompng($ringPath))) {
        $ringSz = 54;
        imagealphablending($img, true);
        imagecopyresampled($img, $ring, $mX, 32, 0, 0, $ringSz, $ringSz,
                           imagesx($ring), imagesy($ring));
        imagedestroy($ring);
        $textX = $mX + $ringSz + 18;
    }
    imagettftext($img, $wmSize, 0, $textX, $wmY, $cWhite, $fontBold, $wm);

    // Argument ID, top-right corner
    if ($d['argID'] > 0) {
        $idText = 'Argument #' . $d['argID'];
        imagettftext($img, 18, 0, $W - $mX - ogTextW(18, $font, $idText), $wmY,
                     $cGrey, $font, $idText);
    }

    // Hub mode (includes/hub_metrics.php): the argument at hand is context,
    // not content — its phrasing renders as a small grey kicker, the verdict
    // strip is dropped, and the Therefore positions take the headline space.
    $isHub = !empty($d['hub']['fires']) && count($d['hub']['top']) >= 3;

    // ── Title: markdown-stripped phrasing ──────────────────────────────────
    $title = ogTruncate(ogStripMarkdown($d['phrasing'] !== null
        ? $d['phrasing'] : 'Join the debate on Agitate'), $isHub ? 120 : 96);
    $maxW = $W - 2 * $mX;

    if ($isHub) {
        // De-emphasized kicker: two lines max, grey, regular weight
        $kSz = 20; $ky = 140;
        foreach (ogClampLines(ogWrap($kSz, $font, $title, $maxW), 2) as $line) {
            imagettftext($img, $kSz, 0, $mX, (int) $ky, $cGrey, $font, $line);
            $ky += 30;
        }
    } else {
    // Auto-fit headline in y 120–300
    $topY = 120; $botY = 300; $availH = $botY - $topY;

    $chosen = null;
    foreach ([48, 42, 36, 30] as $sz) {
        $lines = ogWrap($sz, $fontBold, $title, $maxW);
        $lineH = $sz * 1.28;
        if (count($lines) * $lineH <= $availH) { $chosen = [$sz, $lines, $lineH]; break; }
    }
    if ($chosen === null) {
        $sz = 30; $lineH = $sz * 1.28;
        $lines = ogClampLines(ogWrap($sz, $fontBold, $title, $maxW),
                              max(1, (int) floor($availH / $lineH)));
        $chosen = [$sz, $lines, $lineH];
    }
    list($sz, $lines, $lineH) = $chosen;
    $y = $topY + ($availH - count($lines) * $lineH) / 2 + $sz;
    foreach ($lines as $line) {
        imagettftext($img, $sz, 0, $mX, (int) $y, $cWhite, $fontBold, $line);
        $y += $lineH;
    }
    } // end non-hub headline

    // ── Verdict strip: accept/reject split bar, y ~330–392 (non-hub only —
    //    a hub's own verdict is near-consensus framing, not the story) ──────
    if (!$isHub) {
    $barY0 = 358; $barY1 = 390; $labelY = 344; $barW = $W - 2 * $mX;
    $showProof = defined('SOCIAL_PROOF_MIN_HUMANS')
        ? $d['humans'] >= SOCIAL_PROOF_MIN_HUMANS : false;

    if ($d['assertions'] > 0 && $d['acceptPct'] !== null) {
        $pct = max(0, min(100, $d['acceptPct']));
        $acceptLabel = 'ACCEPT'; $rejectLabel = 'REJECT';
        if ($showProof) {
            $acceptLabel .= ' · ' . round($pct) . '%';
            $rejectLabel  = round(100 - $pct) . '% · ' . $rejectLabel;
        }
        imagettftext($img, 17, 0, $mX, $labelY,
                     $showProof ? $cGreen : $cGrey, $fontBold, $acceptLabel);
        imagettftext($img, 17, 0, $W - $mX - ogTextW(17, $fontBold, $rejectLabel),
                     $labelY, $showProof ? $cRed : $cGrey, $fontBold, $rejectLabel);

        $gap = 4;
        $aW  = (int) round(($barW - $gap) * $pct / 100);
        // Keep a sliver of each color visible unless the split is truly 0/100
        if ($pct > 0   && $aW < 8)             $aW = 8;
        if ($pct < 100 && $aW > $barW - $gap - 8) $aW = $barW - $gap - 8;
        if ($aW > 0)
            imagefilledrectangle($img, $mX, $barY0, $mX + $aW, $barY1, $cGreen);
        if ($aW < $barW - $gap)
            imagefilledrectangle($img, $mX + $aW + $gap, $barY0, $mX + $barW, $barY1, $cRed);
    } else {
        $noneText = 'No verdicts yet — be the first to weigh in.';
        imagettftext($img, 20, 0, (int) (($W - ogTextW(20, $font, $noneText)) / 2),
                     $barY0 + 22, $cGrey, $font, $noneText);
    }
    } // end non-hub verdict strip

    // ── Panels ─────────────────────────────────────────────────────────────
    // Hub mode: the Therefore positions are the headline — a tall full-width
    // ballot panel (top 5 by engagement, numbered) in the space the headline
    // and verdict strip vacated. Otherwise: strongest Because / Rebuttal.
    if ($isHub) {
        $pY0 = 196; $pY1 = 552;
        $hX = $mX; $hW = $W - 2 * $mX; $pad = 20;
        imagefilledrectangle($img, $hX, $pY0, $hX + $hW, $pY1, $cPanel);
        imagefilledrectangle($img, $hX, $pY0, $hX + 5,   $pY1, $cGreen);
        imagettftext($img, 15, 0, $hX + $pad, $pY0 + 32, $cGreen, $fontBold, 'THEREFORE');
        $shown = count($d['hub']['top']);
        if ($d['hub']['kids'] > $shown) {
            $moreN = $d['hub']['kids'] - $shown;
            $moreText = '+ ' . $moreN . ' more position' . ($moreN === 1 ? '' : 's') . ' on the map';
            imagettftext($img, 15, 0, $hX + $hW - $pad - ogTextW(15, $font, $moreText),
                         $pY0 + 32, $cGrey, $font, $moreText);
        }
        $rowSz = 24; $ly = $pY0 + 89; $rank = 1;
        foreach ($d['hub']['top'] as $t) {
            imagettftext($img, $rowSz, 0, $hX + $pad + 4, (int) $ly,
                         $cGreen, $fontBold, (string) $rank);
            $lines = ogClampLines(ogWrap($rowSz, $fontBold,
                ogStripMarkdown($t['phrasing']), $hW - 2 * $pad - 54), 1);
            imagettftext($img, $rowSz, 0, $hX + $pad + 50, (int) $ly,
                         $cWhite, $fontBold, $lines[0]);
            $ly += 54; $rank++;
        }
    } else {
        $pY0 = 416; $pY1 = 552; $pGap = 30;
        $pW = (int) (($W - 2 * $mX - $pGap) / 2);
        ogPanel($img, $mX,               $pY0, $pW, $pY1 - $pY0, 'BECAUSE', $cBlue,
                $d['because'],  'No supporting case yet — make the first argument for it.',
                $cPanel, $cWhite, $cGrey, $font, $fontBold);
        ogPanel($img, $mX + $pW + $pGap, $pY0, $pW, $pY1 - $pY0, 'REBUTTAL', $cRed,
                $d['rebuttal'], 'No rebuttals yet — make the first case against.',
                $cPanel, $cWhite, $cGrey, $font, $fontBold);
    }

    // ── Footer: CTA + domain ───────────────────────────────────────────────
    $footY = 604;
    imagettftext($img, 23, 0, $mX, $footY, $cYellow, $fontBold,
                 $isHub ? 'Which do you back?' : 'Where do you stand?');
    $domain = 'agitate-discourse.org';
    imagettftext($img, 19, 0, $W - $mX - ogTextW(19, $font, $domain), $footY,
                 $cGrey, $font, $domain);

    return $img;
}

// One Because/Rebuttal panel: accent edge, type label, clamped body text.
function ogPanel($img, $x, $y, $w, $h, $label, $cAccent, $text, $emptyText,
                 $cPanel, $cWhite, $cGrey, $font, $fontBold) {
    imagefilledrectangle($img, $x, $y, $x + $w, $y + $h, $cPanel);
    imagefilledrectangle($img, $x, $y, $x + 5, $y + $h, $cAccent);

    $pad = 20;
    imagettftext($img, 15, 0, $x + $pad, $y + 32, $cAccent, $fontBold, $label);

    $isEmpty = ($text === null || trim($text) === '');
    $body    = $isEmpty ? $emptyText : ogStripMarkdown($text);
    $bodySz  = 20; $bodyLineH = $bodySz * 1.32;
    $lines   = ogClampLines(ogWrap($bodySz, $font, $body, $w - 2 * $pad - 5), 3);
    $ly = $y + 62;
    foreach ($lines as $line) {
        imagettftext($img, $bodySz, 0, $x + $pad, (int) $ly,
                     $isEmpty ? $cGrey : $cWhite, $font, $line);
        $ly += $bodyLineH;
    }
}

// ── Helpers ───────────────────────────────────────────────────────────────
function ogFontPath($bold) {
    $candidates = $bold
        ? ['/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
           '/System/Library/Fonts/Supplemental/Arial Bold.ttf']
        : ['/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
           '/System/Library/Fonts/Supplemental/Arial.ttf'];
    foreach ($candidates as $f) { if (is_file($f)) return $f; }
    return $candidates[0];
}

function ogStripMarkdown($t) {
    $t = preg_replace('/!\[([^\]]*)\]\([^)]*\)/', '$1', $t);   // images → alt text
    $t = preg_replace('/\[([^\]]+)\]\([^)]*\)/',  '$1', $t);   // links → link text
    $t = preg_replace('/(\*\*|__)(.*?)\1/s',      '$2', $t);   // bold
    $t = preg_replace('/(\*|_)(.*?)\1/s',         '$2', $t);   // italic
    $t = preg_replace('/`([^`]*)`/',              '$1', $t);   // inline code
    $t = preg_replace('/^\s{0,3}#{1,6}\s*/m',     '',   $t);   // headings
    $t = preg_replace('/^\s{0,3}>\s?/m',          '',   $t);   // blockquotes
    $t = html_entity_decode(strip_tags($t), ENT_QUOTES, 'UTF-8');
    return trim(preg_replace('/\s+/', ' ', $t));
}

function ogTruncate($t, $max) {
    if (mb_strlen($t) <= $max) return $t;
    $cut = mb_substr($t, 0, $max);
    $sp  = mb_strrpos($cut, ' ');
    if ($sp !== false && $sp > $max * 0.6) $cut = mb_substr($cut, 0, $sp);
    return rtrim($cut, ' ,;:.') . '…';
}

function ogWrap($size, $fontFile, $text, $maxWidth) {
    $words = preg_split('/\s+/', trim($text));
    $lines = [];
    $cur   = '';
    foreach ($words as $w) {
        $try = $cur === '' ? $w : $cur . ' ' . $w;
        if (ogTextW($size, $fontFile, $try) > $maxWidth && $cur !== '') {
            $lines[] = $cur;
            $cur = $w;
        } else {
            $cur = $try;
        }
    }
    if ($cur !== '') $lines[] = $cur;
    return $lines;
}

function ogClampLines($lines, $max) {
    if (count($lines) > $max) {
        $lines = array_slice($lines, 0, $max);
        $lines[$max - 1] = rtrim($lines[$max - 1]) . '…';
    }
    return $lines;
}

function ogTextW($size, $fontFile, $text) {
    $bbox = imagettfbbox($size, 0, $fontFile, $text);
    return abs($bbox[2] - $bbox[0]);
}

// ── Web entry point (skipped when included by the CLI test harness) ───────
if (PHP_SAPI !== 'cli') {
    session_start();

    $argID = isset($_GET['arg']) ? intval($_GET['arg']) : 0;

    // Cache: per-argID PNG. Content changes are picked up by the version
    // param index.php appends to the og:image URL; this TTL just bounds how
    // stale a re-scraped card can be.
    $cacheDir = sys_get_temp_dir() . '/agitate_og';
    if (!is_dir($cacheDir)) { @mkdir($cacheDir, 0775, true); }
    $cacheFile = $cacheDir . "/arg_{$argID}.png";
    $ttl = 3600;

    if ($argID > 0 && is_file($cacheFile) && (time() - filemtime($cacheFile)) < $ttl) {
        header('Content-Type: image/png');
        header('Cache-Control: public, max-age=86400');
        readfile($cacheFile);
        exit;
    }

    include("{$_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
    require_once("{$_SERVER['DOCUMENT_ROOT']}/includes/hub_metrics.php");
    $data = ogFetchData($db, $argID);
    $data['hub'] = hubMetrics($db, $argID);
    mysqli_close($db);

    $img = ogRenderCard($data);

    // Only cache real content — a DB hiccup shouldn't pin the fallback card
    // for a valid argument.
    if ($argID > 0 && $data['phrasing'] !== null) { @imagepng($img, $cacheFile); }
    header('Content-Type: image/png');
    header('Cache-Control: public, max-age=86400');
    imagepng($img);
    imagedestroy($img);
}
