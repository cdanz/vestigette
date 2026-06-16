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
    DECLARE humanCount INT DEFAULT 0;
    DECLARE personaToRetire INT UNSIGNED DEFAULT NULL;

    IF NOT EXISTS(SELECT * FROM OPINION WHERE argumentID = argID AND profileID = proID) THEN
        IF op = 1 THEN
            INSERT INTO OPINION VALUES (argID, proID, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        ELSE
            INSERT INTO OPINION VALUES (argID, proID, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        END IF;

        -- Probabilistic persona retirement: fires only for real human users (not personas 1-26).
        -- Probability = (humanCount / 100)^2, giving an S-curve that accelerates through
        -- the middle range and completes retirement of all personas by ~100 human opinions.
        IF proID > 26 THEN
            SELECT COUNT(*) INTO humanCount
            FROM OPINION
            WHERE argumentID = argID AND profileID > 26;

            IF RAND() < POW(humanCount / 100.0, 2) THEN
                SELECT profileID INTO personaToRetire
                FROM OPINION
                WHERE argumentID = argID AND profileID BETWEEN 1 AND 26
                ORDER BY profileID ASC
                LIMIT 1;

                IF personaToRetire IS NOT NULL THEN
                    CALL retirePersonaFromArgument(personaToRetire, argID);
                END IF;
            END IF;
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

-- ── rebalanceRecentRejections ───────────────────────────────────────────────
-- Called from assertOpinion's reject branch. When a user rejects argID, every
-- endorsement where they used argID as a SUPPORT is removed and the remaining
-- weights in each affected target distribution are renormalised back to 100%.
--
-- Each WHILE loop MUST be scoped to its own endorseType. The previous version
-- used an unscoped condition (WHILE EXISTS(... supportingArgID=argID AND
-- profileID=proID)) while the body only deleted 'Because' rows, so once the
-- Because supports were gone but Therefore/Rebuttal supports remained, the
-- condition stayed true forever (argToBalance went NULL, the DELETE matched
-- nothing) — an infinite loop that pegged a CPU and hung the request.
DROP PROCEDURE IF EXISTS rebalanceRecentRejections;
DELIMITER //
CREATE PROCEDURE rebalanceRecentRejections(argID INT UNSIGNED, proID INT UNSIGNED)
BEGIN
    DECLARE weightToCut decimal(8,5);
    DECLARE argToBalance int(10) unsigned;

    WHILE EXISTS(SELECT 1 FROM ENDORSEMENT WHERE supportingArgID = argID AND profileID = proID AND endorseType = 'Because') DO
        SELECT weight, targArgID INTO weightToCut, argToBalance
            FROM ENDORSEMENT
            WHERE supportingArgID = argID AND profileID = proID AND endorseType = 'Because'
            ORDER BY targArgID DESC LIMIT 1;
        DELETE FROM ENDORSEMENT
            WHERE targArgID = argToBalance AND profileID = proID AND supportingArgID = argID AND endorseType = 'Because';
        UPDATE ENDORSEMENT
            SET weight = (weight/(100-weightToCut))*100
            WHERE targArgID = argToBalance AND profileID = proID AND endorseType = 'Because';
    END WHILE;

    WHILE EXISTS(SELECT 1 FROM ENDORSEMENT WHERE supportingArgID = argID AND profileID = proID AND endorseType = 'Therefore') DO
        SELECT weight, targArgID INTO weightToCut, argToBalance
            FROM ENDORSEMENT
            WHERE supportingArgID = argID AND profileID = proID AND endorseType = 'Therefore'
            ORDER BY targArgID DESC LIMIT 1;
        DELETE FROM ENDORSEMENT
            WHERE targArgID = argToBalance AND profileID = proID AND supportingArgID = argID AND endorseType = 'Therefore';
        UPDATE ENDORSEMENT
            SET weight = (weight/(100-weightToCut))*100
            WHERE targArgID = argToBalance AND profileID = proID AND endorseType = 'Therefore';
    END WHILE;

    WHILE EXISTS(SELECT 1 FROM ENDORSEMENT WHERE supportingArgID = argID AND profileID = proID AND endorseType = 'Rebuttal') DO
        SELECT weight, targArgID INTO weightToCut, argToBalance
            FROM ENDORSEMENT
            WHERE supportingArgID = argID AND profileID = proID AND endorseType = 'Rebuttal'
            ORDER BY targArgID DESC LIMIT 1;
        DELETE FROM ENDORSEMENT
            WHERE targArgID = argToBalance AND profileID = proID AND supportingArgID = argID AND endorseType = 'Rebuttal';
        UPDATE ENDORSEMENT
            SET weight = (weight/(100-weightToCut))*100
            WHERE targArgID = argToBalance AND profileID = proID AND endorseType = 'Rebuttal';
    END WHILE;
END //
DELIMITER ;

-- ── getTrending ─────────────────────────────────────────────────────────────
-- Score-based trending list with time decay. Points by event type:
--   New/updated opinion          20 pts  -1 per 3 days  → 0 at 60 days
--   New phrasing                 10 pts  -1 per 6 days  → 0 at 60 days
--   New explication link         10 pts  -1 per 6 days  → 0 at 60 days
--   Explication endorsement chg   2 pts  -1 per 30 days → 0 at 60 days
--   New supporting-arg endorse    5 pts  -1 per 6 days  → 0 at 30 days
-- Ties broken by most-recent event. Returns top 20.
DROP PROCEDURE IF EXISTS getTrending;
DELIMITER //
CREATE PROCEDURE getTrending()
BEGIN
    SELECT
        A.argumentID,
        COALESCE(A.currentPhrasing,
            (SELECT phrasing FROM PHRASING
             WHERE argumentID = A.argumentID ORDER BY createdDate ASC LIMIT 1)
        ) AS phrased,
        SUM(ev.score) AS trendScore,
        MAX(ev.eventTime) AS mostRecent
    FROM ARGUMENT A
    JOIN (
        -- Opinion created or flipped: 20 pts, -1 per 3 days
        SELECT argumentID,
               GREATEST(0, 20 - FLOOR(DATEDIFF(NOW(), lastVisit) / 3)) AS score,
               lastVisit AS eventTime
        FROM OPINION
        WHERE lastVisit IS NOT NULL
          AND DATEDIFF(NOW(), lastVisit) < 60

        UNION ALL

        -- New phrasing added: 10 pts, -1 per 6 days
        SELECT argumentID,
               GREATEST(0, 10 - FLOOR(DATEDIFF(NOW(), createdDate) / 6)) AS score,
               createdDate AS eventTime
        FROM PHRASING
        WHERE createdDate IS NOT NULL
          AND DATEDIFF(NOW(), createdDate) < 60

        UNION ALL

        -- New explication link added: 10 pts, -1 per 6 days
        SELECT argumentID,
               GREATEST(0, 10 - FLOOR(DATEDIFF(NOW(), firstVisit) / 6)) AS score,
               firstVisit AS eventTime
        FROM EXPLICATION
        WHERE firstVisit IS NOT NULL
          AND DATEDIFF(NOW(), firstVisit) < 60

        UNION ALL

        -- Explication endorsement weight changed: 2 pts, -1 per 30 days
        SELECT argumentID,
               GREATEST(0, 2 - FLOOR(DATEDIFF(NOW(), updatedAt) / 30)) AS score,
               updatedAt AS eventTime
        FROM EXPLICATION_ENDORSE
        WHERE updatedAt IS NOT NULL
          AND DATEDIFF(NOW(), updatedAt) < 60

        UNION ALL

        -- New supporting-arg endorsement: 5 pts, -1 per 6 days (0 at 30 days)
        SELECT targArgID AS argumentID,
               GREATEST(0, 5 - FLOOR(DATEDIFF(NOW(), lastVisit) / 6)) AS score,
               lastVisit AS eventTime
        FROM ENDORSEMENT
        WHERE lastVisit IS NOT NULL
          AND active = TRUE
          AND DATEDIFF(NOW(), lastVisit) < 30
    ) AS ev ON ev.argumentID = A.argumentID
    GROUP BY A.argumentID, A.currentPhrasing
    HAVING SUM(ev.score) > 0
    ORDER BY trendScore DESC, mostRecent DESC
    LIMIT 20;
END //
DELIMITER ;

-- ── getMostContested ─────────────────────────────────────────────────────────
-- Arguments closest to a 50/50 accept/reject split across all opinions.
-- Requires at least 5 opinions to surface. Returns top 20.
DROP PROCEDURE IF EXISTS getMostContested;
DELIMITER //
CREATE PROCEDURE getMostContested()
BEGIN
    SELECT
        A.argumentID,
        COALESCE(A.currentPhrasing,
            (SELECT phrasing FROM PHRASING
             WHERE argumentID = A.argumentID ORDER BY createdDate ASC LIMIT 1)
        ) AS phrased,
        votes.total_votes,
        votes.accept_count
    FROM ARGUMENT A
    JOIN (
        SELECT argumentID,
               COUNT(*) AS total_votes,
               SUM(CASE WHEN acceptance = TRUE THEN 1 ELSE 0 END) AS accept_count,
               ABS(0.5 - SUM(CASE WHEN acceptance = TRUE THEN 1.0 ELSE 0 END) / COUNT(*)) AS spread
        FROM OPINION
        GROUP BY argumentID
        HAVING COUNT(*) >= 5
    ) AS votes ON votes.argumentID = A.argumentID
    ORDER BY votes.spread ASC, votes.total_votes DESC
    LIMIT 20;
END //
DELIMITER ;
