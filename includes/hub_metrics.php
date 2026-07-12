<?php
// includes/hub_metrics.php — hub-argument detection for the share card.
//
// A "hub" is an argument that indexes engagement rather than hosting it:
// opinions concentrate on its Therefore children (e.g. arg 1963's 2028
// candidate slate), not on the argument itself or its Because/Rebuttal side.
// When an argument is a hub, the share card highlights the Therefore fan-out
// instead of the default strongest-Because / strongest-Rebuttal dialectic.
//
// Conditions (all must hold), designed to stay valid at scale:
//   H1 substance:         T >= 25 opinions summed across Therefore children
//   H2 dormant dialectic: D < 25 OR T >= 8*D
//                         (D = opinions summed across Because+Rebuttal children;
//                          absolutely small today, or dwarfed at scale)
//   H3 breadth:           effective engaged children T^2/sum(t_i^2) >= 4 —
//                         a field of positions, not one blockbuster chain
//   H4 index test:        T >= 2*S (S = opinions on the hub argument itself);
//                         the children collectively out-engage the venue
//
// Persona opinions count on purpose: personas seed all three types evenly, so
// they cannot fake the lopsidedness H2–H4 require, and they retire as human
// engagement grows — the metric converges to human-only at scale.

function hubMetrics($db, $argID) {
	$h = ['fires' => false, 'T' => 0, 'D' => 0, 'S' => 0, 'kids' => 0, 'top' => []];
	if ($argID <= 0) return $h;

	$res = mysqli_query($db,
		"SELECT
			SUM(IF(x.endorseType = 'Therefore', x.ops, 0)),
			SUM(IF(x.endorseType <> 'Therefore', x.ops, 0)),
			SUM(IF(x.endorseType = 'Therefore', x.ops * x.ops, 0)),
			SUM(IF(x.endorseType = 'Therefore', 1, 0)),
			(SELECT COUNT(*) FROM OPINION WHERE argumentID = $argID)
		 FROM (
			SELECT DISTINCT e.endorseType, e.supportingArgID,
				   (SELECT COUNT(*) FROM OPINION o WHERE o.argumentID = e.supportingArgID) AS ops
			FROM ENDORSEMENT e
			WHERE e.targArgID = $argID AND e.active = 1
		 ) x");
	if (!$res || !($row = mysqli_fetch_row($res))) return $h;

	$T   = (int) $row[0];
	$D   = (int) $row[1];
	$Tsq = (int) $row[2];
	$h['T']    = $T;
	$h['D']    = $D;
	$h['kids'] = (int) $row[3];
	$h['S']    = (int) $row[4];

	$h['fires'] = $T >= 25
		&& ($D < 25 || $T >= 8 * $D)
		&& $T * $T >= 4 * max($Tsq, 1)
		&& $T >= 2 * $h['S'];

	if ($h['fires']) {
		$tRes = mysqli_query($db,
			"SELECT e.supportingArgID, a.currentPhrasing,
					(SELECT COUNT(*) FROM OPINION o WHERE o.argumentID = e.supportingArgID) AS ops
			 FROM ENDORSEMENT e
			 JOIN ARGUMENT a ON a.argumentID = e.supportingArgID
			 WHERE e.targArgID = $argID AND e.endorseType = 'Therefore' AND e.active = 1
			 GROUP BY e.supportingArgID, a.currentPhrasing
			 ORDER BY ops DESC, e.supportingArgID ASC
			 LIMIT 5");
		while ($tRes && ($tRow = mysqli_fetch_row($tRes))) {
			$h['top'][] = [
				'argID'    => (int) $tRow[0],
				'phrasing' => (string) $tRow[1],
				'ops'      => (int) $tRow[2],
			];
		}
	}
	return $h;
}
