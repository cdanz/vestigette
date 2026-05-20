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

-- Step 3: Replace getExplication procedure
-- Returns all active explications with weighted endorsement totals,
-- sorted by endorsement count DESC then submission date ASC.
DROP PROCEDURE IF EXISTS getExplication;
DELIMITER //
CREATE PROCEDURE getExplication(IN argID INT)
BEGIN
    SELECT
        COALESCE(SUM(CASE WHEN EE.active = TRUE THEN EE.weight ELSE 0 END), 0) AS totalWeight,
        COUNT(CASE WHEN EE.active = TRUE THEN EE.profileID ELSE NULL END) AS endorsementCount,
        E.explicationID,
        E.hyperlink,
        E.publisher,
        E.authorFName,
        E.authorLName,
        E.title
    FROM EXPLICATION E
    LEFT JOIN EXPLICATION_ENDORSE EE ON E.explicationID = EE.explicationID AND EE.argumentID = argID
    WHERE E.argumentID = argID AND E.active = TRUE
    GROUP BY E.explicationID, E.hyperlink, E.publisher, E.authorFName, E.authorLName, E.title, E.firstVisit
    ORDER BY endorsementCount DESC, E.firstVisit ASC;
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
