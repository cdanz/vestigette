-- Brianna Barnes (profileID=2) — IMMIG cluster
-- 43 args: 31 accept / 12 reject

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (611,  2, 1),
  (612,  2, 0),
  (613,  2, 1),
  (614,  2, 0),
  (615,  2, 1),
  (616,  2, 1),
  (617,  2, 1),
  (618,  2, 0),
  (619,  2, 0),
  (620,  2, 1),
  (621,  2, 1),
  (954,  2, 1),
  (955,  2, 1),
  (956,  2, 1),
  (957,  2, 1),
  (962,  2, 1),
  (968,  2, 0),
  (969,  2, 1),
  (970,  2, 0),
  (971,  2, 0),
  (972,  2, 1),
  (1006, 2, 1),
  (1159, 2, 1),
  (1160, 2, 1),
  (1161, 2, 1),
  (1162, 2, 1),
  (1163, 2, 1),
  (1164, 2, 1),
  (1237, 2, 0),
  (1238, 2, 0),
  (1239, 2, 1),
  (1240, 2, 0),
  (1241, 2, 1),
  (1242, 2, 0),
  (1243, 2, 1),
  (1244, 2, 1),
  (1245, 2, 1),
  (1246, 2, 1),
  (1247, 2, 1),
  (1248, 2, 0),
  (1308, 2, 1),
  (1309, 2, 1),
  (1310, 2, 1);

-- PHRASINGS (31 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (611, 'Open borders might not be achievable tomorrow, but it\'s the right direction — borders exist to control people, not to honor them.', 2);
CALL updatePhrasingCache(611);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (613, 'Naming where you want to go matters even if you can\'t get there immediately — utopia as a compass, not a destination.', 2);
CALL updatePhrasingCache(613);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (615, 'If someone comes here, works, pays taxes, and follows the law, they have earned the right to call this home.', 2);
CALL updatePhrasingCache(615);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (616, 'People fleeing violence and persecution have a legal and moral right to seek asylum — denying it doesn\'t make us safer, it makes us crueler.', 2);
CALL updatePhrasingCache(616);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (617, 'Taking children from their parents at the border to deter migration is torture used as policy — and that is exactly what it was.', 2);
CALL updatePhrasingCache(617);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (620, 'The family separation policy was designed to be cruel — deterrence through deliberate infliction of trauma on children.', 2);
CALL updatePhrasingCache(620);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (621, 'An administration that dehumanizes migrants in its language and brutalizes them in its policy is showing you who it is — believe it.', 2);
CALL updatePhrasingCache(621);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (954, 'America was built by people who came from somewhere else — the case for welcoming immigrants is the case for the country itself.', 2);
CALL updatePhrasingCache(954);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (955, 'If you\'re proud of what this country built, you can\'t also slam the door on everyone else who wants to be part of it.', 2);
CALL updatePhrasingCache(955);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (956, 'Welcoming immigrants and having a sensible immigration system aren\'t contradictions — responsible policy can do both.', 2);
CALL updatePhrasingCache(956);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (957, 'The entire world\'s population could fit in Texas at New York City density — the case for immigration being unmanageable is not a physical one.', 2);
CALL updatePhrasingCache(957);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (962, 'Denser cities could absorb a significantly larger population — capacity isn\'t the real argument against immigration, politics is.', 2);
CALL updatePhrasingCache(962);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (969, 'Every major faith tradition with any claim to moral seriousness calls for welcoming the stranger — that obligation doesn\'t stop at the border.', 2);
CALL updatePhrasingCache(969);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (972, 'The Republican Party\'s record on immigration is a record of restriction, fear, and dehumanization — calling that anti-immigrant is accurate.', 2);
CALL updatePhrasingCache(972);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1006, 'A larger population means more workers, more innovation, and more economic growth — population growth through immigration is a national asset.', 2);
CALL updatePhrasingCache(1006);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1159, 'The data is clear: immigrants commit crimes at lower rates than native-born citizens — the dangerous-immigrant narrative is not evidence-based.', 2);
CALL updatePhrasingCache(1159);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1160, 'Immigrants start businesses, fill labor shortages, and pay taxes — the economic case for immigration is one of the most documented in economics.', 2);
CALL updatePhrasingCache(1160);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1161, 'Refugees pay more in taxes over their lifetime than they receive in benefits — the fiscal case against refugee resettlement fails the data test.', 2);
CALL updatePhrasingCache(1161);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1162, 'Processing capacity at the border needs to scale with demand — surging numbers need more resources, not harsher deterrence.', 2);
CALL updatePhrasingCache(1162);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1163, 'The vast majority of immigrants show up for their court hearings — the \'they disappear\' narrative is a myth designed to justify cruelty.', 2);
CALL updatePhrasingCache(1163);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1164, 'Competing for the world\'s best engineers, doctors, and researchers is plainly in the national interest — that\'s not even controversial.', 2);
CALL updatePhrasingCache(1164);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1239, 'Migrants are not combatants — military force against people seeking safety has no legal or moral justification.', 2);
CALL updatePhrasingCache(1239);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1241, 'People who cross the border have due process rights — you can support enforcement and still respect the law that governs how enforcement works.', 2);
CALL updatePhrasingCache(1241);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1243, 'Human life has value — which is why an orderly system that protects migrants from cartels and coyotes matters as much as the welcome itself.', 2);
CALL updatePhrasingCache(1243);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1244, 'The 2021 border numbers were lower than 2019 under Trump — the \'Biden border crisis\' was a political frame, not a statistical one.', 2);
CALL updatePhrasingCache(1244);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1245, 'Dignity is owed to everyone in this — American workers, migrants, and border communities — and serious policy has to start from that.', 2);
CALL updatePhrasingCache(1245);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1246, 'Family separation, Muslim bans, and mass deportations didn\'t produce a safer, more humane system — they produced cruelty and chaos.', 2);
CALL updatePhrasingCache(1246);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1247, 'Four years produced a tax cut for the wealthy and a renamed trade deal — that\'s the legislative ledger of the Trump administration.', 2);
CALL updatePhrasingCache(1247);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1308, 'Unaccompanied children at the border are a humanitarian emergency — the only serious response is massive resources to process and protect them.', 2);
CALL updatePhrasingCache(1308);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1309, 'Working people undercut by underpaid undocumented labor deserve protection too — real compassion accounts for everyone who\'s being exploited.', 2);
CALL updatePhrasingCache(1309);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1310, 'Separate is not equal — that principle doesn\'t expire, and it applies as much to how we treat migrant children as to anything else.', 2);
CALL updatePhrasingCache(1310);
