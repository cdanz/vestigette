-- alfred_anderson_GUN_seed.sql
-- Alfred Anderson (profileID=1) — GUN cluster
-- Generated in-session; follow seeding pattern from alfred_args_1_50_seed.sql

START TRANSACTION;

-- ─────────────────────────────────────────────────────────────────────
-- SECTION 1: Clear existing endorsements for cluster args
-- ─────────────────────────────────────────────────────────────────────
DELETE FROM ENDORSEMENT WHERE profileID=1 AND targArgID IN (140,141,326,327,328,329,330,331,332,333,459,460,461,462,729,738,743,745,746,747,1002,1027,1028,1172,1173,1174,1175,1176,1177,1178,1179,1180,1181,1182,1183,1184,1185,1189,1195,1707);

-- ─────────────────────────────────────────────────────────────────────
-- SECTION 2: Assert opinions (assertOpinion: 1=accept, -1=reject)
-- ─────────────────────────────────────────────────────────────────────
CALL assertOpinion(1, 140, 1);
CALL assertOpinion(-1, 141, 1);
CALL assertOpinion(1, 326, 1);
CALL assertOpinion(1, 327, 1);
CALL assertOpinion(1, 328, 1);
CALL assertOpinion(-1, 329, 1);
CALL assertOpinion(1, 330, 1);
CALL assertOpinion(-1, 331, 1);
CALL assertOpinion(1, 332, 1);
CALL assertOpinion(-1, 333, 1);
CALL assertOpinion(1, 459, 1);
CALL assertOpinion(1, 460, 1);
CALL assertOpinion(1, 461, 1);
CALL assertOpinion(-1, 462, 1);
CALL assertOpinion(1, 729, 1);
CALL assertOpinion(1, 738, 1);
CALL assertOpinion(-1, 743, 1);
CALL assertOpinion(-1, 745, 1);
CALL assertOpinion(-1, 746, 1);
CALL assertOpinion(-1, 747, 1);
CALL assertOpinion(1, 1002, 1);
CALL assertOpinion(1, 1027, 1);
CALL assertOpinion(-1, 1028, 1);
CALL assertOpinion(1, 1172, 1);
CALL assertOpinion(1, 1173, 1);
CALL assertOpinion(1, 1174, 1);
CALL assertOpinion(-1, 1175, 1);
CALL assertOpinion(1, 1176, 1);
CALL assertOpinion(1, 1177, 1);
CALL assertOpinion(1, 1178, 1);
CALL assertOpinion(-1, 1179, 1);
CALL assertOpinion(-1, 1180, 1);
CALL assertOpinion(-1, 1181, 1);
CALL assertOpinion(-1, 1182, 1);
CALL assertOpinion(1, 1183, 1);
CALL assertOpinion(-1, 1184, 1);
CALL assertOpinion(1, 1185, 1);
CALL assertOpinion(-1, 1189, 1);
CALL assertOpinion(-1, 1195, 1);
CALL assertOpinion(1, 1707, 1);

-- ─────────────────────────────────────────────────────────────────────
-- SECTION 3: Alfred's phrasings (newPutForth — accepted args only)
--   arg 140 already has Alfred's phrasing; skipped
-- ─────────────────────────────────────────────────────────────────────
CALL newPutForth(326, 1, 'Government doesn\'t get to tell me how I\'m allowed to defend my home. That\'s what the Second Amendment is about — protection, plain and simple.');
CALL newPutForth(327, 1, 'Second Amendment isn\'t just about hunting. It\'s about keeping government honest. An armed citizenry is the last check on tyranny — the Founders understood that.');
CALL newPutForth(328, 1, 'Second Amendment\'s been under attack for fifty years. Time to stop giving an inch. Every compromise just opens the door to the next one.');
CALL newPutForth(330, 1, 'Even I\'m not saying citizens need nukes. There\'s a clear line between personal defense and weapons of mass destruction — nobody serious is arguing for private atom bombs.');
CALL newPutForth(332, 1, 'Served in Vietnam so Americans could stay free. The day U.S. troops are turned against American citizens is the day this Republic dies. Can\'t allow that.');
CALL newPutForth(459, 1, 'Been around guns my whole life — never shot anybody. Nobody in Washington knows better than I do what\'s safe in my own hands. Stay out of it.');
CALL newPutForth(460, 1, 'Millions of law-abiding gun owners get punished every time some lunatic commits a crime. Blaming all of us for one guy\'s actions makes no sense whatsoever.');
CALL newPutForth(461, 1, 'Heller settled it — D.C. v. Heller, 2008. Supreme Court ruled handgun bans unconstitutional. That\'s the law of the land. Case closed.');
CALL newPutForth(729, 1, 'Can\'t ban \'assault weapons\' when nobody agrees what the term even means. Pistol grip? Adjustable stock? Detachable magazine? Politicians are banning a vibe, not a weapon.');
CALL newPutForth(738, 1, 'Look it up — \'assault weapon\' has no legal or technical definition. The term was invented by California Democrats in 1989. You can\'t legislate a made-up category.');
CALL newPutForth(1002, 1, 'Got three guns at home. They\'re tools. I\'m not at gun shows every weekend wearing camo. Own what you need, know how to use it, move on with your life.');
CALL newPutForth(1027, 1, 'Every mass shooting in history has one thing in common — the killer picked a gun-free zone. One armed citizen is a deterrent. FBI crime data backs this up.');
CALL newPutForth(1172, 1, 'Fine to have some regulations — background checks, no felons, whatever — but they have to pass constitutional muster. Second Amendment isn\'t optional or conditional.');
CALL newPutForth(1173, 1, 'If citizens can\'t own a weapon, police shouldn\'t carry it either. Equal protection cuts both ways. Militarized police departments are a warning sign of authoritarianism.');
CALL newPutForth(1174, 1, 'Same rules for everyone. If sheriff deputies in my county carry AR-15s, law-abiding citizens ought to be allowed the same. That\'s what equal protection actually means.');
CALL newPutForth(1176, 1, 'Thirty to fifty feral hogs can destroy crops, kill livestock, injure children in minutes. AR-15 with a 30-round mag isn\'t overkill — it\'s the right tool. City folks don\'t get it.');
CALL newPutForth(1177, 1, 'AR-15 is legal, reliable, and accurate. Used it for hog hunting, coyote control, home defense. Same as any other tool — the purpose determines whether it makes sense to own.');
CALL newPutForth(1178, 1, 'Don\'t own an AR-15? Fine. Then your opinion on whether I should own one is worth exactly nothing. My constitutional rights don\'t expire because they make you uncomfortable.');
CALL newPutForth(1183, 1, 'Look up the Black Codes — after the Civil War, freed slaves were disarmed first. Every major gun control push in U.S. history has targeted the people elites wanted disarmed.');
CALL newPutForth(1185, 1, 'Rich men have armed security details. Politicians have Capitol Police. But they want to take yours. Gun laws are always for the little people — elites exempt themselves.');
CALL newPutForth(1707, 1, 'Nobody serious is arguing for private nukes. \'Well-regulated militia\' always had limits. Second Amendment covers arms a person can bear for defense, not weapons of mass destruction.');

-- ─────────────────────────────────────────────────────────────────────
-- SECTION 4: Because endorsements (accepted args supporting accepted args)
-- Each (targArgID, profileID, 'Because') group sums to 100
-- ─────────────────────────────────────────────────────────────────────
-- arg 140 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Because', 326, 33.33, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Because', 327, 33.33, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Because', 1172, 33.34, 1);
-- arg 326 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (326, 1, 'Because', 140, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (326, 1, 'Because', 460, 40.0, 1);
-- arg 327 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (327, 1, 'Because', 140, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (327, 1, 'Because', 332, 40.0, 1);
-- arg 328 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (328, 1, 'Because', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (328, 1, 'Because', 1177, 30.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (328, 1, 'Because', 460, 30.0, 1);
-- arg 330 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (330, 1, 'Because', 1707, 100.0, 1);
-- arg 332 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (332, 1, 'Because', 327, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (332, 1, 'Because', 140, 40.0, 1);
-- arg 459 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (459, 1, 'Because', 140, 50.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (459, 1, 'Because', 1178, 50.0, 1);
-- arg 460 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Because', 140, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Because', 459, 40.0, 1);
-- arg 461 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (461, 1, 'Because', 140, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (461, 1, 'Because', 1172, 40.0, 1);
-- arg 729 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (729, 1, 'Because', 738, 100.0, 1);
-- arg 738 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (738, 1, 'Because', 729, 100.0, 1);
-- arg 1002 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1002, 1, 'Because', 459, 50.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1002, 1, 'Because', 460, 50.0, 1);
-- arg 1027 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1027, 1, 'Because', 460, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1027, 1, 'Because', 1177, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1027, 1, 'Because', 1176, 25.0, 1);
-- arg 1172 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1172, 1, 'Because', 140, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1172, 1, 'Because', 461, 40.0, 1);
-- arg 1173 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1173, 1, 'Because', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1173, 1, 'Because', 1174, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1173, 1, 'Because', 327, 25.0, 1);
-- arg 1174 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1174, 1, 'Because', 1173, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1174, 1, 'Because', 140, 40.0, 1);
-- arg 1176 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1176, 1, 'Because', 1177, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1176, 1, 'Because', 459, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1176, 1, 'Because', 460, 25.0, 1);
-- arg 1177 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1177, 1, 'Because', 1176, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1177, 1, 'Because', 459, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1177, 1, 'Because', 328, 25.0, 1);
-- arg 1178 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1178, 1, 'Because', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1178, 1, 'Because', 459, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1178, 1, 'Because', 460, 25.0, 1);
-- arg 1183 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1183, 1, 'Because', 1185, 100.0, 1);
-- arg 1185 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1185, 1, 'Because', 1183, 60.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1185, 1, 'Because', 140, 40.0, 1);
-- arg 1707 Because (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1707, 1, 'Because', 330, 100.0, 1);

-- ─────────────────────────────────────────────────────────────────────
-- SECTION 5: Therefore endorsements (reciprocals of Because)
-- Each (targArgID, profileID, 'Therefore') group sums to 100
-- ─────────────────────────────────────────────────────────────────────
-- arg 140 Therefore (n=12)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 326, 10.16949, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 327, 10.16949, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 328, 6.77966, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 332, 6.77966, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 459, 8.47458, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 460, 10.16949, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 461, 10.16949, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 1172, 10.16949, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 1173, 6.77966, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 1174, 6.77966, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 1178, 6.77966, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (140, 1, 'Therefore', 1185, 6.77967, 1);
-- arg 326 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (326, 1, 'Therefore', 140, 100.0, 1);
-- arg 327 Therefore (n=3)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (327, 1, 'Therefore', 140, 28.16699, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (327, 1, 'Therefore', 332, 50.70565, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (327, 1, 'Therefore', 1173, 21.12736, 1);
-- arg 328 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (328, 1, 'Therefore', 1177, 100.0, 1);
-- arg 330 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (330, 1, 'Therefore', 1707, 100.0, 1);
-- arg 332 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (332, 1, 'Therefore', 327, 100.0, 1);
-- arg 459 Therefore (n=5)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (459, 1, 'Therefore', 460, 20.51282, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (459, 1, 'Therefore', 1002, 25.64103, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (459, 1, 'Therefore', 1176, 17.94872, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (459, 1, 'Therefore', 1177, 17.94872, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (459, 1, 'Therefore', 1178, 17.94871, 1);
-- arg 460 Therefore (n=6)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Therefore', 326, 19.04762, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Therefore', 328, 14.28571, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Therefore', 1002, 23.80952, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Therefore', 1027, 19.04762, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Therefore', 1176, 11.90476, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (460, 1, 'Therefore', 1178, 11.90477, 1);
-- arg 461 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (461, 1, 'Therefore', 1172, 100.0, 1);
-- arg 729 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (729, 1, 'Therefore', 738, 100.0, 1);
-- arg 738 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (738, 1, 'Therefore', 729, 100.0, 1);
-- arg 1172 Therefore (n=2)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1172, 1, 'Therefore', 140, 45.4595, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1172, 1, 'Therefore', 461, 54.5405, 1);
-- arg 1173 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1173, 1, 'Therefore', 1174, 100.0, 1);
-- arg 1174 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1174, 1, 'Therefore', 1173, 100.0, 1);
-- arg 1176 Therefore (n=2)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1176, 1, 'Therefore', 1027, 38.46154, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1176, 1, 'Therefore', 1177, 61.53846, 1);
-- arg 1177 Therefore (n=3)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1177, 1, 'Therefore', 328, 28.57143, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1177, 1, 'Therefore', 1027, 33.33333, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1177, 1, 'Therefore', 1176, 38.09524, 1);
-- arg 1178 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1178, 1, 'Therefore', 459, 100.0, 1);
-- arg 1183 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1183, 1, 'Therefore', 1185, 100.0, 1);
-- arg 1185 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1185, 1, 'Therefore', 1183, 100.0, 1);
-- arg 1707 Therefore (n=1)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1707, 1, 'Therefore', 330, 100.0, 1);

-- ─────────────────────────────────────────────────────────────────────
-- SECTION 6: Rebuttal endorsements (rejected args → accepted counter-args)
-- Each (targArgID, profileID, 'Rebuttal') group sums to 100
-- ─────────────────────────────────────────────────────────────────────
-- arg 141 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (141, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (141, 1, 'Rebuttal', 1178, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (141, 1, 'Rebuttal', 460, 25.0, 1);
-- arg 329 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (329, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (329, 1, 'Rebuttal', 729, 20.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (329, 1, 'Rebuttal', 738, 20.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (329, 1, 'Rebuttal', 1178, 20.0, 1);
-- arg 331 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (331, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (331, 1, 'Rebuttal', 461, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (331, 1, 'Rebuttal', 1172, 25.0, 1);
-- arg 333 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (333, 1, 'Rebuttal', 729, 30.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (333, 1, 'Rebuttal', 738, 30.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (333, 1, 'Rebuttal', 1177, 25.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (333, 1, 'Rebuttal', 1176, 15.0, 1);
-- arg 462 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (462, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (462, 1, 'Rebuttal', 1027, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (462, 1, 'Rebuttal', 460, 25.0, 1);
-- arg 743 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (743, 1, 'Rebuttal', 140, 50.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (743, 1, 'Rebuttal', 1178, 30.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (743, 1, 'Rebuttal', 729, 20.0, 1);
-- arg 746 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (746, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (746, 1, 'Rebuttal', 1178, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (746, 1, 'Rebuttal', 459, 25.0, 1);
-- arg 747 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (747, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (747, 1, 'Rebuttal', 1178, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (747, 1, 'Rebuttal', 459, 25.0, 1);
-- arg 1028 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1028, 1, 'Rebuttal', 1027, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1028, 1, 'Rebuttal', 460, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1028, 1, 'Rebuttal', 1177, 25.0, 1);
-- arg 1175 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1175, 1, 'Rebuttal', 1176, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1175, 1, 'Rebuttal', 1177, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1175, 1, 'Rebuttal', 459, 25.0, 1);
-- arg 1179 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1179, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1179, 1, 'Rebuttal', 1172, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1179, 1, 'Rebuttal', 460, 25.0, 1);
-- arg 1180 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1180, 1, 'Rebuttal', 1027, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1180, 1, 'Rebuttal', 460, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1180, 1, 'Rebuttal', 1177, 25.0, 1);
-- arg 1181 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1181, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1181, 1, 'Rebuttal', 461, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1181, 1, 'Rebuttal', 1178, 25.0, 1);
-- arg 1182 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1182, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1182, 1, 'Rebuttal', 328, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1182, 1, 'Rebuttal', 327, 25.0, 1);
-- arg 1184 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1184, 1, 'Rebuttal', 140, 50.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1184, 1, 'Rebuttal', 332, 30.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1184, 1, 'Rebuttal', 1173, 20.0, 1);
-- arg 1189 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1189, 1, 'Rebuttal', 140, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1189, 1, 'Rebuttal', 1177, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1189, 1, 'Rebuttal', 1176, 25.0, 1);
-- arg 1195 Rebuttal (group sum=100.0)
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1195, 1, 'Rebuttal', 1177, 40.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1195, 1, 'Rebuttal', 1176, 35.0, 1);
INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES (1195, 1, 'Rebuttal', 729, 25.0, 1);

-- ─────────────────────────────────────────────────────────────────────
-- SECTION 7: Sync PHRASE_ENDORSE active flags with acceptance
-- ─────────────────────────────────────────────────────────────────────
UPDATE PHRASE_ENDORSE SET active=1 WHERE profileID=1 AND argumentID IN (140,326,327,328,330,332,459,460,461,729,738,1002,1027,1172,1173,1174,1176,1177,1178,1183,1185,1707);
UPDATE PHRASE_ENDORSE SET active=0 WHERE profileID=1 AND argumentID IN (141,329,331,333,462,743,745,746,747,1028,1175,1179,1180,1181,1182,1184,1189,1195);

COMMIT;

-- ─────────────────────────────────────────────────────────────────────
-- VERIFICATION QUERY
-- ─────────────────────────────────────────────────────────────────────
-- Run after applying to check all endorsement weight groups sum to 100:
-- SELECT targArgID, endorseType, SUM(weight), COUNT(*)
-- FROM ENDORSEMENT WHERE profileID=1 AND targArgID IN (140,141,326,327,328,329,330,331,332,333,459,460,461,462,729,738,743,745,746,747,1002,1027,1028,1172,1173,1174,1175,1176,1177,1178,1179,1180,1181,1182,1183,1184,1185,1189,1195,1707)
-- GROUP BY targArgID, endorseType
-- HAVING ABS(SUM(weight)-100) > 0.001;