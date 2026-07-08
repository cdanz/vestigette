-- Persona retirement: gradually remove AI-persona scaffolding as human engagement grows.
-- retirePersonaFromArgument removes one persona's full contribution to one argument:
-- their endorsements, phrasing/explication endorsements, and opinion. Phrasings and
-- explications they submitted are pruned only if no active human endorsements remain.
--
-- Deploy this file BEFORE core_procedures.sql — assertOpinion calls this procedure.
-- Deploy: ssh root@178.128.74.45 "mysql vestigette" < persona_retirement_procedures.sql

USE vestigette;

DROP PROCEDURE IF EXISTS retirePersonaFromArgument;
DELIMITER //
CREATE PROCEDURE retirePersonaFromArgument(IN personaID INT UNSIGNED, IN argID INT UNSIGNED)
BEGIN
    -- 1. Remove persona's because/therefore/rebuttal endorsement weights
    DELETE FROM ENDORSEMENT WHERE profileID = personaID AND targArgID = argID;

    -- 2. Remove persona's phrasing endorsements
    DELETE FROM PHRASE_ENDORSE WHERE profileID = personaID AND argumentID = argID;

    -- 3. Remove persona's explication endorsements (their own and others' on this arg)
    DELETE FROM EXPLICATION_ENDORSE WHERE profileID = personaID AND argumentID = argID;

    -- 4. Prune any remaining persona PHRASE_ENDORSE rows for phrasings with no active
    --    human (profileID > 26) endorsements — these are now fully bot-only phrasings
    DELETE FROM PHRASE_ENDORSE
    WHERE argumentID = argID
      AND phrasingID NOT IN (
          SELECT phrasingID FROM (
              SELECT DISTINCT phrasingID FROM PHRASE_ENDORSE
              WHERE argumentID = argID AND profileID > 26 AND active = TRUE
          ) AS _hp
      );

    -- 5. Delete phrasings for this argument that now have no endorsers at all
    DELETE FROM PHRASING
    WHERE argumentID = argID
      AND phrasingID NOT IN (
          SELECT phrasingID FROM (
              SELECT DISTINCT phrasingID FROM PHRASE_ENDORSE WHERE argumentID = argID
          ) AS _pe
      );

    -- 6. If the cached phrasing winner was among the pruned rows, clear the cache
    --    so updatePhrasingCache can elect a new winner from what remains
    UPDATE ARGUMENT
    SET currentPhrasingID = NULL, currentPhrasing = NULL
    WHERE argumentID = argID
      AND currentPhrasingID IS NOT NULL
      AND currentPhrasingID NOT IN (
          SELECT phrasingID FROM (
              SELECT phrasingID FROM PHRASING WHERE argumentID = argID
          ) AS _rp
      );

    -- 7. Prune all EXPLICATION_ENDORSE rows for this persona's submitted explication
    --    if no active human endorsement exists for it
    DELETE EE FROM EXPLICATION_ENDORSE EE
    INNER JOIN EXPLICATION E ON EE.explicationID = E.explicationID
    WHERE E.profileID = personaID
      AND E.argumentID = argID
      AND E.explicationID NOT IN (
          SELECT explicationID FROM (
              SELECT DISTINCT explicationID FROM EXPLICATION_ENDORSE
              WHERE profileID > 26 AND active = TRUE
          ) AS _he
      );

    -- 8. Delete this persona's submitted explication if no human endorsed it
    DELETE FROM EXPLICATION
    WHERE profileID = personaID
      AND argumentID = argID
      AND explicationID NOT IN (
          SELECT explicationID FROM (
              SELECT DISTINCT explicationID FROM EXPLICATION_ENDORSE
              WHERE profileID > 26 AND active = TRUE
          ) AS _he2
      );

    -- 9. Remove the persona's opinion — badge disappears once all persona opinions are gone
    DELETE FROM OPINION WHERE profileID = personaID AND argumentID = argID;

    -- 10. Refresh the phrasing winner cache
    CALL updatePhrasingCache(argID);
END //
DELIMITER ;
