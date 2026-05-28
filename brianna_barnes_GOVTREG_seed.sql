-- Brianna Barnes (profileID=2) — GOVTREG cluster
-- 59 args: 25 accept / 34 reject
-- Existing: 920(0✓)

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (59,   2, 1),
  (62,   2, 0),
  (63,   2, 0),
  (226,  2, 0),
  (227,  2, 0),
  (228,  2, 0),
  (275,  2, 0),
  (276,  2, 1),
  (277,  2, 1),
  (322,  2, 0),
  (323,  2, 1),
  (324,  2, 0),
  (325,  2, 0),
  (342,  2, 0),
  (343,  2, 1),
  (344,  2, 1),
  (345,  2, 0),
  (400,  2, 0),
  (401,  2, 0),
  (402,  2, 1),
  (403,  2, 0),
  (404,  2, 0),
  (405,  2, 0),
  (406,  2, 1),
  (407,  2, 0),
  (408,  2, 1),
  (409,  2, 1),
  (410,  2, 0),
  (411,  2, 1),
  (412,  2, 0),
  (447,  2, 0),
  (448,  2, 1),
  (450,  2, 1),
  (451,  2, 1),
  (564,  2, 1),
  (565,  2, 0),
  (566,  2, 0),
  (569,  2, 0),
  (570,  2, 1),
  (668,  2, 1),
  (669,  2, 1),
  (670,  2, 1),
  (671,  2, 1),
  (672,  2, 0),
  (689,  2, 0),
  (704,  2, 1),
  (705,  2, 0),
  (706,  2, 0),
  (707,  2, 0),
  (708,  2, 1),
  (920,  2, 0),
  (1045, 2, 0),
  (1049, 2, 1),
  (1050, 2, 0),
  (1051, 2, 0),
  (1052, 2, 0),
  (1053, 2, 1),
  (1054, 2, 0),
  (1442, 2, 1);

-- PHRASINGS (25 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (59, 'Means testing adds bureaucracy, stigma, and barriers that cost more to administer than they save — universal programs work better.', 2);
CALL updatePhrasingCache(59);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (276, 'There is nothing structurally inferior about a government enterprise — the question is whether it\'s well-run and well-resourced, not who runs it.', 2);
CALL updatePhrasingCache(276);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (277, 'Some things — national defense, public health infrastructure, universal education — are better run by government than by profit-seeking entities.', 2);
CALL updatePhrasingCache(277);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (323, 'Government is run by fallible humans — design the system with checks and accountability to account for that, not with naive faith in officials.', 2);
CALL updatePhrasingCache(323);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (343, 'Policy that tries too hard and falls short is recoverable — policy that never tries leaves the problem to fester. Err on the side of action.', 2);
CALL updatePhrasingCache(343);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (344, 'If evidence shows a program works, fund it — results matter more than ideology about which budget line it comes from.', 2);
CALL updatePhrasingCache(344);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (402, 'Markets are legal constructs — property rights, contract enforcement, anti-fraud rules — built by governments. There\'s no "free market" that exists outside the law.', 2);
CALL updatePhrasingCache(402);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (406, 'Power concentrates and self-perpetuates — the Founders understood this, which is why checks and balances exist. Vigilance about power isn\'t paranoia, it\'s maintenance.', 2);
CALL updatePhrasingCache(406);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (408, 'Underfunded government means agencies that can\'t do their jobs — if you want effective regulation and services, you have to resource them.', 2);
CALL updatePhrasingCache(408);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (409, 'Accountability mechanisms matter in any organization — the solution to inefficient government is better accountability, not elimination.', 2);
CALL updatePhrasingCache(409);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (411, 'A hundred poorly enforced rules do less good than ten well-enforced ones — regulatory quality and enforcement capacity matter more than volume.', 2);
CALL updatePhrasingCache(411);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (448, 'The core civic obligation is looking out for people around you — without that, no government program or policy holds together.', 2);
CALL updatePhrasingCache(448);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (450, 'When the private economy contracts, government spending is what fills the gap — that\'s the Keynesian lesson learned in the Depression and relearned in every recession since.', 2);
CALL updatePhrasingCache(450);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (451, 'Inflation fears consistently exceed inflation outcomes — the pattern of treating modest deficit spending as imminent hyperinflation has been wrong for forty years.', 2);
CALL updatePhrasingCache(451);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (564, 'A government that has stopped representing the people it governs has lost its claim to authority — that\'s the bedrock principle of democratic legitimacy.', 2);
CALL updatePhrasingCache(564);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (570, 'We built a representative republic with enumerated rights and accountable government — that structure is worth defending even when it\'s inconvenient.', 2);
CALL updatePhrasingCache(570);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (668, 'When multiple layers of government are chasing the same dollar and duplicating the same functions, consolidation is efficient government — not an attack on it.', 2);
CALL updatePhrasingCache(668);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (669, 'Two HR departments, two pension systems, two administrations for the same territory — consolidation is just basic organizational sense.', 2);
CALL updatePhrasingCache(669);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (670, 'A small jurisdiction with overlapping tiers of government is serving the bureaucracy, not the residents — streamline it.', 2);
CALL updatePhrasingCache(670);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (671, 'Government should be sized to the job, not the other way around — every unnecessary layer is overhead that isn\'t serving anyone.', 2);
CALL updatePhrasingCache(671);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (704, 'If you want collective action, you have to be willing to contribute — free-riding on others\' sacrifice is not a viable strategy.', 2);
CALL updatePhrasingCache(704);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (708, 'Vigilante justice is unaccountable and prone to targeting the wrong people — self-defense is different, but taking the law into your own hands on someone else\'s behalf is not.', 2);
CALL updatePhrasingCache(708);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1049, 'Reviewing outdated regulations is good governance — rules written in 1972 for 1972 conditions should be updated for the world we actually live in.', 2);
CALL updatePhrasingCache(1049);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1053, 'Government should serve the people under it, not perpetuate itself — that means clear rules, real accountability, and measuring outcomes rather than outputs.', 2);
CALL updatePhrasingCache(1053);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1442, 'If you can\'t define what good government looks like, you can\'t build it — the definition comes first.', 2);
CALL updatePhrasingCache(1442);
