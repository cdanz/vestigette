-- Brianna Barnes (profileID=2) — WEALTH cluster
-- 70 args: 56 accept / 14 reject
-- Existing DB: 110(1✓), 185(1✓), 192(1✓), 193(0✓), 203(1✓), 745(1✓)

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (52,   2, 0),
  (54,   2, 1),
  (110,  2, 1),
  (134,  2, 0),
  (135,  2, 0),
  (136,  2, 1),
  (137,  2, 1),
  (138,  2, 1),
  (139,  2, 1),
  (185,  2, 1),
  (186,  2, 1),
  (187,  2, 1),
  (188,  2, 1),
  (189,  2, 1),
  (190,  2, 1),
  (191,  2, 1),
  (192,  2, 1),
  (193,  2, 0),
  (194,  2, 1),
  (195,  2, 1),
  (196,  2, 1),
  (197,  2, 1),
  (198,  2, 0),
  (199,  2, 1),
  (200,  2, 1),
  (201,  2, 1),
  (202,  2, 1),
  (203,  2, 1),
  (204,  2, 1),
  (205,  2, 1),
  (264,  2, 0),
  (265,  2, 0),
  (266,  2, 0),
  (267,  2, 0),
  (268,  2, 1),
  (269,  2, 1),
  (270,  2, 1),
  (271,  2, 1),
  (272,  2, 1),
  (273,  2, 1),
  (429,  2, 1),
  (449,  2, 0),
  (452,  2, 1),
  (454,  2, 1),
  (455,  2, 1),
  (481,  2, 1),
  (482,  2, 1),
  (483,  2, 1),
  (500,  2, 1),
  (501,  2, 1),
  (502,  2, 1),
  (598,  2, 1),
  (601,  2, 0),
  (604,  2, 1),
  (605,  2, 1),
  (606,  2, 1),
  (607,  2, 0),
  (608,  2, 1),
  (609,  2, 1),
  (610,  2, 1),
  (745,  2, 1),
  (1270, 2, 1),
  (1271, 2, 1),
  (1272, 2, 1),
  (1279, 2, 1),
  (1280, 2, 0),
  (1281, 2, 1),
  (1301, 2, 1),
  (1302, 2, 1),
  (1672, 2, 0);

-- PHRASINGS (56 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (54, 'A wealth tax on extreme concentrations is not punishment — it\'s the price of a society stable enough to generate that wealth.', 2);
CALL updatePhrasingCache(54);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (110, 'When the top 1% owns more than the bottom 90% combined, you don\'t have a market — you have a plutocracy.', 2);
CALL updatePhrasingCache(110);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (136, 'Capitalism, heavily regulated and democratically accountable, is where we are — the task is making it work for everyone, not replacing it.', 2);
CALL updatePhrasingCache(136);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (137, 'No one surveys Americans and finds they prefer billionaires holding all the cards — the distribution people want is far more equal than what we have.', 2);
CALL updatePhrasingCache(137);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (138, 'We can articulate what a fair distribution looks like — and it looks nothing like what we actually have.', 2);
CALL updatePhrasingCache(138);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (139, 'Inherited wealth and network effects are not merit — the fortunes at the top of the American wealth distribution were not earned in any classical sense.', 2);
CALL updatePhrasingCache(139);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (185, 'A wealth tax is not envy — it\'s recognition that extreme concentration destabilizes the society that made the wealth possible.', 2);
CALL updatePhrasingCache(185);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (186, 'Cynicism is usually resentment dressed up as sophistication.', 2);
CALL updatePhrasingCache(186);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (187, 'When productivity gains go entirely to the top, resentment of elites is not irrational — it\'s an accurate read of the situation.', 2);
CALL updatePhrasingCache(187);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (188, 'Unaddressed economic resentment curdles into cynicism about institutions — that\'s the political consequence of inequality we keep ignoring.', 2);
CALL updatePhrasingCache(188);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (189, 'Nobody actually believes unlimited wealth concentration is fine — the debate is only about where on the spectrum it becomes unacceptable.', 2);
CALL updatePhrasingCache(189);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (190, 'Being worth a million times more than your neighbor is the threshold beyond which no rational justification survives.', 2);
CALL updatePhrasingCache(190);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (191, 'No honest person can look at a million ordinary people and say their single accumulated fortune is worth more than all of them together.', 2);
CALL updatePhrasingCache(191);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (192, 'A progressive wealth tax on fortunes beyond any conceivable need is not confiscation — it\'s a correction.', 2);
CALL updatePhrasingCache(192);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (194, 'A healthy distribution has a big middle, not a sky-scraping right tail — the current wealth distribution is a system malfunction.', 2);
CALL updatePhrasingCache(194);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (195, 'If the average person can\'t grasp how wealth is distributed in their own society, something about that distribution is deeply wrong.', 2);
CALL updatePhrasingCache(195);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (196, 'The gap between what people are paid and what they contribute should at least be legible — opacity in compensation serves those at the top.', 2);
CALL updatePhrasingCache(196);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (197, 'Rewarding success is reasonable — the question is whether a reward ratio of a hundred million to one is justified by any difference in contribution.', 2);
CALL updatePhrasingCache(197);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (199, 'Incentives matter — the goal is a system where the rewards for success don\'t break democracy in the process.', 2);
CALL updatePhrasingCache(199);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (200, 'Extreme inequality doesn\'t just hurt the poor — it corrodes the social trust that makes democracy and markets function.', 2);
CALL updatePhrasingCache(200);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (201, 'The case for economic freedom is that it unleashes human creativity — the case for redistribution is that deprivation forecloses it.', 2);
CALL updatePhrasingCache(201);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (202, 'Imagine how much talent is wasted in poverty — universal access to capital and education is not charity, it\'s unlocking human potential.', 2);
CALL updatePhrasingCache(202);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (203, 'The research is consistent: more equal societies report higher wellbeing, lower crime, better health outcomes. Equity isn\'t just moral — it works.', 2);
CALL updatePhrasingCache(203);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (204, 'Taxing inherited fortunes is not punishing the dead — it\'s preventing dynastic wealth from calcifying into permanent aristocracy.', 2);
CALL updatePhrasingCache(204);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (205, 'Extreme wealth concentration is political power — the right to control others without their consent, dressed in dollar signs.', 2);
CALL updatePhrasingCache(205);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (268, 'Every means test creates a line — and everyone near that line spends energy gaming it instead of building their life.', 2);
CALL updatePhrasingCache(268);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (269, 'No means test produces a morally clean dividing line — the thresholds are always arbitrary, and always punish people who fall just over them.', 2);
CALL updatePhrasingCache(269);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (270, 'Means testing doesn\'t produce fairness — it produces false precision. The people you\'re excluding always include people who needed help.', 2);
CALL updatePhrasingCache(270);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (271, 'The whole point of a public good is universality — means testing it turns it into a targeted program with a stigma attached.', 2);
CALL updatePhrasingCache(271);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (272, 'Means-tested programs lose political support as soon as the middle class is excluded — that\'s how you kill programs that people need.', 2);
CALL updatePhrasingCache(272);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (273, 'Means tests are political cover — they deflect criticism while adding administrative costs that could have funded the program itself.', 2);
CALL updatePhrasingCache(273);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (429, 'Tax design is a moral question — who bears the burden should reflect who benefits from and can afford to fund a functioning society.', 2);
CALL updatePhrasingCache(429);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (452, 'Targeted government spending on healthcare, education, housing, and childcare redistributes wealth through access — the most durable form.', 2);
CALL updatePhrasingCache(452);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (454, 'The tax code is a policy tool — using it to reward investment, penalize carbon, and tax unproductive wealth is design, not ideology.', 2);
CALL updatePhrasingCache(454);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (455, 'Taxing things that impose costs on others — cigarettes, alcohol, carbon — is simple economics: make the price reflect the actual social cost.', 2);
CALL updatePhrasingCache(455);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (481, 'The problem isn\'t bad players — it\'s bad rules. Changing who\'s rich doesn\'t help if the rules that made them obscenely rich stay the same.', 2);
CALL updatePhrasingCache(481);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (482, 'A fair economic system lowers the floor so everyone can start and raises the stakes as you accumulate — the current system does the opposite.', 2);
CALL updatePhrasingCache(482);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (483, 'Capital compounds and poverty traps — the myth of meritocracy breaks down the moment you look at where most wealthy people started.', 2);
CALL updatePhrasingCache(483);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (500, 'The same economy that can\'t house the poor produces 700-foot yachts — that\'s a distribution problem, not a scarcity problem.', 2);
CALL updatePhrasingCache(500);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (501, 'Financial precarity is not a character flaw — it\'s a chronic condition that the system produces and then blames its victims for.', 2);
CALL updatePhrasingCache(501);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (502, 'Calling economic despair a "mental health crisis" without addressing its economic causes is a very convenient misdirection.', 2);
CALL updatePhrasingCache(502);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (598, 'Nobody in the richest country in human history should go without food, shelter, or healthcare — that\'s the floor, and it\'s not negotiable.', 2);
CALL updatePhrasingCache(598);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (604, 'Eliminating poverty is a policy choice, not an impossible dream — the countries that have reduced it dramatically made different choices.', 2);
CALL updatePhrasingCache(604);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (605, 'Poverty is not inevitable — it\'s the predictable result of specific policy choices, and different choices produce different results.', 2);
CALL updatePhrasingCache(605);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (606, 'Direct cash transfers are the most efficient and dignified form of poverty relief — they trust people to know what they need.', 2);
CALL updatePhrasingCache(606);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (608, 'Charity comes with implied gratitude and conditions — a rights-based government program preserves dignity in a way charity structurally cannot.', 2);
CALL updatePhrasingCache(608);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (609, 'A universal basic income would eliminate poverty, reduce bureaucracy, and give people the freedom to take risks — it\'s an idea whose time has come.', 2);
CALL updatePhrasingCache(609);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (610, 'Restricting how poor people spend their benefits treats them as children who can\'t be trusted — give them the money and trust them to know their lives.', 2);
CALL updatePhrasingCache(610);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (745, 'The wealthy benefit most from the stable society that government maintains — paying a proportionally greater share of the taxes to maintain it is not punishment.', 2);
CALL updatePhrasingCache(745);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1270, 'The federal government creates currency and can fund social priorities without household-style balancing — the constraint is inflation, not budget arithmetic.', 2);
CALL updatePhrasingCache(1270);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1271, 'Healthcare, education, housing, and infrastructure are investments with real returns — the question is not whether to spend, but on what.', 2);
CALL updatePhrasingCache(1271);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1272, 'Public spending on poverty is not charity — it\'s investment in human capital with documented economic returns.', 2);
CALL updatePhrasingCache(1272);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1279, 'An economic system that produces Jeff Bezos and homeless encampments simultaneously has not achieved its purpose.', 2);
CALL updatePhrasingCache(1279);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1281, 'Economic power is political power — a democracy can\'t survive an economy that concentrates both in the same few hands.', 2);
CALL updatePhrasingCache(1281);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1301, 'Capitalism, for all its failures, has genuinely raised living standards at scale — that record deserves honesty alongside the critique.', 2);
CALL updatePhrasingCache(1301);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1302, 'Adam Smith — capitalism\'s founding philosopher — said a society whose majority is poor and miserable cannot be flourishing. We should take that seriously.', 2);
CALL updatePhrasingCache(1302);
