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
        INSERT IGNORE INTO SCOPE_OPINION (argumentID, profileID, affiliationID)
        VALUES (argID, proID, @active_aff_id);

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
CREATE PROCEDURE getAssociated(argID INT UNSIGNED, filtered TINYINT)
BEGIN
    IF filtered = 1 THEN
        SELECT E1.targArgID, E1.endorseType, E1.supportingArgID,
               SUM(E1.weight)/TotalUsers AS AggWeight,
               COALESCE(A1.currentPhrasing,
                   (SELECT phrasing FROM PHRASING
                    WHERE argumentID = A1.argumentID
                    ORDER BY createdDate ASC LIMIT 1)
               ) AS phrasing
        FROM ENDORSEMENT E1
        INNER JOIN FILTER_PROFILES fp1 ON E1.profileID = fp1.profileID
        JOIN (
            SELECT targArgID, endorseType, COUNT(DISTINCT E.profileID) AS TotalUsers
            FROM ENDORSEMENT E
            INNER JOIN FILTER_PROFILES_2 fp2 ON E.profileID = fp2.profileID
            WHERE targArgID = argID AND active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, E.lastVisit <= @vtime_date, E.lastVisit >= @vtime_date))
            GROUP BY endorseType
        ) E2 ON E1.endorseType = E2.endorseType
        JOIN ARGUMENT A1 ON E1.supportingArgID = A1.argumentID
        WHERE E1.targArgID = argID AND E1.active = TRUE
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, E1.lastVisit <= @vtime_date, E1.lastVisit >= @vtime_date))
        GROUP BY E1.endorseType, E1.supportingArgID, A1.currentPhrasing, A1.argumentID
        ORDER BY CASE
            WHEN E1.endorseType = 'Because' THEN '1'
            WHEN E1.endorseType = 'Rebuttal' THEN '2'
            WHEN E1.endorseType = 'Therefore' THEN '3'
            ELSE E1.endorseType
        END ASC, AggWeight DESC;
    ELSE
        SELECT E1.targArgID, E1.endorseType, E1.supportingArgID,
               SUM(E1.weight)/TotalUsers AS AggWeight,
               COALESCE(A1.currentPhrasing,
                   (SELECT phrasing FROM PHRASING
                    WHERE argumentID = A1.argumentID
                    ORDER BY createdDate ASC LIMIT 1)
               ) AS phrasing
        FROM ENDORSEMENT E1
        INNER JOIN SCOPE_ENDORSEMENT SE1 ON E1.profileID = SE1.profileID AND E1.targArgID = SE1.targArgID AND SE1.affiliationID = @active_aff_id
        JOIN (
            SELECT E.targArgID, E.endorseType, COUNT(DISTINCT E.profileID) AS TotalUsers
            FROM ENDORSEMENT E
            INNER JOIN SCOPE_ENDORSEMENT SE2 ON E.profileID = SE2.profileID AND E.targArgID = SE2.targArgID AND SE2.affiliationID = @active_aff_id
            WHERE E.targArgID = argID AND E.active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, E.lastVisit <= @vtime_date, E.lastVisit >= @vtime_date))
            GROUP BY E.endorseType
        ) E2 ON E1.endorseType = E2.endorseType
        JOIN ARGUMENT A1 ON E1.supportingArgID = A1.argumentID
        WHERE E1.targArgID = argID AND E1.active = TRUE
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, E1.lastVisit <= @vtime_date, E1.lastVisit >= @vtime_date))
        GROUP BY E1.endorseType, E1.supportingArgID, A1.currentPhrasing, A1.argumentID
        ORDER BY CASE
            WHEN E1.endorseType = 'Because' THEN '1'
            WHEN E1.endorseType = 'Rebuttal' THEN '2'
            WHEN E1.endorseType = 'Therefore' THEN '3'
            ELSE E1.endorseType
        END ASC, AggWeight DESC;
    END IF;
END //
DELIMITER ;

-- ── getDetail ──────────────────────────────────────────────────────────────
-- Returns the argument's phrasing, accept count, total assertion count, and
-- accept percentage. The phrasing resolution is unaffected by the filter;
-- only the opinion counts are scoped when filtered = 1.
DROP PROCEDURE IF EXISTS getDetail;
DELIMITER //
CREATE PROCEDURE getDetail(argID INT UNSIGNED, filtered TINYINT)
BEGIN
    DECLARE acceptCnt INT DEFAULT 0;
    DECLARE assertCnt INT DEFAULT 0;

    IF filtered = 1 THEN
        SELECT COUNT(*) INTO acceptCnt
        FROM OPINION o INNER JOIN FILTER_PROFILES fp ON o.profileID = fp.profileID
        WHERE o.argumentID = argID AND o.acceptance = TRUE
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, o.lastVisit <= @vtime_date, o.lastVisit >= @vtime_date));

        SELECT COUNT(*) INTO assertCnt
        FROM OPINION o INNER JOIN FILTER_PROFILES fp ON o.profileID = fp.profileID
        WHERE o.argumentID = argID
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, o.lastVisit <= @vtime_date, o.lastVisit >= @vtime_date));
    ELSE
        SELECT COUNT(O.acceptance) INTO acceptCnt
        FROM OPINION O
        INNER JOIN SCOPE_OPINION SO ON O.argumentID = SO.argumentID AND O.profileID = SO.profileID
        WHERE SO.affiliationID = @active_aff_id
          AND O.argumentID = argID AND O.acceptance = TRUE
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, O.lastVisit <= @vtime_date, O.lastVisit >= @vtime_date));

        SELECT COUNT(O.acceptance) INTO assertCnt
        FROM OPINION O
        INNER JOIN SCOPE_OPINION SO ON O.argumentID = SO.argumentID AND O.profileID = SO.profileID
        WHERE SO.affiliationID = @active_aff_id
          AND O.argumentID = argID
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, O.lastVisit <= @vtime_date, O.lastVisit >= @vtime_date));
    END IF;

    SELECT X.argumentID, X.phrased,
        acceptCnt AS AcceptCount,
        assertCnt AS AssertCount,
        CASE WHEN assertCnt = 0 THEN 0 ELSE acceptCnt / assertCnt END AS percentAccept
    FROM (
        SELECT
            A.argumentID,
            IFNULL(B.phrasingID, 0) as phraseID,
            IFNULL(B.phrasing, "Nothing to see here") as phrased
        FROM ARGUMENT A
        LEFT JOIN PHRASING B ON A.argumentID = B.argumentID AND
            B.phrasingID = COALESCE(
                (SELECT C1.phrasingID FROM (
                    SELECT A1.phrasingID, SUM(A1.weight) as totalWeight
                    FROM PHRASE_ENDORSE A1
                    JOIN PHRASING B1 ON A1.phrasingID = B1.phrasingID
                    WHERE A1.active = TRUE AND A1.argumentID = argID
                    GROUP BY A1.phrasingID
                    HAVING totalWeight > 100
                    ORDER BY totalWeight DESC
                ) C1 LIMIT 1),
                (SELECT C2.phrasingID FROM (
                    SELECT A2.phrasingID, SUM(A2.weight) as totalWeight, MIN(A2.firstVisit) as earliest
                    FROM PHRASE_ENDORSE A2
                    JOIN PHRASING B2 ON A2.phrasingID = B2.phrasingID
                    WHERE A2.active = TRUE AND A2.argumentID = argID
                    GROUP BY A2.phrasingID
                    HAVING totalWeight > 100
                    ORDER BY totalWeight DESC, earliest ASC
                ) C2 LIMIT 1),
                (SELECT C3.phrasingID FROM (
                    SELECT A3.phrasingID, SUM(A3.weight) as totalWeight, MIN(A3.firstVisit) as earliest
                    FROM PHRASE_ENDORSE A3
                    JOIN PHRASING B3 ON A3.phrasingID = B3.phrasingID
                    WHERE A3.active = TRUE AND A3.argumentID = argID
                    GROUP BY A3.phrasingID
                    HAVING totalWeight <= 100
                    ORDER BY earliest ASC
                ) C3 LIMIT 1),
                A.currentPhrasingID,
                (SELECT C4.phrasingID FROM PHRASING C4
                 WHERE C4.argumentID = argID
                 ORDER BY C4.createdDate ASC LIMIT 1)
            )
        WHERE A.argumentID = argID
        ORDER BY A.argumentID ASC
    ) X
    WHERE argumentID = argID;
END //
DELIMITER ;

-- ── getAltPhrasing ─────────────────────────────────────────────────────────
-- Returns all phrasings for an argument with averaged endorsement weights.
-- When filtered = 1, only endorsements from FILTER_PROFILES are counted.
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
            P.phrasing,
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
            P.phrasing,
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
        INSERT IGNORE INTO SCOPE_OPINION (argumentID, profileID, affiliationID)
        VALUES (NEW.supportingArgID, NEW.profileID, @active_aff_id);
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
