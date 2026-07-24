<?php
/**
 * Re-fetch OG metadata for explication links whose card is empty or shows a
 * generic placeholder. Uses the same fetch/store logic as the live app
 * (includes/og_meta.php), so results are identical to a fresh link add — and
 * storeOgMeta()'s guard prevents re-caching YouTube's generic placeholder.
 *
 *   php refetch_og.php        # one-time: re-fetch ALL empty + generic
 *   php refetch_og.php 30     # cron mode: generic + empties fetched within 30 days
 */
if (php_sapi_name() !== 'cli') { http_response_code(403); exit; }

require_once '/var/www/html/includes/og_meta.php';

$pw = trim(@file_get_contents('/root/.digitalocean_password'));
$db = @mysqli_connect('localhost', 'root', $pw, 'vestigette');
if (!$db) { fwrite(STDERR, "DB connect failed\n"); exit(1); }

$days = isset($argv[1]) ? intval($argv[1]) : 0;   // 0 = all empties; >0 = only empties fetched within N days

$generic = "og_title IN ('YouTube','- YouTube') OR og_description LIKE 'Enjoy the videos and music you love%'";
$empty   = "(og_title IS NULL OR og_title='')";
if ($days > 0) {
	$empty = "($empty AND (og_fetched_at IS NULL OR og_fetched_at >= NOW() - INTERVAL $days DAY))";
}
$sql = "SELECT explicationID, hyperlink FROM EXPLICATION
        WHERE hyperlink IS NOT NULL AND hyperlink<>'' AND (($generic) OR $empty)";

$res = mysqli_query($db, $sql);
$total = 0; $fixed = 0;
while ($row = mysqli_fetch_assoc($res)) {
	$total++;
	storeOgMeta($db, $row['hyperlink'], intval($row['explicationID']));
	$r2 = mysqli_fetch_row(mysqli_query($db, "SELECT og_title FROM EXPLICATION WHERE explicationID=".intval($row['explicationID'])));
	$title = ($r2 && $r2[0] !== null) ? $r2[0] : '';
	if ($title !== '') $fixed++;
	echo str_pad($row['explicationID'], 7) . str_pad(substr($row['hyperlink'], 0, 44), 46)
	   . ' => ' . ($title !== '' ? $title : '(empty / placeholder skipped)') . "\n";
	usleep(200000); // 0.2s politeness between outbound fetches
}
echo "\nTOTAL=$total  RESOLVED=$fixed\n";
