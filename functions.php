<?php
	require_once(__DIR__ . '/includes/negotiable_term.php');

	// Queue an existing argument for bot seeding when a genuine external human
	// (non-admin, non-persona) forms an opinion on it. parentArgID is NULL — a
	// direct human opinion on an existing argument is itself the validation
	// signal, so no parent-engagement gate applies. The conditional INSERT
	// self-filters: only fires for non-admin real users, and only if the arg
	// isn't already queued/seeded.
	function queueOpinionForSeeding($db, $argID, $profileID) {
		$argID     = intval($argID);
		$profileID = intval($profileID);
		if ($profileID <= 26) return; // bot persona — never queue
		mysqli_query($db,
			"INSERT INTO BOT_SEED_QUEUE
			     (argumentID, createdBy, parentArgID, parentWeight, endorseType, queuedAt)
			 SELECT $argID, $profileID, NULL, NULL, NULL, NOW()
			 FROM USER_PROFILE u
			 WHERE u.profileID = $profileID AND u.isAdmin = 0
			   AND EXISTS (SELECT 1 FROM AFFILIATION a
			               WHERE a.affiliationID = u.activeAffiliationID AND a.public = 1)
			   AND NOT EXISTS (SELECT 1 FROM ARGUMENT arg
			                   WHERE arg.argumentID = $argID AND arg.hasNegotiableTerm = 1)
			   AND NOT EXISTS (SELECT 1 FROM BOT_SEED_QUEUE q
			                   WHERE q.argumentID = $argID
			                     AND q.status IN ('pending','processing','done'))
			   AND NOT EXISTS (SELECT 1 FROM OPINION o
			                   WHERE o.argumentID = $argID AND o.profileID <= 26)"
		);
	}

	if(isset($_SESSION['profile'])){
		switch ($_POST["buttonClicked"]) {
	        case "accept":
	            $opinion=1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
				queueOpinionForSeeding($db, $param2, $param3);
				header('Location: /?arg='.$_SESSION['currentArg']);
	            break;
	        case "reject":
	            $opinion=-1;
	            $param1 = $opinion;
	            $param2 = $_SESSION['currentArg'];
	            $param3 = $_SESSION['profile'];
				$sql = "CALL assertOpinion($param1,$param2,$param3)";
				mysqli_query($db, $sql);
				queueOpinionForSeeding($db, $param2, $param3);
				header('Location: /?arg='.$_SESSION['currentArg']);
	            break;
	        case "weighBecause":
	        	$arrayOfWeighIns = explode(",",$_POST["becauseWeighInWith"]);
	            $type = "Because";
	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);
	            $query = "CALL prepareForNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";

				$impliedAccepts = "";
				for ($i = 0; $i < (count($arrayOfWeighIns)-2); $i+=2) {
					$supportArgVal = intval($arrayOfWeighIns[$i]);
					$weightVal = floatval($arrayOfWeighIns[$i+1]);
					$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
					// Using an argument as a support implies acceptance of it.
					if ($supportArgVal > 0 && $weightVal > 0) {
						$impliedAccepts .= "CALL assertOpinion(1,".$supportArgVal.",".$profileID.");";
					}
				}
				$query .= "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES(".$profileID.",".$argAtHand.",@active_aff_id);";
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";
				// Apply implied acceptance AFTER the inserts/resolve so each opinion
				// flip's ENDORSEMENT updates run outside the insert trigger. Runs at
				// commit (Endorse) and overrides any prior rejection of a support.
				$query .= $impliedAccepts;

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

				$impliedAccepts = "";
				for ($i = 0; $i < (count($arrayOfWeighIns)-2); $i+=2) {
					$supportArgVal = intval($arrayOfWeighIns[$i]);
					$weightVal = floatval($arrayOfWeighIns[$i+1]);
					$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
					// Using an argument as a support implies acceptance of it.
					if ($supportArgVal > 0 && $weightVal > 0) {
						$impliedAccepts .= "CALL assertOpinion(1,".$supportArgVal.",".$profileID.");";
					}
				}
				$query .= "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES(".$profileID.",".$argAtHand.",@active_aff_id);";
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";
				// Apply implied acceptance AFTER the inserts/resolve so each opinion
				// flip's ENDORSEMENT updates run outside the insert trigger. Runs at
				// commit (Endorse) and overrides any prior rejection of a support.
				$query .= $impliedAccepts;

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
				$impliedAccepts = "";
				for ($i = 0; $i < (count($arrayOfWeighIns)-2); $i+=2) {
					$supportArgVal = intval($arrayOfWeighIns[$i]);
					$weightVal = floatval($arrayOfWeighIns[$i+1]);
					$query .= "INSERT INTO ENDORSEMENT VALUES(".$argAtHand.",".$profileID.",\"".$type."\",".$supportArgVal.",".$weightVal.",CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,TRUE);";
					// Using an argument as a support implies acceptance of it.
					if ($supportArgVal > 0 && $weightVal > 0) {
						$impliedAccepts .= "CALL assertOpinion(1,".$supportArgVal.",".$profileID.");";
					}
				}
				$query .= "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES(".$profileID.",".$argAtHand.",@active_aff_id);";
				$query .= "CALL resolveOldWithNewEndorse(\"".$type."\",".$argAtHand.",".$profileID.");";
				// Apply implied acceptance AFTER the inserts/resolve so each opinion
				// flip's ENDORSEMENT updates run outside the insert trigger. Runs at
				// commit (Endorse) and overrides any prior rejection of a support.
				$query .= $impliedAccepts;

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
					// Queue new argument for bot seeding. foldInAssertion creates the
					// argument internally so we retrieve it by creator recency.
					$safeType = mysqli_real_escape_string($db, $type);
					$newRow = mysqli_fetch_row(mysqli_query($db,
						"SELECT argumentID FROM ARGUMENT
						 WHERE createdBy = $profileID
						 ORDER BY createdDate DESC LIMIT 1"
					));
					if ($newRow) {
						mysqli_query($db,
							"INSERT INTO BOT_SEED_QUEUE
							     (argumentID, createdBy, parentArgID, endorseType)
							 VALUES (" . intval($newRow[0]) . ", $profileID, $argAtHand, '$safeType')"
						);
					}
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
					// Queue new argument for bot seeding (same pattern as addAssertion).
					$safeType = mysqli_real_escape_string($db, $type);
					$newRow = mysqli_fetch_row(mysqli_query($db,
						"SELECT argumentID FROM ARGUMENT
						 WHERE createdBy = $profileID
						 ORDER BY createdDate DESC LIMIT 1"
					));
					if ($newRow) {
						mysqli_query($db,
							"INSERT INTO BOT_SEED_QUEUE
							     (argumentID, createdBy, parentArgID, endorseType)
							 VALUES (" . intval($newRow[0]) . ", $profileID, $argAtHand, '$safeType')"
						);
					}
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
					mysqli_query($db, "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES($profileID, $argAtHand, @active_aff_id)");
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
					mysqli_query($db, "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES($profileID, $argAtHand, @active_aff_id)");
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
					mysqli_query($db, "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES($profileID, $argAtHand, @active_aff_id)");
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
					mysqli_query($db, "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES($profileID, $argAtHand, @active_aff_id)");
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
					mysqli_query($db, "INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES($profileID, $argAtHand, @active_aff_id)");
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
				$query .= "INSERT IGNORE INTO SCOPE_PHRASE_ENDORSE (profileID, argumentID, affiliationID) VALUES(".$profileID.",".$argAtHand.",@active_aff_id);";
				$query .= "CALL updatePhrasingCache(".$argAtHand.");";
				if(mysqli_multi_query($db, $query)){
					header('Location: /?arg='.$_SESSION['currentArg']);
				}
				else
					echo "Query Failed";
            	break;

            case "weighTerm":
                $argAtHand = intval($_SESSION['currentArg']);
                $profileID = intval($_SESSION['profile']);
                $rawVal    = $_POST['termValue'] ?? '';
                if (!is_numeric($rawVal)) { header('Location: /?arg='.$argAtHand); exit; }
                // Resolve the argument's term (must exist and be a term-bearing arg).
                $termID = null;
                $tRes = mysqli_query($db, "SELECT termID FROM NEGOTIABLE_TERM WHERE argumentID = ".$argAtHand);
                if ($tRes && ($tRow = mysqli_fetch_row($tRes))) { $termID = intval($tRow[0]); mysqli_free_result($tRes); }
                if ($termID === null) { header('Location: /?arg='.$argAtHand); exit; }
                $val = sprintf('%.8F', floatval($rawVal)); // fixed decimal, no scientific notation
                // Stating a value implies acceptance; then swap the user's active value.
                $query  = "CALL assertOpinion(1,".$argAtHand.",".$profileID.");";
                $query .= "CALL prepareForNewTermValue(".$argAtHand.",".$profileID.");";
                $query .= "INSERT INTO TERM_VALUE (argumentID, termID, profileID, value, active) VALUES(".$argAtHand.",".$termID.",".$profileID.",".$val.",TRUE);";
                $query .= "INSERT IGNORE INTO SCOPE_TERM_VALUE (profileID, argumentID, affiliationID) VALUES(".$profileID.",".$argAtHand.",@active_aff_id);";
                $query .= "CALL updateTermCache(".$argAtHand.");";
                if (mysqli_multi_query($db, $query)) {
                    do { if ($r = mysqli_store_result($db)) mysqli_free_result($r); } while (mysqli_more_results($db) && mysqli_next_result($db));
                    header('Location: /?arg='.$argAtHand);
                } else {
                    echo "Query Failed";
                }
                break;

            case "newPutForth":
            	$phrased = trim($_POST["newPutForth"] ?? '');
            	$argAtHand = intval($_SESSION['currentArg']);
            	// Negotiable-term integrity: an NT argument's phrasings MUST carry the
            	// [[value]] token exactly once; a non-term argument's must carry none.
            	$isNTarg = false;
            	if ($ntChk = mysqli_query($db, "SELECT hasNegotiableTerm FROM ARGUMENT WHERE argumentID = ".$argAtHand)) {
            		if ($ntRow = mysqli_fetch_row($ntChk)) { $isNTarg = (intval($ntRow[0]) === 1); }
            		mysqli_free_result($ntChk);
            	}
            	if (!$isNTarg && strpos($phrased, NT_TOKEN) !== false) {
            		$phrased = trim(nt_strip_token($phrased)); // strip a stray token off a plain arg
            	}
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
            	} elseif ($isNTarg && substr_count($phrased, NT_TOKEN) !== 1) {
            		$phrasingError = 'This argument has a negotiable term — its phrasing must include the value placeholder [[value]] exactly once.';
            	}
            	if ($phrasingError) {
            		$_SESSION['formError'] = $phrasingError;
            		header('Location: /?arg='.$_SESSION['currentArg']);
            		exit;
            	}
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
	            $argAtHand   = intval($_SESSION['currentArg']);
	            $profileID   = intval($_SESSION['profile']);
	            $phraseID    = intval($_POST["userPhraseID"] ?? 0);
	            $replacement = trim($_POST["replacement"] ?? '');
	            // Negotiable-term integrity guard (mirrors newPutForth).
	            $isNTarg = false;
	            if ($ntChk = mysqli_query($db, "SELECT hasNegotiableTerm FROM ARGUMENT WHERE argumentID = ".$argAtHand)) {
	            	if ($ntRow = mysqli_fetch_row($ntChk)) { $isNTarg = (intval($ntRow[0]) === 1); }
	            	mysqli_free_result($ntChk);
	            }
	            if (!$isNTarg && strpos($replacement, NT_TOKEN) !== false) {
	            	$replacement = trim(nt_strip_token($replacement));
	            }
	            if ($isNTarg && substr_count($replacement, NT_TOKEN) !== 1) {
	            	$_SESSION['formError'] = 'This argument has a negotiable term — its phrasing must include the value placeholder [[value]] exactly once.';
	            	header('Location: /?arg='.$argAtHand);
	            	exit;
	            }
	            $phrased = mysqli_real_escape_string($db, $replacement);
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
	        	$query .= "INSERT IGNORE INTO SCOPE_EXPLICATION_ENDORSE (profileID, argumentID, affiliationID) VALUES(" . $profileID . "," . $argAtHand . ",@active_aff_id);";
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
					// promoteExplication() creates the creator's EXPLICATION_ENDORSE
					// row itself, so we only fetch the id here for OG metadata.
					// (Do NOT insert another endorse row — that double-counts weight.)
					$idRow = mysqli_fetch_row(mysqli_query($db, "SELECT explicationID FROM EXPLICATION WHERE argumentID=$argAtHand AND profileID=$profileID LIMIT 1"));
					if ($idRow) {
						storeOgMeta($db, $explicationLink, intval($idRow[0]));
					}
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

		case "flagArgument":
			$argAtHand = intval($_SESSION['currentArg']);
			$profileID = intval($_SESSION['profile']);
			$category  = $_POST['flagCategory'] ?? '';
			$comment   = trim($_POST['flagComment'] ?? '');
			$allowedCats = ['offensive','phrasing_mismatch','duplicate_assoc','spam','incoherent','other'];
			if (!in_array($category, $allowedCats, true)) {
				$_SESSION['formError'] = 'Please choose a reason for flagging this argument.';
				header('Location: /?arg=' . $argAtHand);
				exit;
			}
			if ($category === 'other' && $comment === '') {
				$_SESSION['formError'] = 'Please add a comment explaining the issue.';
				header('Location: /?arg=' . $argAtHand);
				exit;
			}
			if (mb_strlen($comment) > 300) { $comment = mb_substr($comment, 0, 300); }
			$query = "CALL flagArgument($argAtHand, $profileID, \"" .
				mysqli_real_escape_string($db, $category) . "\", \"" .
				mysqli_real_escape_string($db, $comment) . "\")";
			mysqli_query($db, $query);
			header('Location: /?arg=' . $argAtHand);
			exit;

		case "unflagArgument":
			$argAtHand = intval($_SESSION['currentArg']);
			$profileID = intval($_SESSION['profile']);
			mysqli_query($db, "CALL unflagArgument($argAtHand, $profileID)");
			header('Location: /?arg=' . $argAtHand);
			exit;

		case "adminSwitchProfile":
			if (isset($_SESSION['isAdmin']) && $_SESSION['isAdmin']) {
				$switchTo      = intval($_POST['pickerProfile'] ?? 0);
				$realProfileID = intval($_SESSION['realProfile']);
				// Validate against the active picker mode.
				$settRow = mysqli_fetch_assoc(mysqli_query($db,
					"SELECT pickerType, pickerProfiles FROM ADMIN_SETTINGS WHERE profileID=$realProfileID"));
				$pickerType = $settRow ? ($settRow['pickerType'] ?? 'none') : 'none';
				$ok = false;
				if ($switchTo === $realProfileID) {
					$ok = true; // always allowed to return to own profile
				} elseif ($pickerType === 'manual') {
					$allowed = ($settRow && $settRow['pickerProfiles'])
						? array_map('intval', explode(',', $settRow['pickerProfiles'])) : [];
					$ok = in_array($switchTo, $allowed, true);
				} elseif ($pickerType === 'auto' || $pickerType === 'all') {
					// Personas (IDs 1-26) only; never switch to a real (non-persona) user.
					$ok = ($switchTo >= 1 && $switchTo <= 26);
				}
				if ($ok) {
					$_SESSION['profile'] = $switchTo;
				}
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "addOpinionFilter":
			if (!isset($_SESSION['filters'])) $_SESSION['filters'] = ['opinions' => [], 'affiliations' => []];
			$fArgID = intval($_POST['argumentID'] ?? 0);
			$fAccept = intval($_POST['acceptance'] ?? -1);
			if ($fArgID > 0 && ($fAccept === 0 || $fAccept === 1)) {
				foreach ($_SESSION['filters']['opinions'] as $existing) {
					if (intval($existing['argumentID']) === $fArgID) {
						goto skipOpinionAdd;
					}
				}
				$_SESSION['filters']['opinions'][] = ['argumentID' => $fArgID, 'acceptance' => $fAccept];
				skipOpinionAdd:
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "removeOpinionFilter":
			if (isset($_SESSION['filters']['opinions'])) {
				$rArgID = intval($_POST['argumentID'] ?? 0);
				$_SESSION['filters']['opinions'] = array_values(array_filter(
					$_SESSION['filters']['opinions'],
					fn($o) => intval($o['argumentID']) !== $rArgID
				));
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "addAffiliationFilter":
			if (!isset($_SESSION['filters'])) $_SESSION['filters'] = ['opinions' => [], 'affiliations' => []];
			$affID = intval($_POST['affiliationID'] ?? 0);
			if ($affID > 0 && !in_array($affID, $_SESSION['filters']['affiliations'], true)) {
				$affPubRow = mysqli_fetch_row(mysqli_query($db,
					"SELECT public FROM AFFILIATION WHERE affiliationID = $affID LIMIT 1"
				));
				if ($affPubRow && intval($affPubRow[0]) === 1) {
					$_SESSION['filters']['affiliations'][] = $affID;
				} else {
					// Private group — only allow via auto-apply (operating-as switch)
					$realPID = intval($_SESSION['realProfile'] ?? $_SESSION['profile'] ?? 0);
					$activeRow = mysqli_fetch_row(mysqli_query($db,
						"SELECT activeAffiliationID FROM USER_PROFILE WHERE profileID = $realPID LIMIT 1"
					));
					if ($activeRow && intval($activeRow[0]) === $affID) {
						$_SESSION['filters']['affiliations'][] = $affID;
					}
				}
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "removeAffiliationFilter":
			if (isset($_SESSION['filters']['affiliations'])) {
				$rAffID = intval($_POST['affiliationID'] ?? 0);
				$_SESSION['filters']['affiliations'] = array_values(array_filter(
					$_SESSION['filters']['affiliations'],
					fn($a) => $a !== $rAffID
				));
				if (isset($_SESSION['filters']['auto_aff_id']) &&
					intval($_SESSION['filters']['auto_aff_id']) === $rAffID) {
					unset($_SESSION['filters']['auto_aff_id']);
				}
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "setTimeFilter":
			if (!isset($_SESSION['filters'])) $_SESSION['filters'] = ['opinions' => [], 'affiliations' => []];
			$tDir = (($_POST['timeDirection'] ?? 'before') === 'after') ? 'after' : 'before';
			$tDate = $_POST['timeDate'] ?? '';
			if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $tDate)) {
				$_SESSION['filters']['time'] = ['direction' => $tDir, 'date' => $tDate];
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "clearTimeFilter":
			if (isset($_SESSION['filters'])) unset($_SESSION['filters']['time']);
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "clearAllFilters":
			unset($_SESSION['filters']);
			header('Location: /?arg=' . intval($_SESSION['currentArg']));
			exit;

		case "switchGroup":
			$newAffID      = intval($_POST['affiliationID'] ?? 0);
			$realProfileID = intval($_SESSION['realProfile'] ?? $_SESSION['profile']);
			if ($newAffID > 0 && $realProfileID > 0) {
				$chk = $db->prepare(
					"SELECT 1 FROM MEMBER WHERE affiliationID = ? AND profileID = ? LIMIT 1"
				);
				$chk->bind_param("ii", $newAffID, $realProfileID);
				$chk->execute();
				$isMember = (bool) $chk->get_result()->fetch_row();
				$chk->close();
				if ($isMember) {
					$upd = $db->prepare(
						"UPDATE USER_PROFILE SET activeAffiliationID = ? WHERE profileID = ?"
					);
					$upd->bind_param("ii", $newAffID, $realProfileID);
					$upd->execute();
					$upd->close();
					// Auto-apply the new group as the filter view. All Users - Public is the
					// universal default — switching back to it clears the group filter instead.
					if (!isset($_SESSION['filters'])) {
						$_SESSION['filters'] = ['opinions' => [], 'affiliations' => []];
					}
					$prevAutoAff = intval($_SESSION['filters']['auto_aff_id'] ?? 0);
					if ($prevAutoAff > 0) {
						$_SESSION['filters']['affiliations'] = array_values(array_filter(
							$_SESSION['filters']['affiliations'] ?? [],
							fn($a) => $a !== $prevAutoAff
						));
					}
					if ($newAffID !== ALL_PUBLIC_AFF_ID) {
						if (!in_array($newAffID, $_SESSION['filters']['affiliations'] ?? [], true)) {
							$_SESSION['filters']['affiliations'][] = $newAffID;
						}
						$_SESSION['filters']['auto_aff_id'] = $newAffID;
					} else {
						unset($_SESSION['filters']['auto_aff_id']);
					}
				}
			}
			header('Location: /?arg=' . intval($_SESSION['currentArg'] ?? 75));
			exit;

	    }
	}

?>