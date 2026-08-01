-- getNeighborhoodAll: type-agnostic neighborhood of an argument.
--
-- The live getNeighborhood(focal, endType) proc (used by flesh_out / checkpoint)
-- scores neighbors differently depending on whether you arrive via a
-- Because/Therefore association or a Rebuttal. This proc BLENDS both: it scores
-- the supporting-chain neighbors (Because/Therefore, 1-3 hops) AND the rebuttal
-- neighbors (direct + 1-2 hops), plus co-endorsement and full-text similarity,
-- and returns only actual neighbors (proximity_score > 0), most-proximate first.
--
-- Returns: (argumentID, proximity_score, phrasing)

USE vestigette;

-- includeHop3: when 0, the two 3-edge "triple join" branches (hop-3 Because/
-- Therefore and rebuttals-of-hop-2) are gated off. Because includeHop3 is a
-- constant within the query, MySQL prunes those branches entirely (impossible
-- WHERE) so they cost nothing. Callers run with 0 first and only re-run with 1
-- to backfill when too few neighbors come back.
DROP PROCEDURE IF EXISTS getNeighborhoodAll;
DELIMITER //
CREATE PROCEDURE getNeighborhoodAll(IN focal INT UNSIGNED, IN includeHop3 TINYINT)
BEGIN
  DECLARE focal_phrasing TEXT DEFAULT NULL;

  SELECT COALESCE(
    currentPhrasing,
    (SELECT phrasing FROM PHRASING
     WHERE argumentID = focal ORDER BY createdDate ASC LIMIT 1)
  ) INTO focal_phrasing
  FROM ARGUMENT WHERE argumentID = focal;

  SET @_nb_focal = focal_phrasing;

  SELECT
    a.argumentID,
    MAX(nbr.score) AS proximity_score,
    ntPhrasing(COALESCE(
      a.currentPhrasing,
      (SELECT phrasing FROM PHRASING
       WHERE argumentID = a.argumentID ORDER BY createdDate ASC LIMIT 1)
    ), a.currentTermValue) AS phrasing
  FROM ARGUMENT a

  JOIN (

    -- hop-1 Because/Therefore neighbors
    SELECT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID, 10000 AS score
    FROM ENDORSEMENT e
    WHERE (e.targArgID = focal OR e.supportingArgID = focal)
      AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1

    UNION ALL
    -- hop-2 Because/Therefore
    SELECT IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) AS argID, 100 AS score
    FROM (
      SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
      FROM ENDORSEMENT e
      WHERE (e.targArgID = focal OR e.supportingArgID = focal)
        AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
    ) h1
    JOIN ENDORSEMENT e2
      ON (e2.targArgID = h1.argID OR e2.supportingArgID = h1.argID)
      AND e2.endorseType IN ('Because', 'Therefore') AND e2.active = 1
    WHERE IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) != focal

    UNION ALL
    -- hop-3 Because/Therefore
    SELECT IF(e3.targArgID = h2.argID, e3.supportingArgID, e3.targArgID) AS argID, 1 AS score
    FROM (
      SELECT DISTINCT IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) AS argID
      FROM (
        SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
        FROM ENDORSEMENT e
        WHERE (e.targArgID = focal OR e.supportingArgID = focal)
          AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
      ) h1
      JOIN ENDORSEMENT e2
        ON (e2.targArgID = h1.argID OR e2.supportingArgID = h1.argID)
        AND e2.endorseType IN ('Because', 'Therefore') AND e2.active = 1
      WHERE IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) != focal
    ) h2
    JOIN ENDORSEMENT e3
      ON (e3.targArgID = h2.argID OR e3.supportingArgID = h2.argID)
      AND e3.endorseType IN ('Because', 'Therefore') AND e3.active = 1
    WHERE IF(e3.targArgID = h2.argID, e3.supportingArgID, e3.targArgID) != focal
      AND includeHop3 = 1

    UNION ALL
    -- direct rebuttals of focal
    SELECT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID, 5000 AS score
    FROM ENDORSEMENT e
    WHERE (e.targArgID = focal OR e.supportingArgID = focal)
      AND e.endorseType = 'Rebuttal' AND e.active = 1

    UNION ALL
    -- rebuttals of hop-1 Because/Therefore neighbors
    SELECT IF(er.targArgID = h1r.argID, er.supportingArgID, er.targArgID) AS argID, 1000 AS score
    FROM (
      SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
      FROM ENDORSEMENT e
      WHERE (e.targArgID = focal OR e.supportingArgID = focal)
        AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
    ) h1r
    JOIN ENDORSEMENT er
      ON (er.targArgID = h1r.argID OR er.supportingArgID = h1r.argID)
      AND er.endorseType = 'Rebuttal' AND er.active = 1
    WHERE IF(er.targArgID = h1r.argID, er.supportingArgID, er.targArgID) != focal

    UNION ALL
    -- rebuttals of hop-2 Because/Therefore neighbors
    SELECT IF(er2.targArgID = h2r.argID, er2.supportingArgID, er2.targArgID) AS argID, 100 AS score
    FROM (
      SELECT DISTINCT IF(e2.targArgID = h1r2.argID, e2.supportingArgID, e2.targArgID) AS argID
      FROM (
        SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
        FROM ENDORSEMENT e
        WHERE (e.targArgID = focal OR e.supportingArgID = focal)
          AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
      ) h1r2
      JOIN ENDORSEMENT e2
        ON (e2.targArgID = h1r2.argID OR e2.supportingArgID = h1r2.argID)
        AND e2.endorseType IN ('Because', 'Therefore') AND e2.active = 1
      WHERE IF(e2.targArgID = h1r2.argID, e2.supportingArgID, e2.targArgID) != focal
    ) h2r
    JOIN ENDORSEMENT er2
      ON (er2.targArgID = h2r.argID OR er2.supportingArgID = h2r.argID)
      AND er2.endorseType = 'Rebuttal' AND er2.active = 1
    WHERE IF(er2.targArgID = h2r.argID, er2.supportingArgID, er2.targArgID) != focal
      AND includeHop3 = 1

    UNION ALL
    -- arguments whose phrasings are co-endorsed by the same users near in time
    SELECT pe2.argumentID AS argID, COUNT(DISTINCT pe1.profileID) * 5 AS score
    FROM PHRASE_ENDORSE pe1
    JOIN PHRASE_ENDORSE pe2
      ON  pe2.profileID   = pe1.profileID
      AND pe2.argumentID != focal
      AND ABS(DATEDIFF(pe2.firstVisit, pe1.firstVisit)) <= 30
    WHERE pe1.argumentID = focal
    GROUP BY pe2.argumentID

    UNION ALL
    -- full-text phrasing similarity
    SELECT a2.argumentID AS argID,
           ROUND(MATCH(a2.currentPhrasing) AGAINST (@_nb_focal IN BOOLEAN MODE) * 10) AS score
    FROM ARGUMENT a2
    WHERE a2.argumentID != focal
      AND @_nb_focal IS NOT NULL AND @_nb_focal != ''
      AND a2.currentPhrasing IS NOT NULL
      AND MATCH(a2.currentPhrasing) AGAINST (@_nb_focal IN BOOLEAN MODE) > 0

  ) nbr ON nbr.argID = a.argumentID

  WHERE a.argumentID != focal
  GROUP BY a.argumentID, a.currentPhrasing
  HAVING MAX(nbr.score) > 0
  ORDER BY MAX(nbr.score) DESC, a.argumentID ASC
  LIMIT 40;

END //
DELIMITER ;

-- ── getNeighborhood (single-type; used by flesh_out) ───────────────────────
-- Captured to the repo 2026-07-30 (was untracked). Outer phrasing wrapped in
-- ntPhrasing() for negotiable terms; focal_phrasing + MATCH seed stay raw.
DROP PROCEDURE IF EXISTS getNeighborhood;
DELIMITER //
CREATE PROCEDURE `getNeighborhood`(IN focal INT UNSIGNED, IN endType VARCHAR(20))
BEGIN
  DECLARE focal_phrasing TEXT DEFAULT NULL;

  
  SELECT COALESCE(
    currentPhrasing,
    (SELECT phrasing FROM PHRASING
     WHERE argumentID = focal ORDER BY createdDate ASC LIMIT 1)
  ) INTO focal_phrasing
  FROM ARGUMENT WHERE argumentID = focal;

  
  
  SET @_nb_focal = focal_phrasing;

  SELECT
    a.argumentID,
    COALESCE(MAX(nbr.score), 0) AS proximity_score,
    ntPhrasing(COALESCE(
      a.currentPhrasing,
      (SELECT phrasing FROM PHRASING
       WHERE argumentID = a.argumentID ORDER BY createdDate ASC LIMIT 1)
    ), a.currentTermValue) AS phrasing
  FROM ARGUMENT a

  LEFT JOIN (

    
    
    
    SELECT
      IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID,
      IF(endType = 'Rebuttal', 10, 10000) AS score
    FROM ENDORSEMENT e
    WHERE (e.targArgID = focal OR e.supportingArgID = focal)
      AND e.endorseType IN ('Because', 'Therefore')
      AND e.active = 1

    UNION ALL

    
    SELECT
      IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) AS argID,
      100 AS score
    FROM (
      SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
      FROM ENDORSEMENT e
      WHERE (e.targArgID = focal OR e.supportingArgID = focal)
        AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
    ) h1
    JOIN ENDORSEMENT e2
      ON (e2.targArgID = h1.argID OR e2.supportingArgID = h1.argID)
      AND e2.endorseType IN ('Because', 'Therefore') AND e2.active = 1
    WHERE IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) != focal
      AND endType != 'Rebuttal'

    UNION ALL

    
    SELECT
      IF(e3.targArgID = h2.argID, e3.supportingArgID, e3.targArgID) AS argID,
      1 AS score
    FROM (
      SELECT DISTINCT
        IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) AS argID
      FROM (
        SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
        FROM ENDORSEMENT e
        WHERE (e.targArgID = focal OR e.supportingArgID = focal)
          AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
      ) h1
      JOIN ENDORSEMENT e2
        ON (e2.targArgID = h1.argID OR e2.supportingArgID = h1.argID)
        AND e2.endorseType IN ('Because', 'Therefore') AND e2.active = 1
      WHERE IF(e2.targArgID = h1.argID, e2.supportingArgID, e2.targArgID) != focal
    ) h2
    JOIN ENDORSEMENT e3
      ON (e3.targArgID = h2.argID OR e3.supportingArgID = h2.argID)
      AND e3.endorseType IN ('Because', 'Therefore') AND e3.active = 1
    WHERE IF(e3.targArgID = h2.argID, e3.supportingArgID, e3.targArgID) != focal
      AND endType != 'Rebuttal'

    UNION ALL

    
    
    
    SELECT
      IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID,
      10000 AS score
    FROM ENDORSEMENT e
    WHERE (e.targArgID = focal OR e.supportingArgID = focal)
      AND e.endorseType = 'Rebuttal'
      AND e.active = 1
      AND endType = 'Rebuttal'

    UNION ALL

    
    
    
    SELECT
      IF(er.targArgID = h1r.argID, er.supportingArgID, er.targArgID) AS argID,
      1000 AS score
    FROM (
      SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
      FROM ENDORSEMENT e
      WHERE (e.targArgID = focal OR e.supportingArgID = focal)
        AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
    ) h1r
    JOIN ENDORSEMENT er
      ON (er.targArgID = h1r.argID OR er.supportingArgID = h1r.argID)
      AND er.endorseType = 'Rebuttal' AND er.active = 1
    WHERE IF(er.targArgID = h1r.argID, er.supportingArgID, er.targArgID) != focal
      AND endType = 'Rebuttal'

    UNION ALL

    
    SELECT
      IF(er2.targArgID = h2r.argID, er2.supportingArgID, er2.targArgID) AS argID,
      100 AS score
    FROM (
      SELECT DISTINCT
        IF(e2.targArgID = h1r2.argID, e2.supportingArgID, e2.targArgID) AS argID
      FROM (
        SELECT DISTINCT IF(e.targArgID = focal, e.supportingArgID, e.targArgID) AS argID
        FROM ENDORSEMENT e
        WHERE (e.targArgID = focal OR e.supportingArgID = focal)
          AND e.endorseType IN ('Because', 'Therefore') AND e.active = 1
      ) h1r2
      JOIN ENDORSEMENT e2
        ON (e2.targArgID = h1r2.argID OR e2.supportingArgID = h1r2.argID)
        AND e2.endorseType IN ('Because', 'Therefore') AND e2.active = 1
      WHERE IF(e2.targArgID = h1r2.argID, e2.supportingArgID, e2.targArgID) != focal
    ) h2r
    JOIN ENDORSEMENT er2
      ON (er2.targArgID = h2r.argID OR er2.supportingArgID = h2r.argID)
      AND er2.endorseType = 'Rebuttal' AND er2.active = 1
    WHERE IF(er2.targArgID = h2r.argID, er2.supportingArgID, er2.targArgID) != focal
      AND endType = 'Rebuttal'

    UNION ALL

    
    
    
    
    SELECT
      pe2.argumentID                    AS argID,
      COUNT(DISTINCT pe1.profileID) * 5 AS score
    FROM PHRASE_ENDORSE pe1
    JOIN PHRASE_ENDORSE pe2
      ON  pe2.profileID   = pe1.profileID
      AND pe2.argumentID != focal
      AND ABS(DATEDIFF(pe2.firstVisit, pe1.firstVisit)) <= 30
    WHERE pe1.argumentID = focal
    GROUP BY pe2.argumentID

    UNION ALL

    
    
    
    
    
    SELECT
      a2.argumentID AS argID,
      ROUND(MATCH(a2.currentPhrasing) AGAINST (@_nb_focal IN BOOLEAN MODE) * 10) AS score
    FROM ARGUMENT a2
    WHERE a2.argumentID != focal
      AND @_nb_focal IS NOT NULL
      AND @_nb_focal != ''
      AND a2.currentPhrasing IS NOT NULL
      AND MATCH(a2.currentPhrasing) AGAINST (@_nb_focal IN BOOLEAN MODE) > 0

  ) nbr ON nbr.argID = a.argumentID

  
  LEFT JOIN (
    SELECT argID, COUNT(*) AS degree
    FROM (
      SELECT targArgID       AS argID FROM ENDORSEMENT
        WHERE endorseType IN ('Because', 'Therefore') AND active = 1
      UNION ALL
      SELECT supportingArgID AS argID FROM ENDORSEMENT
        WHERE endorseType IN ('Because', 'Therefore') AND active = 1
    ) endpoints
    GROUP BY argID
  ) deg ON deg.argID = a.argumentID

  WHERE a.argumentID != focal
  GROUP BY a.argumentID, a.currentPhrasing, deg.degree
  ORDER BY
    MAX(nbr.score) DESC,
    COALESCE(deg.degree, 0) DESC;

END
//
DELIMITER ;
