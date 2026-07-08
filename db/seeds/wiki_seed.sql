-- Wikipedia explication seed
-- 517 arguments to process
USE vestigette;

-- SKIPPED [1/517] argID=15: no Wikipedia result

-- SKIPPED [2/517] argID=23: no Wikipedia result

-- SKIPPED [3/517] argID=26: no Wikipedia result

-- SKIPPED [4/517] argID=32: no Wikipedia result

-- SKIPPED [5/517] argID=119: no Wikipedia result

-- SKIPPED [6/517] argID=127: no Wikipedia result

-- SKIPPED [7/517] argID=139: no Wikipedia result

-- [8/517] argID=140 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Second_Amendment_to_the_United_States_Constitution
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (140, 1, 'https://en.wikipedia.org/wiki/Second_Amendment_to_the_United_States_Constitution', '', '', '', 'Second Amendment to the United States Constitution', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 140 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 140, 1, 50.0, 1);

-- SKIPPED [9/517] argID=167: no Wikipedia result

-- SKIPPED [10/517] argID=174: no Wikipedia result

-- SKIPPED [11/517] argID=184: no Wikipedia result

-- SKIPPED [12/517] argID=202: no Wikipedia result

-- SKIPPED [13/517] argID=305: no Wikipedia result

-- SKIPPED [14/517] argID=306: no Wikipedia result

-- SKIPPED [15/517] argID=308: no Wikipedia result

-- SKIPPED [16/517] argID=349: no Wikipedia result

-- SKIPPED [17/517] argID=373: no Wikipedia result

-- [18/517] argID=375 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Development_communication
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (375, 2, 'https://en.wikipedia.org/wiki/Development_communication', '', '', '', 'Development communication', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 375 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 375, 2, 50.0, 1);

-- SKIPPED [19/517] argID=409: no Wikipedia result

-- SKIPPED [20/517] argID=531: no Wikipedia result

-- [21/517] argID=549 → profileID=1
-- URL: https://en.wikipedia.org/wiki/NSPM-7
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (549, 1, 'https://en.wikipedia.org/wiki/NSPM-7', '', '', '', 'NSPM-7', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 549 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 549, 1, 50.0, 1);

-- SKIPPED [22/517] argID=597: no Wikipedia result

-- SKIPPED [23/517] argID=608: no Wikipedia result

-- SKIPPED [24/517] argID=641: no Wikipedia result

-- SKIPPED [25/517] argID=647: no Wikipedia result

-- SKIPPED [26/517] argID=691: no Wikipedia result

-- SKIPPED [27/517] argID=697: no Wikipedia result

-- SKIPPED [28/517] argID=718: no Wikipedia result

-- SKIPPED [29/517] argID=722: no Wikipedia result

-- SKIPPED [30/517] argID=765: no Wikipedia result

-- SKIPPED [31/517] argID=768: no Wikipedia result

-- SKIPPED [32/517] argID=796: no Wikipedia result

-- SKIPPED [33/517] argID=860: no Wikipedia result

-- SKIPPED [34/517] argID=861: no Wikipedia result

-- SKIPPED [35/517] argID=866: no Wikipedia result

-- SKIPPED [36/517] argID=981: no Wikipedia result

-- [37/517] argID=1029 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Gangsta%27s_Paradise
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1029, 1, 'https://en.wikipedia.org/wiki/Gangsta%27s_Paradise', '', '', '', 'Gangsta\'s Paradise', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1029 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1029, 1, 50.0, 1);

-- [38/517] argID=1073 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Hey_Ya%21
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1073, 1, 'https://en.wikipedia.org/wiki/Hey_Ya%21', '', '', '', 'Hey Ya!', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1073 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1073, 1, 50.0, 1);

-- [39/517] argID=1074 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Flogging_Molly
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1074, 1, 'https://en.wikipedia.org/wiki/Flogging_Molly', '', '', '', 'Flogging Molly', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1074 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1074, 1, 50.0, 1);

-- [40/517] argID=1076 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Bryson_DeChambeau
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1076, 1, 'https://en.wikipedia.org/wiki/Bryson_DeChambeau', '', '', '', 'Bryson DeChambeau', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1076 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1076, 1, 50.0, 1);

-- [41/517] argID=1081 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Eternal_Sunshine_%28album%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1081, 1, 'https://en.wikipedia.org/wiki/Eternal_Sunshine_%28album%29', '', '', '', 'Eternal Sunshine (album)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1081 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1081, 1, 50.0, 1);

-- [42/517] argID=1082 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Tammy_Wynette
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1082, 1, 'https://en.wikipedia.org/wiki/Tammy_Wynette', '', '', '', 'Tammy Wynette', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1082 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1082, 1, 50.0, 1);

-- [43/517] argID=1083 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_2019_albums
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1083, 1, 'https://en.wikipedia.org/wiki/List_of_2019_albums', '', '', '', 'List of 2019 albums', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1083 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1083, 1, 50.0, 1);

-- [44/517] argID=1085 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Art
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1085, 1, 'https://en.wikipedia.org/wiki/Art', '', '', '', 'Art', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1085 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1085, 1, 50.0, 1);

-- [45/517] argID=1086 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Cultural_impact_of_Beyonc%C3%A9
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1086, 1, 'https://en.wikipedia.org/wiki/Cultural_impact_of_Beyonc%C3%A9', '', '', '', 'Cultural impact of Beyoncé', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1086 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1086, 1, 50.0, 1);

-- [46/517] argID=1088 → profileID=1
-- URL: https://en.wikipedia.org/wiki/2000s
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1088, 1, 'https://en.wikipedia.org/wiki/2000s', '', '', '', '2000s', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1088 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1088, 1, 50.0, 1);

-- [47/517] argID=1090 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Outliers_%28book%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1090, 1, 'https://en.wikipedia.org/wiki/Outliers_%28book%29', '', '', '', 'Outliers (book)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1090 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1090, 1, 50.0, 1);

-- [48/517] argID=1092 → profileID=1
-- URL: https://en.wikipedia.org/wiki/MGK
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1092, 1, 'https://en.wikipedia.org/wiki/MGK', '', '', '', 'MGK', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1092 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1092, 1, 50.0, 1);

-- [49/517] argID=1094 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Toy_gun
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1094, 1, 'https://en.wikipedia.org/wiki/Toy_gun', '', '', '', 'Toy gun', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1094 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1094, 1, 50.0, 1);

-- [50/517] argID=1095 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Late_capitalism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1095, 1, 'https://en.wikipedia.org/wiki/Late_capitalism', '', '', '', 'Late capitalism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1095 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1095, 1, 50.0, 1);

-- [51/517] argID=1096 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Crony_capitalism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1096, 1, 'https://en.wikipedia.org/wiki/Crony_capitalism', '', '', '', 'Crony capitalism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1096 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1096, 1, 50.0, 1);

-- [52/517] argID=1097 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Nudity
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1097, 1, 'https://en.wikipedia.org/wiki/Nudity', '', '', '', 'Nudity', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1097 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1097, 1, 50.0, 1);

-- [53/517] argID=1098 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Meme_marketing
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1098, 1, 'https://en.wikipedia.org/wiki/Meme_marketing', '', '', '', 'Meme marketing', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1098 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1098, 1, 50.0, 1);

-- [54/517] argID=1100 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Donald_Trump_sexual_misconduct_allegations
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1100, 1, 'https://en.wikipedia.org/wiki/Donald_Trump_sexual_misconduct_allegations', '', '', '', 'Donald Trump sexual misconduct allegations', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1100 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1100, 1, 50.0, 1);

-- [55/517] argID=1101 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Market_socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1101, 1, 'https://en.wikipedia.org/wiki/Market_socialism', '', '', '', 'Market socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1101 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1101, 1, 50.0, 1);

-- [56/517] argID=1102 → profileID=1
-- URL: https://en.wikipedia.org/wiki/1993_Michael_Jackson_sexual_abuse_allegations
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1102, 1, 'https://en.wikipedia.org/wiki/1993_Michael_Jackson_sexual_abuse_allegations', '', '', '', '1993 Michael Jackson sexual abuse allegations', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1102 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1102, 1, 50.0, 1);

-- [57/517] argID=1103 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Free_market
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1103, 1, 'https://en.wikipedia.org/wiki/Free_market', '', '', '', 'Free market', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1103 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1103, 1, 50.0, 1);

-- [58/517] argID=1104 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Glossary_of_baseball_terms
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1104, 1, 'https://en.wikipedia.org/wiki/Glossary_of_baseball_terms', '', '', '', 'Glossary of baseball terms', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1104 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1104, 1, 50.0, 1);

-- [59/517] argID=1105 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Meryl_Streep
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1105, 1, 'https://en.wikipedia.org/wiki/Meryl_Streep', '', '', '', 'Meryl Streep', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1105 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1105, 1, 50.0, 1);

-- [60/517] argID=1106 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Darknet_market
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1106, 1, 'https://en.wikipedia.org/wiki/Darknet_market', '', '', '', 'Darknet market', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1106 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1106, 1, 50.0, 1);

-- [61/517] argID=1107 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Stock_market_bubble
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1107, 1, 'https://en.wikipedia.org/wiki/Stock_market_bubble', '', '', '', 'Stock market bubble', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1107 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1107, 1, 50.0, 1);

-- [62/517] argID=1108 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Brooklyn_Bridge
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1108, 1, 'https://en.wikipedia.org/wiki/Brooklyn_Bridge', '', '', '', 'Brooklyn Bridge', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1108 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1108, 1, 50.0, 1);

-- [63/517] argID=1109 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Economic_democracy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1109, 1, 'https://en.wikipedia.org/wiki/Economic_democracy', '', '', '', 'Economic democracy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1109 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1109, 1, 50.0, 1);

-- [64/517] argID=1110 → profileID=1
-- URL: https://en.wikipedia.org/wiki/1993_Michael_Jackson_sexual_abuse_allegations
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1110, 1, 'https://en.wikipedia.org/wiki/1993_Michael_Jackson_sexual_abuse_allegations', '', '', '', '1993 Michael Jackson sexual abuse allegations', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1110 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1110, 1, 50.0, 1);

-- [65/517] argID=1111 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Leaving_Neverland
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1111, 1, 'https://en.wikipedia.org/wiki/Leaving_Neverland', '', '', '', 'Leaving Neverland', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1111 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1111, 1, 50.0, 1);

-- [66/517] argID=1112 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Microsoft
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1112, 1, 'https://en.wikipedia.org/wiki/Microsoft', '', '', '', 'Microsoft', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1112 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1112, 1, 50.0, 1);

-- [67/517] argID=1113 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Reasonable_doubt
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1113, 1, 'https://en.wikipedia.org/wiki/Reasonable_doubt', '', '', '', 'Reasonable doubt', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1113 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1113, 1, 50.0, 1);

-- [68/517] argID=1115 → profileID=1
-- URL: https://en.wikipedia.org/wiki/White_House_Farm_murders
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1115, 1, 'https://en.wikipedia.org/wiki/White_House_Farm_murders', '', '', '', 'White House Farm murders', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1115 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1115, 1, 50.0, 1);

-- [69/517] argID=1119 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Michael_%282026_film%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1119, 1, 'https://en.wikipedia.org/wiki/Michael_%282026_film%29', '', '', '', 'Michael (2026 film)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1119 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1119, 1, 50.0, 1);

-- [70/517] argID=1120 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Tina_Peters_%28politician%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1120, 1, 'https://en.wikipedia.org/wiki/Tina_Peters_%28politician%29', '', '', '', 'Tina Peters (politician)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1120 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1120, 1, 50.0, 1);

-- [71/517] argID=1121 → profileID=1
-- URL: https://en.wikipedia.org/wiki/X_%28social_network%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1121, 1, 'https://en.wikipedia.org/wiki/X_%28social_network%29', '', '', '', 'X (social network)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1121 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1121, 1, 50.0, 1);

-- [72/517] argID=1122 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Mike_Pence
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1122, 2, 'https://en.wikipedia.org/wiki/Mike_Pence', '', '', '', 'Mike Pence', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1122 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1122, 2, 50.0, 1);

-- [73/517] argID=1124 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Joe_Jackson_%28talent_manager%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1124, 1, 'https://en.wikipedia.org/wiki/Joe_Jackson_%28talent_manager%29', '', '', '', 'Joe Jackson (talent manager)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1124 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1124, 1, 50.0, 1);

-- [74/517] argID=1125 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_actors_who_have_played_the_president_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1125, 1, 'https://en.wikipedia.org/wiki/List_of_actors_who_have_played_the_president_of_the_United_States', '', '', '', 'List of actors who have played the president of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1125 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1125, 1, 50.0, 1);

-- [75/517] argID=1126 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_actors_who_have_played_the_president_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1126, 1, 'https://en.wikipedia.org/wiki/List_of_actors_who_have_played_the_president_of_the_United_States', '', '', '', 'List of actors who have played the president of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1126 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1126, 1, 50.0, 1);

-- [76/517] argID=1127 → profileID=1
-- URL: https://en.wikipedia.org/wiki/James_Brown
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1127, 1, 'https://en.wikipedia.org/wiki/James_Brown', '', '', '', 'James Brown', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1127 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1127, 1, 50.0, 1);

-- [77/517] argID=1128 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Willie_Brown_%28politician%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1128, 1, 'https://en.wikipedia.org/wiki/Willie_Brown_%28politician%29', '', '', '', 'Willie Brown (politician)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1128 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1128, 1, 50.0, 1);

-- [78/517] argID=1129 → profileID=1
-- URL: https://en.wikipedia.org/wiki/2024_United_States_presidential_election
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1129, 1, 'https://en.wikipedia.org/wiki/2024_United_States_presidential_election', '', '', '', '2024 United States presidential election', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1129 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1129, 1, 50.0, 1);

-- [79/517] argID=1130 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Cultural_impact_of_Michael_Jackson
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1130, 1, 'https://en.wikipedia.org/wiki/Cultural_impact_of_Michael_Jackson', '', '', '', 'Cultural impact of Michael Jackson', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1130 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1130, 1, 50.0, 1);

-- [80/517] argID=1131 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Assassination_of_Charlie_Kirk
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1131, 1, 'https://en.wikipedia.org/wiki/Assassination_of_Charlie_Kirk', '', '', '', 'Assassination of Charlie Kirk', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1131 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1131, 1, 50.0, 1);

-- SKIPPED [81/517] argID=1132: no Wikipedia result

-- [82/517] argID=1134 → profileID=1
-- URL: https://en.wikipedia.org/wiki/The_Wall
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1134, 1, 'https://en.wikipedia.org/wiki/The_Wall', '', '', '', 'The Wall', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1134 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1134, 1, 50.0, 1);

-- [83/517] argID=1141 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Great_Divergence
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1141, 1, 'https://en.wikipedia.org/wiki/Great_Divergence', '', '', '', 'Great Divergence', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1141 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1141, 1, 50.0, 1);

-- [84/517] argID=1142 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Enough_%28film%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1142, 1, 'https://en.wikipedia.org/wiki/Enough_%28film%29', '', '', '', 'Enough (film)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1142 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1142, 1, 50.0, 1);

-- [85/517] argID=1143 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Affordable_housing
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1143, 1, 'https://en.wikipedia.org/wiki/Affordable_housing', '', '', '', 'Affordable housing', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1143 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1143, 1, 50.0, 1);

-- [86/517] argID=1144 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Urban_area
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1144, 1, 'https://en.wikipedia.org/wiki/Urban_area', '', '', '', 'Urban area', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1144 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1144, 1, 50.0, 1);

-- [87/517] argID=1145 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Suspension_of_Jimmy_Kimmel_Live%21
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1145, 1, 'https://en.wikipedia.org/wiki/Suspension_of_Jimmy_Kimmel_Live%21', '', '', '', 'Suspension of Jimmy Kimmel Live!', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1145 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1145, 1, 50.0, 1);

-- [88/517] argID=1153 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Occam%27s_razor
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1153, 1, 'https://en.wikipedia.org/wiki/Occam%27s_razor', '', '', '', 'Occam\'s razor', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1153 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1153, 1, 50.0, 1);

-- [89/517] argID=1156 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Four_Noble_Truths
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1156, 1, 'https://en.wikipedia.org/wiki/Four_Noble_Truths', '', '', '', 'Four Noble Truths', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1156 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1156, 1, 50.0, 1);

-- [90/517] argID=1158 → profileID=28
-- URL: https://en.wikipedia.org/wiki/God
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1158, 28, 'https://en.wikipedia.org/wiki/God', '', '', '', 'God', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1158 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1158, 28, 50.0, 1);

-- [91/517] argID=1159 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Deportation_in_the_second_Trump_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1159, 2, 'https://en.wikipedia.org/wiki/Deportation_in_the_second_Trump_administration', '', '', '', 'Deportation in the second Trump administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1159 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1159, 2, 50.0, 1);

-- [92/517] argID=1160 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Day_Without_Immigrants_%282017%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1160, 2, 'https://en.wikipedia.org/wiki/Day_Without_Immigrants_%282017%29', '', '', '', 'Day Without Immigrants (2017)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1160 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1160, 2, 50.0, 1);

-- [93/517] argID=1161 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Unemployment_benefits
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1161, 2, 'https://en.wikipedia.org/wiki/Unemployment_benefits', '', '', '', 'Unemployment benefits', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1161 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1161, 2, 50.0, 1);

-- [94/517] argID=1162 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Chinese_Exclusion_Act
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1162, 2, 'https://en.wikipedia.org/wiki/Chinese_Exclusion_Act', '', '', '', 'Chinese Exclusion Act', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1162 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1162, 2, 50.0, 1);

-- [95/517] argID=1163 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Deportation_in_the_second_Trump_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1163, 2, 'https://en.wikipedia.org/wiki/Deportation_in_the_second_Trump_administration', '', '', '', 'Deportation in the second Trump administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1163 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1163, 2, 50.0, 1);

-- [96/517] argID=1164 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Diane_Greene
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1164, 1, 'https://en.wikipedia.org/wiki/Diane_Greene', '', '', '', 'Diane Greene', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1164 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1164, 1, 50.0, 1);

-- [97/517] argID=1165 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Advanced_Research_Projects_Agency_for_Health
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1165, 1, 'https://en.wikipedia.org/wiki/Advanced_Research_Projects_Agency_for_Health', '', '', '', 'Advanced Research Projects Agency for Health', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1165 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1165, 1, 50.0, 1);

-- [98/517] argID=1166 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Public_school_funding_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1166, 1, 'https://en.wikipedia.org/wiki/Public_school_funding_in_the_United_States', '', '', '', 'Public school funding in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1166 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1166, 1, 50.0, 1);

-- [99/517] argID=1167 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Industry_funding_of_academic_research
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1167, 1, 'https://en.wikipedia.org/wiki/Industry_funding_of_academic_research', '', '', '', 'Industry funding of academic research', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1167 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1167, 1, 50.0, 1);

-- [100/517] argID=1168 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Project_985
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1168, 1, 'https://en.wikipedia.org/wiki/Project_985', '', '', '', 'Project 985', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1168 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1168, 1, 50.0, 1);

-- [101/517] argID=1169 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Antoinette_Frank
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1169, 1, 'https://en.wikipedia.org/wiki/Antoinette_Frank', '', '', '', 'Antoinette Frank', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1169 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1169, 1, 50.0, 1);

-- [102/517] argID=1171 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Manusmriti
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1171, 1, 'https://en.wikipedia.org/wiki/Manusmriti', '', '', '', 'Manusmriti', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1171 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1171, 1, 50.0, 1);

-- [103/517] argID=1172 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Title_II_weapons
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1172, 1, 'https://en.wikipedia.org/wiki/Title_II_weapons', '', '', '', 'Title II weapons', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1172 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1172, 1, 50.0, 1);

-- [104/517] argID=1173 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Gun_laws_in_California
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1173, 1, 'https://en.wikipedia.org/wiki/Gun_laws_in_California', '', '', '', 'Gun laws in California', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1173 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1173, 1, 50.0, 1);

-- [105/517] argID=1174 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Broward_County_Sheriff%27s_Office
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1174, 1, 'https://en.wikipedia.org/wiki/Broward_County_Sheriff%27s_Office', '', '', '', 'Broward County Sheriff\'s Office', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1174 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1174, 1, 50.0, 1);

-- [106/517] argID=1176 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Hunting
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1176, 1, 'https://en.wikipedia.org/wiki/Hunting', '', '', '', 'Hunting', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1176 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1176, 1, 50.0, 1);

-- [107/517] argID=1177 → profileID=1
-- URL: https://en.wikipedia.org/wiki/7.62%C3%9740mm_Wilson_Tactical
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1177, 1, 'https://en.wikipedia.org/wiki/7.62%C3%9740mm_Wilson_Tactical', '', '', '', '7.62×40mm Wilson Tactical', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1177 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1177, 1, 50.0, 1);

-- SKIPPED [108/517] argID=1187: no Wikipedia result

-- [109/517] argID=1196 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Prejudice
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1196, 2, 'https://en.wikipedia.org/wiki/Prejudice', '', '', '', 'Prejudice', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1196 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1196, 2, 50.0, 1);

-- [110/517] argID=1197 → profileID=1
-- URL: https://en.wikipedia.org/wiki/White_Americans
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1197, 1, 'https://en.wikipedia.org/wiki/White_Americans', '', '', '', 'White Americans', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1197 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1197, 1, 50.0, 1);

-- [111/517] argID=1198 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Christy_Turlington
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1198, 1, 'https://en.wikipedia.org/wiki/Christy_Turlington', '', '', '', 'Christy Turlington', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1198 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1198, 1, 50.0, 1);

-- [112/517] argID=1199 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Cinema_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1199, 2, 'https://en.wikipedia.org/wiki/Cinema_of_the_United_States', '', '', '', 'Cinema of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1199 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1199, 2, 50.0, 1);

-- [113/517] argID=1200 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Industrial_relations
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1200, 1, 'https://en.wikipedia.org/wiki/Industrial_relations', '', '', '', 'Industrial relations', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1200 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1200, 1, 50.0, 1);

-- [114/517] argID=1201 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Slavery_in_the_21st_century
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1201, 1, 'https://en.wikipedia.org/wiki/Slavery_in_the_21st_century', '', '', '', 'Slavery in the 21st century', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1201 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1201, 1, 50.0, 1);

-- [115/517] argID=1202 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Black_Lives_Matter
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1202, 2, 'https://en.wikipedia.org/wiki/Black_Lives_Matter', '', '', '', 'Black Lives Matter', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1202 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1202, 2, 50.0, 1);

-- [116/517] argID=1203 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Scotts_Run%2C_West_Virginia
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1203, 1, 'https://en.wikipedia.org/wiki/Scotts_Run%2C_West_Virginia', '', '', '', 'Scotts Run, West Virginia', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1203 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1203, 1, 50.0, 1);

-- [117/517] argID=1204 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Wheel_of_Fortune_%28American_game_show%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1204, 1, 'https://en.wikipedia.org/wiki/Wheel_of_Fortune_%28American_game_show%29', '', '', '', 'Wheel of Fortune (American game show)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1204 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1204, 1, 50.0, 1);

-- [118/517] argID=1205 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Campus_sexual_assault
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1205, 2, 'https://en.wikipedia.org/wiki/Campus_sexual_assault', '', '', '', 'Campus sexual assault', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1205 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1205, 2, 50.0, 1);

-- [119/517] argID=1206 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Sexual_harassment
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1206, 2, 'https://en.wikipedia.org/wiki/Sexual_harassment', '', '', '', 'Sexual harassment', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1206 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1206, 2, 50.0, 1);

-- [120/517] argID=1207 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Ancient_Egyptian_race_controversy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1207, 1, 'https://en.wikipedia.org/wiki/Ancient_Egyptian_race_controversy', '', '', '', 'Ancient Egyptian race controversy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1207 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1207, 1, 50.0, 1);

-- [121/517] argID=1208 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Critical_race_theory
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1208, 2, 'https://en.wikipedia.org/wiki/Critical_race_theory', '', '', '', 'Critical race theory', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1208 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1208, 2, 50.0, 1);

-- [122/517] argID=1209 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Discrimination_based_on_skin_tone
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1209, 1, 'https://en.wikipedia.org/wiki/Discrimination_based_on_skin_tone', '', '', '', 'Discrimination based on skin tone', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1209 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1209, 1, 50.0, 1);

-- [123/517] argID=1210 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Racism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1210, 1, 'https://en.wikipedia.org/wiki/Racism', '', '', '', 'Racism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1210 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1210, 1, 50.0, 1);

-- [124/517] argID=1211 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Plan_of_Rome_%28Bigot%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1211, 1, 'https://en.wikipedia.org/wiki/Plan_of_Rome_%28Bigot%29', '', '', '', 'Plan of Rome (Bigot)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1211 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1211, 1, 50.0, 1);

-- [125/517] argID=1212 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Scientific_racism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1212, 1, 'https://en.wikipedia.org/wiki/Scientific_racism', '', '', '', 'Scientific racism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1212 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1212, 1, 50.0, 1);

-- [126/517] argID=1213 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Racism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1213, 2, 'https://en.wikipedia.org/wiki/Racism', '', '', '', 'Racism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1213 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1213, 2, 50.0, 1);

-- [127/517] argID=1214 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Racial_views_of_Donald_Trump
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1214, 2, 'https://en.wikipedia.org/wiki/Racial_views_of_Donald_Trump', '', '', '', 'Racial views of Donald Trump', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1214 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1214, 2, 50.0, 1);

-- SKIPPED [128/517] argID=1215: no Wikipedia result

-- [129/517] argID=1216 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Gemma_Arterton
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1216, 1, 'https://en.wikipedia.org/wiki/Gemma_Arterton', '', '', '', 'Gemma Arterton', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1216 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1216, 1, 50.0, 1);

-- SKIPPED [130/517] argID=1220: no Wikipedia result

-- SKIPPED [131/517] argID=1221: no Wikipedia result

-- SKIPPED [132/517] argID=1222: no Wikipedia result

-- [133/517] argID=1225 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Oppression
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1225, 2, 'https://en.wikipedia.org/wiki/Oppression', '', '', '', 'Oppression', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1225 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1225, 2, 50.0, 1);

-- [134/517] argID=1226 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_lesbian_characters_in_television
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1226, 1, 'https://en.wikipedia.org/wiki/List_of_lesbian_characters_in_television', '', '', '', 'List of lesbian characters in television', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1226 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1226, 1, 50.0, 1);

-- [135/517] argID=1227 → profileID=1
-- URL: https://en.wikipedia.org/wiki/The_Meteor_Man_%28film%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1227, 1, 'https://en.wikipedia.org/wiki/The_Meteor_Man_%28film%29', '', '', '', 'The Meteor Man (film)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1227 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1227, 1, 50.0, 1);

-- [136/517] argID=1228 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_films_based_on_Marvel_Comics_publications
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1228, 1, 'https://en.wikipedia.org/wiki/List_of_films_based_on_Marvel_Comics_publications', '', '', '', 'List of films based on Marvel Comics publications', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1228 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1228, 1, 50.0, 1);

-- [137/517] argID=1229 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Unite_the_Right_rally
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1229, 1, 'https://en.wikipedia.org/wiki/Unite_the_Right_rally', '', '', '', 'Unite the Right rally', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1229 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1229, 1, 50.0, 1);

-- [138/517] argID=1231 → profileID=1
-- URL: https://en.wikipedia.org/wiki/AI_bubble
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1231, 1, 'https://en.wikipedia.org/wiki/AI_bubble', '', '', '', 'AI bubble', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1231 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1231, 1, 50.0, 1);

-- [139/517] argID=1232 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Gal_Gadot
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1232, 1, 'https://en.wikipedia.org/wiki/Gal_Gadot', '', '', '', 'Gal Gadot', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1232 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1232, 1, 50.0, 1);

-- [140/517] argID=1233 → profileID=2
-- URL: https://en.wikipedia.org/wiki/OK
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1233, 2, 'https://en.wikipedia.org/wiki/OK', '', '', '', 'OK', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1233 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1233, 2, 50.0, 1);

-- [141/517] argID=1234 → profileID=2
-- URL: https://en.wikipedia.org/wiki/OK
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1234, 2, 'https://en.wikipedia.org/wiki/OK', '', '', '', 'OK', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1234 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1234, 2, 50.0, 1);

-- [142/517] argID=1236 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Palestinian_right_of_armed_resistance
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1236, 1, 'https://en.wikipedia.org/wiki/Palestinian_right_of_armed_resistance', '', '', '', 'Palestinian right of armed resistance', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1236 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1236, 1, 50.0, 1);

-- [143/517] argID=1237 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Border_control
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1237, 1, 'https://en.wikipedia.org/wiki/Border_control', '', '', '', 'Border control', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1237 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1237, 1, 50.0, 1);

-- [144/517] argID=1238 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Mexico%E2%80%93United_States_border_crisis
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1238, 1, 'https://en.wikipedia.org/wiki/Mexico%E2%80%93United_States_border_crisis', '', '', '', 'Mexico–United States border crisis', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1238 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1238, 1, 50.0, 1);

-- [145/517] argID=1239 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Illegal_immigration_to_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1239, 2, 'https://en.wikipedia.org/wiki/Illegal_immigration_to_the_United_States', '', '', '', 'Illegal immigration to the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1239 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1239, 2, 50.0, 1);

-- [146/517] argID=1240 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Immigration_policy_of_the_first_Trump_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1240, 1, 'https://en.wikipedia.org/wiki/Immigration_policy_of_the_first_Trump_administration', '', '', '', 'Immigration policy of the first Trump administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1240 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1240, 1, 50.0, 1);

-- [147/517] argID=1241 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Transgender_rights_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1241, 1, 'https://en.wikipedia.org/wiki/Transgender_rights_in_the_United_States', '', '', '', 'Transgender rights in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1241 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1241, 1, 50.0, 1);

-- [148/517] argID=1242 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Mexico%E2%80%93United_States_border_wall
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1242, 1, 'https://en.wikipedia.org/wiki/Mexico%E2%80%93United_States_border_wall', '', '', '', 'Mexico–United States border wall', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1242 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1242, 1, 50.0, 1);

-- [149/517] argID=1243 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Theory_of_basic_human_values
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1243, 1, 'https://en.wikipedia.org/wiki/Theory_of_basic_human_values', '', '', '', 'Theory of basic human values', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1243 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1243, 1, 50.0, 1);

-- [150/517] argID=1244 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Immigration_policy_of_the_second_Trump_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1244, 2, 'https://en.wikipedia.org/wiki/Immigration_policy_of_the_second_Trump_administration', '', '', '', 'Immigration policy of the second Trump administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1244 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1244, 2, 50.0, 1);

-- [151/517] argID=1245 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Civil_rights_movement
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1245, 1, 'https://en.wikipedia.org/wiki/Civil_rights_movement', '', '', '', 'Civil rights movement', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1245 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1245, 1, 50.0, 1);

-- [152/517] argID=1246 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Immigration_policy_of_the_second_Trump_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1246, 2, 'https://en.wikipedia.org/wiki/Immigration_policy_of_the_second_Trump_administration', '', '', '', 'Immigration policy of the second Trump administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1246 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1246, 2, 50.0, 1);

-- [153/517] argID=1247 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Joe_Biden
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1247, 2, 'https://en.wikipedia.org/wiki/Joe_Biden', '', '', '', 'Joe Biden', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1247 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1247, 2, 50.0, 1);

-- [154/517] argID=1248 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Immigration_and_crime
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1248, 1, 'https://en.wikipedia.org/wiki/Immigration_and_crime', '', '', '', 'Immigration and crime', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1248 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1248, 1, 50.0, 1);

-- [155/517] argID=1249 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Wikipedia
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1249, 1, 'https://en.wikipedia.org/wiki/Wikipedia', '', '', '', 'Wikipedia', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1249 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1249, 1, 50.0, 1);

-- [156/517] argID=1251 → profileID=1
-- URL: https://en.wikipedia.org/wiki/History_of_cities
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1251, 1, 'https://en.wikipedia.org/wiki/History_of_cities', '', '', '', 'History of cities', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1251 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1251, 1, 50.0, 1);

-- [157/517] argID=1252 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Zoning_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1252, 1, 'https://en.wikipedia.org/wiki/Zoning_in_the_United_States', '', '', '', 'Zoning in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1252 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1252, 1, 50.0, 1);

-- SKIPPED [158/517] argID=1253: no Wikipedia result

-- [159/517] argID=1254 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Jersey_City%2C_New_Jersey
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1254, 1, 'https://en.wikipedia.org/wiki/Jersey_City%2C_New_Jersey', '', '', '', 'Jersey City, New Jersey', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1254 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1254, 1, 50.0, 1);

-- SKIPPED [160/517] argID=1255: no Wikipedia result

-- [161/517] argID=1257 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Biophilic_design
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1257, 1, 'https://en.wikipedia.org/wiki/Biophilic_design', '', '', '', 'Biophilic design', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1257 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1257, 1, 50.0, 1);

-- SKIPPED [162/517] argID=1259: no Wikipedia result

-- [163/517] argID=1260 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Hong_Kong
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1260, 1, 'https://en.wikipedia.org/wiki/Hong_Kong', '', '', '', 'Hong Kong', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1260 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1260, 1, 50.0, 1);

-- [164/517] argID=1262 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Data_center
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1262, 1, 'https://en.wikipedia.org/wiki/Data_center', '', '', '', 'Data center', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1262 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1262, 1, 50.0, 1);

-- [165/517] argID=1263 → profileID=1
-- URL: https://en.wikipedia.org/wiki/First-generation_college_students_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1263, 1, 'https://en.wikipedia.org/wiki/First-generation_college_students_in_the_United_States', '', '', '', 'First-generation college students in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1263 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1263, 1, 50.0, 1);

-- [166/517] argID=1264 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Proportional_representation
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1264, 2, 'https://en.wikipedia.org/wiki/Proportional_representation', '', '', '', 'Proportional representation', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1264 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1264, 2, 50.0, 1);

-- [167/517] argID=1266 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Scheduled_Castes_and_Scheduled_Tribes
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1266, 1, 'https://en.wikipedia.org/wiki/Scheduled_Castes_and_Scheduled_Tribes', '', '', '', 'Scheduled Castes and Scheduled Tribes', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1266 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1266, 1, 50.0, 1);

-- [168/517] argID=1267 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Peter_Thiel
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1267, 1, 'https://en.wikipedia.org/wiki/Peter_Thiel', '', '', '', 'Peter Thiel', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1267 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1267, 1, 50.0, 1);

-- [169/517] argID=1268 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Rural_women
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1268, 1, 'https://en.wikipedia.org/wiki/Rural_women', '', '', '', 'Rural women', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1268 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1268, 1, 50.0, 1);

-- [170/517] argID=1269 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Multidimensional_Poverty_Index
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1269, 2, 'https://en.wikipedia.org/wiki/Multidimensional_Poverty_Index', '', '', '', 'Multidimensional Poverty Index', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1269 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1269, 2, 50.0, 1);

-- [171/517] argID=1270 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Money
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1270, 2, 'https://en.wikipedia.org/wiki/Money', '', '', '', 'Money', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1270 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1270, 2, 50.0, 1);

-- [172/517] argID=1271 → profileID=1
-- URL: https://en.wikipedia.org/wiki/United_States_federal_budget
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1271, 1, 'https://en.wikipedia.org/wiki/United_States_federal_budget', '', '', '', 'United States federal budget', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1271 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1271, 1, 50.0, 1);

-- [173/517] argID=1272 → profileID=2
-- URL: https://en.wikipedia.org/wiki/War_on_Poverty
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1272, 2, 'https://en.wikipedia.org/wiki/War_on_Poverty', '', '', '', 'War on Poverty', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1272 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1272, 2, 50.0, 1);

-- [174/517] argID=1273 → profileID=2
-- URL: https://en.wikipedia.org/wiki/List_of_The_Boys_characters
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1273, 2, 'https://en.wikipedia.org/wiki/List_of_The_Boys_characters', '', '', '', 'List of The Boys characters', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1273 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1273, 2, 50.0, 1);

-- [175/517] argID=1274 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Almost_ideal_demand_system
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1274, 1, 'https://en.wikipedia.org/wiki/Almost_ideal_demand_system', '', '', '', 'Almost ideal demand system', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1274 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1274, 1, 50.0, 1);

-- [176/517] argID=1275 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Climate_change
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1275, 1, 'https://en.wikipedia.org/wiki/Climate_change', '', '', '', 'Climate change', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1275 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1275, 1, 50.0, 1);

-- [177/517] argID=1276 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Fermi_paradox
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1276, 1, 'https://en.wikipedia.org/wiki/Fermi_paradox', '', '', '', 'Fermi paradox', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1276 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1276, 1, 50.0, 1);

-- [178/517] argID=1277 → profileID=2
-- URL: https://en.wikipedia.org/wiki/History_of_climate_change_science
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1277, 2, 'https://en.wikipedia.org/wiki/History_of_climate_change_science', '', '', '', 'History of climate change science', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1277 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1277, 2, 50.0, 1);

-- [179/517] argID=1278 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Capitalism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1278, 1, 'https://en.wikipedia.org/wiki/Capitalism', '', '', '', 'Capitalism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1278 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1278, 1, 50.0, 1);

-- SKIPPED [180/517] argID=1281: no Wikipedia result

-- SKIPPED [181/517] argID=1283: no Wikipedia result

-- [182/517] argID=1289 → profileID=1
-- URL: https://en.wikipedia.org/wiki/The_Bear_%28TV_series%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1289, 1, 'https://en.wikipedia.org/wiki/The_Bear_%28TV_series%29', '', '', '', 'The Bear (TV series)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1289 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1289, 1, 50.0, 1);

-- [183/517] argID=1290 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Go_%28game%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1290, 1, 'https://en.wikipedia.org/wiki/Go_%28game%29', '', '', '', 'Go (game)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1290 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1290, 1, 50.0, 1);

-- [184/517] argID=1291 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Parliamentary_procedure
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1291, 1, 'https://en.wikipedia.org/wiki/Parliamentary_procedure', '', '', '', 'Parliamentary procedure', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1291 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1291, 1, 50.0, 1);

-- [185/517] argID=1292 → profileID=1
-- URL: https://en.wikipedia.org/wiki/State-building
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1292, 1, 'https://en.wikipedia.org/wiki/State-building', '', '', '', 'State-building', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1292 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1292, 1, 50.0, 1);

-- [186/517] argID=1293 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Hewlett-Packard
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1293, 1, 'https://en.wikipedia.org/wiki/Hewlett-Packard', '', '', '', 'Hewlett-Packard', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1293 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1293, 1, 50.0, 1);

-- [187/517] argID=1294 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Project_governance
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1294, 1, 'https://en.wikipedia.org/wiki/Project_governance', '', '', '', 'Project governance', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1294 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1294, 1, 50.0, 1);

-- [188/517] argID=1295 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Market_sentiment
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1295, 1, 'https://en.wikipedia.org/wiki/Market_sentiment', '', '', '', 'Market sentiment', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1295 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1295, 1, 50.0, 1);

-- [189/517] argID=1296 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Climate_change
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1296, 2, 'https://en.wikipedia.org/wiki/Climate_change', '', '', '', 'Climate change', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1296 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1296, 2, 50.0, 1);

-- [190/517] argID=1297 → profileID=2
-- URL: https://en.wikipedia.org/wiki/McCarthyism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1297, 2, 'https://en.wikipedia.org/wiki/McCarthyism', '', '', '', 'McCarthyism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1297 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1297, 2, 50.0, 1);

-- [191/517] argID=1298 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Climate_change
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1298, 2, 'https://en.wikipedia.org/wiki/Climate_change', '', '', '', 'Climate change', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1298 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1298, 2, 50.0, 1);

-- [192/517] argID=1299 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Project_2025
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1299, 2, 'https://en.wikipedia.org/wiki/Project_2025', '', '', '', 'Project 2025', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1299 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1299, 2, 50.0, 1);

-- [193/517] argID=1300 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Climate_change
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1300, 2, 'https://en.wikipedia.org/wiki/Climate_change', '', '', '', 'Climate change', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1300 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1300, 2, 50.0, 1);

-- [194/517] argID=1301 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Late_capitalism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1301, 1, 'https://en.wikipedia.org/wiki/Late_capitalism', '', '', '', 'Late capitalism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1301 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1301, 1, 50.0, 1);

-- [195/517] argID=1302 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Bront%C3%AB_family
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1302, 1, 'https://en.wikipedia.org/wiki/Bront%C3%AB_family', '', '', '', 'Brontë family', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1302 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1302, 1, 50.0, 1);

-- [196/517] argID=1303 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Italian_cuisine
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1303, 1, 'https://en.wikipedia.org/wiki/Italian_cuisine', '', '', '', 'Italian cuisine', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1303 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1303, 1, 50.0, 1);

-- [197/517] argID=1304 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Peperoncino
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1304, 1, 'https://en.wikipedia.org/wiki/Peperoncino', '', '', '', 'Peperoncino', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1304 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1304, 1, 50.0, 1);

-- SKIPPED [198/517] argID=1305: no Wikipedia result

-- [199/517] argID=1306 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Kaiseki
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1306, 1, 'https://en.wikipedia.org/wiki/Kaiseki', '', '', '', 'Kaiseki', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1306 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1306, 1, 50.0, 1);

-- SKIPPED [200/517] argID=1307: no Wikipedia result

-- [201/517] argID=1308 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Donald_Trump_and_fascism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1308, 2, 'https://en.wikipedia.org/wiki/Donald_Trump_and_fascism', '', '', '', 'Donald Trump and fascism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1308 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1308, 2, 50.0, 1);

-- [202/517] argID=1309 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Illegal_immigration_to_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1309, 1, 'https://en.wikipedia.org/wiki/Illegal_immigration_to_the_United_States', '', '', '', 'Illegal immigration to the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1309 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1309, 1, 50.0, 1);

-- [203/517] argID=1310 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Separate_but_equal
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1310, 2, 'https://en.wikipedia.org/wiki/Separate_but_equal', '', '', '', 'Separate but equal', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1310 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1310, 2, 50.0, 1);

-- [204/517] argID=1311 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Louis%27_Lunch
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1311, 1, 'https://en.wikipedia.org/wiki/Louis%27_Lunch', '', '', '', 'Louis\' Lunch', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1311 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1311, 1, 50.0, 1);

-- [205/517] argID=1312 → profileID=2
-- URL: https://en.wikipedia.org/wiki/2020s_anti-LGBTQ_movement_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1312, 2, 'https://en.wikipedia.org/wiki/2020s_anti-LGBTQ_movement_in_the_United_States', '', '', '', '2020s anti-LGBTQ movement in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1312 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1312, 2, 50.0, 1);

-- [206/517] argID=1313 → profileID=2
-- URL: https://en.wikipedia.org/wiki/All_Lives_Matter
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1313, 2, 'https://en.wikipedia.org/wiki/All_Lives_Matter', '', '', '', 'All Lives Matter', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1313 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1313, 2, 50.0, 1);

-- [207/517] argID=1314 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Black_Lives_Matter
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1314, 2, 'https://en.wikipedia.org/wiki/Black_Lives_Matter', '', '', '', 'Black Lives Matter', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1314 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1314, 2, 50.0, 1);

-- [208/517] argID=1315 → profileID=2
-- URL: https://en.wikipedia.org/wiki/The_Black_Book_of_Communism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1315, 2, 'https://en.wikipedia.org/wiki/The_Black_Book_of_Communism', '', '', '', 'The Black Book of Communism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1315 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1315, 2, 50.0, 1);

-- [209/517] argID=1316 → profileID=2
-- URL: https://en.wikipedia.org/wiki/The_Black_Book_of_Communism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1316, 2, 'https://en.wikipedia.org/wiki/The_Black_Book_of_Communism', '', '', '', 'The Black Book of Communism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1316 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1316, 2, 50.0, 1);

-- [210/517] argID=1317 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Crime_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1317, 1, 'https://en.wikipedia.org/wiki/Crime_in_the_United_States', '', '', '', 'Crime in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1317 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1317, 1, 50.0, 1);

-- [211/517] argID=1318 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Race_and_crime_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1318, 2, 'https://en.wikipedia.org/wiki/Race_and_crime_in_the_United_States', '', '', '', 'Race and crime in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1318 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1318, 2, 50.0, 1);

-- [212/517] argID=1319 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Black_Lives_Matter
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1319, 1, 'https://en.wikipedia.org/wiki/Black_Lives_Matter', '', '', '', 'Black Lives Matter', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1319 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1319, 1, 50.0, 1);

-- [213/517] argID=1320 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Killing_of_Akai_Gurley
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1320, 1, 'https://en.wikipedia.org/wiki/Killing_of_Akai_Gurley', '', '', '', 'Killing of Akai Gurley', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1320 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1320, 1, 50.0, 1);

-- [214/517] argID=1321 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Formation_%28song%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1321, 2, 'https://en.wikipedia.org/wiki/Formation_%28song%29', '', '', '', 'Formation (song)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1321 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1321, 2, 50.0, 1);

-- SKIPPED [215/517] argID=1322: no Wikipedia result

-- [216/517] argID=1323 → profileID=2
-- URL: https://en.wikipedia.org/wiki/All_Lives_Matter
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1323, 2, 'https://en.wikipedia.org/wiki/All_Lives_Matter', '', '', '', 'All Lives Matter', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1323 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1323, 2, 50.0, 1);

-- [217/517] argID=1324 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Ableism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1324, 2, 'https://en.wikipedia.org/wiki/Ableism', '', '', '', 'Ableism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1324 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1324, 2, 50.0, 1);

-- [218/517] argID=1325 → profileID=2
-- URL: https://en.wikipedia.org/wiki/The_Wire
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1325, 2, 'https://en.wikipedia.org/wiki/The_Wire', '', '', '', 'The Wire', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1325 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1325, 2, 50.0, 1);

-- [219/517] argID=1326 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Police_brutality_by_country
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1326, 2, 'https://en.wikipedia.org/wiki/Police_brutality_by_country', '', '', '', 'Police brutality by country', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1326 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1326, 2, 50.0, 1);

-- [220/517] argID=1327 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_vaccine_misinformation_and_hesitancy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1327, 1, 'https://en.wikipedia.org/wiki/COVID-19_vaccine_misinformation_and_hesitancy', '', '', '', 'COVID-19 vaccine misinformation and hesitancy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1327 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1327, 1, 50.0, 1);

-- [221/517] argID=1329 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Respiratory_syncytial_virus
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1329, 1, 'https://en.wikipedia.org/wiki/Respiratory_syncytial_virus', '', '', '', 'Respiratory syncytial virus', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1329 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1329, 1, 50.0, 1);

-- [222/517] argID=1330 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Face_masks_during_the_COVID-19_pandemic_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1330, 1, 'https://en.wikipedia.org/wiki/Face_masks_during_the_COVID-19_pandemic_in_the_United_States', '', '', '', 'Face masks during the COVID-19 pandemic in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1330 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1330, 1, 50.0, 1);

-- [223/517] argID=1331 → profileID=1
-- URL: https://en.wikipedia.org/wiki/1993_Four_Corners_hantavirus_outbreak
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1331, 1, 'https://en.wikipedia.org/wiki/1993_Four_Corners_hantavirus_outbreak', '', '', '', '1993 Four Corners hantavirus outbreak', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1331 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1331, 1, 50.0, 1);

-- [224/517] argID=1332 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Party_Time%3F
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1332, 1, 'https://en.wikipedia.org/wiki/Party_Time%3F', '', '', '', 'Party Time?', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1332 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1332, 1, 50.0, 1);

-- [225/517] argID=1333 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Face_masks_during_the_COVID-19_pandemic
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1333, 2, 'https://en.wikipedia.org/wiki/Face_masks_during_the_COVID-19_pandemic', '', '', '', 'Face masks during the COVID-19 pandemic', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1333 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1333, 2, 50.0, 1);

-- [226/517] argID=1334 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Reclassification_%28education%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1334, 1, 'https://en.wikipedia.org/wiki/Reclassification_%28education%29', '', '', '', 'Reclassification (education)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1334 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1334, 1, 50.0, 1);

-- [227/517] argID=1336 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Clich%C3%A9
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1336, 2, 'https://en.wikipedia.org/wiki/Clich%C3%A9', '', '', '', 'Cliché', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1336 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1336, 2, 50.0, 1);

-- [228/517] argID=1337 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Professional_wrestling
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1337, 1, 'https://en.wikipedia.org/wiki/Professional_wrestling', '', '', '', 'Professional wrestling', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1337 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1337, 1, 50.0, 1);

-- [229/517] argID=1338 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Transgender_rights_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1338, 1, 'https://en.wikipedia.org/wiki/Transgender_rights_in_the_United_States', '', '', '', 'Transgender rights in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1338 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1338, 1, 50.0, 1);

-- [230/517] argID=1339 → profileID=1
-- URL: https://en.wikipedia.org/wiki/2026_Australian_federal_budget
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1339, 1, 'https://en.wikipedia.org/wiki/2026_Australian_federal_budget', '', '', '', '2026 Australian federal budget', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1339 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1339, 1, 50.0, 1);

-- [231/517] argID=1340 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Women_in_the_Victorian_era
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1340, 2, 'https://en.wikipedia.org/wiki/Women_in_the_Victorian_era', '', '', '', 'Women in the Victorian era', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1340 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1340, 2, 50.0, 1);

-- [232/517] argID=1341 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Sport_of_athletics
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1341, 1, 'https://en.wikipedia.org/wiki/Sport_of_athletics', '', '', '', 'Sport of athletics', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1341 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1341, 1, 50.0, 1);

-- [233/517] argID=1342 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Spice_Girls
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1342, 1, 'https://en.wikipedia.org/wiki/Spice_Girls', '', '', '', 'Spice Girls', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1342 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1342, 1, 50.0, 1);

-- [234/517] argID=1343 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Variants_of_SARS-CoV-2
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1343, 1, 'https://en.wikipedia.org/wiki/Variants_of_SARS-CoV-2', '', '', '', 'Variants of SARS-CoV-2', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1343 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1343, 1, 50.0, 1);

-- [235/517] argID=1344 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_Saturday_Night_Live_commercial_parodies
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1344, 1, 'https://en.wikipedia.org/wiki/List_of_Saturday_Night_Live_commercial_parodies', '', '', '', 'List of Saturday Night Live commercial parodies', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1344 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1344, 1, 50.0, 1);

-- [236/517] argID=1345 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Sixth_National_Government_of_New_Zealand
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1345, 2, 'https://en.wikipedia.org/wiki/Sixth_National_Government_of_New_Zealand', '', '', '', 'Sixth National Government of New Zealand', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1345 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1345, 2, 50.0, 1);

-- SKIPPED [237/517] argID=1347: no Wikipedia result

-- [238/517] argID=1348 → profileID=2
-- URL: https://en.wikipedia.org/wiki/2020s_critical_race_theory_controversies
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1348, 2, 'https://en.wikipedia.org/wiki/2020s_critical_race_theory_controversies', '', '', '', '2020s critical race theory controversies', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1348 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1348, 2, 50.0, 1);

-- SKIPPED [239/517] argID=1349: no Wikipedia result

-- [240/517] argID=1350 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Responsibility_for_the_Holocaust
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1350, 2, 'https://en.wikipedia.org/wiki/Responsibility_for_the_Holocaust', '', '', '', 'Responsibility for the Holocaust', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1350 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1350, 2, 50.0, 1);

-- [241/517] argID=1351 → profileID=2
-- URL: https://en.wikipedia.org/wiki/White_supremacy_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1351, 2, 'https://en.wikipedia.org/wiki/White_supremacy_in_the_United_States', '', '', '', 'White supremacy in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1351 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1351, 2, 50.0, 1);

-- [242/517] argID=1352 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Parking_mandates
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1352, 1, 'https://en.wikipedia.org/wiki/Parking_mandates', '', '', '', 'Parking mandates', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1352 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1352, 1, 50.0, 1);

-- [243/517] argID=1353 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Plug-in_electric_vehicles_in_Norway
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1353, 1, 'https://en.wikipedia.org/wiki/Plug-in_electric_vehicles_in_Norway', '', '', '', 'Plug-in electric vehicles in Norway', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1353 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1353, 1, 50.0, 1);

-- [244/517] argID=1354 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Car
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1354, 2, 'https://en.wikipedia.org/wiki/Car', '', '', '', 'Car', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1354 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1354, 2, 50.0, 1);

-- [245/517] argID=1355 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Mass_Rapid_Transit_%28Singapore%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1355, 1, 'https://en.wikipedia.org/wiki/Mass_Rapid_Transit_%28Singapore%29', '', '', '', 'Mass Rapid Transit (Singapore)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1355 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1355, 1, 50.0, 1);

-- [246/517] argID=1356 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Donald_Trump
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1356, 2, 'https://en.wikipedia.org/wiki/Donald_Trump', '', '', '', 'Donald Trump', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1356 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1356, 2, 50.0, 1);

-- [247/517] argID=1357 → profileID=2
-- URL: https://en.wikipedia.org/wiki/2024%E2%80%932026_Georgian_political_crisis
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1357, 2, 'https://en.wikipedia.org/wiki/2024%E2%80%932026_Georgian_political_crisis', '', '', '', '2024–2026 Georgian political crisis', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1357 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1357, 2, 50.0, 1);

-- [248/517] argID=1358 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Lumen_Field
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1358, 2, 'https://en.wikipedia.org/wiki/Lumen_Field', '', '', '', 'Lumen Field', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1358 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1358, 2, 50.0, 1);

-- [249/517] argID=1359 → profileID=2
-- URL: https://en.wikipedia.org/wiki/List_of_air_rage_incidents
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1359, 2, 'https://en.wikipedia.org/wiki/List_of_air_rage_incidents', '', '', '', 'List of air rage incidents', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1359 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1359, 2, 50.0, 1);

-- [250/517] argID=1360 → profileID=2
-- URL: https://en.wikipedia.org/wiki/2025_Major_League_Baseball_All-Star_Game
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1360, 2, 'https://en.wikipedia.org/wiki/2025_Major_League_Baseball_All-Star_Game', '', '', '', '2025 Major League Baseball All-Star Game', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1360 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1360, 2, 50.0, 1);

-- [251/517] argID=1361 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Alfie_Kohn
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1361, 1, 'https://en.wikipedia.org/wiki/Alfie_Kohn', '', '', '', 'Alfie Kohn', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1361 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1361, 1, 50.0, 1);

-- [252/517] argID=1362 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Northwest_Airlines
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1362, 1, 'https://en.wikipedia.org/wiki/Northwest_Airlines', '', '', '', 'Northwest Airlines', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1362 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1362, 1, 50.0, 1);

-- [253/517] argID=1374 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Corporate_tax_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1374, 1, 'https://en.wikipedia.org/wiki/Corporate_tax_in_the_United_States', '', '', '', 'Corporate tax in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1374 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1374, 1, 50.0, 1);

-- [254/517] argID=1375 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Postal_voting_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1375, 1, 'https://en.wikipedia.org/wiki/Postal_voting_in_the_United_States', '', '', '', 'Postal voting in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1375 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1375, 1, 50.0, 1);

-- [255/517] argID=1376 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Voter_registration_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1376, 1, 'https://en.wikipedia.org/wiki/Voter_registration_in_the_United_States', '', '', '', 'Voter registration in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1376 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1376, 1, 50.0, 1);

-- [256/517] argID=1377 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Colorado
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1377, 1, 'https://en.wikipedia.org/wiki/Colorado', '', '', '', 'Colorado', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1377 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1377, 1, 50.0, 1);

-- [257/517] argID=1378 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Voter_identification_laws_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1378, 1, 'https://en.wikipedia.org/wiki/Voter_identification_laws_in_the_United_States', '', '', '', 'Voter identification laws in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1378 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1378, 1, 50.0, 1);

-- [258/517] argID=1379 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Republican_efforts_to_restrict_voting_following_the_2020_United_States_presidential_election
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1379, 1, 'https://en.wikipedia.org/wiki/Republican_efforts_to_restrict_voting_following_the_2020_United_States_presidential_election', '', '', '', 'Republican efforts to restrict voting following the 2020 United States presidential election', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1379 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1379, 1, 50.0, 1);

-- [259/517] argID=1380 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Crossfire_Hurricane_%28FBI_investigation%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1380, 2, 'https://en.wikipedia.org/wiki/Crossfire_Hurricane_%28FBI_investigation%29', '', '', '', 'Crossfire Hurricane (FBI investigation)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1380 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1380, 2, 50.0, 1);

-- [260/517] argID=1381 → profileID=1
-- URL: https://en.wikipedia.org/wiki/2025%E2%80%9326_NBA_season
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1381, 1, 'https://en.wikipedia.org/wiki/2025%E2%80%9326_NBA_season', '', '', '', '2025–26 NBA season', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1381 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1381, 1, 50.0, 1);

-- [261/517] argID=1382 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Voter_turnout_in_United_States_presidential_elections
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1382, 1, 'https://en.wikipedia.org/wiki/Voter_turnout_in_United_States_presidential_elections', '', '', '', 'Voter turnout in United States presidential elections', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1382 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1382, 1, 50.0, 1);

-- [262/517] argID=1383 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Dastardly_and_Muttley_in_Their_Flying_Machines
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1383, 2, 'https://en.wikipedia.org/wiki/Dastardly_and_Muttley_in_Their_Flying_Machines', '', '', '', 'Dastardly and Muttley in Their Flying Machines', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1383 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1383, 2, 50.0, 1);

-- [263/517] argID=1384 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_cognitive_biases
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1384, 1, 'https://en.wikipedia.org/wiki/List_of_cognitive_biases', '', '', '', 'List of cognitive biases', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1384 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1384, 1, 50.0, 1);

-- [264/517] argID=1385 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Names_and_titles_of_Jesus_in_the_New_Testament
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1385, 1, 'https://en.wikipedia.org/wiki/Names_and_titles_of_Jesus_in_the_New_Testament', '', '', '', 'Names and titles of Jesus in the New Testament', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1385 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1385, 1, 50.0, 1);

-- [265/517] argID=1386 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Ascension_of_Jesus
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1386, 1, 'https://en.wikipedia.org/wiki/Ascension_of_Jesus', '', '', '', 'Ascension of Jesus', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1386 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1386, 1, 50.0, 1);

-- [266/517] argID=1387 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Beginning_of_human_personhood
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1387, 1, 'https://en.wikipedia.org/wiki/Beginning_of_human_personhood', '', '', '', 'Beginning of human personhood', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1387 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1387, 1, 50.0, 1);

-- [267/517] argID=1388 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Domestic_policy_of_the_second_Trump_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1388, 1, 'https://en.wikipedia.org/wiki/Domestic_policy_of_the_second_Trump_administration', '', '', '', 'Domestic policy of the second Trump administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1388 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1388, 1, 50.0, 1);

-- [268/517] argID=1389 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Vaccine_passports_during_the_COVID-19_pandemic
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1389, 1, 'https://en.wikipedia.org/wiki/Vaccine_passports_during_the_COVID-19_pandemic', '', '', '', 'Vaccine passports during the COVID-19 pandemic', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1389 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1389, 1, 50.0, 1);

-- [269/517] argID=1390 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_vaccine
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1390, 1, 'https://en.wikipedia.org/wiki/COVID-19_vaccine', '', '', '', 'COVID-19 vaccine', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1390 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1390, 1, 50.0, 1);

-- [270/517] argID=1391 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Joe_Biden
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1391, 1, 'https://en.wikipedia.org/wiki/Joe_Biden', '', '', '', 'Joe Biden', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1391 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1391, 1, 50.0, 1);

-- [271/517] argID=1392 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID_Tracking_Project
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1392, 1, 'https://en.wikipedia.org/wiki/COVID_Tracking_Project', '', '', '', 'COVID Tracking Project', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1392 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1392, 1, 50.0, 1);

-- [272/517] argID=1393 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_vaccine_misinformation_and_hesitancy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1393, 1, 'https://en.wikipedia.org/wiki/COVID-19_vaccine_misinformation_and_hesitancy', '', '', '', 'COVID-19 vaccine misinformation and hesitancy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1393 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1393, 1, 50.0, 1);

-- [273/517] argID=1394 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Environmental_policy_of_the_Biden_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1394, 2, 'https://en.wikipedia.org/wiki/Environmental_policy_of_the_Biden_administration', '', '', '', 'Environmental policy of the Biden administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1394 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1394, 2, 50.0, 1);

-- [274/517] argID=1395 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Vaccine_passports_during_the_COVID-19_pandemic
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1395, 1, 'https://en.wikipedia.org/wiki/Vaccine_passports_during_the_COVID-19_pandemic', '', '', '', 'Vaccine passports during the COVID-19 pandemic', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1395 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1395, 1, 50.0, 1);

-- [275/517] argID=1396 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_pandemic
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1396, 1, 'https://en.wikipedia.org/wiki/COVID-19_pandemic', '', '', '', 'COVID-19 pandemic', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1396 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1396, 1, 50.0, 1);

-- [276/517] argID=1397 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_vaccine_misinformation_and_hesitancy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1397, 1, 'https://en.wikipedia.org/wiki/COVID-19_vaccine_misinformation_and_hesitancy', '', '', '', 'COVID-19 vaccine misinformation and hesitancy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1397 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1397, 1, 50.0, 1);

-- [277/517] argID=1398 → profileID=2
-- URL: https://en.wikipedia.org/wiki/X_%28social_network%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1398, 2, 'https://en.wikipedia.org/wiki/X_%28social_network%29', '', '', '', 'X (social network)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1398 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1398, 2, 50.0, 1);

-- [278/517] argID=1401 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Canada_convoy_protest
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1401, 2, 'https://en.wikipedia.org/wiki/Canada_convoy_protest', '', '', '', 'Canada convoy protest', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1401 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1401, 2, 50.0, 1);

-- [279/517] argID=1402 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_pandemic
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1402, 1, 'https://en.wikipedia.org/wiki/COVID-19_pandemic', '', '', '', 'COVID-19 pandemic', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1402 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1402, 1, 50.0, 1);

-- [280/517] argID=1403 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Timeline_of_the_COVID-19_pandemic_in_the_United_States_%282020%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1403, 1, 'https://en.wikipedia.org/wiki/Timeline_of_the_COVID-19_pandemic_in_the_United_States_%282020%29', '', '', '', 'Timeline of the COVID-19 pandemic in the United States (2020)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1403 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1403, 1, 50.0, 1);

-- [281/517] argID=1404 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_pandemic
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1404, 1, 'https://en.wikipedia.org/wiki/COVID-19_pandemic', '', '', '', 'COVID-19 pandemic', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1404 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1404, 1, 50.0, 1);

-- [282/517] argID=1405 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19_pandemic_in_New_Caledonia
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1405, 1, 'https://en.wikipedia.org/wiki/COVID-19_pandemic_in_New_Caledonia', '', '', '', 'COVID-19 pandemic in New Caledonia', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1405 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1405, 1, 50.0, 1);

-- [283/517] argID=1406 → profileID=1
-- URL: https://en.wikipedia.org/wiki/COVID-19
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1406, 1, 'https://en.wikipedia.org/wiki/COVID-19', '', '', '', 'COVID-19', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1406 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1406, 1, 50.0, 1);

-- [284/517] argID=1407 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Stripper
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1407, 2, 'https://en.wikipedia.org/wiki/Stripper', '', '', '', 'Stripper', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1407 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1407, 2, 50.0, 1);

-- [285/517] argID=1408 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Police_officer_certification_and_licensure_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1408, 2, 'https://en.wikipedia.org/wiki/Police_officer_certification_and_licensure_in_the_United_States', '', '', '', 'Police officer certification and licensure in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1408 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1408, 2, 50.0, 1);

-- [286/517] argID=1409 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Washington_%28state%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1409, 2, 'https://en.wikipedia.org/wiki/Washington_%28state%29', '', '', '', 'Washington (state)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1409 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1409, 2, 50.0, 1);

-- [287/517] argID=1410 → profileID=1
-- URL: https://en.wikipedia.org/wiki/School_resource_officer
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1410, 1, 'https://en.wikipedia.org/wiki/School_resource_officer', '', '', '', 'School resource officer', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1410 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1410, 1, 50.0, 1);

-- [288/517] argID=1411 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_law_enforcement_officers_killed_in_the_line_of_duty_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1411, 1, 'https://en.wikipedia.org/wiki/List_of_law_enforcement_officers_killed_in_the_line_of_duty_in_the_United_States', '', '', '', 'List of law enforcement officers killed in the line of duty in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1411 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1411, 1, 50.0, 1);

-- [289/517] argID=1412 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Anti-vaccine_activism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1412, 2, 'https://en.wikipedia.org/wiki/Anti-vaccine_activism', '', '', '', 'Anti-vaccine activism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1412 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1412, 2, 50.0, 1);

-- [290/517] argID=1413 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Nazism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1413, 1, 'https://en.wikipedia.org/wiki/Nazism', '', '', '', 'Nazism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1413 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1413, 1, 50.0, 1);

-- [291/517] argID=1414 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Citizen_journalism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1414, 1, 'https://en.wikipedia.org/wiki/Citizen_journalism', '', '', '', 'Citizen journalism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1414 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1414, 1, 50.0, 1);

-- [292/517] argID=1415 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Right-wing_terrorism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1415, 2, 'https://en.wikipedia.org/wiki/Right-wing_terrorism', '', '', '', 'Right-wing terrorism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1415 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1415, 2, 50.0, 1);

-- [293/517] argID=1416 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Right-wing_authoritarianism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1416, 2, 'https://en.wikipedia.org/wiki/Right-wing_authoritarianism', '', '', '', 'Right-wing authoritarianism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1416 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1416, 2, 50.0, 1);

-- [294/517] argID=1417 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Pizzagate_conspiracy_theory
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1417, 1, 'https://en.wikipedia.org/wiki/Pizzagate_conspiracy_theory', '', '', '', 'Pizzagate conspiracy theory', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1417 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1417, 1, 50.0, 1);

-- [295/517] argID=1418 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Controlled_Substances_Act
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1418, 1, 'https://en.wikipedia.org/wiki/Controlled_Substances_Act', '', '', '', 'Controlled Substances Act', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1418 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1418, 1, 50.0, 1);

-- [296/517] argID=1421 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Extraordinary_claims_require_extraordinary_evidence
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1421, 1, 'https://en.wikipedia.org/wiki/Extraordinary_claims_require_extraordinary_evidence', '', '', '', 'Extraordinary claims require extraordinary evidence', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1421 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1421, 1, 50.0, 1);

-- [297/517] argID=1422 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_The_Blacklist_characters
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1422, 1, 'https://en.wikipedia.org/wiki/List_of_The_Blacklist_characters', '', '', '', 'List of The Blacklist characters', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1422 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1422, 1, 50.0, 1);

-- [298/517] argID=1423 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Large_language_model
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1423, 1, 'https://en.wikipedia.org/wiki/Large_language_model', '', '', '', 'Large language model', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1423 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1423, 1, 50.0, 1);

-- [299/517] argID=1426 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Affect_%28psychology%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1426, 1, 'https://en.wikipedia.org/wiki/Affect_%28psychology%29', '', '', '', 'Affect (psychology)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1426 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1426, 1, 50.0, 1);

-- [300/517] argID=1427 → profileID=2
-- URL: https://en.wikipedia.org/wiki/MV_Hondius_hantavirus_outbreak
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1427, 2, 'https://en.wikipedia.org/wiki/MV_Hondius_hantavirus_outbreak', '', '', '', 'MV Hondius hantavirus outbreak', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1427 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1427, 2, 50.0, 1);

-- [301/517] argID=1428 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Canadian_Medical_Protective_Association
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1428, 2, 'https://en.wikipedia.org/wiki/Canadian_Medical_Protective_Association', '', '', '', 'Canadian Medical Protective Association', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1428 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1428, 2, 50.0, 1);

-- [302/517] argID=1429 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Media_portrayals_of_transgender_people
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1429, 2, 'https://en.wikipedia.org/wiki/Media_portrayals_of_transgender_people', '', '', '', 'Media portrayals of transgender people', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1429 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1429, 2, 50.0, 1);

-- [303/517] argID=1430 → profileID=2
-- URL: https://en.wikipedia.org/wiki/My_Family
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1430, 2, 'https://en.wikipedia.org/wiki/My_Family', '', '', '', 'My Family', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1430 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1430, 2, 50.0, 1);

-- [304/517] argID=1431 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Dhurandhar
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1431, 1, 'https://en.wikipedia.org/wiki/Dhurandhar', '', '', '', 'Dhurandhar', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1431 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1431, 1, 50.0, 1);

-- [305/517] argID=1432 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Always_a_Catch%21
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1432, 2, 'https://en.wikipedia.org/wiki/Always_a_Catch%21', '', '', '', 'Always a Catch!', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1432 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1432, 2, 50.0, 1);

-- [306/517] argID=1433 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Misogyny
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1433, 2, 'https://en.wikipedia.org/wiki/Misogyny', '', '', '', 'Misogyny', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1433 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1433, 2, 50.0, 1);

-- [307/517] argID=1434 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Bias
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1434, 2, 'https://en.wikipedia.org/wiki/Bias', '', '', '', 'Bias', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1434 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1434, 2, 50.0, 1);

-- [308/517] argID=1435 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Family
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1435, 1, 'https://en.wikipedia.org/wiki/Family', '', '', '', 'Family', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1435 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1435, 1, 50.0, 1);

-- SKIPPED [309/517] argID=1437: no Wikipedia result

-- [310/517] argID=1440 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Tetragrammaton
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1440, 1, 'https://en.wikipedia.org/wiki/Tetragrammaton', '', '', '', 'Tetragrammaton', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1440 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1440, 1, 50.0, 1);

-- [311/517] argID=1442 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Gas_constant
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1442, 2, 'https://en.wikipedia.org/wiki/Gas_constant', '', '', '', 'Gas constant', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1442 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1442, 2, 50.0, 1);

-- [312/517] argID=1443 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Legal_status_of_same-sex_marriage
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1443, 1, 'https://en.wikipedia.org/wiki/Legal_status_of_same-sex_marriage', '', '', '', 'Legal status of same-sex marriage', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1443 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1443, 1, 50.0, 1);

-- [313/517] argID=1444 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Supreme_Court_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1444, 1, 'https://en.wikipedia.org/wiki/Supreme_Court_of_the_United_States', '', '', '', 'Supreme Court of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1444 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1444, 1, 50.0, 1);

-- [314/517] argID=1445 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Brett_Kavanaugh_Supreme_Court_nomination
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1445, 1, 'https://en.wikipedia.org/wiki/Brett_Kavanaugh_Supreme_Court_nomination', '', '', '', 'Brett Kavanaugh Supreme Court nomination', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1445 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1445, 1, 50.0, 1);

-- [315/517] argID=1446 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Foreign_policy_of_the_Biden_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1446, 1, 'https://en.wikipedia.org/wiki/Foreign_policy_of_the_Biden_administration', '', '', '', 'Foreign policy of the Biden administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1446 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1446, 1, 50.0, 1);

-- [316/517] argID=1449 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Joe_Biden
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1449, 1, 'https://en.wikipedia.org/wiki/Joe_Biden', '', '', '', 'Joe Biden', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1449 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1449, 1, 50.0, 1);

-- [317/517] argID=1450 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Gerrymandering
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1450, 1, 'https://en.wikipedia.org/wiki/Gerrymandering', '', '', '', 'Gerrymandering', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1450 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1450, 1, 50.0, 1);

-- [318/517] argID=1451 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Supreme_Court_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1451, 1, 'https://en.wikipedia.org/wiki/Supreme_Court_of_the_United_States', '', '', '', 'Supreme Court of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1451 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1451, 1, 50.0, 1);

-- [319/517] argID=1454 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Subcontractor
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1454, 1, 'https://en.wikipedia.org/wiki/Subcontractor', '', '', '', 'Subcontractor', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1454 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1454, 1, 50.0, 1);

-- [320/517] argID=1456 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Commonwealth_citizen
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1456, 2, 'https://en.wikipedia.org/wiki/Commonwealth_citizen', '', '', '', 'Commonwealth citizen', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1456 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1456, 2, 50.0, 1);

-- [321/517] argID=1457 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Supreme_Court_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1457, 2, 'https://en.wikipedia.org/wiki/Supreme_Court_of_the_United_States', '', '', '', 'Supreme Court of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1457 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1457, 2, 50.0, 1);

-- [322/517] argID=1458 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Supreme_Court_of_Virginia
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1458, 1, 'https://en.wikipedia.org/wiki/Supreme_Court_of_Virginia', '', '', '', 'Supreme Court of Virginia', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1458 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1458, 1, 50.0, 1);

-- [323/517] argID=1459 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Democratic_Party_%28United_States%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1459, 1, 'https://en.wikipedia.org/wiki/Democratic_Party_%28United_States%29', '', '', '', 'Democratic Party (United States)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1459 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1459, 1, 50.0, 1);

-- [324/517] argID=1470 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Southern_strategy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1470, 2, 'https://en.wikipedia.org/wiki/Southern_strategy', '', '', '', 'Southern strategy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1470 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1470, 2, 50.0, 1);

-- [325/517] argID=1471 → profileID=2
-- URL: https://en.wikipedia.org/wiki/FDT
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1471, 2, 'https://en.wikipedia.org/wiki/FDT', '', '', '', 'FDT', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1471 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1471, 2, 50.0, 1);

-- [326/517] argID=1472 → profileID=2
-- URL: https://en.wikipedia.org/wiki/LGBTQ_grooming_conspiracy_theory
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1472, 2, 'https://en.wikipedia.org/wiki/LGBTQ_grooming_conspiracy_theory', '', '', '', 'LGBTQ grooming conspiracy theory', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1472 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1472, 2, 50.0, 1);

-- [327/517] argID=1473 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Democratic_Party_%28United_States%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1473, 1, 'https://en.wikipedia.org/wiki/Democratic_Party_%28United_States%29', '', '', '', 'Democratic Party (United States)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1473 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1473, 1, 50.0, 1);

-- [328/517] argID=1474 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Republican_Party_%28United_States%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1474, 2, 'https://en.wikipedia.org/wiki/Republican_Party_%28United_States%29', '', '', '', 'Republican Party (United States)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1474 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1474, 2, 50.0, 1);

-- [329/517] argID=1475 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Democratic_Party_%28United_States%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1475, 1, 'https://en.wikipedia.org/wiki/Democratic_Party_%28United_States%29', '', '', '', 'Democratic Party (United States)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1475 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1475, 1, 50.0, 1);

-- [330/517] argID=1476 → profileID=1
-- URL: https://en.wikipedia.org/wiki/2024_Lebanon_war
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1476, 1, 'https://en.wikipedia.org/wiki/2024_Lebanon_war', '', '', '', '2024 Lebanon war', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1476 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1476, 1, 50.0, 1);

-- [331/517] argID=1477 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Weinberger_Doctrine
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1477, 1, 'https://en.wikipedia.org/wiki/Weinberger_Doctrine', '', '', '', 'Weinberger Doctrine', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1477 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1477, 1, 50.0, 1);

-- [332/517] argID=1478 → profileID=1
-- URL: https://en.wikipedia.org/wiki/George_W._Bush
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1478, 1, 'https://en.wikipedia.org/wiki/George_W._Bush', '', '', '', 'George W. Bush', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1478 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1478, 1, 50.0, 1);

-- [333/517] argID=1479 → profileID=1
-- URL: https://en.wikipedia.org/wiki/2025_Cambodian%E2%80%93Thai_border_crisis
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1479, 1, 'https://en.wikipedia.org/wiki/2025_Cambodian%E2%80%93Thai_border_crisis', '', '', '', '2025 Cambodian–Thai border crisis', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1479 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1479, 1, 50.0, 1);

-- [334/517] argID=1480 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Presidency_of_Javier_Milei
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1480, 1, 'https://en.wikipedia.org/wiki/Presidency_of_Javier_Milei', '', '', '', 'Presidency of Javier Milei', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1480 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1480, 1, 50.0, 1);

-- [335/517] argID=1482 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Soviet%E2%80%93Afghan_War
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1482, 1, 'https://en.wikipedia.org/wiki/Soviet%E2%80%93Afghan_War', '', '', '', 'Soviet–Afghan War', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1482 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1482, 1, 50.0, 1);

-- [336/517] argID=1483 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Moral_injury
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1483, 1, 'https://en.wikipedia.org/wiki/Moral_injury', '', '', '', 'Moral injury', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1483 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1483, 1, 50.0, 1);

-- [337/517] argID=1484 → profileID=1
-- URL: https://en.wikipedia.org/wiki/2020%E2%80%932021_U.S._troop_withdrawal_from_Afghanistan
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1484, 1, 'https://en.wikipedia.org/wiki/2020%E2%80%932021_U.S._troop_withdrawal_from_Afghanistan', '', '', '', '2020–2021 U.S. troop withdrawal from Afghanistan', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1484 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1484, 1, 50.0, 1);

-- [338/517] argID=1485 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Israeli%E2%80%93Palestinian_conflict
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1485, 1, 'https://en.wikipedia.org/wiki/Israeli%E2%80%93Palestinian_conflict', '', '', '', 'Israeli–Palestinian conflict', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1485 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1485, 1, 50.0, 1);

-- [339/517] argID=1486 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Authoritarianism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1486, 1, 'https://en.wikipedia.org/wiki/Authoritarianism', '', '', '', 'Authoritarianism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1486 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1486, 1, 50.0, 1);

-- [340/517] argID=1490 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Terrorism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1490, 1, 'https://en.wikipedia.org/wiki/Terrorism', '', '', '', 'Terrorism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1490 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1490, 1, 50.0, 1);

-- [341/517] argID=1491 → profileID=1
-- URL: https://en.wikipedia.org/wiki/War_in_Afghanistan_%282001%E2%80%932021%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1491, 1, 'https://en.wikipedia.org/wiki/War_in_Afghanistan_%282001%E2%80%932021%29', '', '', '', 'War in Afghanistan (2001–2021)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1491 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1491, 1, 50.0, 1);

-- [342/517] argID=1492 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Oil_smuggling_in_Iran
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1492, 1, 'https://en.wikipedia.org/wiki/Oil_smuggling_in_Iran', '', '', '', 'Oil smuggling in Iran', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1492 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1492, 1, 50.0, 1);

-- [343/517] argID=1493 → profileID=1
-- URL: https://en.wikipedia.org/wiki/War_in_Afghanistan_%282001%E2%80%932021%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1493, 1, 'https://en.wikipedia.org/wiki/War_in_Afghanistan_%282001%E2%80%932021%29', '', '', '', 'War in Afghanistan (2001–2021)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1493 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1493, 1, 50.0, 1);

-- [344/517] argID=1494 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Rare-earth_element
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1494, 1, 'https://en.wikipedia.org/wiki/Rare-earth_element', '', '', '', 'Rare-earth element', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1494 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1494, 1, 50.0, 1);

-- [345/517] argID=1495 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Gold
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1495, 1, 'https://en.wikipedia.org/wiki/Gold', '', '', '', 'Gold', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1495 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1495, 1, 50.0, 1);

-- [346/517] argID=1496 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Katie_Haun
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1496, 1, 'https://en.wikipedia.org/wiki/Katie_Haun', '', '', '', 'Katie Haun', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1496 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1496, 1, 50.0, 1);

-- [347/517] argID=1497 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Crime_in_New_York_City
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1497, 2, 'https://en.wikipedia.org/wiki/Crime_in_New_York_City', '', '', '', 'Crime in New York City', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1497 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1497, 2, 50.0, 1);

-- [348/517] argID=1498 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Qualified_immunity
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1498, 2, 'https://en.wikipedia.org/wiki/Qualified_immunity', '', '', '', 'Qualified immunity', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1498 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1498, 2, 50.0, 1);

-- [349/517] argID=1499 → profileID=1
-- URL: https://en.wikipedia.org/wiki/White_Americans
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1499, 1, 'https://en.wikipedia.org/wiki/White_Americans', '', '', '', 'White Americans', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1499 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1499, 1, 50.0, 1);

-- [350/517] argID=1500 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Culture_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1500, 1, 'https://en.wikipedia.org/wiki/Culture_of_the_United_States', '', '', '', 'Culture of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1500 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1500, 1, 50.0, 1);

-- [351/517] argID=1501 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Leipzig
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1501, 1, 'https://en.wikipedia.org/wiki/Leipzig', '', '', '', 'Leipzig', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1501 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1501, 1, 50.0, 1);

-- [352/517] argID=1502 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Minor_Threat
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1502, 2, 'https://en.wikipedia.org/wiki/Minor_Threat', '', '', '', 'Minor Threat', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1502 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1502, 2, 50.0, 1);

-- [353/517] argID=1503 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Capitalist_Realism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1503, 2, 'https://en.wikipedia.org/wiki/Capitalist_Realism', '', '', '', 'Capitalist Realism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1503 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1503, 2, 50.0, 1);

-- [354/517] argID=1504 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Anglo-Saxon_settlement_of_Britain
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1504, 2, 'https://en.wikipedia.org/wiki/Anglo-Saxon_settlement_of_Britain', '', '', '', 'Anglo-Saxon settlement of Britain', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1504 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1504, 2, 50.0, 1);

-- [355/517] argID=1505 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Information_Age
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1505, 1, 'https://en.wikipedia.org/wiki/Information_Age', '', '', '', 'Information Age', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1505 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1505, 1, 50.0, 1);

-- [356/517] argID=1506 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Moir%C3%A9_pattern
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1506, 1, 'https://en.wikipedia.org/wiki/Moir%C3%A9_pattern', '', '', '', 'Moiré pattern', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1506 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1506, 1, 50.0, 1);

-- [357/517] argID=1507 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Information_asymmetry
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1507, 1, 'https://en.wikipedia.org/wiki/Information_asymmetry', '', '', '', 'Information asymmetry', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1507 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1507, 1, 50.0, 1);

-- [358/517] argID=1508 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Online_casino
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1508, 1, 'https://en.wikipedia.org/wiki/Online_casino', '', '', '', 'Online casino', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1508 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1508, 1, 50.0, 1);

-- [359/517] argID=1509 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Social_media
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1509, 1, 'https://en.wikipedia.org/wiki/Social_media', '', '', '', 'Social media', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1509 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1509, 1, 50.0, 1);

-- [360/517] argID=1510 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Peter_Thiel
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1510, 1, 'https://en.wikipedia.org/wiki/Peter_Thiel', '', '', '', 'Peter Thiel', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1510 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1510, 1, 50.0, 1);

-- [361/517] argID=1511 → profileID=1
-- URL: https://en.wikipedia.org/wiki/False_or_misleading_statements_by_Donald_Trump_%28second_term%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1511, 1, 'https://en.wikipedia.org/wiki/False_or_misleading_statements_by_Donald_Trump_%28second_term%29', '', '', '', 'False or misleading statements by Donald Trump (second term)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1511 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1511, 1, 50.0, 1);

-- [362/517] argID=1512 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Patent_medicine
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1512, 1, 'https://en.wikipedia.org/wiki/Patent_medicine', '', '', '', 'Patent medicine', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1512 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1512, 1, 50.0, 1);

-- [363/517] argID=1513 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Michael_Savage
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1513, 1, 'https://en.wikipedia.org/wiki/Michael_Savage', '', '', '', 'Michael Savage', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1513 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1513, 1, 50.0, 1);

-- [364/517] argID=1514 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Homeopathy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1514, 1, 'https://en.wikipedia.org/wiki/Homeopathy', '', '', '', 'Homeopathy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1514 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1514, 1, 50.0, 1);

-- [365/517] argID=1515 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Sovereign_citizen_movement
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1515, 1, 'https://en.wikipedia.org/wiki/Sovereign_citizen_movement', '', '', '', 'Sovereign citizen movement', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1515 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1515, 1, 50.0, 1);

-- [366/517] argID=1516 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Coca-Cola
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1516, 1, 'https://en.wikipedia.org/wiki/Coca-Cola', '', '', '', 'Coca-Cola', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1516 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1516, 1, 50.0, 1);

-- [367/517] argID=1517 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Freedom_of_speech_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1517, 1, 'https://en.wikipedia.org/wiki/Freedom_of_speech_in_the_United_States', '', '', '', 'Freedom of speech in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1517 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1517, 1, 50.0, 1);

-- [368/517] argID=1518 → profileID=1
-- URL: https://en.wikipedia.org/wiki/First_Amendment_to_the_United_States_Constitution
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1518, 1, 'https://en.wikipedia.org/wiki/First_Amendment_to_the_United_States_Constitution', '', '', '', 'First Amendment to the United States Constitution', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1518 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1518, 1, 50.0, 1);

-- [369/517] argID=1519 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Herbalife
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1519, 1, 'https://en.wikipedia.org/wiki/Herbalife', '', '', '', 'Herbalife', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1519 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1519, 1, 50.0, 1);

-- [370/517] argID=1520 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Cosmopolitan_%28film%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1520, 1, 'https://en.wikipedia.org/wiki/Cosmopolitan_%28film%29', '', '', '', 'Cosmopolitan (film)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1520 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1520, 1, 50.0, 1);

-- [371/517] argID=1521 → profileID=2
-- URL: https://en.wikipedia.org/wiki/X_%28social_network%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1521, 2, 'https://en.wikipedia.org/wiki/X_%28social_network%29', '', '', '', 'X (social network)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1521 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1521, 2, 50.0, 1);

-- [372/517] argID=1522 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Ilya_Rozanov
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1522, 1, 'https://en.wikipedia.org/wiki/Ilya_Rozanov', '', '', '', 'Ilya Rozanov', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1522 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1522, 1, 50.0, 1);

-- [373/517] argID=1523 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Electrification
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1523, 2, 'https://en.wikipedia.org/wiki/Electrification', '', '', '', 'Electrification', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1523 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1523, 2, 50.0, 1);

-- [374/517] argID=1525 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Douglas_Adams
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1525, 2, 'https://en.wikipedia.org/wiki/Douglas_Adams', '', '', '', 'Douglas Adams', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1525 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1525, 2, 50.0, 1);

-- [375/517] argID=1526 → profileID=2
-- URL: https://en.wikipedia.org/wiki/City
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1526, 2, 'https://en.wikipedia.org/wiki/City', '', '', '', 'City', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1526 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1526, 2, 50.0, 1);

-- [376/517] argID=1527 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Mass_Effect_3
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1527, 2, 'https://en.wikipedia.org/wiki/Mass_Effect_3', '', '', '', 'Mass Effect 3', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1527 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1527, 2, 50.0, 1);

-- SKIPPED [377/517] argID=1528: no Wikipedia result

-- [378/517] argID=1529 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Elon_Musk
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1529, 1, 'https://en.wikipedia.org/wiki/Elon_Musk', '', '', '', 'Elon Musk', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1529 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1529, 1, 50.0, 1);

-- [379/517] argID=1530 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Views_of_Elon_Musk
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1530, 2, 'https://en.wikipedia.org/wiki/Views_of_Elon_Musk', '', '', '', 'Views of Elon Musk', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1530 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1530, 2, 50.0, 1);

-- [380/517] argID=1531 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Cryptocurrency_bubble
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1531, 1, 'https://en.wikipedia.org/wiki/Cryptocurrency_bubble', '', '', '', 'Cryptocurrency bubble', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1531 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1531, 1, 50.0, 1);

-- [381/517] argID=1532 → profileID=2
-- URL: https://en.wikipedia.org/wiki/List_of_Saturday_Night_Live_commercial_parodies
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1532, 2, 'https://en.wikipedia.org/wiki/List_of_Saturday_Night_Live_commercial_parodies', '', '', '', 'List of Saturday Night Live commercial parodies', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1532 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1532, 2, 50.0, 1);

-- [382/517] argID=1533 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Holland_Tunnel
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1533, 2, 'https://en.wikipedia.org/wiki/Holland_Tunnel', '', '', '', 'Holland Tunnel', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1533 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1533, 2, 50.0, 1);

-- [383/517] argID=1534 → profileID=2
-- URL: https://en.wikipedia.org/wiki/SpaceX_Mars_colonization_program
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1534, 2, 'https://en.wikipedia.org/wiki/SpaceX_Mars_colonization_program', '', '', '', 'SpaceX Mars colonization program', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1534 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1534, 2, 50.0, 1);

-- [384/517] argID=1535 → profileID=2
-- URL: https://en.wikipedia.org/wiki/United_States_Numbered_Highway_System
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1535, 2, 'https://en.wikipedia.org/wiki/United_States_Numbered_Highway_System', '', '', '', 'United States Numbered Highway System', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1535 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1535, 2, 50.0, 1);

-- [385/517] argID=1536 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Transit-oriented_development
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1536, 2, 'https://en.wikipedia.org/wiki/Transit-oriented_development', '', '', '', 'Transit-oriented development', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1536 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1536, 2, 50.0, 1);

-- [386/517] argID=1537 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Police_and_crime_commissioner
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1537, 2, 'https://en.wikipedia.org/wiki/Police_and_crime_commissioner', '', '', '', 'Police and crime commissioner', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1537 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1537, 2, 50.0, 1);

-- [387/517] argID=1539 → profileID=1
-- URL: https://en.wikipedia.org/wiki/History_of_golf
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1539, 1, 'https://en.wikipedia.org/wiki/History_of_golf', '', '', '', 'History of golf', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1539 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1539, 1, 50.0, 1);

-- [388/517] argID=1540 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_most-polluted_rivers
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1540, 1, 'https://en.wikipedia.org/wiki/List_of_most-polluted_rivers', '', '', '', 'List of most-polluted rivers', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1540 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1540, 1, 50.0, 1);

-- [389/517] argID=1541 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Millennials
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1541, 1, 'https://en.wikipedia.org/wiki/Millennials', '', '', '', 'Millennials', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1541 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1541, 1, 50.0, 1);

-- [390/517] argID=1542 → profileID=1
-- URL: https://en.wikipedia.org/wiki/FBI_search_of_Mar-a-Lago
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1542, 1, 'https://en.wikipedia.org/wiki/FBI_search_of_Mar-a-Lago', '', '', '', 'FBI search of Mar-a-Lago', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1542 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1542, 1, 50.0, 1);

-- [391/517] argID=1544 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Business_career_of_Donald_Trump
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1544, 1, 'https://en.wikipedia.org/wiki/Business_career_of_Donald_Trump', '', '', '', 'Business career of Donald Trump', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1544 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1544, 1, 50.0, 1);

-- [392/517] argID=1545 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Local_government
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1545, 1, 'https://en.wikipedia.org/wiki/Local_government', '', '', '', 'Local government', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1545 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1545, 1, 50.0, 1);

-- [393/517] argID=1546 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Housing_crisis
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1546, 1, 'https://en.wikipedia.org/wiki/Housing_crisis', '', '', '', 'Housing crisis', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1546 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1546, 1, 50.0, 1);

-- [394/517] argID=1547 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Lower_East_Side
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1547, 1, 'https://en.wikipedia.org/wiki/Lower_East_Side', '', '', '', 'Lower East Side', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1547 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1547, 1, 50.0, 1);

-- [395/517] argID=1559 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Los_Angeles
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1559, 1, 'https://en.wikipedia.org/wiki/Los_Angeles', '', '', '', 'Los Angeles', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1559 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1559, 1, 50.0, 1);

-- [396/517] argID=1560 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Seaside%2C_California
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1560, 1, 'https://en.wikipedia.org/wiki/Seaside%2C_California', '', '', '', 'Seaside, California', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1560 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1560, 1, 50.0, 1);

-- [397/517] argID=1561 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Subprime_mortgage_crisis
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1561, 1, 'https://en.wikipedia.org/wiki/Subprime_mortgage_crisis', '', '', '', 'Subprime mortgage crisis', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1561 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1561, 1, 50.0, 1);

-- [398/517] argID=1562 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Reprisals_against_commentators_on_the_Charlie_Kirk_assassination
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1562, 1, 'https://en.wikipedia.org/wiki/Reprisals_against_commentators_on_the_Charlie_Kirk_assassination', '', '', '', 'Reprisals against commentators on the Charlie Kirk assassination', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1562 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1562, 1, 50.0, 1);

-- [399/517] argID=1563 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Bill_Maher
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1563, 2, 'https://en.wikipedia.org/wiki/Bill_Maher', '', '', '', 'Bill Maher', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1563 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1563, 2, 50.0, 1);

-- SKIPPED [400/517] argID=1564: no Wikipedia result

-- [401/517] argID=1565 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Miko
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1565, 2, 'https://en.wikipedia.org/wiki/Miko', '', '', '', 'Miko', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1565 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1565, 2, 50.0, 1);

-- [402/517] argID=1566 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Ebonics_%28word%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1566, 2, 'https://en.wikipedia.org/wiki/Ebonics_%28word%29', '', '', '', 'Ebonics (word)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1566 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1566, 2, 50.0, 1);

-- [403/517] argID=1567 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Black_hole
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1567, 2, 'https://en.wikipedia.org/wiki/Black_hole', '', '', '', 'Black hole', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1567 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1567, 2, 50.0, 1);

-- [404/517] argID=1570 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Induced_demand
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1570, 1, 'https://en.wikipedia.org/wiki/Induced_demand', '', '', '', 'Induced demand', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1570 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1570, 1, 50.0, 1);

-- [405/517] argID=1571 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Affordable_housing
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1571, 1, 'https://en.wikipedia.org/wiki/Affordable_housing', '', '', '', 'Affordable housing', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1571 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1571, 1, 50.0, 1);

-- [406/517] argID=1573 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Driver%27s_license
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1573, 1, 'https://en.wikipedia.org/wiki/Driver%27s_license', '', '', '', 'Driver\'s license', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1573 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1573, 1, 50.0, 1);

-- [407/517] argID=1574 → profileID=1
-- URL: https://en.wikipedia.org/wiki/A_Better_Tomorrow
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1574, 1, 'https://en.wikipedia.org/wiki/A_Better_Tomorrow', '', '', '', 'A Better Tomorrow', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1574 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1574, 1, 50.0, 1);

-- [408/517] argID=1575 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Parking
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1575, 1, 'https://en.wikipedia.org/wiki/Parking', '', '', '', 'Parking', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1575 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1575, 1, 50.0, 1);

-- [409/517] argID=1576 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Right_of_way
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1576, 1, 'https://en.wikipedia.org/wiki/Right_of_way', '', '', '', 'Right of way', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1576 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1576, 1, 50.0, 1);

-- [410/517] argID=1577 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Soviet_Union
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1577, 1, 'https://en.wikipedia.org/wiki/Soviet_Union', '', '', '', 'Soviet Union', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1577 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1577, 1, 50.0, 1);

-- [411/517] argID=1578 → profileID=2
-- URL: https://en.wikipedia.org/wiki/The_X-Files
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1578, 2, 'https://en.wikipedia.org/wiki/The_X-Files', '', '', '', 'The X-Files', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1578 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1578, 2, 50.0, 1);

-- [412/517] argID=1579 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Human_rights
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1579, 2, 'https://en.wikipedia.org/wiki/Human_rights', '', '', '', 'Human rights', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1579 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1579, 2, 50.0, 1);

-- [413/517] argID=1580 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Brook_%28One_Piece%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1580, 1, 'https://en.wikipedia.org/wiki/Brook_%28One_Piece%29', '', '', '', 'Brook (One Piece)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1580 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1580, 1, 50.0, 1);

-- [414/517] argID=1582 → profileID=1
-- URL: https://en.wikipedia.org/wiki/The_Good_Girl_%282004_film%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1582, 1, 'https://en.wikipedia.org/wiki/The_Good_Girl_%282004_film%29', '', '', '', 'The Good Girl (2004 film)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1582 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1582, 1, 50.0, 1);

-- [415/517] argID=1583 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_artists_influenced_by_Michael_Jackson
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1583, 1, 'https://en.wikipedia.org/wiki/List_of_artists_influenced_by_Michael_Jackson', '', '', '', 'List of artists influenced by Michael Jackson', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1583 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1583, 1, 50.0, 1);

-- [416/517] argID=1584 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Personal_relationships_of_Michael_Jackson
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1584, 1, 'https://en.wikipedia.org/wiki/Personal_relationships_of_Michael_Jackson', '', '', '', 'Personal relationships of Michael Jackson', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1584 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1584, 1, 50.0, 1);

-- [417/517] argID=1585 → profileID=1
-- URL: https://en.wikipedia.org/wiki/List_of_social_networking_services
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1585, 1, 'https://en.wikipedia.org/wiki/List_of_social_networking_services', '', '', '', 'List of social networking services', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1585 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1585, 1, 50.0, 1);

-- SKIPPED [418/517] argID=1586: no Wikipedia result

-- SKIPPED [419/517] argID=1587: no Wikipedia result

-- [420/517] argID=1588 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Online_disinhibition_effect
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1588, 1, 'https://en.wikipedia.org/wiki/Online_disinhibition_effect', '', '', '', 'Online disinhibition effect', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1588 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1588, 1, 50.0, 1);

-- [421/517] argID=1589 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1589, 2, 'https://en.wikipedia.org/wiki/Socialism', '', '', '', 'Socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1589 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1589, 2, 50.0, 1);

-- [422/517] argID=1590 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Collective_ownership
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1590, 1, 'https://en.wikipedia.org/wiki/Collective_ownership', '', '', '', 'Collective ownership', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1590 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1590, 1, 50.0, 1);

-- [423/517] argID=1591 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Authoritarian_socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1591, 1, 'https://en.wikipedia.org/wiki/Authoritarian_socialism', '', '', '', 'Authoritarian socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1591 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1591, 1, 50.0, 1);

-- [424/517] argID=1592 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Authoritarian_socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1592, 1, 'https://en.wikipedia.org/wiki/Authoritarian_socialism', '', '', '', 'Authoritarian socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1592 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1592, 1, 50.0, 1);

-- [425/517] argID=1593 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Anarcho-capitalism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1593, 1, 'https://en.wikipedia.org/wiki/Anarcho-capitalism', '', '', '', 'Anarcho-capitalism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1593 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1593, 1, 50.0, 1);

-- [426/517] argID=1594 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Nordic_model
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1594, 2, 'https://en.wikipedia.org/wiki/Nordic_model', '', '', '', 'Nordic model', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1594 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1594, 2, 50.0, 1);

-- [427/517] argID=1595 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Informal_economy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1595, 1, 'https://en.wikipedia.org/wiki/Informal_economy', '', '', '', 'Informal economy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1595 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1595, 1, 50.0, 1);

-- [428/517] argID=1596 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Cuban_Revolution
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1596, 1, 'https://en.wikipedia.org/wiki/Cuban_Revolution', '', '', '', 'Cuban Revolution', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1596 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1596, 1, 50.0, 1);

-- [429/517] argID=1597 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Authoritarian_socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1597, 1, 'https://en.wikipedia.org/wiki/Authoritarian_socialism', '', '', '', 'Authoritarian socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1597 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1597, 1, 50.0, 1);

-- [430/517] argID=1598 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Capital_punishment_by_country
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1598, 2, 'https://en.wikipedia.org/wiki/Capital_punishment_by_country', '', '', '', 'Capital punishment by country', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1598 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1598, 2, 50.0, 1);

-- [431/517] argID=1599 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Cruel_and_unusual_punishment
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1599, 2, 'https://en.wikipedia.org/wiki/Cruel_and_unusual_punishment', '', '', '', 'Cruel and unusual punishment', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1599 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1599, 2, 50.0, 1);

-- [432/517] argID=1600 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Hanging
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1600, 1, 'https://en.wikipedia.org/wiki/Hanging', '', '', '', 'Hanging', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1600 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1600, 1, 50.0, 1);

-- [433/517] argID=1601 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Eco-socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1601, 2, 'https://en.wikipedia.org/wiki/Eco-socialism', '', '', '', 'Eco-socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1601 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1601, 2, 50.0, 1);

-- [434/517] argID=1602 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Private_property
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1602, 1, 'https://en.wikipedia.org/wiki/Private_property', '', '', '', 'Private property', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1602 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1602, 1, 50.0, 1);

-- [435/517] argID=1603 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Economy_of_Brazil
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1603, 1, 'https://en.wikipedia.org/wiki/Economy_of_Brazil', '', '', '', 'Economy of Brazil', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1603 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1603, 1, 50.0, 1);

-- [436/517] argID=1604 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Capitalism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1604, 1, 'https://en.wikipedia.org/wiki/Capitalism', '', '', '', 'Capitalism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1604 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1604, 1, 50.0, 1);

-- [437/517] argID=1605 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Traffic_signal_preemption
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1605, 1, 'https://en.wikipedia.org/wiki/Traffic_signal_preemption', '', '', '', 'Traffic signal preemption', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1605 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1605, 1, 50.0, 1);

-- [438/517] argID=1606 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Accelerationism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1606, 2, 'https://en.wikipedia.org/wiki/Accelerationism', '', '', '', 'Accelerationism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1606 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1606, 2, 50.0, 1);

-- [439/517] argID=1607 → profileID=1
-- URL: https://en.wikipedia.org/wiki/De_%28Chinese%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1607, 1, 'https://en.wikipedia.org/wiki/De_%28Chinese%29', '', '', '', 'De (Chinese)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1607 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1607, 1, 50.0, 1);

-- [440/517] argID=1610 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Working_time
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1610, 1, 'https://en.wikipedia.org/wiki/Working_time', '', '', '', 'Working time', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1610 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1610, 1, 50.0, 1);

-- [441/517] argID=1611 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Sweatshop
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1611, 1, 'https://en.wikipedia.org/wiki/Sweatshop', '', '', '', 'Sweatshop', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1611 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1611, 1, 50.0, 1);

-- [442/517] argID=1612 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Transgender_rights_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1612, 2, 'https://en.wikipedia.org/wiki/Transgender_rights_in_the_United_States', '', '', '', 'Transgender rights in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1612 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1612, 2, 50.0, 1);

-- [443/517] argID=1613 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Juvenile_delinquency
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1613, 1, 'https://en.wikipedia.org/wiki/Juvenile_delinquency', '', '', '', 'Juvenile delinquency', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1613 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1613, 1, 50.0, 1);

-- [444/517] argID=1614 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Stonewall_riots
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1614, 2, 'https://en.wikipedia.org/wiki/Stonewall_riots', '', '', '', 'Stonewall riots', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1614 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1614, 2, 50.0, 1);

-- [445/517] argID=1620 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Hamas
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1620, 1, 'https://en.wikipedia.org/wiki/Hamas', '', '', '', 'Hamas', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1620 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1620, 1, 50.0, 1);

-- [446/517] argID=1644 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Israeli_attack_on_Doha
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1644, 1, 'https://en.wikipedia.org/wiki/Israeli_attack_on_Doha', '', '', '', 'Israeli attack on Doha', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1644 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1644, 1, 50.0, 1);

-- [447/517] argID=1645 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Suspension_of_Jimmy_Kimmel_Live%21
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1645, 1, 'https://en.wikipedia.org/wiki/Suspension_of_Jimmy_Kimmel_Live%21', '', '', '', 'Suspension of Jimmy Kimmel Live!', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1645 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1645, 1, 50.0, 1);

-- [448/517] argID=1646 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Racism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1646, 1, 'https://en.wikipedia.org/wiki/Racism', '', '', '', 'Racism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1646 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1646, 1, 50.0, 1);

-- [449/517] argID=1651 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Palestinian_refugees
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1651, 1, 'https://en.wikipedia.org/wiki/Palestinian_refugees', '', '', '', 'Palestinian refugees', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1651 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1651, 1, 50.0, 1);

-- [450/517] argID=1652 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Hamas
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1652, 1, 'https://en.wikipedia.org/wiki/Hamas', '', '', '', 'Hamas', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1652 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1652, 1, 50.0, 1);

-- [451/517] argID=1653 → profileID=1
-- URL: https://en.wikipedia.org/wiki/1988_Hamas_charter
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1653, 1, 'https://en.wikipedia.org/wiki/1988_Hamas_charter', '', '', '', '1988 Hamas charter', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1653 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1653, 1, 50.0, 1);

-- [452/517] argID=1656 → profileID=1
-- URL: https://en.wikipedia.org/wiki/1988_Hamas_charter
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1656, 1, 'https://en.wikipedia.org/wiki/1988_Hamas_charter', '', '', '', '1988 Hamas charter', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1656 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1656, 1, 50.0, 1);

-- [453/517] argID=1658 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Royal_Brunei_Land_Force
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1658, 1, 'https://en.wikipedia.org/wiki/Royal_Brunei_Land_Force', '', '', '', 'Royal Brunei Land Force', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1658 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1658, 1, 50.0, 1);

-- [454/517] argID=1659 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Critical_race_theory
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1659, 2, 'https://en.wikipedia.org/wiki/Critical_race_theory', '', '', '', 'Critical race theory', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1659 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1659, 2, 50.0, 1);

-- [455/517] argID=1660 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Critical_race_theory
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1660, 1, 'https://en.wikipedia.org/wiki/Critical_race_theory', '', '', '', 'Critical race theory', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1660 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1660, 1, 50.0, 1);

-- [456/517] argID=1661 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Racial_segregation_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1661, 2, 'https://en.wikipedia.org/wiki/Racial_segregation_in_the_United_States', '', '', '', 'Racial segregation in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1661 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1661, 2, 50.0, 1);

-- [457/517] argID=1662 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Race_and_health_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1662, 1, 'https://en.wikipedia.org/wiki/Race_and_health_in_the_United_States', '', '', '', 'Race and health in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1662 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1662, 1, 50.0, 1);

-- [458/517] argID=1663 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Healthcare_in_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1663, 1, 'https://en.wikipedia.org/wiki/Healthcare_in_the_United_States', '', '', '', 'Healthcare in the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1663 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1663, 1, 50.0, 1);

-- [459/517] argID=1664 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Gaza_genocide
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1664, 2, 'https://en.wikipedia.org/wiki/Gaza_genocide', '', '', '', 'Gaza genocide', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1664 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1664, 2, 50.0, 1);

-- [460/517] argID=1665 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Nazi_racial_theories
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1665, 2, 'https://en.wikipedia.org/wiki/Nazi_racial_theories', '', '', '', 'Nazi racial theories', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1665 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1665, 2, 50.0, 1);

-- [461/517] argID=1667 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Article_One_of_the_United_States_Constitution
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1667, 1, 'https://en.wikipedia.org/wiki/Article_One_of_the_United_States_Constitution', '', '', '', 'Article One of the United States Constitution', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1667 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1667, 1, 50.0, 1);

-- [462/517] argID=1668 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Constitution_of_the_United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1668, 2, 'https://en.wikipedia.org/wiki/Constitution_of_the_United_States', '', '', '', 'Constitution of the United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1668 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1668, 2, 50.0, 1);

-- [463/517] argID=1669 → profileID=2
-- URL: https://en.wikipedia.org/wiki/Indigenous_peoples_of_the_Americas
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1669, 2, 'https://en.wikipedia.org/wiki/Indigenous_peoples_of_the_Americas', '', '', '', 'Indigenous peoples of the Americas', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1669 AND profileID = 2));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1669, 2, 50.0, 1);

-- [464/517] argID=1670 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Forty_acres_and_a_mule
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1670, 1, 'https://en.wikipedia.org/wiki/Forty_acres_and_a_mule', '', '', '', 'Forty acres and a mule', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1670 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1670, 1, 50.0, 1);

-- [465/517] argID=1672 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Rothschild_family
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1672, 1, 'https://en.wikipedia.org/wiki/Rothschild_family', '', '', '', 'Rothschild family', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1672 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1672, 1, 50.0, 1);

-- [466/517] argID=1673 → profileID=1
-- URL: https://en.wikipedia.org/wiki/SpaceX_Starship_%28spacecraft%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1673, 1, 'https://en.wikipedia.org/wiki/SpaceX_Starship_%28spacecraft%29', '', '', '', 'SpaceX Starship (spacecraft)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1673 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1673, 1, 50.0, 1);

-- [467/517] argID=1674 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Space_Launch_System
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1674, 1, 'https://en.wikipedia.org/wiki/Space_Launch_System', '', '', '', 'Space Launch System', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1674 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1674, 1, 50.0, 1);

-- [468/517] argID=1704 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Sharpe_ratio
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1704, 28, 'https://en.wikipedia.org/wiki/Sharpe_ratio', '', '', '', 'Sharpe ratio', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1704 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1704, 28, 50.0, 1);

-- [469/517] argID=1705 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Endogeneity_%28econometrics%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1705, 28, 'https://en.wikipedia.org/wiki/Endogeneity_%28econometrics%29', '', '', '', 'Endogeneity (econometrics)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1705 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1705, 28, 50.0, 1);

-- [470/517] argID=1706 → profileID=28
-- URL: https://en.wikipedia.org/wiki/United_States
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1706, 28, 'https://en.wikipedia.org/wiki/United_States', '', '', '', 'United States', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1706 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1706, 28, 50.0, 1);

-- [471/517] argID=1707 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Second_Amendment_to_the_United_States_Constitution
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1707, 1, 'https://en.wikipedia.org/wiki/Second_Amendment_to_the_United_States_Constitution', '', '', '', 'Second Amendment to the United States Constitution', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1707 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1707, 1, 50.0, 1);

-- [472/517] argID=1708 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Sound_Transit
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1708, 28, 'https://en.wikipedia.org/wiki/Sound_Transit', '', '', '', 'Sound Transit', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1708 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1708, 28, 50.0, 1);

-- [473/517] argID=1710 → profileID=1
-- URL: https://en.wikipedia.org/wiki/Orgasm
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1710, 1, 'https://en.wikipedia.org/wiki/Orgasm', '', '', '', 'Orgasm', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1710 AND profileID = 1));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1710, 1, 50.0, 1);

-- [474/517] argID=1711 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Scientific_method
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1711, 28, 'https://en.wikipedia.org/wiki/Scientific_method', '', '', '', 'Scientific method', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1711 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1711, 28, 50.0, 1);

-- [475/517] argID=1712 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Agenda_47
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1712, 28, 'https://en.wikipedia.org/wiki/Agenda_47', '', '', '', 'Agenda 47', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1712 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1712, 28, 50.0, 1);

-- [476/517] argID=1713 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Squid_as_food
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1713, 28, 'https://en.wikipedia.org/wiki/Squid_as_food', '', '', '', 'Squid as food', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1713 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1713, 28, 50.0, 1);

-- [477/517] argID=1715 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Homosexual_behavior_in_animals
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1715, 28, 'https://en.wikipedia.org/wiki/Homosexual_behavior_in_animals', '', '', '', 'Homosexual behavior in animals', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1715 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1715, 28, 50.0, 1);

-- [478/517] argID=1716 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Variable_renewable_energy
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1716, 28, 'https://en.wikipedia.org/wiki/Variable_renewable_energy', '', '', '', 'Variable renewable energy', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1716 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1716, 28, 50.0, 1);

-- [479/517] argID=1718 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Human_rights_violations_against_Palestinians_by_Israel
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1718, 28, 'https://en.wikipedia.org/wiki/Human_rights_violations_against_Palestinians_by_Israel', '', '', '', 'Human rights violations against Palestinians by Israel', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1718 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1718, 28, 50.0, 1);

-- [480/517] argID=1720 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Violence_and_controversies_during_the_George_Floyd_protests
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1720, 28, 'https://en.wikipedia.org/wiki/Violence_and_controversies_during_the_George_Floyd_protests', '', '', '', 'Violence and controversies during the George Floyd protests', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1720 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1720, 28, 50.0, 1);

-- [481/517] argID=1721 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Social_contract
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1721, 28, 'https://en.wikipedia.org/wiki/Social_contract', '', '', '', 'Social contract', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1721 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1721, 28, 50.0, 1);

-- [482/517] argID=1722 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Vaccination
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1722, 28, 'https://en.wikipedia.org/wiki/Vaccination', '', '', '', 'Vaccination', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1722 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1722, 28, 50.0, 1);

-- [483/517] argID=1723 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Governorship_of_Ron_DeSantis
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1723, 28, 'https://en.wikipedia.org/wiki/Governorship_of_Ron_DeSantis', '', '', '', 'Governorship of Ron DeSantis', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1723 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1723, 28, 50.0, 1);

-- [484/517] argID=1724 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Golan_Heights
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1724, 28, 'https://en.wikipedia.org/wiki/Golan_Heights', '', '', '', 'Golan Heights', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1724 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1724, 28, 50.0, 1);

-- [485/517] argID=1725 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Second_presidency_of_Donald_Trump
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1725, 28, 'https://en.wikipedia.org/wiki/Second_presidency_of_Donald_Trump', '', '', '', 'Second presidency of Donald Trump', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1725 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1725, 28, 50.0, 1);

-- [486/517] argID=1726 → profileID=28
-- URL: https://en.wikipedia.org/wiki/False_or_misleading_statements_by_Donald_Trump_%28second_term%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1726, 28, 'https://en.wikipedia.org/wiki/False_or_misleading_statements_by_Donald_Trump_%28second_term%29', '', '', '', 'False or misleading statements by Donald Trump (second term)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1726 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1726, 28, 50.0, 1);

-- [487/517] argID=1727 → profileID=28
-- URL: https://en.wikipedia.org/wiki/2026_Iran_war
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1727, 28, 'https://en.wikipedia.org/wiki/2026_Iran_war', '', '', '', '2026 Iran war', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1727 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1727, 28, 50.0, 1);

-- [488/517] argID=1729 → profileID=28
-- URL: https://en.wikipedia.org/wiki/2026_Iran_war
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1729, 28, 'https://en.wikipedia.org/wiki/2026_Iran_war', '', '', '', '2026 Iran war', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1729 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1729, 28, 50.0, 1);

-- [489/517] argID=1730 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Second_impeachment_of_Donald_Trump
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1730, 28, 'https://en.wikipedia.org/wiki/Second_impeachment_of_Donald_Trump', '', '', '', 'Second impeachment of Donald Trump', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1730 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1730, 28, 50.0, 1);

-- [490/517] argID=1731 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Donald_Trump_2016_presidential_campaign
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1731, 28, 'https://en.wikipedia.org/wiki/Donald_Trump_2016_presidential_campaign', '', '', '', 'Donald Trump 2016 presidential campaign', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1731 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1731, 28, 50.0, 1);

-- [491/517] argID=1732 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Domestic_policy_of_the_second_Trump_administration
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1732, 28, 'https://en.wikipedia.org/wiki/Domestic_policy_of_the_second_Trump_administration', '', '', '', 'Domestic policy of the second Trump administration', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1732 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1732, 28, 50.0, 1);

-- [492/517] argID=1733 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Suez_Crisis
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1733, 28, 'https://en.wikipedia.org/wiki/Suez_Crisis', '', '', '', 'Suez Crisis', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1733 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1733, 28, 50.0, 1);

-- [493/517] argID=1734 → profileID=28
-- URL: https://en.wikipedia.org/wiki/2026_Iran_war
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1734, 28, 'https://en.wikipedia.org/wiki/2026_Iran_war', '', '', '', '2026 Iran war', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1734 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1734, 28, 50.0, 1);

-- SKIPPED [494/517] argID=1735: no Wikipedia result

-- [495/517] argID=1736 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Girl
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1736, 28, 'https://en.wikipedia.org/wiki/Girl', '', '', '', 'Girl', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1736 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1736, 28, 50.0, 1);

-- [496/517] argID=1737 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Non-binary
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1737, 28, 'https://en.wikipedia.org/wiki/Non-binary', '', '', '', 'Non-binary', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1737 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1737, 28, 50.0, 1);

-- [497/517] argID=1738 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Smith%E2%80%93Lemli%E2%80%93Opitz_syndrome
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1738, 28, 'https://en.wikipedia.org/wiki/Smith%E2%80%93Lemli%E2%80%93Opitz_syndrome', '', '', '', 'Smith–Lemli–Opitz syndrome', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1738 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1738, 28, 50.0, 1);

-- [498/517] argID=1739 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Disorders_of_sex_development
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1739, 28, 'https://en.wikipedia.org/wiki/Disorders_of_sex_development', '', '', '', 'Disorders of sex development', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1739 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1739, 28, 50.0, 1);

-- [499/517] argID=1740 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Disorders_of_sex_development
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1740, 28, 'https://en.wikipedia.org/wiki/Disorders_of_sex_development', '', '', '', 'Disorders of sex development', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1740 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1740, 28, 50.0, 1);

-- [500/517] argID=1741 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Genealogical_DNA_test
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1741, 28, 'https://en.wikipedia.org/wiki/Genealogical_DNA_test', '', '', '', 'Genealogical DNA test', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1741 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1741, 28, 50.0, 1);

-- [501/517] argID=1742 → profileID=28
-- URL: https://en.wikipedia.org/wiki/XYY_syndrome
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1742, 28, 'https://en.wikipedia.org/wiki/XYY_syndrome', '', '', '', 'XYY syndrome', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1742 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1742, 28, 50.0, 1);

-- [502/517] argID=1743 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Intersex
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1743, 28, 'https://en.wikipedia.org/wiki/Intersex', '', '', '', 'Intersex', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1743 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1743, 28, 50.0, 1);

-- [503/517] argID=1744 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Sex_chromosome
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1744, 28, 'https://en.wikipedia.org/wiki/Sex_chromosome', '', '', '', 'Sex chromosome', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1744 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1744, 28, 50.0, 1);

-- [504/517] argID=1745 → profileID=28
-- URL: https://en.wikipedia.org/wiki/XYY_syndrome
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1745, 28, 'https://en.wikipedia.org/wiki/XYY_syndrome', '', '', '', 'XYY syndrome', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1745 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1745, 28, 50.0, 1);

-- [505/517] argID=1746 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Authoritarian_socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1746, 28, 'https://en.wikipedia.org/wiki/Authoritarian_socialism', '', '', '', 'Authoritarian socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1746 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1746, 28, 50.0, 1);

-- [506/517] argID=1747 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Authoritarian_socialism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1747, 28, 'https://en.wikipedia.org/wiki/Authoritarian_socialism', '', '', '', 'Authoritarian socialism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1747 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1747, 28, 50.0, 1);

-- [507/517] argID=1749 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Suspension_of_Jimmy_Kimmel_Live%21
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1749, 28, 'https://en.wikipedia.org/wiki/Suspension_of_Jimmy_Kimmel_Live%21', '', '', '', 'Suspension of Jimmy Kimmel Live!', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1749 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1749, 28, 50.0, 1);

-- [508/517] argID=1750 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Gender_role
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1750, 28, 'https://en.wikipedia.org/wiki/Gender_role', '', '', '', 'Gender role', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1750 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1750, 28, 50.0, 1);

-- [509/517] argID=1751 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Thou_shalt_not_steal
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1751, 28, 'https://en.wikipedia.org/wiki/Thou_shalt_not_steal', '', '', '', 'Thou shalt not steal', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1751 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1751, 28, 50.0, 1);

-- [510/517] argID=1752 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Sin_tax
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1752, 28, 'https://en.wikipedia.org/wiki/Sin_tax', '', '', '', 'Sin tax', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1752 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1752, 28, 50.0, 1);

-- [511/517] argID=1753 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Member_state_of_the_European_Union
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1753, 28, 'https://en.wikipedia.org/wiki/Member_state_of_the_European_Union', '', '', '', 'Member state of the European Union', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1753 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1753, 28, 50.0, 1);

-- [512/517] argID=1754 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Ned_Kelly
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1754, 28, 'https://en.wikipedia.org/wiki/Ned_Kelly', '', '', '', 'Ned Kelly', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1754 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1754, 28, 50.0, 1);

-- [513/517] argID=1755 → profileID=28
-- URL: https://en.wikipedia.org/wiki/George_W._Bush
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1755, 28, 'https://en.wikipedia.org/wiki/George_W._Bush', '', '', '', 'George W. Bush', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1755 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1755, 28, 50.0, 1);

-- [514/517] argID=1756 → profileID=28
-- URL: https://en.wikipedia.org/wiki/List_of_JoJo%27s_Bizarre_Adventure_characters
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1756, 28, 'https://en.wikipedia.org/wiki/List_of_JoJo%27s_Bizarre_Adventure_characters', '', '', '', 'List of JoJo\'s Bizarre Adventure characters', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1756 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1756, 28, 50.0, 1);

-- [515/517] argID=1757 → profileID=28
-- URL: https://en.wikipedia.org/wiki/National_Police_Corps_%28Netherlands%29
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1757, 28, 'https://en.wikipedia.org/wiki/National_Police_Corps_%28Netherlands%29', '', '', '', 'National Police Corps (Netherlands)', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1757 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1757, 28, 50.0, 1);

-- [516/517] argID=1758 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Totem_pole
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1758, 28, 'https://en.wikipedia.org/wiki/Totem_pole', '', '', '', 'Totem pole', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1758 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1758, 28, 50.0, 1);

-- [517/517] argID=1759 → profileID=28
-- URL: https://en.wikipedia.org/wiki/Vulva_activism
INSERT IGNORE INTO EXPLICATION (argumentID, profileID, hyperlink, publisher, authorFName,  authorLName, title, metaPub, metaName, metaWildcard,  firstVisit, lastVisit, active)
  VALUES (1759, 28, 'https://en.wikipedia.org/wiki/Vulva_activism', '', '', '', 'Vulva activism', '', '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);
SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), (SELECT explicationID FROM EXPLICATION  WHERE argumentID = 1759 AND profileID = 28));
INSERT IGNORE INTO EXPLICATION_ENDORSE (explicationID, argumentID, profileID, weight, active) VALUES (@eid, 1759, 28, 50.0, 1);

-- Wikipedia done: 462 inserted, 55 skipped (total 517)
