-- Argument flagging: schema + stored procedures.
--
-- Users (logged-in only) can flag an argument once with a single reason
-- category and an optional comment. Re-submitting updates their flag; the
-- user can also retract it. Admins resolve all active flags for an argument
-- in one click; resolved flags are retained for audit.
--
-- "One ACTIVE flag per user per argument" is enforced by the unique key
-- (argumentID, profileID, isActive): active rows carry isActive=1, resolved
-- rows carry isActive=NULL. MySQL treats NULLs as distinct in a unique index,
-- so any number of resolved (historical) rows coexist while at most one active
-- row per (argument, profile) is allowed.

USE vestigette;

CREATE TABLE IF NOT EXISTS ARGUMENT_FLAG (
    flagID         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    argumentID     INT UNSIGNED NOT NULL,
    profileID      INT UNSIGNED NOT NULL,
    reasonCategory ENUM('offensive','phrasing_mismatch','duplicate_assoc',
                        'spam','incoherent','other') NOT NULL,
    comment        VARCHAR(300) NULL,
    createdAt      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolvedAt     TIMESTAMP NULL DEFAULT NULL,
    resolvedBy     INT UNSIGNED NULL DEFAULT NULL,
    isActive       TINYINT NULL DEFAULT 1,
    PRIMARY KEY (flagID),
    UNIQUE KEY uq_active_flag (argumentID, profileID, isActive),
    KEY idx_arg_active (argumentID, isActive),
    KEY idx_profile (profileID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── flagArgument — create or update a user's active flag (upsert/toggle-edit) ──
DROP PROCEDURE IF EXISTS flagArgument;
DELIMITER //
CREATE PROCEDURE flagArgument(
    IN p_argID    INT UNSIGNED,
    IN p_profID   INT UNSIGNED,
    IN p_category VARCHAR(32),
    IN p_comment  VARCHAR(300))
BEGIN
    INSERT INTO ARGUMENT_FLAG (argumentID, profileID, reasonCategory, comment, isActive)
    VALUES (p_argID, p_profID, p_category, NULLIF(TRIM(p_comment), ''), 1)
    ON DUPLICATE KEY UPDATE
        reasonCategory = VALUES(reasonCategory),
        comment        = VALUES(comment),
        createdAt      = CURRENT_TIMESTAMP;
END //
DELIMITER ;

-- ── unflagArgument — retract a user's active flag ─────────────────────────────
DROP PROCEDURE IF EXISTS unflagArgument;
DELIMITER //
CREATE PROCEDURE unflagArgument(
    IN p_argID  INT UNSIGNED,
    IN p_profID INT UNSIGNED)
BEGIN
    DELETE FROM ARGUMENT_FLAG
    WHERE argumentID = p_argID AND profileID = p_profID AND isActive = 1;
END //
DELIMITER ;

-- ── resolveArgumentFlags — soft-resolve all active flags for an argument ──────
DROP PROCEDURE IF EXISTS resolveArgumentFlags;
DELIMITER //
CREATE PROCEDURE resolveArgumentFlags(
    IN p_argID   INT UNSIGNED,
    IN p_adminID INT UNSIGNED)
BEGIN
    UPDATE ARGUMENT_FLAG
    SET resolvedAt = CURRENT_TIMESTAMP,
        resolvedBy = p_adminID,
        isActive   = NULL
    WHERE argumentID = p_argID AND isActive = 1;
END //
DELIMITER ;
