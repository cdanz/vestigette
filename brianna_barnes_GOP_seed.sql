-- Brianna Barnes (profileID=2) — GOP cluster
-- 72 args: 49 accept / 23 reject
-- Note: 80, 88, 89, 90, 94, 96, 104, 120, 574, 1247 already in DB (all match intended stances)
-- Note: arg 1247 phrasing already written in IMMIG — no new phrasing here

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (80,   2, 0),
  (88,   2, 1),
  (89,   2, 1),
  (90,   2, 1),
  (91,   2, 1),
  (92,   2, 1),
  (93,   2, 1),
  (94,   2, 1),
  (95,   2, 1),
  (96,   2, 1),
  (97,   2, 1),
  (98,   2, 1),
  (99,   2, 1),
  (104,  2, 1),
  (120,  2, 0),
  (121,  2, 0),
  (122,  2, 1),
  (156,  2, 1),
  (157,  2, 1),
  (158,  2, 1),
  (159,  2, 1),
  (179,  2, 0),
  (229,  2, 0),
  (231,  2, 0),
  (232,  2, 0),
  (233,  2, 0),
  (346,  2, 1),
  (347,  2, 1),
  (348,  2, 1),
  (383,  2, 1),
  (384,  2, 1),
  (385,  2, 1),
  (386,  2, 1),
  (387,  2, 1),
  (388,  2, 0),
  (389,  2, 1),
  (574,  2, 0),
  (575,  2, 0),
  (576,  2, 0),
  (861,  2, 1),
  (864,  2, 1),
  (866,  2, 1),
  (985,  2, 0),
  (986,  2, 1),
  (987,  2, 1),
  (988,  2, 1),
  (989,  2, 1),
  (990,  2, 1),
  (991,  2, 1),
  (992,  2, 1),
  (994,  2, 1),
  (996,  2, 1),
  (1003, 2, 1),
  (1004, 2, 1),
  (1120, 2, 0),
  (1121, 2, 0),
  (1122, 2, 1),
  (1123, 2, 0),
  (1127, 2, 0),
  (1128, 2, 0),
  (1129, 2, 1),
  (1247, 2, 1),
  (1466, 2, 0),
  (1467, 2, 0),
  (1468, 2, 0),
  (1469, 2, 1),
  (1470, 2, 1),
  (1471, 2, 1),
  (1472, 2, 1),
  (1473, 2, 0),
  (1474, 2, 1),
  (1475, 2, 0);

-- PHRASINGS (48 new accepts; 1247 already phrased in IMMIG)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (88, 'Trump\'s total lack of intellectual curiosity isn\'t a personality quirk — it\'s a governing failure.', 2);
CALL updatePhrasingCache(88);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (89, 'Trump doesn\'t have to say it explicitly — the racism is in the wink, the retweet, and the deliberate slowness to condemn.', 2);
CALL updatePhrasingCache(89);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (90, 'The GOP agenda — for three decades — has been good for a shrinking few and bad for most Americans.', 2);
CALL updatePhrasingCache(90);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (91, 'Every major GOP policy priority leads to the same place: more wealth for people who already have it.', 2);
CALL updatePhrasingCache(91);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (92, 'The GOP\'s anti-government ideology is genuine — and it\'s why they can\'t govern when given the chance.', 2);
CALL updatePhrasingCache(92);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (93, 'The GOP\'s climate denial isn\'t honest skepticism — it\'s paid-for policy to protect fossil fuel profits.', 2);
CALL updatePhrasingCache(93);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (94, 'The GOP must change fundamentally before it earns your vote — not just new faces, a new agenda and new structure.', 2);
CALL updatePhrasingCache(94);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (95, 'Biden wasn\'t perfect, but the comparison to Trump made the choice obvious — not close.', 2);
CALL updatePhrasingCache(95);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (96, 'Every decision Trump makes runs through the same filter: is this good for Trump? That\'s it.', 2);
CALL updatePhrasingCache(96);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (97, 'Trump\'s ignorance is structural, not strategic — and that makes him genuinely dangerous in any position of authority.', 2);
CALL updatePhrasingCache(97);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (98, 'Biden got my vote in 2020 — not as enthusiasm, but as a clear-eyed assessment of what the alternative meant.', 2);
CALL updatePhrasingCache(98);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (99, 'Trump gold-plated everything he touched and called it class — he has no taste, in any sense of the word.', 2);
CALL updatePhrasingCache(99);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (104, 'If you care about voting rights, climate, healthcare, or racial justice — vote Democratic until that changes.', 2);
CALL updatePhrasingCache(104);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (122, 'Trump is not conservative — he\'s authoritarian populist, and the difference matters more than Republicans want to admit.', 2);
CALL updatePhrasingCache(122);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (156, 'Deliberately separating children from parents to traumatize families out of seeking asylum is a crime against humanity — the legal term fits.', 2);
CALL updatePhrasingCache(156);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (157, 'An administration that pressures election officials, pardons allies, and treats law as optional is not governing — it\'s dismantling.', 2);
CALL updatePhrasingCache(157);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (158, 'A woman VP wasn\'t a concession to identity politics — it was long overdue and plainly the right call.', 2);
CALL updatePhrasingCache(158);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (159, 'Biden promised a Black woman on the ticket and delivered — it mattered, and it was right.', 2);
CALL updatePhrasingCache(159);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (346, 'Trump incited a mob to overturn an election — impeachment and conviction was the minimum appropriate response.', 2);
CALL updatePhrasingCache(346);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (347, 'Inciting an insurrection against your own government is an automatic disqualifier from ever holding office again — full stop.', 2);
CALL updatePhrasingCache(347);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (348, 'Trump faced no real consequence for any of it, and the country is still paying the price of that lesson.', 2);
CALL updatePhrasingCache(348);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (383, 'The GOP\'s governing philosophy has one consistent through-line: accumulate power, then use it to accumulate more.', 2);
CALL updatePhrasingCache(383);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (384, 'The GOP is ruthless about power — and Democrats have repeatedly underestimated exactly how ruthless.', 2);
CALL updatePhrasingCache(384);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (385, 'Democrats keep bringing norms to a knife fight — being principled doesn\'t require being naive about what the other side will do.', 2);
CALL updatePhrasingCache(385);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (386, 'The GOP has given you no reason to trust it — the record speaks for itself.', 2);
CALL updatePhrasingCache(386);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (387, 'GOP governance consistently makes life harder for most Americans — that is not an accident, it is a priority.', 2);
CALL updatePhrasingCache(387);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (389, 'Democrats holding the line on democratic norms isn\'t weakness — it is the point.', 2);
CALL updatePhrasingCache(389);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (861, 'Left to their own devices, the GOP would drill everything, burn everything, and call it prosperity.', 2);
CALL updatePhrasingCache(861);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (864, 'The GOP\'s climate position is written by fossil fuel donors — and it shows in every vote.', 2);
CALL updatePhrasingCache(864);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (866, 'The GOP defends entrenched wealth first, last, and always — the rest is just rhetoric.', 2);
CALL updatePhrasingCache(866);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (986, 'The GOP didn\'t stumble into racism — it recruited it deliberately as an electoral strategy.', 2);
CALL updatePhrasingCache(986);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (987, 'Cultural chauvinists are reliably motivated voters — the GOP understood this and built its coalition accordingly.', 2);
CALL updatePhrasingCache(987);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (988, 'The Southern Strategy worked — that\'s what makes it so damning.', 2);
CALL updatePhrasingCache(988);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (989, 'The racists the GOP spent years appealing to without fully owning are now running it — that was always the risk of the deal.', 2);
CALL updatePhrasingCache(989);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (990, 'The parties switched on race — that\'s not a liberal talking point, it\'s documented in the voting record.', 2);
CALL updatePhrasingCache(990);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (991, 'LBJ knew the Civil Rights Act would cost Democrats the South — he signed it anyway, and the South went Republican exactly as he predicted.', 2);
CALL updatePhrasingCache(991);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (992, 'Medicare, Medicaid, food stamps, HUD — LBJ built the floor under American life that Democrats have been defending ever since.', 2);
CALL updatePhrasingCache(992);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (994, 'LBJ passed more transformative domestic legislation than anyone since FDR — Vietnam obscures that legacy more than it should.', 2);
CALL updatePhrasingCache(994);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (996, 'The New Deal coalition FDR built still defines what the Democratic Party is at its best: active government in the service of ordinary people.', 2);
CALL updatePhrasingCache(996);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1003, 'For cultural chauvinists, diversity isn\'t a policy disagreement — it\'s an existential threat to who they think America is.', 2);
CALL updatePhrasingCache(1003);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1004, 'The GOP\'s resistance to immigration isn\'t about policy management — it\'s about who counts as American.', 2);
CALL updatePhrasingCache(1004);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1122, 'Harris was a state AG, a US Senator, and a presidential candidate before any of this — her CV was not the question.', 2);
CALL updatePhrasingCache(1122);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1129, 'Harris won the 2003 DA race seven years later in a contested election — the suggestion that Willie Brown made her career doesn\'t survive the timeline.', 2);
CALL updatePhrasingCache(1129);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1469, 'Trump had no apparatus, no earned loyalty, no party office — and the entire GOP fell in line within three years. That should terrify you.', 2);
CALL updatePhrasingCache(1469);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1470, 'The GOP\'s racial playbook goes back to Nixon — fifty years of deliberate racial division for electoral gain.', 2);
CALL updatePhrasingCache(1470);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1471, 'Fuck Donald Trump — as a man, as a president, and as a precedent.', 2);
CALL updatePhrasingCache(1471);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1472, 'The GOP base wasn\'t born angry and conspiratorial — it was built that way through decades of deliberate media cultivation.', 2);
CALL updatePhrasingCache(1472);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1474, 'Republicans are disciplined soldiers; Democrats are herding cats — that asymmetry explains a lot of recent political history.', 2);
CALL updatePhrasingCache(1474);
