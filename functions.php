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
	        	$assertion = mysqli_real_escape_string($db,trim($_POST["assertion"]));
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
			case "addAssertionAndReciprocate":
				$assertion = mysqli_real_escape_string($db,trim($_POST["assertion"]));
				$type = $_POST["type"];
				$argAtHand = intval($_SESSION['currentArg']);
				$profileID = intval($_SESSION['profile']);
				$query = "CALL foldAndReciprocate(\"".$assertion."\",\"".$type."\",".$argAtHand.",".$profileID.");";

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
			case "useInsteadAndReciprocate": 
				$existing = $_POST["useInstead"]; 
				$type = $_POST["type"]; 
				$argAtHand = intval($_SESSION['currentArg']);
				$profileID = intval($_SESSION['profile']);
				$query = "CALL useInsteadAndReciprocate(\"".$type."\",".$argAtHand.",".$existing.",".$profileID.");";

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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else
					echo "Query Failed";
            	break;

            case "newPutForth":
            	$phrased = mysqli_real_escape_string($db,trim($_POST["newPutForth"]));
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
            	$phrased = mysqli_real_escape_string($db,trim($_POST["replacement"]));
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
	        		header('Location: /index.php?arg=' . $_SESSION['currentArg']);
	        	} else {
	        		echo "Query Failed";
	        	}
	        	break;

	            //Promote explication TODO Sucks because just pushing the full link string when should have a int key
	        case "promoteExplication":
	        	$explicationLink = $_POST["promoteExplication"];

	            $argAtHand = intval($_SESSION['currentArg']);
	            $profileID = intval($_SESSION['profile']);

	            $query = "CALL promoteExplication(".$argAtHand.",".$profileID.",\"".mysqli_real_escape_string($db, $explicationLink)."\");";

				/*Execute queries */
				if(mysqli_query($db, $query)){
					$idRow = mysqli_fetch_row(mysqli_query($db, "SELECT explicationID FROM EXPLICATION WHERE argumentID=$argAtHand AND profileID=$profileID LIMIT 1"));
					if ($idRow) storeOgMeta($db, $explicationLink, $idRow[0]);
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
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
					header('Location: /index.php?arg='.$_SESSION['currentArg']);
				}
				else 
					echo "Query Failed";
				break;

	    }
	}

function fetchOgMeta($url) {
	$meta = ['title' => null, 'image' => null, 'description' => null];
	if (!filter_var($url, FILTER_VALIDATE_URL)) return $meta;

	$ch = curl_init();
	curl_setopt_array($ch, [
		CURLOPT_URL            => $url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_MAXREDIRS      => 3,
		CURLOPT_TIMEOUT        => 6,
		CURLOPT_CONNECTTIMEOUT => 4,
		CURLOPT_USERAGENT      => 'Mozilla/5.0 (compatible; Vestigette/1.0; +https://vestigette.com)',
		CURLOPT_SSL_VERIFYPEER => false,
		CURLOPT_HTTPHEADER     => ['Accept: text/html'],
	]);
	$html = curl_exec($ch);
	curl_close($ch);
	if (!$html) return $meta;

	// og: tags — try content-before-property order too (some sites swap them)
	$patterns = [
		'title'       => '/<meta[^>]+property=["\']og:title["\'][^>]+content=["\'](.*?)["\']/is',
		'title_rev'   => '/<meta[^>]+content=["\'](.*?)["\'][^>]+property=["\']og:title["\']/is',
		'image'       => '/<meta[^>]+property=["\']og:image["\'][^>]+content=["\'](.*?)["\']/is',
		'image_rev'   => '/<meta[^>]+content=["\'](.*?)["\'][^>]+property=["\']og:image["\']/is',
		'desc'        => '/<meta[^>]+property=["\']og:description["\'][^>]+content=["\'](.*?)["\']/is',
		'desc_rev'    => '/<meta[^>]+content=["\'](.*?)["\'][^>]+property=["\']og:description["\']/is',
	];

	if (preg_match($patterns['title'], $html, $m) || preg_match($patterns['title_rev'], $html, $m))
		$meta['title'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');
	if (preg_match($patterns['image'], $html, $m) || preg_match($patterns['image_rev'], $html, $m))
		$meta['image'] = trim($m[1]);
	if (preg_match($patterns['desc'], $html, $m) || preg_match($patterns['desc_rev'], $html, $m))
		$meta['description'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');

	// Fallbacks for pages without OG tags
	if (!$meta['title'] && preg_match('/<title[^>]*>(.*?)<\/title>/is', $html, $m))
		$meta['title'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');
	if (!$meta['description'] && preg_match('/<meta[^>]+name=["\']description["\'][^>]+content=["\'](.*?)["\']/is', $html, $m))
		$meta['description'] = html_entity_decode(trim($m[1]), ENT_QUOTES | ENT_HTML5, 'UTF-8');

	return $meta;
}

function storeOgMeta($db, $url, $explicationID) {
	$og = fetchOgMeta($url);
	$id = intval($explicationID);
	$t  = mysqli_real_escape_string($db, mb_substr($og['title'] ?? '', 0, 300));
	$i  = mysqli_real_escape_string($db, mb_substr($og['image'] ?? '', 0, 500));
	$d  = mysqli_real_escape_string($db, $og['description'] ?? '');
	mysqli_query($db, "UPDATE EXPLICATION SET og_title='$t', og_image='$i', og_description='$d', og_fetched_at=NOW() WHERE explicationID=$id");
}
?>