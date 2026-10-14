-- Stored procedures for Negotiable Terms (per-user value, median consensus).
-- Canonical source. Deploy by piping to the droplet as root:
--   cat db/negotiable_term_procedures.sql | ssh root@<production-host> \
--     'MYSQL_PWD=$(cat <path-to-root-only-password-file>) mysql -u root vestigette'
-- MySQL 8 (not MariaDB): DROP + CREATE, no CREATE OR REPLACE.
--
-- Median (not mean) is deliberate: one absolute value per user, so a lone extreme
-- can't drag the consensus. The AVG-of-middle-row(s) idiom below yields the single
-- middle value for odd counts and the mean of the two middles for even counts.

USE vestigette;

-- ── prepareForNewTermValue ──────────────────────────────────────────────────
-- Deactivate a user's current value for an argument before inserting a new one.
-- Mirrors prepareForNewPhrasingEndorse; keeps history rather than updating in place.
DROP PROCEDURE IF EXISTS prepareForNewTermValue;
DELIMITER //
CREATE PROCEDURE prepareForNewTermValue(IN argID INT, IN proID INT)
BEGIN
    UPDATE TERM_VALUE
    SET active = FALSE
    WHERE argumentID = argID AND profileID = proID AND active = TRUE;
END //
DELIMITER ;

-- ── updateTermCache ─────────────────────────────────────────────────────────
-- Recompute the GLOBAL (unscoped) median of all active submitted values and cache
-- it on ARGUMENT.currentTermValue. Analogous to updatePhrasingCache: the cache is
-- the default value substituted into the phrasing everywhere; scoped/filtered views
-- are computed live by getTermValue. Leaves the cache unchanged when no active values
-- exist (mirrors updatePhrasingCache).
DROP PROCEDURE IF EXISTS updateTermCache;
DELIMITER //
CREATE PROCEDURE updateTermCache(IN argID INT)
BEGIN
    DECLARE activeCount INT DEFAULT 0;
    DECLARE medianVal DECIMAL(24,8) DEFAULT NULL;

    SELECT COUNT(*) INTO activeCount
    FROM TERM_VALUE
    WHERE argumentID = argID AND active = TRUE;

    IF activeCount > 0 THEN
        SELECT AVG(t.value) INTO medianVal
        FROM (
            SELECT tv.value,
                   ROW_NUMBER() OVER (ORDER BY tv.value) AS rn,
                   COUNT(*)     OVER ()                  AS cnt
            FROM TERM_VALUE tv
            WHERE tv.argumentID = argID AND tv.active = TRUE
        ) t
        WHERE t.rn IN (FLOOR((t.cnt + 1) / 2), FLOOR((t.cnt + 2) / 2));

        UPDATE ARGUMENT
        SET currentTermValue = medianVal
        WHERE argumentID = argID;
    END IF;
END //
DELIMITER ;

-- ── getTermValue ────────────────────────────────────────────────────────────
-- Returns the SCOPED median + vote count for live display (header under a filter,
-- and the "Negotiate the term" subsection). Scoping mirrors getDetail exactly:
--   filtered = 1 → JOIN FILTER_PROFILES (the profiles currently in view)
--   filtered = 0 → JOIN SCOPE_TERM_VALUE at @active_aff_id (the operating group)
-- Both honor the @vtime time filter on TERM_VALUE.lastVisit. medianValue is NULL
-- and voteCount is 0 when no one in scope has submitted a value.
DROP PROCEDURE IF EXISTS getTermValue;
DELIMITER //
CREATE PROCEDURE getTermValue(IN argID INT, IN filtered TINYINT)
BEGIN
    DECLARE voteCnt INT DEFAULT 0;
    DECLARE medianVal DECIMAL(24,8) DEFAULT NULL;

    IF filtered = 1 THEN
        SELECT COUNT(*) INTO voteCnt
        FROM TERM_VALUE tv
        INNER JOIN FILTER_PROFILES fp ON tv.profileID = fp.profileID
        WHERE tv.argumentID = argID AND tv.active = TRUE
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, tv.lastVisit <= @vtime_date, tv.lastVisit >= @vtime_date));

        SELECT AVG(t.value) INTO medianVal
        FROM (
            SELECT tv.value,
                   ROW_NUMBER() OVER (ORDER BY tv.value) AS rn,
                   COUNT(*)     OVER ()                  AS cnt
            FROM TERM_VALUE tv
            INNER JOIN FILTER_PROFILES fp ON tv.profileID = fp.profileID
            WHERE tv.argumentID = argID AND tv.active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, tv.lastVisit <= @vtime_date, tv.lastVisit >= @vtime_date))
        ) t
        WHERE t.rn IN (FLOOR((t.cnt + 1) / 2), FLOOR((t.cnt + 2) / 2));
    ELSE
        SELECT COUNT(*) INTO voteCnt
        FROM TERM_VALUE tv
        INNER JOIN SCOPE_TERM_VALUE stv
            ON tv.argumentID = stv.argumentID AND tv.profileID = stv.profileID
        WHERE stv.affiliationID = @active_aff_id
          AND tv.argumentID = argID AND tv.active = TRUE
          AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, tv.lastVisit <= @vtime_date, tv.lastVisit >= @vtime_date));

        SELECT AVG(t.value) INTO medianVal
        FROM (
            SELECT tv.value,
                   ROW_NUMBER() OVER (ORDER BY tv.value) AS rn,
                   COUNT(*)     OVER ()                  AS cnt
            FROM TERM_VALUE tv
            INNER JOIN SCOPE_TERM_VALUE stv
                ON tv.argumentID = stv.argumentID AND tv.profileID = stv.profileID
            WHERE stv.affiliationID = @active_aff_id
              AND tv.argumentID = argID AND tv.active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, tv.lastVisit <= @vtime_date, tv.lastVisit >= @vtime_date))
        ) t
        WHERE t.rn IN (FLOOR((t.cnt + 1) / 2), FLOOR((t.cnt + 2) / 2));
    END IF;

    SELECT argID AS argumentID, medianVal AS medianValue, voteCnt AS voteCount;
END //
DELIMITER ;
