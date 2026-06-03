<?php
	if(isset($_SESSION['profile'])){
		switch ($_POST["buttonClicked"]) {
	        case "accept":
	            $opinion=1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
				header('Location: /?arg='.$_SESSION['currentArg']);	
	            break;
	        case "reject":
	            $opinion=-1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
				header('Location: /?arg='.$_SESSION['currentArg']);
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
					while (mysqli_more_results($db)) { mysqli_next_result($db); if ($r = mysqli_store_result($db)) mysqli_free_result($r); }
					header('Location: /?arg='.$_SESSION['currentArg']);
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
					$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
				}
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";

				/*Execute queries */
				if(mysqli_multi_query($db, $query)){
					while (mysqli_more_results($db)) { mysqli_next_result($db); if ($r = mysqli_store_result($db)) mysqli_free_result($r); }
					header('Location: /?arg='.$_SESSION['currentArg']);
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
					$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
				}
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";

				/*Execute queries */
				if(mysqli_multi_query($db, $query)){
					while (mysqli_more_results($db)) { mysqli_next_result($db); if ($r = mysqli_store_result($db)) mysqli_free_result($r); }
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else
					echo "Query Failed";

	            break;
	        case "addAssertion":
	        	$assertion = mysqli_real_escape_string($db,trim($_POST["assertion"]));
	            $type = $_POST["type"];
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL foldInAssertion(\"".$assertion."\",\"".$type."\",".$argAtHand.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
				
	            break;
			case "addAssertionAndReciprocate":
				$assertion = mysqli_real_escape_string($db,trim($_POST["assertion"]));
				$type = $_POST["type"];
				$argAtHand = intval($_SESSION['currentArg']);
				$profileID = intval($_SESSION['profile']);
				$query = "CALL foldAndReciprocate(\"".$assertion."\",\"".$type."\",".$argAtHand.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
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
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
	            break;
			case "useInsteadAndReciprocate": 
				$existing = $_POST["useInstead"]; 
				$type = $_POST["type"]; 
				$argAtHand = intval($_SESSION['currentArg']);
				$profileID = intval($_SESSION['profile']);
				$query = "CALL useInsteadAndReciprocate(\"".$type."\",".$argAtHand.",".$existing.",".$profileID.");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
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
					header('Location: /?arg='.$_SESSION['currentArg']);
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
					header('Location: /?arg='.$_SESSION['currentArg']);
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
					header('Location: /?arg='.$_SESSION['currentArg']);
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
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
				
            	break;
	            //Submit a new way of putting forth - TODO Likely no different than promote. remove until data schema changes
            case "weighPhrasing":
            	$arrayOfWeighIns = explode(",",$_POST["phrasingWeighInWith"]);
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL prepareForNewPhrasingEndorse(".$argAtHand.",".$profileID.");";
				for ($i = 0; $i < (count($arrayOfWeighIns)-2); $i+=2) {
					$phrasingIDVal = intval($arrayOfWeighIns[$i]);
					$weightVal = floatval($arrayOfWeighIns[$i+1]);
					$query .= "INSERT INTO PHRASE_ENDORSE (argumentID, profileID, phrasingID, weight, active) VALUES(".$argAtHand.",".$profileID.",".$phrasingIDVal.",".$weightVal.",TRUE);";
				}
				$query .= "CALL updatePhrasingCache(".$argAtHand.");";
				if(mysqli_multi_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else
					echo "Query Failed";
            	break;

            case "newPutForth":
            	$phrased = trim($_POST["newPutForth"] ?? '');
            	// Server-side validation: must be human-readable text, not a URL or HTML
            	$phrasingError = null;
            	if (strlen($phrased) < 5) {
            		$phrasingError = 'Phrasing is too short — write it out as a complete sentence.';
            	} elseif (strlen($phrased) > 300) {
            		$phrasingError = 'Phrasing must be 300 characters or less.';
            	} elseif (preg_match('#^https?://#i', $phrased) || preg_match('#^www\.#i', $phrased)) {
            		$phrasingError = 'Phrasings should be human-readable text, not a URL. Use the Explication section to add links.';
            	} elseif (preg_match('/<[a-zA-Z][\s\S]*>/u', $phrased)) {
            		$phrasingError = 'HTML tags are not allowed in phrasings.';
            	} elseif (!preg_match('/[a-zA-Z\x{00C0}-\x{024F}]/u', $phrased)) {
            		$phrasingError = 'Phrasings must contain readable text with letters.';
            	}
            	if ($phrasingError) {
            		$_SESSION['formError'] = $phrasingError;
            		header('Location: /?arg='.$_SESSION['currentArg']);
            		exit;
            	}
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $phrased = mysqli_real_escape_string($db, $phrased);
	            $query = "CALL newPutForth(".$argAtHand.",".$profileID.",\"".$phrased."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else
					echo "Query Failed";
            	break;

    			//Replace user's existing preferred putforth if they are its only endorser
            case "replacePutForth":
            	$phrased = mysqli_real_escape_string($db,trim($_POST["replacement"]));
            	$phraseID = $_POST["userPhraseID"]; 
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL replacePutForth(".$argAtHand.",".$profileID.",".$phraseID.",\"".$phrased."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
            	break;

	        case "weighExplication":
	        	$arrayOfWeighIns = explode(",", $_POST["explicWeighInWith"]);
	        	$argAtHand = intval($_SESSION['currentArg']);
	        	$profileID = intval($_SESSION['profile']);
	        	$query = "CALL prepareForNewExplicationEndorse(" . $argAtHand . "," . $profileID . ");";
	        	for ($i = 0; $i < (count($arrayOfWeighIns) - 2); $i += 2) {
	        		$explicationIDVal = intval($arrayOfWeighIns[$i]);
	        		$weightVal = floatval($arrayOfWeighIns[$i + 1]);
	        		$query .= "INSERT INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES(" . $explicationIDVal . "," . $argAtHand . "," . $profileID . "," . $weightVal . ",TRUE);";
	        	}
	        	if (mysqli_multi_query($db, $query)) {
	        		header('Location: /?arg=' . $_SESSION['currentArg']);
	        	} else {
	        		echo "Query Failed";
	        	}
	        	break;

	            //Promote explication TODO Sucks because just pushing the full link string when should have a int key
	        case "promoteExplication":
	        	$explicationLink = trim($_POST["promoteExplication"] ?? '');
	        	// Server-side validation: must be a valid http/https URL
	        	if (!preg_match('#^https?://#i', $explicationLink) || !filter_var($explicationLink, FILTER_VALIDATE_URL)) {
	        		$_SESSION['formError'] = 'Explications must be a valid URL starting with https:// or http://';
	        		header('Location: /?arg='.$_SESSION['currentArg']);
	        		exit;
	        	}

	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);

	            $query = "CALL promoteExplication(".$argAtHand.",".$profileID.",\"".mysqli_real_escape_string($db, $explicationLink)."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					$idRow = mysqli_fetch_row(mysqli_query($db, "SELECT explicationID FROM EXPLICATION WHERE argumentID=$argAtHand AND profileID=$profileID LIMIT 1"));
					if ($idRow) storeOgMeta($db, $explicationLink, $idRow[0]);
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else
					echo "Query Failed";
	            break;
			case "newExplication": //may not need at all until we make the data model for explications more sophisticated.
				$phrased = trim($_POST["newExplication"]);
				$argAtHand = intval($_SESSION['currentArg']);
				$profileID = intval($_SESSION['profile']);
				$query = "CALL newExplication(".$argAtHand.",".$profileID.",\"".$phrased."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
				break;

		case "adminSwitchProfile":
			if (isset($_SESSION['isAdmin']) && $_SESSION['isAdmin']) {
				$switchTo      = intval($_POST['pickerProfile'] ?? 0);
				$realProfileID = intval($_SESSION['realProfile']);
				// Validate: must be the real profile or one of the designated profiles
				$settRow = mysqli_fetch_assoc(mysqli_query($db,
					"SELECT pickerProfiles FROM ADMIN_SETTINGS WHERE profileID=$realProfileID"));
				$allowed = [$realProfileID];
				if ($settRow && $settRow['pickerProfiles']) {
					$allowed = array_merge($allowed, array_map('intval', explode(',', $settRow['pickerProfiles'])));
				}
				if (in_array($switchTo, $allowed)) {
					$_SESSION['profile'] = $switchTo;
				}
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

	    }
	}

?>