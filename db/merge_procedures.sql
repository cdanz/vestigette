-- Stored procedure for merging two arguments.
-- mergeArguments(keepID, dropID)
--   - dropID's content is merged into keepID; dropID is then deleted.
--   - ENDORSEMENT support-merge SUMS weights (conserves each user's 100% total).
--   - ENDORSEMENT target-merge is KEEP-WINS (a user's keep distribution wins;
--     their drop distribution of that type is discarded — two 100% distributions
--     are never stacked).
--   - OPINION / PHRASE_ENDORSE / EXPLICATION / EXPLICATION_ENDORSE are keep-wins.
--   - Writes ARGUMENT_REDIRECT (dropID -> keepID) so old URLs resolve.
--
-- Unique constraints that drive the dedupe logic:
--   ENDORSEMENT  PK (targArgID, profileID, endorseType, supportingArgID, active)
--   EXPLICATION  UNIQUE (argumentID, profileID)
--   OPINION      PK (argumentID, profileID)
--   PHRASE_ENDORSE / EXPLICATION_ENDORSE: autoincrement PK (no migrate collision)

USE vestigette;

DROP PROCEDURE IF EXISTS mergeArguments;
DELIMITER //
CREATE PROCEDURE mergeArguments(IN keepID INT UNSIGNED, IN dropID INT UNSIGNED)
BEGIN

    IF keepID = dropID THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot merge an argument with itself';
    END IF;

    -- ── 1. OPINION — keep wins ──────────────────────────────────────────────
    DELETE op_drop
    FROM   OPINION op_drop
    INNER  JOIN OPINION op_keep
           ON op_keep.argumentID = keepID AND op_keep.profileID = op_drop.profileID
    WHERE  op_drop.argumentID = dropID;
    UPDATE OPINION SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 2. ENDORSEMENT — targArgID (target-merge) — KEEP WINS ────────────────
    -- Self-loop: drop-supports-keep would become keep-supports-keep
    DELETE FROM ENDORSEMENT WHERE targArgID = dropID AND supportingArgID = keepID;
    -- Keep wins: if the user already has ANY endorsement of this type on keep,
    -- discard their whole drop distribution of that type (don't stack two 100%s).
    DELETE e_drop
    FROM   ENDORSEMENT e_drop
    INNER  JOIN (SELECT DISTINCT profileID, endorseType
                 FROM ENDORSEMENT WHERE targArgID = keepID) k
           ON k.profileID = e_drop.profileID AND k.endorseType = e_drop.endorseType
    WHERE  e_drop.targArgID = dropID;
    -- Migrate the rest (users with no keep distribution of that type)
    UPDATE ENDORSEMENT SET targArgID = keepID WHERE targArgID = dropID;

    -- ── 3. ENDORSEMENT — supportingArgID (support-merge) — SUM WEIGHTS ───────
    -- Self-loop: keep-supports-drop would become keep-supports-keep
    DELETE FROM ENDORSEMENT WHERE supportingArgID = dropID AND targArgID = keepID;
    -- Collision: this (targArgID, profile, type, active) already supports keep.
    -- SUM drop's weight into keep so the user's distribution still totals 100%.
    UPDATE ENDORSEMENT e_keep
    INNER  JOIN ENDORSEMENT e_drop
           ON  e_drop.targArgID       = e_keep.targArgID
           AND e_drop.profileID       = e_keep.profileID
           AND e_drop.endorseType     = e_keep.endorseType
           AND e_drop.active          = e_keep.active
           AND e_keep.supportingArgID = keepID
           AND e_drop.supportingArgID = dropID
    SET    e_keep.weight = e_keep.weight + e_drop.weight;
    -- Remove the now-summed drop rows (they would collide on migrate)
    DELETE e_drop
    FROM   ENDORSEMENT e_drop
    INNER  JOIN ENDORSEMENT e_keep
           ON  e_keep.targArgID       = e_drop.targArgID
           AND e_keep.profileID       = e_drop.profileID
           AND e_keep.endorseType     = e_drop.endorseType
           AND e_keep.active          = e_drop.active
           AND e_keep.supportingArgID = keepID
    WHERE  e_drop.supportingArgID = dropID;
    -- Migrate the rest
    UPDATE ENDORSEMENT SET supportingArgID = keepID WHERE supportingArgID = dropID;

    -- ── 3b. Renormalize keep distributions broken by self-loop removal ──────
    -- A user who supported keep WITH drop (or drop WITH keep) created a
    -- self-loop on merge, which is logically meaningless and is deleted above.
    -- That deletion drops their distribution below 100%, so rescale each
    -- affected keep distribution back to 100% — this preserves the relative
    -- weights of the user's genuine remaining supports. Distributions already
    -- at 100% are left untouched; ones whose only support was the duplicate
    -- itself vanish entirely (no rows, no violation).
    UPDATE ENDORSEMENT e
    INNER  JOIN (
        SELECT profileID, endorseType, active, SUM(weight) AS tot
        FROM   ENDORSEMENT
        WHERE  targArgID = keepID
        GROUP  BY profileID, endorseType, active
        HAVING ABS(SUM(weight) - 100) > 0.0001 AND SUM(weight) > 0
    ) d ON d.profileID = e.profileID
       AND d.endorseType = e.endorseType
       AND d.active = e.active
    SET    e.weight = e.weight * 100 / d.tot
    WHERE  e.targArgID = keepID;

    -- ── 4. PHRASING — migrate (phrasingID unique, no collision) ─────────────
    UPDATE PHRASING SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 5. PHRASE_ENDORSE — keep wins on active, migrate (autoincrement PK) ──
    UPDATE PHRASE_ENDORSE pe_drop
    INNER  JOIN PHRASE_ENDORSE pe_keep
           ON pe_keep.argumentID = keepID AND pe_keep.profileID = pe_drop.profileID
           AND pe_keep.active = TRUE
    SET    pe_drop.active = FALSE
    WHERE  pe_drop.argumentID = dropID AND pe_drop.active = TRUE;
    UPDATE PHRASE_ENDORSE SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 6. EXPLICATION — keep wins on (argumentID, profileID) unique key ────
    -- First remove endorsements of the drop explications that will be deleted
    DELETE ee
    FROM   EXPLICATION_ENDORSE ee
    INNER  JOIN EXPLICATION ex_drop
           ON ex_drop.explicationID = ee.explicationID AND ex_drop.argumentID = dropID
    INNER  JOIN EXPLICATION ex_keep
           ON ex_keep.argumentID = keepID AND ex_keep.profileID = ex_drop.profileID;
    -- Delete drop's duplicate explication rows (keep wins)
    DELETE ex_drop
    FROM   EXPLICATION ex_drop
    INNER  JOIN EXPLICATION ex_keep
           ON ex_keep.argumentID = keepID AND ex_keep.profileID = ex_drop.profileID
    WHERE  ex_drop.argumentID = dropID;
    -- Migrate the rest
    UPDATE EXPLICATION SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 7. EXPLICATION_ENDORSE — keep wins on active, migrate argumentID ────
    UPDATE EXPLICATION_ENDORSE ee_drop
    INNER  JOIN EXPLICATION_ENDORSE ee_keep
           ON ee_keep.argumentID = keepID AND ee_keep.profileID = ee_drop.profileID
           AND ee_keep.active = TRUE
    SET    ee_drop.active = FALSE
    WHERE  ee_drop.argumentID = dropID AND ee_drop.active = TRUE;
    UPDATE EXPLICATION_ENDORSE SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 8. Archives ─────────────────────────────────────────────────────────
    UPDATE PHRASING_ARCHIVE SET argumentID = keepID WHERE argumentID = dropID;
    DELETE pa_drop
    FROM   PUT_FORTH_ARCHIVE pa_drop
    INNER  JOIN PUT_FORTH_ARCHIVE pa_keep
           ON pa_keep.argumentID = keepID AND pa_keep.putForthID = pa_drop.putForthID
    WHERE  pa_drop.argumentID = dropID;
    UPDATE PUT_FORTH_ARCHIVE SET argumentID = keepID WHERE argumentID = dropID;

    -- ── 9. Cache, redirect, delete source ───────────────────────────────────
    CALL updatePhrasingCache(keepID);
    INSERT INTO ARGUMENT_REDIRECT (oldArgumentID, newArgumentID)
    VALUES (dropID, keepID)
    ON DUPLICATE KEY UPDATE newArgumentID = keepID, mergedAt = CURRENT_TIMESTAMP;
    DELETE FROM ARGUMENT WHERE argumentID = dropID;

END //
DELIMITER ;
