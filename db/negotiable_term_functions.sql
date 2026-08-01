-- Negotiable Terms — SQL helper function.
-- Deploy FIRST (before redeploying any proc that calls it), as root:
--   cat db/negotiable_term_functions.sql | ssh root@178.128.74.45 \
--     'MYSQL_PWD=$(cat /root/.digitalocean_password) mysql -u root vestigette'
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
    IF p IS NULL OR v IS NULL OR LOCATE('[[value]]', p) = 0 THEN
        RETURN p;
    END IF;
    -- Trim trailing zeros then a dangling decimal point: 3.50000000 -> 3.5, 4.00000000 -> 4.
    RETURN REPLACE(p, '[[value]]',
        TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM CAST(v AS CHAR))));
END //
DELIMITER ;
