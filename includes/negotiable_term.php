<?php
// Negotiable Terms — display helpers.
//
// The [[value]] token lives inside stored phrasings. List/associated render sites
// get the token already substituted at the SQL source (see ntPhrasing() in
// db/negotiable_term_functions.sql). These PHP helpers cover the CURRENT-argument
// surfaces that need token-aware treatment in PHP: the index header (halo + info
// icon) and the plain-text share/OG title.
//
// NB: htmlspecialchars() does NOT escape '[' or ']', so the token survives escaping
// intact — substitution runs AFTER escaping, with no XSS-ordering hazard.

if (!defined('NT_TOKEN')) define('NT_TOKEN', '[[value]]');

// Format a DECIMAL(24,8) value for display: trim trailing zeros and any dangling
// decimal point (3.50000000 -> "3.5", 4.00000000 -> "4"). Returns '' for NULL.
function nt_format_value($v) {
    if ($v === null || $v === '') return '';
    $s = (string) $v;
    if (strpos($s, '.') !== false) {
        $s = rtrim(rtrim($s, '0'), '.');
    }
    return $s;
}

function nt_has_token($text) {
    return $text !== null && strpos($text, NT_TOKEN) !== false;
}

// Remove the token entirely and tidy whitespace — for similarity/search matching
// so the literal word "value" can't pollute FULLTEXT scoring.
function nt_strip_token($text) {
    if ($text === null) return $text;
    $t = str_replace(NT_TOKEN, '', $text);
    return trim(preg_replace('/\s{2,}/', ' ', $t));
}

// Index header: escaped phrasing with the value wrapped in a cddbYellow halo plus
// an info icon (upper-right) linking to the glossary. Falls back to plain escaped
// text when there is no token or no cached value.
function nt_render_header($rawPhrasing, $value) {
    $safe = htmlspecialchars($rawPhrasing ?? '', ENT_QUOTES, 'UTF-8');
    if (strpos($safe, NT_TOKEN) === false) return $safe;
    $fmt = nt_format_value($value);
    if ($fmt === '') return $safe;
    $valHtml = htmlspecialchars($fmt, ENT_QUOTES, 'UTF-8');
    $icon = '<a class="nt-info" href="/post.php?slug=glossary"'
          . ' title="This is a negotiable term, accept to weigh-in"'
          . ' aria-label="This is a negotiable term, accept to weigh in">'
          . '<svg class="nt-info-ico" viewBox="0 0 24 24" fill="none" stroke="currentColor"'
          . ' stroke-width="2" stroke-linecap="round" aria-hidden="true">'
          . '<line x1="4" y1="8" x2="20" y2="8"/><line x1="4" y1="16" x2="20" y2="16"/>'
          . '<circle cx="9" cy="8" r="2.5" fill="currentColor" stroke="none"/>'
          . '<circle cx="15" cy="16" r="2.5" fill="currentColor" stroke="none"/></svg></a>';
    $replacement = '<span class="nt-term"><span class="nt-value">'
                 . $valHtml . '</span>' . $icon . '</span>';
    return str_replace(NT_TOKEN, $replacement, $safe);
}

// Escaped phrasing with the value substituted plain (no halo) — for HTML contexts
// that aren't the header.
function nt_substitute_plain($rawPhrasing, $value) {
    $safe = htmlspecialchars($rawPhrasing ?? '', ENT_QUOTES, 'UTF-8');
    if (strpos($safe, NT_TOKEN) === false) return $safe;
    $valHtml = htmlspecialchars(nt_format_value($value), ENT_QUOTES, 'UTF-8');
    return str_replace(NT_TOKEN, $valHtml, $safe);
}

// Raw (unescaped) text with the value substituted — for building share/OG titles
// that are escaped later by the caller, or drawn into an image.
function nt_substitute_text($rawPhrasing, $value) {
    if (!nt_has_token($rawPhrasing)) return $rawPhrasing;
    return str_replace(NT_TOKEN, nt_format_value($value), $rawPhrasing);
}
