-- Stored procedure for merging two arguments.
-- mergeArguments(keepID, dropID)
--   - All relationships pointing to dropID are re-pointed to keepID.
--   - Target (keepID) wins all conflicts.
--   - dropID is deleted after all references are migrated.
--   - Redirect behaviour is handled separately (TODO).

USE vestigette;

DROP PROCEDURE IF EXISTS mergeArguments;
DELIMITER //
CREATE PROCEDURE mergeArguments(IN keepID INT UNSIGNED, IN dropID INT UNSIGNED)
BEGIN

    -- Guard: must be distinct arguments
    IF keepID = dropID THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot merge an argument with itself';
    END IF;

    -- ── 1. OPINION ──────────────────────────────────────────────────────────
    -- Target wins: delete drop's row when user already has an opinion on keep
    DELETE op_drop
    FROM   OPINION op_drop
    INNER  JOIN OPINION op_keep
           ON  op_keep.argumentID = keepID
           AND op_keep.profileID  = op_drop.profileID
    WHERE  op_drop.argumentID = dropID;

    UPDATE OPINION SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 2. ENDORSEMENT — targArgID column ───────────────────────────────────
    -- Self-loop guard: drop-supports-keep would become keep-supports-keep
    DELETE FROM ENDORSEMENT
    WHERE  targArgID = dropID AND supportingArgID = keepID;

    -- Conflict: identical (keepID, profileID, endorseType, supportingArgID, active) exists
    DELETE e_drop
    FROM   ENDORSEMENT e_drop
    INNER  JOIN ENDORSEMENT e_keep
           ON  e_keep.targArgID       = keepID
           AND e_keep.profileID       = e_drop.profileID
           AND e_keep.endorseType     = e_drop.endorseType
           AND e_keep.supportingArgID = e_drop.supportingArgID
           AND e_keep.active          = e_drop.active
    WHERE  e_drop.targArgID = dropID;

    UPDATE ENDORSEMENT SET targArgID = keepID WHERE targArgID = dropID;

    -- ── 3. ENDORSEMENT — supportingArgID column ─────────────────────────────
    -- Self-loop guard: keep-supports-drop would become keep-supports-keep
    DELETE FROM ENDORSEMENT
    WHERE  supportingArgID = dropID AND targArgID = keepID;

    -- Conflict: identical (targArgID, profileID, endorseType, keepID, active) exists
    DELETE e_drop
    FROM   ENDORSEMENT e_drop
    INNER  JOIN ENDORSEMENT e_keep
           ON  e_keep.targArgID       = e_drop.targArgID
           AND e_keep.profileID       = e_drop.profileID
           AND e_keep.endorseType     = e_drop.endorseType
           AND e_keep.supportingArgID = keepID
           AND e_keep.active          = e_drop.active
    WHERE  e_drop.supportingArgID = dropID;

    UPDATE ENDORSEMENT SET supportingArgID = keepID WHERE supportingArgID = dropID;

    -- ── 4. PHRASING ─────────────────────────────────────────────────────────
    -- phrasingID is a unique auto-increment — no PK conflict possible
    UPDATE PHRASING SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 5. PHRASE_ENDORSE ───────────────────────────────────────────────────
    -- If user already has active phrasing endorsements on keep, deactivate their
    -- drop rows (they will still be transferred so the history is preserved)
    UPDATE PHRASE_ENDORSE pe_drop
    INNER  JOIN PHRASE_ENDORSE pe_keep
           ON  pe_keep.argumentID = keepID
           AND pe_keep.profileID  = pe_drop.profileID
           AND pe_keep.active     = TRUE
    SET    pe_drop.active = FALSE
    WHERE  pe_drop.argumentID = dropID AND pe_drop.active = TRUE;

    UPDATE PHRASE_ENDORSE SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 6. EXPLICATION ──────────────────────────────────────────────────────
    -- explicationID is unique auto-increment — no PK conflict possible
    UPDATE EXPLICATION SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 7. EXPLICATION_ENDORSE ──────────────────────────────────────────────
    -- Same active-conflict pattern as PHRASE_ENDORSE
    UPDATE EXPLICATION_ENDORSE ee_drop
    INNER  JOIN EXPLICATION_ENDORSE ee_keep
           ON  ee_keep.argumentID = keepID
           AND ee_keep.profileID  = ee_drop.profileID
           AND ee_keep.active     = TRUE
    SET    ee_drop.active = FALSE
    WHERE  ee_drop.argumentID = dropID AND ee_drop.active = TRUE;

    UPDATE EXPLICATION_ENDORSE SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 8. PHRASING_ARCHIVE ─────────────────────────────────────────────────
    UPDATE PHRASING_ARCHIVE SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 9. PUT_FORTH_ARCHIVE ────────────────────────────────────────────────
    -- Composite PK (argumentID, putForthID): delete drop rows that would collide
    DELETE pa_drop
    FROM   PUT_FORTH_ARCHIVE pa_drop
    INNER  JOIN PUT_FORTH_ARCHIVE pa_keep
           ON  pa_keep.argumentID = keepID
           AND pa_keep.putForthID = pa_drop.putForthID
    WHERE  pa_drop.argumentID = dropID;

    UPDATE PUT_FORTH_ARCHIVE SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 10. Refresh phrasing cache on target ────────────────────────────────
    CALL updatePhrasingCache(keepID);

    -- ── 11. Record redirect so old URLs resolve to the new argument ─────────
    INSERT INTO ARGUMENT_REDIRECT (oldArgumentID, newArgumentID)
    VALUES (dropID, keepID)
    ON DUPLICATE KEY UPDATE newArgumentID = keepID, mergedAt = CURRENT_TIMESTAMP;

    -- ── 12. Delete source argument ──────────────────────────────────────────
    -- All FK-constrained references have been migrated above.
    DELETE FROM ARGUMENT WHERE argumentID = dropID;

END //
DELIMITER ;
