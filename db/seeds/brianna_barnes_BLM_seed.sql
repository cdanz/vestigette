-- Brianna Barnes (profileID=2) — BLM cluster
-- 37 args: 22 accept / 15 reject
-- Note: 546, 1202, 1313, 1314, 1319, 1320, 1321 already in DB (all match intended stances — no UPDATEs needed)
-- Note: 764 is a misplaced Fish/Game arg; Brianna rejects it (supports regulatory oversight)

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (546,  2, 1),
  (547,  2, 0),
  (548,  2, 0),
  (549,  2, 0),
  (551,  2, 1),
  (552,  2, 1),
  (553,  2, 1),
  (554,  2, 0),
  (555,  2, 0),
  (556,  2, 0),
  (557,  2, 1),
  (558,  2, 1),
  (759,  2, 0),
  (760,  2, 0),
  (761,  2, 0),
  (763,  2, 1),
  (764,  2, 0),
  (765,  2, 0),
  (766,  2, 1),
  (767,  2, 1),
  (768,  2, 1),
  (771,  2, 0),
  (1202, 2, 1),
  (1313, 2, 1),
  (1314, 2, 1),
  (1315, 2, 1),
  (1316, 2, 1),
  (1317, 2, 0),
  (1318, 2, 1),
  (1319, 2, 0),
  (1320, 2, 0),
  (1321, 2, 1),
  (1322, 2, 1),
  (1323, 2, 1),
  (1324, 2, 1),
  (1325, 2, 1),
  (1326, 2, 1);

-- PHRASINGS (22 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (546, 'BLM organizers put their bodies on the line for a cause that is plainly right — they deserve support.', 2);
CALL updatePhrasingCache(546);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (551, 'BLM is a peaceful movement — the violence around it comes from those trying to stop it, not lead it.', 2);
CALL updatePhrasingCache(551);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (552, 'The Proud Boys are a violent street gang with a political logo.', 2);
CALL updatePhrasingCache(552);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (553, 'Boogaloo adherents are armed extremists — treating them as a legitimate political tendency is a mistake.', 2);
CALL updatePhrasingCache(553);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (557, 'Antifa didn\'t appear from nowhere — it\'s a response to organized fascist activity that was already happening.', 2);
CALL updatePhrasingCache(557);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (558, 'People who organize against fascism deserve solidarity, not condemnation.', 2);
CALL updatePhrasingCache(558);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (763, 'Anti-fascist researchers do painstaking, thankless work — and communities are measurably safer for it.', 2);
CALL updatePhrasingCache(763);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (766, 'Exposing who Nazis actually are, in their own communities, is exactly how you shrink them.', 2);
CALL updatePhrasingCache(766);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (767, 'Fascists count on being taken seriously — humiliation is an underrated and effective tool against them.', 2);
CALL updatePhrasingCache(767);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (768, 'Antifa researchers put in real, unglamorous hours to keep communities safe from organized extremism.', 2);
CALL updatePhrasingCache(768);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1202, 'Study after study confirmed what organizers said: BLM protests were overwhelmingly peaceful.', 2);
CALL updatePhrasingCache(1202);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1313, 'BLM is about one thing: Black people deserving to live without fear of the state that is supposed to protect them.', 2);
CALL updatePhrasingCache(1313);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1314, 'Black Americans\' fear of police isn\'t irrational — it is calibrated to a documented reality.', 2);
CALL updatePhrasingCache(1314);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1315, 'Expecting the justice system to under-deliver for Black victims isn\'t pessimism — it\'s pattern recognition.', 2);
CALL updatePhrasingCache(1315);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1316, 'The data on clearance rates and prosecution patterns backs up what Black communities have always said.', 2);
CALL updatePhrasingCache(1316);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1318, 'Unsolved crimes against Black victims aren\'t a coincidence — they\'re a structural failure.', 2);
CALL updatePhrasingCache(1318);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1321, 'BLM is not a claim that Black lives matter more — it is a demand that they stop mattering less.', 2);
CALL updatePhrasingCache(1321);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1322, '\'Black lives matter, too\' — the \'too\' was always implied; the resistance to hearing it tells you everything.', 2);
CALL updatePhrasingCache(1322);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1323, 'BLM asks the country to live up to the value it claims to hold — that all lives matter, including Black ones.', 2);
CALL updatePhrasingCache(1323);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1324, 'When someone changes the subject the moment Black lives come up, the subject-change is the point.', 2);
CALL updatePhrasingCache(1324);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1325, 'A cop\'s subjective fear is treated as legal justification — a Black person\'s documented danger is treated as provocation.', 2);
CALL updatePhrasingCache(1325);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1326, 'Victims of police killings are held to an impossible standard: perfect calm, perfect compliance, perfect foreknowledge of what an officer needed.', 2);
CALL updatePhrasingCache(1326);
