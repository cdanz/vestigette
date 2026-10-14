-- Negotiable Terms — SQL helper function.
-- Deploy FIRST (before redeploying any proc that calls it), as root:
--   cat db/negotiable_term_functions.sql | ssh root@<production-host> \
--     'MYSQL_PWD=$(cat <path-to-root-only-password-file>) mysql -u root vestigette'
--
-- ntPhrasing(phrasing, value): bakes a term-bearing argument's median value into
-- its phrasing by replacing the [[value]] token with the formatted number. Used at
-- the SOURCE of every "other-argument" list/associated query so the token never
-- reaches a plain render site — an in-place column transform, so positional row
-- parsing is unaffected. Guaranteed no-op when the phrasing has no token (every
-- argument today) or when value is NULL. The index HEADER deliberately does NOT use
-- this — it keeps the raw token so PHP can wrap the value in the cddbYellow halo.
--
-- DETERMINISTIC NO SQL: pure string op, no table access — creatable under binlog
-- without SUPER, and safe to inline per-row.

USE vestigette;

DROP FUNCTION IF EXISTS ntPhrasing;
DELIMITER //
CREATE FUNCTION ntPhrasing(p VARCHAR(300), v DECIMAL(24,8))
RETURNS VARCHAR(400)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE s   VARCHAR(64);
    DECLARE ip  VARCHAR(48);
    DECLARE fp  VARCHAR(16);
    DECLARE res VARCHAR(64);
    IF p IS NULL OR v IS NULL OR LOCATE('[[value]]', p) = 0 THEN
        RETURN p;
    END IF;
    -- Trim trailing zeros then a dangling decimal point: 3.50000000 -> 3.5, 4.00000000 -> 4.
    SET s  = TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM CAST(v AS CHAR)));
    SET ip = SUBSTRING_INDEX(s, '.', 1);                                  -- integer part (keeps sign)
    SET fp = IF(LOCATE('.', s) > 0, SUBSTRING_INDEX(s, '.', -1), '');     -- trimmed fraction, if any
    -- Group the integer part in threes with commas (matches PHP nt_format_value).
    SET res = FORMAT(CAST(ip AS DECIMAL(24,0)), 0);
    IF fp <> '' THEN
        SET res = CONCAT(res, '.', fp);
    END IF;
    RETURN REPLACE(p, '[[value]]', res);
END //
DELIMITER ;
