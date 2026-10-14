-- Negotiable Terms — schema (v1)
-- A term-bearing argument carries a single dynamic numeric value ("negotiable term")
-- adjudicated separately from its phrasing. Each accepting user submits one absolute
-- value; the consensus is the median, cached on ARGUMENT.currentTermValue.
--
-- This is NOT an ENDORSEMENT: one absolute value per user (like OPINION), so the
-- 100%-per-user invariant does not apply here.
--
-- v1 scope: one term per argument, termType 'decimal' only. Units live in the phrasing
-- ($[[value]], [[value]] lbs). The [[value]] token marks the slot in every phrasing.
--
-- Deploy (MySQL 8 on the droplet):
--   cat db/negotiable_term_schema.sql | ssh root@<production-host> \
--     'cat > /tmp/nt.sql && MYSQL_PWD=$(cat <path-to-root-only-password-file>) mysql -u root vestigette < /tmp/nt.sql'
-- The ALTER is one-time (MySQL 8 has no ADD COLUMN IF NOT EXISTS); re-running it errors
-- harmlessly on "Duplicate column". The CREATE TABLEs are idempotent.

USE vestigette;

-- ── ARGUMENT: two new columns ────────────────────────────────────────────────
-- Appended (no AFTER clause) so MySQL 8 uses the INSTANT algorithm — no rebuild,
-- no lock on this central table.
ALTER TABLE `ARGUMENT`
  ADD COLUMN `hasNegotiableTerm` tinyint(1) NOT NULL DEFAULT 0,
  ADD COLUMN `currentTermValue` decimal(24,8) DEFAULT NULL;

-- ── NEGOTIABLE_TERM: one row per term-bearing argument ───────────────────────
-- Thin in v1 (a type marker). Own PK + UNIQUE(argumentID) enforces one-per-arg now
-- but leaves the table multi-ready. termType is the dispatch seam for future types
-- (integer / percent / currency / range / date / enum / formula).
CREATE TABLE IF NOT EXISTS `NEGOTIABLE_TERM` (
  `termID` int unsigned NOT NULL AUTO_INCREMENT,
  `argumentID` int unsigned NOT NULL,
  `termType` varchar(20) NOT NULL DEFAULT 'decimal',
  `createdBy` int unsigned NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`termID`),
  UNIQUE KEY `uq_argument` (`argumentID`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `NEGOTIABLE_TERM_ibfk_1` FOREIGN KEY (`argumentID`) REFERENCES `ARGUMENT` (`argumentID`),
  CONSTRAINT `NEGOTIABLE_TERM_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `USER_PROFILE` (`profileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ── TERM_VALUE: per-user submitted value ─────────────────────────────────────
-- Modeled on PHRASE_ENDORSE: re-submission deactivates the prior active row
-- (prepareForNewTermValue) rather than updating in place, preserving history.
CREATE TABLE IF NOT EXISTS `TERM_VALUE` (
  `termValueID` int unsigned NOT NULL AUTO_INCREMENT,
  `argumentID` int unsigned NOT NULL,
  `termID` int unsigned NOT NULL,
  `profileID` int unsigned NOT NULL,
  `value` decimal(24,8) NOT NULL,
  `firstVisit` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastVisit` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`termValueID`),
  KEY `argumentID` (`argumentID`),
  KEY `termID` (`termID`),
  KEY `profileID` (`profileID`),
  KEY `idx_active_median` (`termID`,`active`,`value`),
  CONSTRAINT `TERM_VALUE_ibfk_1` FOREIGN KEY (`argumentID`) REFERENCES `ARGUMENT` (`argumentID`),
  CONSTRAINT `TERM_VALUE_ibfk_2` FOREIGN KEY (`termID`) REFERENCES `NEGOTIABLE_TERM` (`termID`),
  CONSTRAINT `TERM_VALUE_ibfk_3` FOREIGN KEY (`profileID`) REFERENCES `USER_PROFILE` (`profileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ── SCOPE_TERM_VALUE: group context for each value submission ─────────────────
-- The fifth SCOPE table. Mirrors SCOPE_PHRASE_ENDORSE exactly (no FKs, composite PK).
-- Inserted with @active_aff_id on submit; backs group/opinion filtering of the median.
CREATE TABLE IF NOT EXISTS `SCOPE_TERM_VALUE` (
  `profileID` int unsigned NOT NULL,
  `argumentID` int unsigned NOT NULL,
  `affiliationID` int NOT NULL,
  PRIMARY KEY (`profileID`,`argumentID`,`affiliationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
