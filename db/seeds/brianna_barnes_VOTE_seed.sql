-- Brianna Barnes (profileID=2) — VOTE cluster
-- 69 args: 57 accept / 12 reject
-- Note: arg 444 overlaps HOUSING (phrasing already exists, INSERT IGNORE skips opinion)
-- Fix: arg 1366 placeholder was 0; Brianna accepts factual content → UPDATE to 1

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (180,  2, 0),
  (181,  2, 0),
  (182,  2, 1),
  (183,  2, 0),
  (184,  2, 1),
  (354,  2, 1),
  (355,  2, 1),
  (356,  2, 1),
  (357,  2, 1),
  (433,  2, 1),
  (434,  2, 1),
  (435,  2, 1),
  (439,  2, 0),
  (440,  2, 0),
  (441,  2, 1),
  (442,  2, 1),
  (443,  2, 1),
  (444,  2, 1),
  (445,  2, 1),
  (446,  2, 1),
  (456,  2, 1),
  (469,  2, 1),
  (470,  2, 1),
  (640,  2, 1),
  (696,  2, 1),
  (697,  2, 1),
  (698,  2, 1),
  (699,  2, 1),
  (700,  2, 0),
  (701,  2, 1),
  (702,  2, 1),
  (770,  2, 1),
  (775,  2, 1),
  (777,  2, 1),
  (1357, 2, 1),
  (1358, 2, 1),
  (1359, 2, 1),
  (1360, 2, 1),
  (1361, 2, 1),
  (1362, 2, 1),
  (1363, 2, 1),
  (1364, 2, 1),
  (1365, 2, 0),
  (1366, 2, 1),
  (1367, 2, 1),
  (1368, 2, 1),
  (1369, 2, 0),
  (1370, 2, 1),
  (1371, 2, 1),
  (1372, 2, 0),
  (1373, 2, 0),
  (1374, 2, 1),
  (1375, 2, 1),
  (1376, 2, 1),
  (1377, 2, 1),
  (1378, 2, 0),
  (1379, 2, 1),
  (1380, 2, 1),
  (1381, 2, 1),
  (1382, 2, 1),
  (1456, 2, 1),
  (1457, 2, 1),
  (1458, 2, 1),
  (1459, 2, 1),
  (1460, 2, 1),
  (1461, 2, 1),
  (1462, 2, 1),
  (1463, 2, 0),
  (1464, 2, 1);

-- Fix placeholder conflict
UPDATE OPINION SET acceptance = 1 WHERE profileID = 2 AND argumentID = 1366;

-- PHRASINGS (56 new accepts; 444 already phrased in HOUSING)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (182, 'The right of every citizen to vote and have a voice in their government is non-negotiable — there is no principled basis for restricting it.', 2);
CALL updatePhrasingCache(182);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (184, 'The same systemic forces that exploit marginalized communities also work to keep them from the ballot box — the connection is not accidental.', 2);
CALL updatePhrasingCache(184);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (354, 'Government that consistently serves one party\'s interests over the public\'s is not representative democracy — it\'s patronage in the shell of a republic.', 2);
CALL updatePhrasingCache(354);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (355, 'Voting rights should be expanded, protected, and treated with the urgency of something people have died for — because they have.', 2);
CALL updatePhrasingCache(355);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (356, 'Every eligible citizen should be automatically registered to vote — making people opt in to their own democratic rights is backwards.', 2);
CALL updatePhrasingCache(356);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (357, 'Universal vote-by-mail removes barriers of time and transportation that fall hardest on working people and people of color.', 2);
CALL updatePhrasingCache(357);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (433, 'A government with too many veto points cannot respond to the people it governs — that gridlock serves those who benefit from the status quo.', 2);
CALL updatePhrasingCache(433);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (434, 'The 60-vote threshold for the Senate is not in the Constitution — it was invented to block legislation, and it works exactly as designed.', 2);
CALL updatePhrasingCache(434);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (435, 'Wyoming gets two Senate seats and so does California — that structural imbalance means small-state voters have dramatically outsized Senate power.', 2);
CALL updatePhrasingCache(435);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (441, 'Every veto point added to governance is another place where those who benefit from inaction can block everyone else — fewer is better.', 2);
CALL updatePhrasingCache(441);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (442, 'Democrats had to use budget reconciliation for COVID relief because the Senate was broken — that\'s not how urgent legislation should have to work.', 2);
CALL updatePhrasingCache(442);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (443, 'Loading reconciliation happened because the normal legislative process had been weaponized into permanent obstruction.', 2);
CALL updatePhrasingCache(443);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (445, 'Small-population states have a structural Senate advantage that was baked in at the founding and grows more distorted every decade.', 2);
CALL updatePhrasingCache(445);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (446, 'Wyoming gets two Senate seats and so does California — that structural imbalance means small-state voters have dramatically outsized Senate power.', 2);
CALL updatePhrasingCache(446);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (456, 'The filibuster was used for decades primarily to block civil rights legislation — calling it racist isn\'t overreach, it\'s history.', 2);
CALL updatePhrasingCache(456);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (469, 'DC has more people than two states, pays federal taxes, and fights in American wars — denying it statehood is about keeping its Black Democratic majority out of the Senate.', 2);
CALL updatePhrasingCache(469);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (470, 'DC statehood is overdue — the people of DC deserve the same representation as every other American city of their size.', 2);
CALL updatePhrasingCache(470);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (640, 'The For The People Act would make it easier for every eligible American to vote — opposing it means you don\'t think everyone should vote.', 2);
CALL updatePhrasingCache(640);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (696, 'Ranked-choice voting lets you vote for who you actually want without throwing away your vote — it\'s a better system than what we have.', 2);
CALL updatePhrasingCache(696);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (697, 'Local jurisdictions having the option to use ranked-choice voting should be a no-brainer — let communities choose better electoral systems.', 2);
CALL updatePhrasingCache(697);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (698, 'Ranked-choice voting ends the spoiler problem — your second choice kicks in if your first is out, and your vote is never wasted.', 2);
CALL updatePhrasingCache(698);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (699, 'Ranked-choice voting increases diversity of candidates and creates more equitable representation — that\'s a feature, not a side effect.', 2);
CALL updatePhrasingCache(699);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (701, 'When candidates need to be someone\'s second choice to win, they campaign less negatively — ranked-choice changes the incentive structure.', 2);
CALL updatePhrasingCache(701);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (702, 'Ranked-choice voting can eliminate primaries entirely — less money spent, higher participation, one cleaner process.', 2);
CALL updatePhrasingCache(702);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (770, 'One person, one vote is the irreducible principle of democratic legitimacy — everything else in electoral design has to answer to it.', 2);
CALL updatePhrasingCache(770);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (775, 'Disenfranchising people for past convictions extends the punishment beyond its stated purpose and falls hardest on communities the system already targeted.', 2);
CALL updatePhrasingCache(775);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (777, 'Permanent disenfranchisement for most offenses is indefensible — losing the vote temporarily while incarcerated is at least proportional.', 2);
CALL updatePhrasingCache(777);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1357, 'Georgia\'s SB 202 should be condemned — it was designed to make voting harder in communities that were inconveniently effective at organizing.', 2);
CALL updatePhrasingCache(1357);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1358, 'When Coca-Cola spoke out against Georgia\'s voter suppression law, that was pressure applied correctly — praise the behavior you want to see more of.', 2);
CALL updatePhrasingCache(1358);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1359, 'Delta speaking out against SB 202 was the right thing — when corporations have that kind of platform in Georgia, using it matters.', 2);
CALL updatePhrasingCache(1359);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1360, 'The MLB moving the All-Star Game out of Georgia was the right call — money talks in Atlanta, and using that leverage was exactly what the moment called for.', 2);
CALL updatePhrasingCache(1360);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1361, 'Corporate statements in favor of social justice that don\'t cost anything are PR, not principle — praise the ones that actually put something on the line.', 2);
CALL updatePhrasingCache(1361);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1362, 'Delta contributed heavily to the sponsors of SB 202 — the praise for speaking out has to be weighed against that.', 2);
CALL updatePhrasingCache(1362);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1363, 'Delta bankrolls politicians who oppose voting rights and then issues statements defending those rights — that\'s not a stand, that\'s brand management.', 2);
CALL updatePhrasingCache(1363);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1364, 'At the end of the day, corporations serve shareholders — any social justice alignment that costs them money will eventually disappear.', 2);
CALL updatePhrasingCache(1364);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1366, 'SB 202 did expand some early voting — but acknowledging that doesn\'t excuse the parts that let the legislature override local election officials.', 2);
CALL updatePhrasingCache(1366);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1367, 'SB 202 requires ID for absentee ballots — a requirement that falls hardest on the elderly, the poor, and communities of color.', 2);
CALL updatePhrasingCache(1367);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1368, 'SB 202 lets the state legislature override local election officials — that\'s not election integrity, that\'s a mechanism for stealing elections.', 2);
CALL updatePhrasingCache(1368);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1370, 'Corporations withholding business from states with regressive laws is one of the most effective forms of leverage available — use it.', 2);
CALL updatePhrasingCache(1370);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1371, 'The MLB has a complicated history with Black players and has real amends to make — acknowledging that history and acting on it now matters.', 2);
CALL updatePhrasingCache(1371);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1374, 'Corporate virtue signaling on voting rights is cheap when you\'re still writing checks to the politicians who suppress them.', 2);
CALL updatePhrasingCache(1374);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1375, 'Colorado\'s mail-in voting system is exactly the model Georgia should be moving toward, not away from.', 2);
CALL updatePhrasingCache(1375);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1376, 'Automatic voter registration means the government handles the process — that\'s how a serious democracy treats its citizens.', 2);
CALL updatePhrasingCache(1376);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1377, 'Colorado doesn\'t have voting lines because it does voting right — that\'s the standard, not the exception.', 2);
CALL updatePhrasingCache(1377);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1379, 'Georgia Republicans enacted no-excuse absentee voting in 2005 — the 2021 reversal tells you the concern was never about election security.', 2);
CALL updatePhrasingCache(1379);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1380, 'SB 202 was predicated on a lie — courts and election officials confirmed there was no 2020 fraud, and the law was passed anyway.', 2);
CALL updatePhrasingCache(1380);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1381, 'Moving the All-Star Game cost Atlanta businesses in a majority-Black city — that\'s a real cost worth naming even for people who supported the boycott.', 2);
CALL updatePhrasingCache(1381);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1382, 'Colorado leads in voter turnout because it makes voting easy — that\'s not a coincidence, it\'s a policy outcome.', 2);
CALL updatePhrasingCache(1382);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1456, 'When every eligible vote counts equally, Democrats win the Senate — voter suppression exists because Republican politics requires it.', 2);
CALL updatePhrasingCache(1456);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1457, 'A Supreme Court that reflected where the country\'s votes have gone over the last 30 years would lean liberal — the current one doesn\'t.', 2);
CALL updatePhrasingCache(1457);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1458, 'Supreme Court compositions reflect accumulated presidential power over decades — the current tilt is the result of eight presidential terms of appointments.', 2);
CALL updatePhrasingCache(1458);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1459, 'Democrats winning 6 of 8 popular votes shows where the country is — the electoral system\'s failure to reflect that is a structural problem.', 2);
CALL updatePhrasingCache(1459);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1460, 'Trump lost the 2016 popular vote by nearly 3 million — he entered office without the support of the majority of American voters.', 2);
CALL updatePhrasingCache(1460);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1461, 'Democrats have won 7 of the last 9 popular presidential votes — this country leans left, and the electoral system obscures that.', 2);
CALL updatePhrasingCache(1461);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1462, 'Trump lost the 2020 popular vote by 7 million votes — there was no stolen election, just a result that didn\'t favor him.', 2);
CALL updatePhrasingCache(1462);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1464, 'A proportionally representative Senate would reliably be Democratic — the current structure gives a geographic minority effective veto over the majority.', 2);
CALL updatePhrasingCache(1464);
