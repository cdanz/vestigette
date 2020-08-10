<?php
//  $webroot = str_replace($_SERVER['SCRIPT_NAME'], '', realpath($_SERVER['SCRIPT_FILENAME']));
  $webroot = $_SERVER['DOCUMENT_ROOT'];
  $config = parse_ini_file("${webroot}/../private/config.ini"); 

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
?>
