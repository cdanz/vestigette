<?php
	$sql = "CALL getAssociated($argID);";
	$sql .= "CALL getAllTheRest();";
	$sql .= "CALL getAggrEndorse()";

	if (mysqli_multi_query($db, $sql)) {
		$result = mysqli_store_result($db);
		$assoc = array();
		if (mysqli_num_rows($result) > 0) {
			$iterator = 0;
			while ($row = mysqli_fetch_row($result)) {
				$assoc[$iterator] = array();
				$assoc[$iterator][0] = $row[1];
				$assoc[$iterator][1] = $row[2];
				$assoc[$iterator][2] = $row[3];
				$assoc[$iterator][3] = $row[4];
				$iterator++;
			}
		}
		mysqli_free_result($result);
		mysqli_next_result($db);
		mysqli_next_result($db);
		mysqli_next_result($db);
		$result = mysqli_store_result($db);
		$leftovers = array();
		if (mysqli_num_rows($result) > 0) {
			$iterator = 0;
			while ($row = mysqli_fetch_row($result)) {
				$leftovers[$iterator] = array();
				$leftovers[$iterator][0] = $row[0];
				$leftovers[$iterator][1] = $row[1];
				$leftovers[$iterator][2] = $row[2];
				$leftovers[$iterator][3] = $row[3];
				$iterator++;
			}
		}
		mysqli_free_result($result);
		mysqli_next_result($db);
		mysqli_next_result($db);
		mysqli_next_result($db);
		$result = mysqli_store_result($db);
		$bigList = array();
		if (mysqli_num_rows($result) > 0) {
			$iterator = 0;
			while ($row = mysqli_fetch_row($result)) {
				$bigList[$iterator] = array();
				$bigList[$iterator][0] = $row[0];
				$bigList[$iterator][1] = $row[1];
				$bigList[$iterator][2] = $row[2];
				$bigList[$iterator][3] = $row[3];
				$bigList[$iterator][4] = $row[4];
				$iterator++;
			}
		}
		//Clear all remaining results from multi-query if any
		while (mysqli_more_results($db)) {
			mysqli_next_result($db);
		}
	} else {
		echo "ERROR - MULTIPLE QUERIES FAILED";
	}
	$pending = array(); // argID, starting weight, phrasing
	$results = array(); // argID, greatest weight, phrasing
	if ($type == 'Because' || $type == 'Therefore') {
		$endIndex = 0; //continue to use from one loop to next
		//All associated args go into array of pending args
		foreach ($assoc as $tuple) {
			if($tuple[0] != 'Rebuttal') {
				$pending[$endIndex] = array();
				$pending[$endIndex][0] = $tuple[1];
				$pending[$endIndex][1] = $tuple[2];
				$pending[$endIndex][2] = $tuple[3];
				$endIndex++;
			}
		}
		//Any args that were supported by current arg go in pending too. 
		for ($i = 0; $i < count($bigList); $i++) {
			if ($bigList[$i][2] == $argID && $bigList[$i][1] != 'Rebuttal') {
				$pending[$endIndex] = array();
				$pending[$endIndex][0] = $bigList[$i][0];
				$pending[$endIndex][1] = $bigList[$i][2];
				$pending[$endIndex][2] = null; //TODO returned phrasing is for supporting not target will need to find phrasing elsewhere
				$endIndex++;
			}
		}
	}
	$startIndex = 0;
	while ($startIndex < count($pending)) {
		//Look through the whole bigList looking for matches on the current pending arg
		for ($i = 0; $i < count($bigList); $i++) {
			//match and not a rebuttal
			if ($pending[$startIndex][0] == $bigList[$i][0] && $bigList[$i][1] != 'Rebuttal') {
				//find weighted weight - weight to the N
				$weightN = (($pending[$startIndex][1]/100) * ($bigList[$i][3]/100)) * 100;
				//check for existing arg in the results that was just matched
				$found = false;
				for ($j = 0; $j < count($results); $j++) {
					if ($bigList[$i][2] == $results[$j][0]) {
						$found = true;
						//if found see if its existing weight is less than current
						if ($results[$j][1] < $weightN){
							$results[$j][1] = $weightN;
							$results[$j][2] = $bigList[$i][4]; //might be impossible to be null - opportunity to populate
						}
					}
				}
				//If not found then add it to results
				if (!$found) {
					$newResult = array($bigList[$i][2], $weightN, $bigList[$i][4]);
					array_push($results, $newResult);
				}
				//check for existing arg in the pending that hasn't already been processed 
				$found = false;
				for ($j = 0; $j < count($pending); $j++) { //TODO Previously j= $startIndex and not sure why I thought that was goo. set to zero fixes infinite loop.
					if ($bigList[$i][2] == $pending[$j][0]) {
						$found = true;
						//if found see if its existing weight is less than current
						if ($pending[$j][1] < $weightN){
							$pending[$j][1] = $weightN;
							$pending[$j][2] = $bigList[$i][4];
						}
					}
				}
				//If not found then add it to results
				if (!$found) {
					$newResult = array($bigList[$i][2], $weightN, $bigList[$i][4]);
					array_push($pending, $newResult);
					$endIndex++;
				}
			}
		}
		$startIndex++;
	}
	//Sort results by weight
	$weight = array(); //declare it here because there are not always results to define it
	foreach ($results as $key => $row) {
	    $weight[$key]  = $row[1];
	}
	array_multisort($weight, SORT_DESC, $results);

	//All other options. remove related leaving only unused
	for ($i = 0; $i < count($results); $i++) {
		for ($j = 0; $j < count($leftovers); $j++) {
			if (isset($results[$i][0]) && isset($leftovers[$j][0]) && $results[$i][0] == $leftovers[$j][0]){
				unset($leftovers[$j]);
				break;
			}
		}
	}

	//merge 
	$results = array_merge($results, $leftovers);
?>