<?php
session_start();

header('Content-Type: application/json');

if (!isset($_SESSION['profile'])) {
    http_response_code(401);
    echo json_encode([]);
    exit;
}

$q = trim($_POST['q'] ?? '');
if (mb_strlen($q) < 2) {
    echo json_encode([]);
    exit;
}

include("{$_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");

$like = '%' . $q . '%';
$stmt = $db->prepare(
    "SELECT affiliationID, orgName FROM AFFILIATION WHERE orgName LIKE ? AND public = 1 ORDER BY orgName ASC LIMIT 10"
);
$stmt->bind_param("s", $like);
$stmt->execute();
$result = $stmt->get_result();

$matches = [];
while ($row = $result->fetch_assoc()) {
    $matches[] = [
        'affiliationID' => intval($row['affiliationID']),
        'orgName'       => $row['orgName'],
    ];
}

$stmt->close();
mysqli_close($db);

echo json_encode($matches);
