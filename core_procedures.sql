-- Core argument graph procedures (getAssociated, getMostEndorsed, getHeterodox,
-- assertOpinion, rebalanceRecentRejections, prepareForNewEndorse, resolveOldWithNewEndorse)
-- These were rewritten to fix a MySQL 5.7 correlated-subquery bug: derived tables
-- that are materialized cannot reference outer aliases, so phrasing lookups were
-- moved out of derived tables and into direct JOIN ARGUMENT + inline COALESCE.
-- Run against the vestigette database to restore after a DB reset.

USE vestigette;

-- assertOpinion: called on every accept/reject. Handles first-time opinions and
-- flips. On flip, toggles active state of ENDORSEMENT, PHRASE_ENDORSE, EXPLICATION,
-- and EXPLICATION_ENDORSE rows. updatePhrasingCache is called on both flip branches.
-- EXPLICATION_ENDORSE toggle added 2026-06-05 to match EXPLICATION toggle.
DROP PROCEDURE IF EXISTS assertOpinion;
DELIMITER //
CREATE PROCEDURE assertOpinion(op INT, argID INT UNSIGNED, proID INT UNSIGNED)
BEGIN
    IF NOT EXISTS(SELECT * FROM OPINION WHERE argumentID = argID AND profileID = proID) THEN
        IF op = 1 THEN
            INSERT INTO OPINION VALUES (argID, proID, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        ELSE
            INSERT INTO OPINION VALUES (argID, proID, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        END IF;
    ELSEIF (EXISTS(SELECT * FROM OPINION WHERE argumentID = argID AND profileID = proID AND acceptance = FALSE) AND op = 1) THEN
        UPDATE OPINION
            SET acceptance = TRUE, lastVisit = CURRENT_TIMESTAMP
                WHERE argumentID = argID AND profileID = proID;
        UPDATE ENDORSEMENT
            SET active = TRUE, lastVisit = CURRENT_TIMESTAMP
                WHERE targArgID = argID AND profileID = proID AND (endorseType = 'Because' OR endorseType = 'Therefore');
        UPDATE ENDORSEMENT
            SET active = FALSE, lastVisit = CURRENT_TIMESTAMP
                WHERE targArgID = argID AND profileID = proID AND endorseType = 'Rebuttal';
        IF (EXISTS(SELECT * FROM PHRASE_ENDORSE WHERE argumentID = argID AND profileID = proID)) THEN
            UPDATE PHRASE_ENDORSE SET active = TRUE WHERE argumentID = argID AND profileID = proID;
        END IF;
        IF (EXISTS(SELECT * FROM EXPLICATION WHERE argumentID = argID AND profileID = proID)) THEN
            UPDATE EXPLICATION SET active = TRUE WHERE argumentID = argID AND profileID = proID;
            UPDATE EXPLICATION_ENDORSE SET active = TRUE WHERE argumentID = argID AND profileID = proID;
        END IF;
        CALL updatePhrasingCache(argID);
    ELSEIF (EXISTS(SELECT * FROM OPINION WHERE argumentID = argID AND profileID = proID AND acceptance = TRUE) AND op = -1) THEN
        UPDATE OPINION
            SET acceptance = FALSE, lastVisit = CURRENT_TIMESTAMP
                WHERE argumentID = argID AND profileID = proID;
        UPDATE ENDORSEMENT
            SET active = FALSE, lastVisit = CURRENT_TIMESTAMP
                WHERE targArgID = argID AND profileID = proID AND (endorseType = 'Because' OR endorseType = 'Therefore');
        UPDATE ENDORSEMENT
            SET active = TRUE
                WHERE targArgID = argID AND profileID = proID AND endorseType = 'Rebuttal';
        IF (EXISTS(SELECT * FROM PHRASE_ENDORSE WHERE argumentID = argID AND profileID = proID)) THEN
            UPDATE PHRASE_ENDORSE SET active = FALSE WHERE argumentID = argID AND profileID = proID;
        END IF;
        IF (EXISTS(SELECT * FROM EXPLICATION WHERE argumentID = argID AND profileID = proID)) THEN
            UPDATE EXPLICATION SET active = FALSE WHERE argumentID = argID AND profileID = proID;
            UPDATE EXPLICATION_ENDORSE SET active = FALSE WHERE argumentID = argID AND profileID = proID;
        END IF;
        CALL updatePhrasingCache(argID);
        CALL rebalanceRecentRejections(argID, proID);
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getAssociated;
DELIMITER //
CREATE PROCEDURE getAssociated(argID INT UNSIGNED)
BEGIN
    SELECT E1.targArgID, E1.endorseType, E1.supportingArgID,
           SUM(E1.weight)/TotalUsers AS AggWeight,
           COALESCE(A1.currentPhrasing,
               (SELECT phrasing FROM PHRASING
                WHERE argumentID = A1.argumentID
                ORDER BY createdDate ASC LIMIT 1)
           ) AS phrasing
    FROM ENDORSEMENT E1
    JOIN (
        SELECT targArgID, endorseType, COUNT(DISTINCT profileID) AS TotalUsers
        FROM ENDORSEMENT
        WHERE targArgID = argID AND active = TRUE
        GROUP BY endorseType
    ) E2 ON E1.endorseType = E2.endorseType
    JOIN ARGUMENT A1 ON E1.supportingArgID = A1.argumentID
    WHERE E1.targArgID = argID AND E1.active = TRUE
    GROUP BY E1.endorseType, E1.supportingArgID, A1.currentPhrasing, A1.argumentID
    ORDER BY CASE
        WHEN E1.endorseType = 'Because' THEN '1'
        WHEN E1.endorseType = 'Rebuttal' THEN '2'
        WHEN E1.endorseType = 'Therefore' THEN '3'
        ELSE E1.endorseType
    END ASC, AggWeight DESC;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getMostEndorsed;
DELIMITER //
CREATE PROCEDURE getMostEndorsed()
BEGIN
    SELECT
        E1.supportingArgID,
        SUM(E1.weight) AS TotalWeight,
        COALESCE(A.currentPhrasing,
            (SELECT phrasing FROM PHRASING
             WHERE argumentID = A.argumentID
             ORDER BY createdDate ASC LIMIT 1)
        ) AS phrased
    FROM ENDORSEMENT E1
    JOIN ARGUMENT A ON E1.supportingArgID = A.argumentID
    WHERE E1.active = TRUE
    GROUP BY E1.supportingArgID, A.currentPhrasing, A.argumentID
    ORDER BY TotalWeight DESC;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getHeterodox;
DELIMITER //
CREATE PROCEDURE getHeterodox(proID INT UNSIGNED)
BEGIN
    SELECT
        A.argumentID,
        A.acceptance,
        D.Accept,
        D.Total,
        D.Percent,
        IF(A.acceptance = 0, D.Percent, 1 - D.Percent) AS Difference,
        COALESCE(
            AR.currentPhrasing,
            (SELECT P.phrasing FROM PHRASING P WHERE P.argumentID = AR.argumentID ORDER BY P.createdDate ASC LIMIT 1)
        ) AS phrased
    FROM OPINION A
    JOIN (
        SELECT B.argumentID,
            COUNT(B.acceptance) AS Accept,
            C.Total,
            COUNT(B.acceptance) / C.Total AS Percent
        FROM OPINION B
        JOIN (
            SELECT argumentID, COUNT(acceptance) AS Total
            FROM OPINION
            GROUP BY argumentID
        ) C ON B.argumentID = C.argumentID
        WHERE B.acceptance = TRUE
        GROUP BY B.argumentID
    ) D ON A.argumentID = D.argumentID
    JOIN ARGUMENT AR ON A.argumentID = AR.argumentID
    WHERE A.profileID = proID
      AND IF(A.acceptance = 0, D.Percent, 1 - D.Percent) > .5
    ORDER BY Difference DESC;
END //
DELIMITER ;

-- ── impliedAssertion trigger ────────────────────────────────────────────────
-- Weighing an argument (inserting an ENDORSEMENT) implies acceptance of the
-- supporting argument. Record that acceptance only when the user has no opinion
-- on the support yet.
--
-- The trigger must NOT modify ENDORSEMENT — a trigger cannot write the same
-- table whose statement fired it (MySQL: "Can't update table 'ENDORSEMENT' in
-- stored function/trigger because it is already used by statement which invoked
-- this stored function/trigger"). It therefore only inserts an OPINION when the
-- user has none, and never overrides an existing explicit opinion. (It used to
-- CALL assertOpinion(1, ...), whose opinion-flip branches UPDATE ENDORSEMENT,
-- which crashed any weigh-in that supported a previously-rejected argument.)
DROP TRIGGER IF EXISTS impliedAssertion;
DELIMITER //
CREATE TRIGGER impliedAssertion BEFORE INSERT ON ENDORSEMENT
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM OPINION
                   WHERE argumentID = NEW.supportingArgID
                     AND profileID  = NEW.profileID) THEN
        INSERT INTO OPINION
            VALUES (NEW.supportingArgID, NEW.profileID, TRUE,
                    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    END IF;
END //
DELIMITER ;
