-- Brianna Barnes (profileID=2) — POLICE cluster
-- 72 args: 59 accept / 13 reject
-- Note: 17 args (112, 207-223) overlap RACE cluster — INSERT IGNORE skips them; phrasings already exist
-- Fix: arg 165 placeholder was 1 but Brianna rejects it (conflicts with accepted arg 151)

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (105,  2, 1),
  (106,  2, 0),
  (107,  2, 0),
  (108,  2, 0),
  (111,  2, 1),
  (112,  2, 1),
  (115,  2, 1),
  (116,  2, 1),
  (118,  2, 0),
  (119,  2, 1),
  (145,  2, 1),
  (146,  2, 1),
  (147,  2, 1),
  (148,  2, 1),
  (149,  2, 1),
  (151,  2, 1),
  (152,  2, 1),
  (153,  2, 1),
  (154,  2, 1),
  (155,  2, 1),
  (162,  2, 1),
  (163,  2, 1),
  (165,  2, 0),
  (166,  2, 0),
  (167,  2, 1),
  (168,  2, 1),
  (178,  2, 1),
  (207,  2, 1),
  (208,  2, 1),
  (209,  2, 1),
  (210,  2, 1),
  (211,  2, 1),
  (212,  2, 1),
  (213,  2, 1),
  (214,  2, 1),
  (215,  2, 1),
  (217,  2, 1),
  (218,  2, 1),
  (219,  2, 1),
  (220,  2, 1),
  (221,  2, 1),
  (222,  2, 1),
  (223,  2, 1),
  (539,  2, 1),
  (545,  2, 1),
  (550,  2, 1),
  (559,  2, 1),
  (560,  2, 0),
  (561,  2, 0),
  (562,  2, 1),
  (563,  2, 1),
  (594,  2, 1),
  (602,  2, 0),
  (603,  2, 1),
  (778,  2, 0),
  (779,  2, 1),
  (1169, 2, 1),
  (1170, 2, 1),
  (1171, 2, 1),
  (1173, 2, 0),
  (1187, 2, 1),
  (1188, 2, 1),
  (1408, 2, 1),
  (1409, 2, 1),
  (1410, 2, 0),
  (1411, 2, 1),
  (1497, 2, 1),
  (1498, 2, 1),
  (1537, 2, 1),
  (1598, 2, 1),
  (1599, 2, 1),
  (1600, 2, 1);

-- Fix placeholder conflict
UPDATE OPINION SET acceptance = 0 WHERE profileID = 2 AND argumentID = 165;

-- PHRASINGS for new accepts only (112, 207-223 already phrased in RACE cluster)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (105, 'Police kill Black people with impunity — and the rarity of prosecution is proof the system accepts it.', 2);
CALL updatePhrasingCache(105);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (111, 'Cash bail means wealthy people go home and poor people stay locked up — end it.', 2);
CALL updatePhrasingCache(111);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (115, 'If you can\'t afford to buy your freedom, you sit in a cage before trial — that\'s not justice, it\'s a poverty tax.', 2);
CALL updatePhrasingCache(115);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (116, 'Cash bail doesn\'t just punish poverty — it concentrates that punishment in Black and brown communities.', 2);
CALL updatePhrasingCache(116);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (119, 'Black defendants are offered worse plea deals for the same crimes — that disparity is documented and compounds at every step.', 2);
CALL updatePhrasingCache(119);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (145, 'American policing was not designed to protect Black communities — reform isn\'t optional, it\'s overdue.', 2);
CALL updatePhrasingCache(145);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (146, 'The case for police reform doesn\'t require hating the police — it requires an honest look at what the current system is doing.', 2);
CALL updatePhrasingCache(146);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (147, 'Choke holds and strangleholds kill people — there is no police situation that requires them, and they should be banned.', 2);
CALL updatePhrasingCache(147);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (148, 'De-escalation should be the default, not the exception — people\'s lives depend on whether officers are trained to choose it first.', 2);
CALL updatePhrasingCache(148);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (149, 'De-escalation isn\'t soft policing — it\'s the difference between a situation that ends safely and one that doesn\'t.', 2);
CALL updatePhrasingCache(149);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (151, 'Police unions have used their power to block accountability and protect officers who should have been fired — that\'s obstruction, not worker protection.', 2);
CALL updatePhrasingCache(151);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (152, 'Mental health responders, housing services, social workers — some of the calls police get now shouldn\'t be police calls at all.', 2);
CALL updatePhrasingCache(152);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (153, 'Lethal force should be the last resort, not the first response — that principle should be written into every use-of-force policy.', 2);
CALL updatePhrasingCache(153);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (154, 'Officers have a duty to step in when a colleague is going too far — the blue wall of silence is not a professional obligation.', 2);
CALL updatePhrasingCache(154);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (155, 'When the procedures themselves produce racially disparate outcomes, the procedure is the problem — not just the individual officer.', 2);
CALL updatePhrasingCache(155);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (162, 'Tear-gassing people exercising their constitutional right to protest is an abuse of force, not crowd control.', 2);
CALL updatePhrasingCache(162);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (163, 'You can\'t police your way out of poverty, disinvestment, and despair — that\'s not what policing is for.', 2);
CALL updatePhrasingCache(163);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (167, 'Tearing down the prison system overnight without a replacement creates chaos — reform has to be real and sequenced.', 2);
CALL updatePhrasingCache(167);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (168, 'We need a system that moves people from arrest to trial faster and doesn\'t punish them with abuse while they wait.', 2);
CALL updatePhrasingCache(168);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (178, 'Releasing people without support — housing, employment, mental health services — sets them up to fail and everyone else up for risk.', 2);
CALL updatePhrasingCache(178);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (539, 'Qualified immunity shields officers from accountability for misconduct — it was invented by courts, not Congress, and it has to go.', 2);
CALL updatePhrasingCache(539);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (545, 'A six-figure bail for a minor offense isn\'t justice — it\'s a wealth ransom, and poor defendants pay it with their jobs and their families.', 2);
CALL updatePhrasingCache(545);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (550, 'The violence that police routinely use against Black people isn\'t a series of bad apples — the pattern is the policy.', 2);
CALL updatePhrasingCache(550);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (559, 'Tear gas is banned in international warfare — its use on American streets against protesters is indefensible.', 2);
CALL updatePhrasingCache(559);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (562, 'Departments that have tanks and military rifles on standby for low-level calls have more resources than the mission requires.', 2);
CALL updatePhrasingCache(562);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (563, 'Military equipment in civilian policing changes the culture — officers start treating the community like enemy combatants.', 2);
CALL updatePhrasingCache(563);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (594, 'No-knock raids on drug warrants and seizing property before conviction are abuses — calling them out isn\'t anti-police, it\'s anti-abuse.', 2);
CALL updatePhrasingCache(594);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (603, 'The data shows cities with significant BLM protests saw reductions in police homicides — accountability works.', 2);
CALL updatePhrasingCache(603);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (779, 'The death penalty doesn\'t deter crime and costs more than life imprisonment — if it worked, that would at least be an argument.', 2);
CALL updatePhrasingCache(779);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1169, 'Some officers do abuse their power — that\'s a training and culture problem, and the good officers are the first to know it.', 2);
CALL updatePhrasingCache(1169);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1170, 'There\'s a difference between authority the community grants you and power a badge gives you — most academies don\'t teach that distinction.', 2);
CALL updatePhrasingCache(1170);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1171, 'When every situation becomes a tactical threat, routine stops become lethal ones — warrior culture in policing costs lives.', 2);
CALL updatePhrasingCache(1171);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1187, 'Pulling someone over for a cracked taillight you were never going to ticket isn\'t traffic enforcement — it\'s racial profiling with paperwork.', 2);
CALL updatePhrasingCache(1187);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1188, 'Every time my husband or my son gets in the car, I think about traffic stops — that fear is not irrational, it\'s data.', 2);
CALL updatePhrasingCache(1188);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1408, 'De-escalation as the mandatory first resort isn\'t a limit on officer effectiveness — it\'s the standard a civilized society should require.', 2);
CALL updatePhrasingCache(1408);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1409, 'Mandating de-escalation by law is how you change a culture that won\'t change itself.', 2);
CALL updatePhrasingCache(1409);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1411, 'Officers deserve proper equipment, fair pay, and community respect — and they also deserve to work in a department that holds misconduct accountable.', 2);
CALL updatePhrasingCache(1411);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1497, 'Police homicide rates don\'t track with crime rates — which means the killing isn\'t about public safety, it\'s about something else.', 2);
CALL updatePhrasingCache(1497);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1498, 'Qualified immunity has to end — no other profession is this shielded from the consequences of misconduct.', 2);
CALL updatePhrasingCache(1498);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1537, 'More police funding doesn\'t reduce crime — investing in education, mental health, and housing does.', 2);
CALL updatePhrasingCache(1537);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1598, 'Abolish the death penalty — not because some crimes don\'t deserve it, but because the system that delivers it is too broken to trust with that power.', 2);
CALL updatePhrasingCache(1598);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1599, 'State-sanctioned killing is cruel and unusual punishment — full stop, regardless of the crime.', 2);
CALL updatePhrasingCache(1599);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1600, 'Over 185 death row exonerations — meaning we\'ve nearly executed that many innocent people — should end this debate.', 2);
CALL updatePhrasingCache(1600);
