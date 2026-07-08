<?php
//  $webroot = str_replace($_SERVER['SCRIPT_NAME'], '', realpath($_SERVER['SCRIPT_FILENAME']));
  $webroot = $_SERVER['DOCUMENT_ROOT'];
  if (file_exists('includes/config.local.php')) {
    $config = require 'includes/config.local.php';
  } else {
    $config = parse_ini_file("${webroot}/../private/config.ini"); 
  }
  

  $key = "${webroot}/../ssl/client-key.pem";
  $cert = "${webroot}/../ssl/client-cert.pem";
  $ca = "${webroot}/../ssl/server-ca.pem";

  if ($config['environment'] == 'DEVELOPMENT') {
    ini_set('error_reporting', E_ALL);
    ini_set('display_errors', '1');
    error_reporting(E_ALL|E_STRICT);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
  }
  $db = mysqli_init();
  if ($config['dblocation'] == "REMOTE") {
    $db->ssl_set($key, $cert, $ca, NULL, NULL);
  }
  try {
      $link = mysqli_real_connect($db, $config['servername'], $config['username'], $config['pass'], $config['dbname'], 3306, NULL, MYSQLI_CLIENT_SSL_DONT_VERIFY_SERVER_CERT);
  } catch (mysqli_sql_exception $ex) {
      throw new Exception("Can't connect to the database! \n" . $ex);
  }
  mysqli_set_charset($db, "utf8mb4");
  mysqli_query($db, "SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'");

  // ALL_PUBLIC_AFF_ID: affiliationID for "All Users - Public" (the universal default group).
  define('ALL_PUBLIC_AFF_ID', 12);

  //Be skeptical of this. Claude added on 09.05.2026
  $mysqli = $db; // Create $mysqli alias for compatibility with existing queries

  // Restore session from rememberMe cookie if session has expired
  if (isset($_COOKIE['rememberMe']) && !isset($_SESSION['profile'])) {
    $rm_stmt = $db->prepare(
      "SELECT profileID, email FROM REMEMBER_ME WHERE token = ? AND expiry > NOW()"
    );
    $rm_stmt->bind_param("s", $_COOKIE['rememberMe']);
    $rm_stmt->execute();
    $rm_row = $rm_stmt->get_result()->fetch_assoc();
    $rm_stmt->close();
    if ($rm_row) {
      $_SESSION['profile'] = $rm_row['profileID'];
      $_SESSION['email']   = $rm_row['email'];
    }
  }

  // Set @active_aff_id from the logged-in user's stored active affiliation.
  // Runs after rememberMe restore so cookie-authenticated sessions are covered.
  $_aff_id = ALL_PUBLIC_AFF_ID;
  if (isset($_SESSION['profile'])) {
    $_aff_stmt = $db->prepare("SELECT activeAffiliationID FROM USER_PROFILE WHERE profileID = ?");
    $_aff_stmt->bind_param("i", $_SESSION['profile']);
    $_aff_stmt->execute();
    $_aff_row = $_aff_stmt->get_result()->fetch_assoc();
    $_aff_stmt->close();
    if ($_aff_row && !empty($_aff_row['activeAffiliationID'])) {
      $_aff_id = intval($_aff_row['activeAffiliationID']);
    }
    unset($_aff_stmt, $_aff_row);
  }
  mysqli_query($db, "SET @active_aff_id = " . $_aff_id);
  unset($_aff_id);
?>
