<?php
$argID = $_SESSION['currentArg'];
$opinion = 0;
$sql = "CALL getAssociated($argID);";
$sql .= "CALL getDetail($argID);";
$sql .= "CALL getExplication($argID);";
if (isset($_SESSION['profile'])) {
  $proID = $_SESSION['profile'];
  $sql .= "CALL getOpinion($argID,$proID);";
  $sql .= "CALL getUserAssociated($argID,$proID);";
}
$sql .= "CALL getAltPhrasing($argID)";

if (mysqli_multi_query($db, $sql)) {
  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) {
    $assocArgs = array();
    $because = array();
    $therefore = array();
    $rebuttal = array();
    $iterator = 0;
    $bIterator = 0;
    $tIterator = 0;
    $rIterator = 0;
    while ($row = mysqli_fetch_row($result)) {
      $assocArgs[$iterator] = array();
      $assocArgs[$iterator][0] = $row[1];
      $assocArgs[$iterator][1] = $row[2];
      $assocArgs[$iterator][2] = $row[3];
      $assocArgs[$iterator][3] = $row[4];
      $iterator++;
      switch ($row[1]) {
        case 'Because':
          $because[$bIterator] = array();
          $because[$bIterator][0] = $row[2];
          $because[$bIterator][1] = $row[3];
          $because[$bIterator][2] = $row[4];
          $bIterator++;
          break;
        case 'Therefore':
          $therefore[$tIterator] = array();
          $therefore[$tIterator][0] = $row[2];
          $therefore[$tIterator][1] = $row[3];
          $therefore[$tIterator][2] = $row[4];
          $tIterator++;
          break;
        case 'Rebuttal':
          $rebuttal[$rIterator] = array();
          $rebuttal[$rIterator][0] = $row[2];
          $rebuttal[$rIterator][1] = $row[3];
          $rebuttal[$rIterator][2] = $row[4];
          $rIterator++;
          break;
      }
    }
  }
  if ($result) mysqli_free_result($result);
  mysqli_next_result($db);
  mysqli_next_result($db);
  mysqli_next_result($db);

  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_row($result);
    $rate = number_format($row[4]*100,1);
    $phrasing = $row[1];
    $assertions = $row[3];
  } else {
    $rate = 'N/A.N/A';
    $phrasing = 'Invalid Argument Identifier';
    $assertions = 0;
  }
  if ($result) mysqli_free_result($result);
  mysqli_next_result($db);
  mysqli_next_result($db);
  mysqli_next_result($db);
  
  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) {
    $iterator = 0;
    $links = array();
    while ($row = mysqli_fetch_row($result)) {
      $links[$iterator] = array();
      $links[$iterator][0] = $row[0];  // totalWeight
      $links[$iterator][1] = $row[1];  // endorsementCount
      $links[$iterator][2] = $row[2];  // explicationID
      $links[$iterator][3] = $row[3];  // hyperlink
      $links[$iterator][4] = $row[4];  // publisher
      $links[$iterator][5] = $row[5];  // authorFName
      $links[$iterator][6] = $row[6];  // authorLName
      $links[$iterator][7] = $row[7];  // title
      $links[$iterator][8] = $row[8];  // og_title
      $links[$iterator][9] = $row[9];  // og_image
      $links[$iterator][10] = $row[10]; // og_description
      $iterator++;
    }
  } else {
    $links = array();
  }
  if ($result) mysqli_free_result($result);
  mysqli_next_result($db);
  mysqli_next_result($db);
  mysqli_next_result($db);
  
  if (isset($_SESSION['profile'])) {
    $result = mysqli_store_result($db);
    if ($result && mysqli_num_rows($result) > 0) {
      $row = mysqli_fetch_row($result);
      if ($row[0])
        $opinion = 1;
      else
        $opinion = -1;
    }
    if ($result) mysqli_free_result($result);
    mysqli_next_result($db);
    mysqli_next_result($db);
    mysqli_next_result($db);
    
    $result = mysqli_store_result($db);
    if ($result && mysqli_num_rows($result) > 0) {
      while ($row = mysqli_fetch_row($result)) {
        switch ($row[1]) {
          case 'Because':
            for ($i = 0; $i < count($because); $i++) {
              if ($because[$i][0] == $row[2]) {
                $because[$i][3] = $row[3];
                break;
              }
            }
            break;
          case 'Therefore':
            for ($i = 0; $i < count($therefore); $i++) {
              if ($therefore[$i][0] == $row[2]) {
                $therefore[$i][3] = $row[3];
                break;
              }
            }
            break;
          case 'Rebuttal':
            for ($i = 0; $i < count($rebuttal); $i++) {
              if ($rebuttal[$i][0] == $row[2]) {
                $rebuttal[$i][3] = $row[3];
                break;
              }
            }
            break;
        }
      }
    }
    if ($result) mysqli_free_result($result);
    mysqli_next_result($db);
    mysqli_next_result($db);
    mysqli_next_result($db);
  }
  
  $result = mysqli_store_result($db);
  if ($result && mysqli_num_rows($result) > 0) { 
    $iterator = 0;
    $altPhrasings = array();
    while ($row = mysqli_fetch_row($result)) {
      $altPhrasings[$iterator] = array();
      $altPhrasings[$iterator][0] = $row[0];  // totalWeight
      $altPhrasings[$iterator][1] = $row[1];  // endorsementCount
      $altPhrasings[$iterator][2] = $row[2];  // phrasing text
      $altPhrasings[$iterator][3] = $row[3];  // phrasingID
      $iterator++;
    }
  }
  if ($result) mysqli_free_result($result);
  
  //Clear all remaining results from multi-query if any
  while (mysqli_more_results($db)) {
    mysqli_next_result($db);
    if ($result = mysqli_store_result($db)) {
      mysqli_free_result($result);
    }
  }
} else {
  echo "ERROR - MULTIPLE QUERIES FAILED";
}
?>