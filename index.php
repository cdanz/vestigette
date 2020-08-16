<?php 
session_start();
$_SESSION['currentArg'] = intval($_GET["arg"]); 
include("${_SERVER['DOCUMENT_ROOT']}/includes/dbconnect.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/query_current_argument.php");
$baseURL = "/index.php";

if(isset($_POST["buttonClicked"])) {
		switch ($_POST["buttonClicked"]) {
	        case "accept":
	            $opinion=1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
					
	            break;
	        case "reject":
	            $opinion=-1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
				
	            break;
	        case "weighBecause":
	        	$arrayOfWeighIns = explode(",",$_POST["becauseWeighInWith"]);
	            $type = "Because";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL prepareForNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";

				for ($i = 0; $i < (count($arrayOfWeighIns)-2); $i+=2) {
					$supportArgVal = intval($arrayOfWeighIns[$i]);
					$weightVal = floatval($arrayOfWeighIns[$i+1]);
					$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
				}
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";
				
				/*Execute queries */
				if(mysqli_multi_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	        case "weighTherefore":
	        	$arrayOfWeighIns = explode(",",$_POST["thereforeWeighInWith"]);
	            $type = "Therefore";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL prepareForNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";

				for ($i = 0; $i < (count($arrayOfWeighIns)-2); $i+=2) {
					$supportArgVal = intval($arrayOfWeighIns[$i]);
					$weightVal = floatval($arrayOfWeighIns[$i+1]);
					if($i == 0){
						$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
					}
					else {
						$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
					}
				}
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";
				
				echo $query;
				/*Execute queries */
				if(mysqli_multi_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	        case "weighRebuttal":
	        	$arrayOfWeighIns = explode(",",$_POST["rebuttalWeighInWith"]);
	            $type = "Rebuttal";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL prepareForNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";
				for ($i = 0; $i < (count($arrayOfWeighIns)-2); $i+=2) {
					$supportArgVal = intval($arrayOfWeighIns[$i]);
					$weightVal = floatval($arrayOfWeighIns[$i+1]);
					if($i == 0){
						$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
					}
					else {
						$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
					}
				}
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";
				echo $query;
				/*Execute queries */
				if(mysqli_multi_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	        case "becauseAddAssertion":
	        /*TODO can't handle special characters. They fail and show up with blank phrasing.	
	        	MySQL recognizes the following escape sequences.
					\0     An ASCII NUL (0x00) character.
					\'     A single quote (“'”) character.
					\"     A double quote (“"”) character.
					\b     A backspace character.
					\n     A newline (linefeed) character.
					\r     A carriage return character.
					\t     A tab character.
					\Z     ASCII 26 (Control-Z). See note following the table.
					\\     A backslash (“\”) character.
					\%     A “%” character. See note following the table.
					\_     A “_” character. See note following the table.
			*/
	        	$assertion = $_POST["becauseAddAssertion"];
	            $type = "Because";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL foldInAssertion(\"".$assertion."\",\"".$type."\",".$argAtHand.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	            //TODO THIS IS NOT NEARLY DONE - YOU HAVE AN UNTESTED SQL STORED PROCEDURE
	            //Make the button pass the arg ID
	        case "becauseUseInstead": 
	        	$existing = $_POST["becauseUseInstead"]; 
	            $type = "Because";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL useInstead(\"".$type."\",".$argAtHand.",".$existing.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
	            break;
	        case "thereforeAddAssertion":
	        	$assertion = $_POST["thereforeAddAssertion"];
	            $type = "Therefore";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL foldInAssertion(\"".$assertion."\",\"".$type."\",".$argAtHand.",".$profileID.");";
				
				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	        	//TODO THIS IS NOT NEARLY DONE - YOU HAVE AN UNTESTED SQL STORED PROCEDURE
	            //Make the button pass the arg ID
	        case "thereforeUseInstead": 
	        	$existing = $_POST["thereforeUseInstead"]; 
	            $type = "Therefore";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL useInstead(\"".$type."\",".$argAtHand.",".$existing.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	        case "rebuttalAddAssertion":
	        	$assertion = $_POST["rebuttalAddAssertion"];
	            $type = "Rebuttal";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL foldInAssertion(\"".$assertion."\",\"".$type."\",".$argAtHand.",".$profileID.");";
				
				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	        	//TODO THIS IS NOT NEARLY DONE - YOU HAVE AN UNTESTED SQL STORED PROCEDURE
	            //Make the button pass the arg ID
	        case "rebuttalUseInstead": 
	        	$existing = $_POST["rebuttalUseInstead"]; 
	            $type = "Rebuttal";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL useInstead(\"".$type."\",".$argAtHand.",".$existing.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            
	            break;
	        	//Promote existing but not currently leading way of putting this forth.
            case "promotePutForth":
            	$preferredPutForth = $_POST["promotePutForth"]; 
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL promotePutForth(".$argAtHand.",".$preferredPutForth.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
            	break;
	            //Submit a new way of putting forth
            case "newPutForth":
            	$phrased = $_POST["newPutForth"]; 
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL newPutForth(".$argAtHand.",".$profileID.",\"".$phrased."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
            	break;

	        //Promote existing mot juste
	        case "promoteMotJuste": 
	        	$preferredPutForth = $_POST["phraseQuibble"];
	        	$preferredMotJuste = $_POST["promoteMotJuste"];
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL promoteMotJuste(".$argAtHand.",".$preferredPutForth.",".$preferredMotJuste.",".$profileID.");";

				//Execute queries
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				
	            break;
	        //Submit new mot juste  
	        case "newMotJuste": 
	        	$preferredPutForth = $_POST["phraseQuibble"];
	        	$phrased = $_POST["newMotJuste"]; 
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL newMotJuste(".$argAtHand.",".$preferredPutForth.",".$profileID.",\"".$phrased."\");";

				//Execute queries 
				if(mysqli_query($db, $query)){
					
				}
				else 
					echo "Query Failed";
				

	            break;

	            //Promote explication TODO Sucks because just pushing the full link string when should have a int key
	        case "promoteExplication": 
	        	$explicationLink = $_POST["promoteExplication"]; 
	            
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);

	            $query = "CALL promoteExplication(".$argAtHand.",".$profileID.",\"".$explicationLink."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					
					
				}
				else 
					echo "Query Failed";
				
	            
	            break;
	    }
	}
mysqli_close($db);

function generateTypeLines($type, $typeArray) {
  global $baseURL;
  global $opinion;
  if (sizeof($typeArray) > 0) {
    foreach ($typeArray as $line) {
        if (isset($_SESSION['profile']) AND ($opinion != 0)) {
          if ((($type == "rebuttal") AND ($opinion < 0)) OR (($type != "rebuttal") AND ($opinion > 0))) {
          	$onClick = "onclick=\"firstClick" . ucfirst($type) . "(" . $line[0] . ")\"";
          }
        }
      if ($line[1] <= 50) {
        $half = "half1";
      } else {
        $half = "half2";
      }
      $pct = strval(number_format($line[1], 1, '_', ''));
      echo "      <div class=\"lineItem\">
        <div class=\"wrapper ${half} pct${pct} ${type}\" " . ((isset($onClick)) ? $onClick : "") . ">
          <div class=\"pointBtn arc1\"></div>
          <div class=\"pointBtn arc2\"></div>
        </div>
        <div class=\"assocArg\"><span class=\"inLinePct" . ucfirst($type) . "\">" . strval(number_format($line[1], 2, '.', '')) . "% - </span><a href=\"${baseURL}?arg=${line[0]}\">${line[2]}</a></div>
      </div>";
    }
    unset($line);
  } else {
    echo "0 results";
  }
}
?>

<!DOCTYPE html>
<html>
  <head>
    <title>Vestigette</title>
    <meta charset="utf-8"/>
    <meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, 
    dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic 
    polling, self-guided polling, opposition research, best reason why, best reason not"/>
    <meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA">  
    <meta name="robots" content="follow"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <link rel="stylesheet" href="style_vestigette.css">
    <script language="javascript" src="script_vestigette.js"></script>
  </head>
  <body>

    <div class="mastHead primaryColor">
      <div class="logoHeader">Vestigette</div>
      <div><a href="http://www.vestigette.org/About.php?arg=<?php echo $_SESSION['currentArg'];?>">About</a></div>
      <div><a href="http://www.vestigette.org/Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a></div>
      <div><a href="http://www.vestigette.org/Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a></div>
      <div><a href="login.php?arg=<?php echo $_SESSION['currentArg'];?>">Login</a></div> 
    </div>


    <div class="accordion becauseColor"><div>Because</div>
<?php if(isset($opinion) AND ($opinion > 0)) { ?> 
  <div style="width: 70%;"></div>
    <button onclick="becauseClearData()" class="button weighBecause" name="buttonClicked" value="weighBecause">&#x27F2;</button> 
    <form action="functions.php" method="POST"> 
      <button type="submit" class="button weighBecause" name="buttonClicked" value="weighBecause">Weigh In</button>
<!-- This hidden field has its value updated with an array as a string serving as the "weigh in" input -->
      <input type="hidden" name="becauseWeighInWith" id="becauseWeighInWith" value="" /> 
    </form>
<?php } ?>
    </div>
    <div class="panel becauseContent" id="because">
<?php
generateTypeLines("because", $because);
?>
    </div>

    <div class="accordion argHeader primaryColor">
      <div>Argument ID</div>
      <div class="opinionContainer">
        <div class="opinion">
<?php
$acceptOpen = "<form action=\"functions.php\" method=\"POST\">
                <button type=\"submit\" class=\"button acceptOpen\" name=\"buttonClicked\" value=\"accept\">Accept</button> 
              </form>";
$acceptSet = "<button type=\"submit\" class=\"button acceptSet\" name=\"buttonClicked\" value=\"accept\">Accepted</button>";
$rejectOpen = "<form action=\"functions.php\" method=\"POST\">
                <button type=\"submit\" class=\"button rejectOpen\" name=\"buttonClicked\" value=\"reject\">Reject</button> 
              </form>";
$rejectSet = "<button type=\"submit\" class=\"button rejectSet\" name=\"buttonClicked\" value=\"reject\">Rejected</button>";
if (isset($_SESSION['profile'])) {
  if ($opinion == 0) { 
    echo $acceptOpen;
    echo $rejectOpen;
  }
  else if ($opinion > 0) { 
    echo $acceptSet;
    echo $rejectOpen;
  }
  else {
    echo $acceptOpen;
    echo $rejectSet;
  }
} 
else {
  echo "      <form action=\"login.php?arg=" . $_SESSION['currentArg'] . "\">
                <button type=\"submit\" class=\"button acceptOpen\" name=\"buttonClicked\">Accept</button> 
              </form>
              <form action=\"login.php?arg=" . $_SESSION['currentArg'] . "\">
                <button type=\"submit\" class=\"button rejectOpen\" name=\"buttonClicked\">Reject</button> 
              </form>";
  }
?>
        </div>
      </div>
    </div>
    <div class="panel expanded bordered" id="argument">
      <div class="rate_phrase">
        <div class="stat">
          <div class="statBig"><?php echo explode('.', $rate)[0]; ?></div>
          <div class="statSmall">.<?php echo explode('.', $rate)[1]; ?>%</div>
          <div class="statDetail">of <?php echo $assertions . (($assertions == 1) ? " user accept\n" : " users accept\n"); ?></div>
        </div>
        <div class="argPhrasing"><?php echo $phrasing; ?></div>
        <button class="altPhraseBtn" name="buttonClicked" value="altPhrasing">&#x270e;</button> 
      </div>
      <div class="explicationBox">
        <div class="explication">
          <a href="<?php echo $links[0][1];?>" target="_blank"><?php echo $links[0][1];?></a>
        </div>
        <button class="altExplicationBtn" name="buttonClicked" value="altExplication">&#x2318;</button>
      </div>
    </div>
    <div class="accordion rebuttalColor">Rebuttal</div>
    <div class="panel rebuttalContent" id="rebuttal">
<?php
generateTypeLines("rebuttal", $rebuttal);
?>
    </div>
    </div> 
    <div class="accordion thereforeColor">Therefore</div>
    <div class="panel thereforeContent" id="therefore">
<?php
generateTypeLines("therefore", $therefore);
?>
    </div>

    <div class="accordion primaryColor">Filter</div>
    <div class="panel primaryContent" id="filters">
      <p>Coming "Soon"<br/><br/></p>
    </div>
  </body>
</html>