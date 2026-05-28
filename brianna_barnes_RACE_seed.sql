-- Brianna Barnes (profileID=2) — RACE cluster
-- 114 args: 98 accept / 16 reject

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (100,  2, 1),
  (101,  2, 0),
  (102,  2, 0),
  (103,  2, 1),
  (109,  2, 1),
  (112,  2, 1),
  (113,  2, 1),
  (114,  2, 1),
  (164,  2, 1),
  (169,  2, 1),
  (170,  2, 0),
  (171,  2, 1),
  (172,  2, 0),
  (173,  2, 0),
  (174,  2, 1),
  (175,  2, 1),
  (176,  2, 1),
  (177,  2, 1),
  (206,  2, 1),
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
  (234,  2, 1),
  (235,  2, 1),
  (236,  2, 1),
  (237,  2, 1),
  (238,  2, 1),
  (239,  2, 1),
  (240,  2, 1),
  (241,  2, 1),
  (242,  2, 1),
  (243,  2, 1),
  (244,  2, 1),
  (245,  2, 1),
  (246,  2, 1),
  (317,  2, 1),
  (318,  2, 1),
  (319,  2, 1),
  (320,  2, 1),
  (349,  2, 0),
  (350,  2, 0),
  (351,  2, 1),
  (352,  2, 1),
  (353,  2, 1),
  (457,  2, 1),
  (458,  2, 0),
  (484,  2, 1),
  (485,  2, 1),
  (486,  2, 1),
  (487,  2, 0),
  (1005, 2, 1),
  (1192, 2, 1),
  (1193, 2, 1),
  (1194, 2, 0),
  (1196, 2, 1),
  (1197, 2, 0),
  (1198, 2, 1),
  (1199, 2, 1),
  (1203, 2, 1),
  (1204, 2, 1),
  (1205, 2, 1),
  (1206, 2, 1),
  (1207, 2, 1),
  (1208, 2, 1),
  (1209, 2, 1),
  (1210, 2, 1),
  (1211, 2, 1),
  (1212, 2, 0),
  (1213, 2, 1),
  (1214, 2, 1),
  (1225, 2, 1),
  (1229, 2, 0),
  (1231, 2, 1),
  (1233, 2, 1),
  (1234, 2, 1),
  (1345, 2, 1),
  (1346, 2, 0),
  (1347, 2, 1),
  (1348, 2, 1),
  (1349, 2, 1),
  (1350, 2, 1),
  (1351, 2, 1),
  (1499, 2, 0),
  (1500, 2, 1),
  (1501, 2, 1),
  (1502, 2, 1),
  (1503, 2, 1),
  (1504, 2, 1),
  (1646, 2, 1),
  (1659, 2, 1),
  (1660, 2, 1),
  (1661, 2, 1),
  (1662, 2, 1),
  (1663, 2, 1),
  (1664, 2, 1),
  (1665, 2, 1),
  (1666, 2, 0),
  (1667, 2, 1),
  (1668, 2, 1),
  (1669, 2, 1),
  (1670, 2, 1);

-- PHRASINGS (accepted args only, coinedBy=2)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (100, 'No system is perfectly fair — that\'s the argument for constant reform, not a reason to quit.', 2);
CALL updatePhrasingCache(100);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (103, 'Black conviction rates are grotesquely disproportionate to crime rates — that\'s the system doing what it was built to do.', 2);
CALL updatePhrasingCache(103);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (109, 'Black empowerment isn\'t charity — it\'s what overdue justice looks like.', 2);
CALL updatePhrasingCache(109);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (112, 'Implicit bias shows up in who gets prison and who gets probation — judges aren\'t immune.', 2);
CALL updatePhrasingCache(112);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (113, 'Poverty, disinvestment, and underfunded schools predict crime rates — skin color doesn\'t.', 2);
CALL updatePhrasingCache(113);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (114, 'Put anyone under the same conditions and you get the same outcomes — the variables are structural, not racial.', 2);
CALL updatePhrasingCache(114);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (164, 'Teaching the roots of racism requires real curriculum funding — you can\'t cut that and claim to care about equity.', 2);
CALL updatePhrasingCache(164);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (169, 'Non-white workers earn less to the dollar, and it compounds over a lifetime — the wage gap is documented, not imagined.', 2);
CALL updatePhrasingCache(169);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (171, 'The criminal justice system doesn\'t just reflect racial inequality — it produces it.', 2);
CALL updatePhrasingCache(171);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (174, 'You can\'t design race-neutral reform for a system that\'s already racially biased — that\'s not neutrality, that\'s avoidance.', 2);
CALL updatePhrasingCache(174);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (175, 'Racial bias doesn\'t stay in one room — it ripples through housing, employment, healthcare, and education.', 2);
CALL updatePhrasingCache(175);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (176, 'The education gap is documented, and you can trace it directly to which schools get funded.', 2);
CALL updatePhrasingCache(176);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (177, 'The education gap between white and non-white students follows the funding gap, not the children.', 2);
CALL updatePhrasingCache(177);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (206, 'When the harm is real and systemic, resentment is a reasonable response — not a character flaw.', 2);
CALL updatePhrasingCache(206);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (207, 'Black people are stopped for \'looking suspicious\' at rates that have nothing to do with actual crime.', 2);
CALL updatePhrasingCache(207);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (208, 'Black people are stopped for \'looking suspicious\' at rates that have nothing to do with actual crime.', 2);
CALL updatePhrasingCache(208);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (209, 'Black people are stopped for \'looking suspicious\' at rates that have nothing to do with actual crime.', 2);
CALL updatePhrasingCache(209);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (210, 'Black people are stopped for \'looking suspicious\' at rates that have nothing to do with actual crime.', 2);
CALL updatePhrasingCache(210);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (211, 'Black people are stopped for \'looking suspicious\' at rates that have nothing to do with actual crime.', 2);
CALL updatePhrasingCache(211);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (212, 'Black people are stopped for \'looking suspicious\' at rates that have nothing to do with actual crime.', 2);
CALL updatePhrasingCache(212);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (213, 'Black people are stopped for \'looking suspicious\' at rates that have nothing to do with actual crime.', 2);
CALL updatePhrasingCache(213);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (214, 'Cross-racial misidentification is documented — and when you\'re Black, a false ID can cost you years of your life.', 2);
CALL updatePhrasingCache(214);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (215, 'The same behavior gets a warning for one person and handcuffs for another — race predicts which.', 2);
CALL updatePhrasingCache(215);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (217, 'Without real accountability, misconduct doesn\'t stop — it becomes policy.', 2);
CALL updatePhrasingCache(217);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (218, 'My son is 9 years old and already seen as a threat — that\'s not paranoia, that\'s what the data confirms.', 2);
CALL updatePhrasingCache(218);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (219, 'Qualified immunity is a legal shield for misconduct — as long as it stands, accountability is mostly just a word.', 2);
CALL updatePhrasingCache(219);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (220, 'The coverage, the outrage, and the cameras tell you whose life counts as more valuable.', 2);
CALL updatePhrasingCache(220);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (221, 'White supremacy\'s structures are most hostile to those they were built to exclude.', 2);
CALL updatePhrasingCache(221);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (222, 'You can\'t fix the justice system in isolation when it reflects a society that\'s unequal everywhere.', 2);
CALL updatePhrasingCache(222);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (223, 'A just society starts with a just justice system — you can\'t build equity on a rigged foundation.', 2);
CALL updatePhrasingCache(223);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (234, 'Hyper-policing Black neighborhoods isn\'t a coincidence — it\'s a policy choice with documented racial disparities.', 2);
CALL updatePhrasingCache(234);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (235, 'Not all anger is equal — some of it comes from real harm, and you don\'t have to apologize for that.', 2);
CALL updatePhrasingCache(235);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (236, 'Four hundred years of documented harm earns you the right to name it.', 2);
CALL updatePhrasingCache(236);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (237, 'Forced relocations, broken treaties, stolen land — Native Americans have every reason to hold this government accountable.', 2);
CALL updatePhrasingCache(237);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (238, 'Calling American society white supremacist isn\'t hyperbole — the institutions were built to concentrate power among white people.', 2);
CALL updatePhrasingCache(238);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (239, 'Whiteness was invented as a category to decide who gets to hold power.', 2);
CALL updatePhrasingCache(239);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (240, 'The second any group is treated as less than fully human, their equality becomes everyone\'s responsibility.', 2);
CALL updatePhrasingCache(240);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (241, 'Black Americans aren\'t asking for charity — they\'re asking for what was withheld for four hundred years.', 2);
CALL updatePhrasingCache(241);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (242, 'My faith and my politics meet right here: we are one body, and you cannot cut part of it off and call yourself whole.', 2);
CALL updatePhrasingCache(242);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (243, 'A country that treats parts of itself as disposable will eventually tear itself apart.', 2);
CALL updatePhrasingCache(243);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (244, 'You can\'t move forward as a nation by deciding some people don\'t count — that debt always comes due.', 2);
CALL updatePhrasingCache(244);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (245, 'The Trail of Tears, the Dawes Act, the boarding schools — the government didn\'t just take land, it tried to erase peoples.', 2);
CALL updatePhrasingCache(245);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (246, 'White supremacy needs division to survive — it can\'t coexist with a society that recognizes everyone\'s humanity.', 2);
CALL updatePhrasingCache(246);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (317, 'Race was constructed as a category to organize power — it\'s a social fact, not a biological one.', 2);
CALL updatePhrasingCache(317);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (318, 'Human beings are genetically nearly identical across so-called racial lines — race lives in society, not DNA.', 2);
CALL updatePhrasingCache(318);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (319, 'If you\'re using race to make genetic claims, you\'re not doing science — the categories don\'t map to the biology.', 2);
CALL updatePhrasingCache(319);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (320, 'Equal treatment under the law is the floor, not the ceiling — and for Black people in this country, we\'re still fighting for the floor.', 2);
CALL updatePhrasingCache(320);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (351, 'Prejudice anyone can have — racism is that prejudice backed by systems and centuries of concentrated power.', 2);
CALL updatePhrasingCache(351);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (352, 'Racism without the institutional power to enforce it is bigotry — the word means something specific, and that specificity matters.', 2);
CALL updatePhrasingCache(352);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (353, '\'Reverse racism\' is a term designed to avoid talking about actual racism — prejudice isn\'t the same as a system built to keep you down.', 2);
CALL updatePhrasingCache(353);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (457, 'Voter suppression, school defunding, weakened civil rights enforcement — you don\'t need a hood to uphold white supremacy; policy does it just as well.', 2);
CALL updatePhrasingCache(457);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (484, 'We all carry biases we didn\'t choose — the question is whether you\'re willing to do anything about yours.', 2);
CALL updatePhrasingCache(484);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (485, 'If your decisions affect other people\'s lives, you owe it to them to examine your own blind spots.', 2);
CALL updatePhrasingCache(485);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (486, 'Knowing why something happens and knowing how to fix it are two different problems — we need both.', 2);
CALL updatePhrasingCache(486);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1005, 'Every time we actually measure it — in lending, in hiring, in healthcare, in sentencing — we find more racism than anyone admitted.', 2);
CALL updatePhrasingCache(1005);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1192, 'Racial assumptions are racial assumptions — your politics don\'t determine whether they count as racism.', 2);
CALL updatePhrasingCache(1192);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1193, 'White people can be targets of prejudice — they can\'t be victims of racism as a system, because that system was built to serve them.', 2);
CALL updatePhrasingCache(1193);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1196, 'Racism, sexism, classism — they\'re all doing the same work: keeping power where it already is.', 2);
CALL updatePhrasingCache(1196);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1198, 'The C-suites, the Senate, the federal bench, the boardrooms — the representation data is not subtle.', 2);
CALL updatePhrasingCache(1198);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1199, 'Hollywood spent decades erasing us from the screen — representation still hasn\'t caught up.', 2);
CALL updatePhrasingCache(1199);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1203, 'Look at who runs this country — it didn\'t happen by accident, and it hasn\'t changed as fast as people claim.', 2);
CALL updatePhrasingCache(1203);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1204, 'The Fortune 500 boards are still predominantly white men — the pipeline isn\'t broken, the gate is.', 2);
CALL updatePhrasingCache(1204);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1205, 'A culture that runs the global economy and dominates its institutions is not under siege.', 2);
CALL updatePhrasingCache(1205);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1206, 'When you\'ve never had to share the table, being asked to make room feels like a threat.', 2);
CALL updatePhrasingCache(1206);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1207, 'CRT doesn\'t change what racism means — it explains the structures that let racism persist long after any individual bigot is gone.', 2);
CALL updatePhrasingCache(1207);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1208, 'The CRT panic is manufactured — it\'s an analysis of how legal structures maintain racial inequality, and that makes certain people very uncomfortable.', 2);
CALL updatePhrasingCache(1208);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1209, 'Targeting someone because of their race is always wrong — that applies to everyone, no exceptions.', 2);
CALL updatePhrasingCache(1209);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1210, 'Bigotry is personal prejudice — racism is that prejudice plus the power to enforce it.', 2);
CALL updatePhrasingCache(1210);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1211, 'A bigot is intolerant of anyone unlike them — every group can produce that, but it doesn\'t carry the same weight without institutional power.', 2);
CALL updatePhrasingCache(1211);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1213, 'Casting bigotry against white people as \'racism\' muddies the distinction between prejudice and systemic power.', 2);
CALL updatePhrasingCache(1213);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1214, 'When \'racism\' means everything, it explains nothing — and that confusion is exactly what some people are counting on.', 2);
CALL updatePhrasingCache(1214);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1225, 'Oppression requires systematic disadvantage at scale — that\'s not white people\'s experience in this country.', 2);
CALL updatePhrasingCache(1225);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1231, 'Individual exceptions don\'t measure systemic outcomes — you look at the aggregate, not the anecdote.', 2);
CALL updatePhrasingCache(1231);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1233, 'Nobody is asking you to apologize for being white — they\'re asking you to understand what it has meant in this country.', 2);
CALL updatePhrasingCache(1233);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1234, 'You can be proud of who you are and still reckon with what that identity has meant for others — those aren\'t mutually exclusive.', 2);
CALL updatePhrasingCache(1234);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1345, 'What we teach children about American history shapes what they believe is normal — and the current version leaves out too much.', 2);
CALL updatePhrasingCache(1345);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1347, 'My kids need to understand the headwinds they\'re facing — not to be defeated by them, but to know what they\'re dealing with.', 2);
CALL updatePhrasingCache(1347);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1348, 'Benefiting from an unjust system and perpetuating it yourself are not the same thing.', 2);
CALL updatePhrasingCache(1348);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1349, 'Every BIPOC person working twice as hard for half the recognition isn\'t imagining it — those headwinds are structural.', 2);
CALL updatePhrasingCache(1349);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1350, 'Racism isn\'t solved by a change of heart — it\'s solved by changing the laws and policies that produce unequal outcomes.', 2);
CALL updatePhrasingCache(1350);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1351, 'You can\'t prepare children for the real world by teaching them a version of history with the hard parts removed.', 2);
CALL updatePhrasingCache(1351);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1500, 'America says it celebrates diversity — what it actually practices and what it claims are still two very different things.', 2);
CALL updatePhrasingCache(1500);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1501, 'Communities told to disappear are finally being encouraged to preserve their culture — that\'s not a trend, that\'s justice.', 2);
CALL updatePhrasingCache(1501);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1502, 'A culture that dominates every major global institution does not face a meaningful threat.', 2);
CALL updatePhrasingCache(1502);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1503, 'Whiteness was never a culture — it was a boundary drawn to decide who belongs.', 2);
CALL updatePhrasingCache(1503);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1504, 'Anglo-Saxon culture has left its mark everywhere, but as a living, distinct tradition it dissolved long ago.', 2);
CALL updatePhrasingCache(1504);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1646, 'Any belief that one racial group is inherently superior or inferior is a moral failure — full stop, no exceptions.', 2);
CALL updatePhrasingCache(1646);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1659, 'CRT doesn\'t redefine racism — it examines the legal architecture that racism built and left standing.', 2);
CALL updatePhrasingCache(1659);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1660, 'CRT starts from an observable fact: American racism isn\'t just about bad individuals, it\'s woven into how the systems operate.', 2);
CALL updatePhrasingCache(1660);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1661, 'Redlining was federal policy — racial inequality isn\'t an accident in American law, it was a design choice.', 2);
CALL updatePhrasingCache(1661);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1662, 'Underfunded schools in Black neighborhoods aren\'t accidental — they\'re the direct result of policies that tied school funding to property wealth.', 2);
CALL updatePhrasingCache(1662);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1663, 'Black patients get fewer referrals, shorter appointments, and more denials — the mortality data reflects exactly what you\'d expect.', 2);
CALL updatePhrasingCache(1663);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1664, 'From the three-fifths clause to Jim Crow to redlining — this isn\'t ancient history, it\'s the foundation the current legal system was built on.', 2);
CALL updatePhrasingCache(1664);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1665, 'Understanding how law and policy shaped racial outcomes belongs in every serious civics curriculum.', 2);
CALL updatePhrasingCache(1665);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1667, 'The three-fifths clause is in the original text — that\'s not revisionism, that\'s the document.', 2);
CALL updatePhrasingCache(1667);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1668, 'The original Constitution protected a racial hierarchy — amendments improved it, but you can\'t separate the document from what it was built to do.', 2);
CALL updatePhrasingCache(1668);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1669, 'The forced erasure of Indigenous language, ceremony, and culture is genocide — and mainstream America has never truly reckoned with it.', 2);
CALL updatePhrasingCache(1669);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1670, 'The Homestead Act gave stolen Indigenous land to white settlers while explicitly excluding Black Americans — that wealth transfer echoes to this day.', 2);
CALL updatePhrasingCache(1670);
