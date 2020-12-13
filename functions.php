<?php
		switch ($_POST["buttonClicked"]) {
	        case "accept":
	            $opinion=1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
				header('Location: /index.php?arg='.$_SESSION['currentArg']);	
	            break;
	        case "reject":
	            $opinion=-1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
				header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
				
	            break;
	        case "addAssertion":
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
	        	$assertion = $_POST["assertion"];
	            $type = $_POST["type"];
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL foldInAssertion(\"".$assertion."\",\"".$type."\",".$argAtHand.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
				
	            break;
	            //TODO THIS IS NOT NEARLY DONE - YOU HAVE AN UNTESTED SQL STORED PROCEDURE
	            //Make the button pass the arg ID
	        case "useInstead": 
	        	$existing = $_POST["useInstead"]; 
	            $type = $_POST["type"]; 
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL useInstead(\"".$type."\",".$argAtHand.",".$existing.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
	            break;
	        case "becauseUseInstead": 
	        	$existing = $_POST["becauseUseInstead"]; 
	            $type = "Because";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL useInstead(\"".$type."\",".$argAtHand.",".$existing.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
            	break;

    			//Replace user's existing preferred putforth if they are its only endorser
            case "replacePutForth":
            	$phrased = $_POST["replacement"];
            	$phraseID = $_POST["userPhraseID"]; 
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL replacePutForth(".$argAtHand.",".$profileID.",".$phraseID.",\"".$phrased."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
	            break;
			case "newExplication":
				$phrased = $_POST["newExplication"]; 
				$argAtHand = intval($_SESSION['currentArg']);
				$profileID = intval($_SESSION['profile']);
				$query = "CALL newExplication(".$argAtHand.",".$profileID.",\"".$phrased."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
				break;

	    }
?>