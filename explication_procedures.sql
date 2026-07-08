-- Schema changes and stored procedures for weighted explication endorsement
-- Run this once in MAMP's phpMyAdmin or MySQL CLI against the vestigette database

USE vestigette;

-- Step 1: Drop FK constraints that prevent PK restructure, then rebuild
ALTER TABLE EXPLICATION DROP FOREIGN KEY EXPLICATION_ibfk_1;
ALTER TABLE EXPLICATION DROP FOREIGN KEY EXPLICATION_ibfk_2;
ALTER TABLE EXPLICATION DROP PRIMARY KEY;
ALTER TABLE EXPLICATION ADD COLUMN explicationID INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
ALTER TABLE EXPLICATION ADD UNIQUE KEY uq_arg_profile (argumentID, profileID);
-- Restore foreign keys
ALTER TABLE EXPLICATION ADD CONSTRAINT EXPLICATION_ibfk_1 FOREIGN KEY (argumentID) REFERENCES ARGUMENT (argumentID);
ALTER TABLE EXPLICATION ADD CONSTRAINT EXPLICATION_ibfk_2 FOREIGN KEY (profileID) REFERENCES USER_PROFILE (profileID);

-- Step 2: Create endorsement table (mirrors PHRASE_ENDORSE pattern)
CREATE TABLE IF NOT EXISTS EXPLICATION_ENDORSE (
    endorseID INT NOT NULL AUTO_INCREMENT,
    explicationID INT NOT NULL,
    argumentID INT UNSIGNED NOT NULL,
    profileID INT UNSIGNED NOT NULL,
    weight FLOAT NOT NULL DEFAULT 0,
    active TINYINT(1) NOT NULL DEFAULT 1,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (endorseID)
);

-- Step 3a: Add OG preview cache columns (idempotent — safe to re-run if column already exists)
ALTER TABLE EXPLICATION
  ADD COLUMN IF NOT EXISTS og_title VARCHAR(300) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS og_image VARCHAR(500) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS og_description TEXT DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS og_fetched_at TIMESTAMP NULL DEFAULT NULL;

-- Step 3b: promoteExplication — creates EXPLICATION row and auto-creates
-- EXPLICATION_ENDORSE for the creator (fixes gap where ranking system had no
-- weight data for newly submitted explications).
-- UPDATE branch: ensures creator endorsement exists and is active after URL change.
-- INSERT branch: creates both rows atomically.
DROP PROCEDURE IF EXISTS promoteExplication;
DELIMITER //
CREATE PROCEDURE promoteExplication(argID INT UNSIGNED, proID INT UNSIGNED, link VARCHAR(300))
BEGIN
    DECLARE thisExplID INT DEFAULT NULL;

    IF (EXISTS(SELECT * FROM EXPLICATION WHERE argumentID = argID AND profileID = proID)) THEN
        UPDATE EXPLICATION
        SET hyperlink = link, lastVisit = CURRENT_TIMESTAMP,
            og_title = NULL, og_image = NULL, og_description = NULL, og_fetched_at = NULL
        WHERE argumentID = argID AND profileID = proID;

        SELECT explicationID INTO thisExplID
        FROM EXPLICATION WHERE argumentID = argID AND profileID = proID;

        IF NOT EXISTS(SELECT 1 FROM EXPLICATION_ENDORSE
                      WHERE explicationID = thisExplID AND profileID = proID) THEN
            INSERT INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active)
            VALUES (thisExplID, argID, proID, 100, TRUE);
            INSERT IGNORE INTO SCOPE_EXPLICATION_ENDORSE (profileID, argumentID, affiliationID)
            VALUES (proID, argID, @active_aff_id);
        ELSE
            UPDATE EXPLICATION_ENDORSE SET active = TRUE
            WHERE explicationID = thisExplID AND profileID = proID;
        END IF;

    ELSE
        INSERT INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,
            authorLName, title, metaPub, metaName, metaWildcard, firstVisit, lastVisit, active)
        VALUES (argID, proID, link, '', '', '', '', '', '', '',
            CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE);

        SET thisExplID = LAST_INSERT_ID();

        INSERT INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active)
        VALUES (thisExplID, argID, proID, 100, TRUE);
        INSERT IGNORE INTO SCOPE_EXPLICATION_ENDORSE (profileID, argumentID, affiliationID)
        VALUES (proID, argID, @active_aff_id);
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS newExplication;
DELIMITER //
CREATE PROCEDURE newExplication(argID INT UNSIGNED, proID INT UNSIGNED, link VARCHAR(300))
BEGIN
    INSERT INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName, authorLName, title, metaPub, metaName, metaWildcard, firstVisit, lastVisit, active)
    VALUES (argID, proID, link, '', '', '', '', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE);
END //
DELIMITER ;

-- Step 3c: Replace getExplication procedure — returns OG preview columns in addition to core fields.
-- avgWeight = SUM(weight) / total distinct endorsers, matching getAssociated/getAltPhrasing pattern.
-- Keeps display values on a 0-100 scale regardless of endorser count; sorted by avgWeight DESC.
-- When filtered = 1, only endorsements from FILTER_PROFILES are counted.
DROP PROCEDURE IF EXISTS getExplication;
DELIMITER //
CREATE PROCEDURE getExplication(IN argID INT, filtered TINYINT)
BEGIN
    IF filtered = 1 THEN
        SELECT
            CASE
                WHEN TotEndorsers.cnt > 0 THEN
                    COALESCE(SUM(CASE WHEN EE.active = TRUE THEN EE.weight ELSE 0 END), 0) / TotEndorsers.cnt
                ELSE 0
            END AS avgWeight,
            COUNT(CASE WHEN EE.active = TRUE THEN EE.profileID ELSE NULL END) AS endorsementCount,
            E.explicationID,
            E.hyperlink,
            E.publisher,
            E.authorFName,
            E.authorLName,
            E.title,
            E.og_title,
            E.og_image,
            E.og_description
        FROM EXPLICATION E
        LEFT JOIN (
            SELECT ee.* FROM EXPLICATION_ENDORSE ee
            INNER JOIN FILTER_PROFILES fp ON ee.profileID = fp.profileID
            WHERE @vtime_dir = 0 OR IF(@vtime_dir = 1, ee.updatedAt <= @vtime_date, ee.updatedAt >= @vtime_date)
        ) EE ON E.explicationID = EE.explicationID AND EE.argumentID = argID
        CROSS JOIN (
            SELECT COUNT(DISTINCT ee2.profileID) AS cnt
            FROM EXPLICATION_ENDORSE ee2
            INNER JOIN FILTER_PROFILES_2 fp2 ON ee2.profileID = fp2.profileID
            WHERE ee2.argumentID = argID AND ee2.active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, ee2.updatedAt <= @vtime_date, ee2.updatedAt >= @vtime_date))
        ) TotEndorsers
        WHERE E.argumentID = argID AND E.active = TRUE
        GROUP BY E.explicationID, E.hyperlink, E.publisher, E.authorFName, E.authorLName, E.title, E.firstVisit, E.og_title, E.og_image, E.og_description, TotEndorsers.cnt
        ORDER BY avgWeight DESC, E.firstVisit ASC;
    ELSE
        SELECT
            CASE
                WHEN TotEndorsers.cnt > 0 THEN
                    COALESCE(SUM(CASE WHEN EE.active = TRUE THEN EE.weight ELSE 0 END), 0) / TotEndorsers.cnt
                ELSE 0
            END AS avgWeight,
            COUNT(CASE WHEN EE.active = TRUE THEN EE.profileID ELSE NULL END) AS endorsementCount,
            E.explicationID,
            E.hyperlink,
            E.publisher,
            E.authorFName,
            E.authorLName,
            E.title,
            E.og_title,
            E.og_image,
            E.og_description
        FROM EXPLICATION E
        LEFT JOIN (
            SELECT EE2.* FROM EXPLICATION_ENDORSE EE2
            INNER JOIN SCOPE_EXPLICATION_ENDORSE SEE ON EE2.profileID = SEE.profileID AND EE2.argumentID = SEE.argumentID AND SEE.affiliationID = @active_aff_id
            WHERE @vtime_dir = 0 OR IF(@vtime_dir = 1, EE2.updatedAt <= @vtime_date, EE2.updatedAt >= @vtime_date)
        ) EE ON E.explicationID = EE.explicationID AND EE.argumentID = argID
        CROSS JOIN (
            SELECT COUNT(DISTINCT EE3.profileID) AS cnt
            FROM EXPLICATION_ENDORSE EE3
            INNER JOIN SCOPE_EXPLICATION_ENDORSE SEE3 ON EE3.profileID = SEE3.profileID AND EE3.argumentID = SEE3.argumentID AND SEE3.affiliationID = @active_aff_id
            WHERE EE3.argumentID = argID AND EE3.active = TRUE
              AND (@vtime_dir = 0 OR IF(@vtime_dir = 1, EE3.updatedAt <= @vtime_date, EE3.updatedAt >= @vtime_date))
        ) TotEndorsers
        WHERE E.argumentID = argID AND E.active = TRUE
        GROUP BY E.explicationID, E.hyperlink, E.publisher, E.authorFName, E.authorLName, E.title, E.firstVisit, E.og_title, E.og_image, E.og_description, TotEndorsers.cnt
        ORDER BY avgWeight DESC, E.firstVisit ASC;
    END IF;
END //
DELIMITER ;

-- Step 4: Deactivate a user's existing explication endorsements before inserting new ones
DROP PROCEDURE IF EXISTS prepareForNewExplicationEndorse;
DELIMITER //
CREATE PROCEDURE prepareForNewExplicationEndorse(IN argID INT, IN proID INT)
BEGIN
    UPDATE EXPLICATION_ENDORSE
    SET active = FALSE
    WHERE argumentID = argID AND profileID = proID AND active = TRUE;
END //
DELIMITER ;
