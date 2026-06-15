<?php
// Admin-only image upload for the content editor. Returns JSON.
// Saves to /var/www/html/uploads/ and returns a Markdown snippet to insert.
session_start();
header('Content-Type: application/json');

function out($arr) { echo json_encode($arr); exit; }

// ---- Auth (admin only) ----
$realID = isset($_SESSION['realProfile']) ? intval($_SESSION['realProfile'])
        : (isset($_SESSION['profile']) ? intval($_SESSION['profile']) : 0);
$isAdmin = false;
if ($realID) {
	if (isset($_SESSION['isAdmin'])) {
		$isAdmin = (bool) $_SESSION['isAdmin'];
	} else {
		include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
		$chk = mysqli_fetch_row(mysqli_query($db, "SELECT isAdmin FROM USER_PROFILE WHERE profileID=$realID"));
		$isAdmin = ($chk && intval($chk[0]) === 1);
		mysqli_close($db);
	}
}
if (!$isAdmin) { http_response_code(403); out(['ok' => false, 'error' => 'Not authorized.']); }

// ---- Validate the upload ----
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !isset($_FILES['image'])) {
	out(['ok' => false, 'error' => 'No file received.']);
}
$file = $_FILES['image'];
if ($file['error'] !== UPLOAD_ERR_OK) {
	out(['ok' => false, 'error' => 'Upload failed (is the file under the server limit?).']);
}
if ($file['size'] > 5 * 1024 * 1024) {
	out(['ok' => false, 'error' => 'Image is over the 5 MB limit.']);
}
$info = @getimagesize($file['tmp_name']); // raster images only; rejects SVG/other
$extMap = [IMAGETYPE_PNG => 'png', IMAGETYPE_JPEG => 'jpg', IMAGETYPE_GIF => 'gif', IMAGETYPE_WEBP => 'webp'];
if (!$info || !isset($extMap[$info[2]])) {
	out(['ok' => false, 'error' => 'Unsupported file — use a PNG, JPG, GIF, or WebP image.']);
}
$ext = $extMap[$info[2]];

// ---- Safe, server-generated filename (never trust the client name for the path) ----
$base = strtolower(preg_replace('/[^a-z0-9]+/i', '-', pathinfo($file['name'], PATHINFO_FILENAME)));
$base = trim($base, '-');
if ($base === '') $base = 'image';
$base = substr($base, 0, 40);
$name = $base . '-' . bin2hex(random_bytes(4)) . '.' . $ext;

$dir = "${_SERVER['DOCUMENT_ROOT']}/uploads";
if (!is_dir($dir)) { @mkdir($dir, 0755, true); }
if (!move_uploaded_file($file['tmp_name'], "$dir/$name")) {
	out(['ok' => false, 'error' => 'Could not save the file on the server.']);
}

$url = '/uploads/' . $name;
out(['ok' => true, 'url' => $url, 'markdown' => '![' . $base . '](' . $url . ')']);
