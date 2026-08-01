-- Stored procedures for weighted phrasing endorsement
-- Run this once in MAMP's phpMyAdmin or MySQL CLI against the vestigette database

USE vestigette;

-- Returns all phrasings for an argument sorted by average weight (descending).
-- Average weight = SUM(weight) / total distinct endorsers, matching the getAssociated pattern.
-- This keeps each phrasing's display value on a 0-100 scale regardless of how many
-- people have endorsed, preventing values from exceeding 100.
-- Tie-break: cached phrasing (ARGUMENT.currentPhrasingID) first, then createdDate ASC.
-- When nobody has endorsed, all avgWeight = 0 and the cached phrasing surfaces first.
-- NOTE: reconciled 2026-07-30 to the LIVE 2-param definition (this file had drifted
-- to a stale 1-param/1-branch version). filtered=1 scopes to FILTER_PROFILES; else
-- scopes to SCOPE_PHRASE_ENDORSE at @active_aff_id; both honor @vtime. The phrasing
-- column is wrapped in ntPhrasing() to bake a negotiable-term [[value]] token.
DROP PROCEDURE IF EXISTS getAltPhrasing;
DELIMITER //
CREATE PROCEDURE getAltPhrasing(IN argID INT, filtered TINYINT)
BEGIN
    DECLARE cachedID INT DEFAULT NULL;
    SELECT currentPhrasingID INTO cachedID FROM ARGUMENT WHERE argumentID = argID;

    IF filtered = 1 THEN
        SELECT
            CASE
                WHEN TotEndorsers.cnt > 0 THEN
                    COALESCE(SUM(CASE WHEN E.active = TRUE THEN E.weight ELSE 0 END), 0) / TotEndorsers.cnt
                ELSE 0
            END AS avgWeight,
            COUNT(CASE WHEN E.active = TRUE THEN E.profileID ELSE NULL END) AS endorsementCount,
            ntPhrasing(P.phrasing, (SELECT currentTermValue FROM ARGUMENT WHERE argumentID = argID)) AS phrasing,
            P.phrasingID
        FROM PHRASING P
        LEFT JOIN (
            SELECT pe.* FROM PHRASE_ENDORSE pe
            INNER JOIN FILTER_PROFILES fp ON pe.profileID = fp.profileID
            WHERE (@vtime_dir = 0 OR IF(@vtime_dir = 1, pe.firstVisit <= @vtime_date, pe.firstVisit >= @vtime_date))
        ) E ON P.phrasingID = E.phrasingID AND E.argumentID = argID
        CROSS JOIN (
            SELECT COUNT(DISTINCT pe2.profileID) AS cnt
            FROM PHRASE_ENDORSE pe2
            INNER JOIN FILTER_PROFILES_2 fp2 ON pe2.profileID = fp2.profileID
            WHERE pe2.argumentID = argID AND pe2.active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, pe2.firstVisit <= @vtime_date, pe2.firstVisit >= @vtime_date))
        ) TotEndorsers
        WHERE P.argumentID = argID
        GROUP BY P.phrasingID, P.phrasing, P.createdDate, TotEndorsers.cnt
        ORDER BY avgWeight DESC,
            CASE WHEN P.phrasingID = cachedID THEN 0 ELSE 1 END ASC,
            P.createdDate ASC;
    ELSE
        SELECT
            CASE
                WHEN TotEndorsers.cnt > 0 THEN
                    COALESCE(SUM(CASE WHEN E.active = TRUE THEN E.weight ELSE 0 END), 0) / TotEndorsers.cnt
                ELSE 0
            END AS avgWeight,
            COUNT(CASE WHEN E.active = TRUE THEN E.profileID ELSE NULL END) AS endorsementCount,
            ntPhrasing(P.phrasing, (SELECT currentTermValue FROM ARGUMENT WHERE argumentID = argID)) AS phrasing,
            P.phrasingID
        FROM PHRASING P
        LEFT JOIN (
            SELECT PE.* FROM PHRASE_ENDORSE PE
            INNER JOIN SCOPE_PHRASE_ENDORSE SPE ON PE.profileID = SPE.profileID AND PE.argumentID = SPE.argumentID AND SPE.affiliationID = @active_aff_id
            WHERE @vtime_dir = 0 OR IF(@vtime_dir = 1, PE.firstVisit <= @vtime_date, PE.firstVisit >= @vtime_date)
        ) E ON P.phrasingID = E.phrasingID AND E.argumentID = argID
        CROSS JOIN (
            SELECT COUNT(DISTINCT PE2.profileID) AS cnt
            FROM PHRASE_ENDORSE PE2
            INNER JOIN SCOPE_PHRASE_ENDORSE SPE2 ON PE2.profileID = SPE2.profileID AND PE2.argumentID = SPE2.argumentID AND SPE2.affiliationID = @active_aff_id
            WHERE PE2.argumentID = argID AND PE2.active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, PE2.firstVisit <= @vtime_date, PE2.firstVisit >= @vtime_date))
        ) TotEndorsers
        WHERE P.argumentID = argID
        GROUP BY P.phrasingID, P.phrasing, P.createdDate, TotEndorsers.cnt
        ORDER BY avgWeight DESC,
            CASE WHEN P.phrasingID = cachedID THEN 0 ELSE 1 END ASC,
            P.createdDate ASC;
    END IF;
END //
DELIMITER ;

-- Deactivates a user's existing phrasing endorsements for an argument before inserting new ones
DROP PROCEDURE IF EXISTS prepareForNewPhrasingEndorse;
DELIMITER //
CREATE PROCEDURE prepareForNewPhrasingEndorse(IN argID INT, IN proID INT)
BEGIN
    UPDATE PHRASE_ENDORSE
    SET active = FALSE
    WHERE argumentID = argID AND profileID = proID AND active = TRUE;
END //
DELIMITER ;

-- Refreshes currentPhrasing/currentPhrasingID cache on ARGUMENT after a new endorsement.
-- Winner = highest total weight (SUM is equivalent to avgWeight for ranking since all share
-- the same total-endorser denominator). Tie-break = oldest createdDate.
-- Only updates if at least one phrasing has active endorsements; otherwise leaves cache unchanged.
DROP PROCEDURE IF EXISTS updatePhrasingCache;
DELIMITER //
CREATE PROCEDURE updatePhrasingCache(IN argID INT)
BEGIN
    DECLARE bestPhrasingID INT DEFAULT NULL;
    DECLARE bestPhrasing VARCHAR(300) DEFAULT NULL;
    DECLARE activeCount INT DEFAULT 0;

    SELECT COUNT(*) INTO activeCount
    FROM PHRASE_ENDORSE
    WHERE argumentID = argID AND active = TRUE;

    IF activeCount > 0 THEN
        SELECT P.phrasingID, P.phrasing
        INTO bestPhrasingID, bestPhrasing
        FROM PHRASING P
        INNER JOIN PHRASE_ENDORSE E ON P.phrasingID = E.phrasingID
            AND E.argumentID = argID AND E.active = TRUE
        WHERE P.argumentID = argID
        GROUP BY P.phrasingID, P.phrasing, P.createdDate
        ORDER BY SUM(E.weight) DESC, P.createdDate ASC
        LIMIT 1;

        UPDATE ARGUMENT
        SET currentPhrasingID = bestPhrasingID,
            currentPhrasing = bestPhrasing
        WHERE argumentID = argID;
    END IF;
END //
DELIMITER ;
