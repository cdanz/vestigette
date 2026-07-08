-- Brianna Barnes (profileID=2) — COVID cluster
-- 57 args: 46 accept / 11 reject
-- Existing DB opinions: 51(1✓), 66(1✓), 67(1✗), 68(1✓) — arg 67 needs UPDATE
-- Fix: arg 67 placeholder was 1; Brianna trusts FDA → UPDATE to 0

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (51,   2, 1),
  (61,   2, 1),
  (66,   2, 1),
  (67,   2, 0),
  (68,   2, 1),
  (263,  2, 0),
  (341,  2, 1),
  (358,  2, 1),
  (359,  2, 1),
  (360,  2, 1),
  (361,  2, 0),
  (362,  2, 1),
  (363,  2, 1),
  (364,  2, 1),
  (365,  2, 1),
  (578,  2, 1),
  (579,  2, 1),
  (580,  2, 1),
  (581,  2, 1),
  (582,  2, 1),
  (644,  2, 0),
  (666,  2, 1),
  (667,  2, 1),
  (748,  2, 1),
  (881,  2, 1),
  (1327, 2, 1),
  (1328, 2, 1),
  (1329, 2, 1),
  (1330, 2, 1),
  (1331, 2, 1),
  (1332, 2, 1),
  (1333, 2, 1),
  (1343, 2, 1),
  (1344, 2, 0),
  (1356, 2, 1),
  (1388, 2, 1),
  (1389, 2, 1),
  (1390, 2, 0),
  (1391, 2, 1),
  (1392, 2, 1),
  (1393, 2, 0),
  (1394, 2, 1),
  (1395, 2, 1),
  (1396, 2, 0),
  (1397, 2, 0),
  (1398, 2, 1),
  (1399, 2, 1),
  (1400, 2, 0),
  (1401, 2, 1),
  (1402, 2, 1),
  (1403, 2, 1),
  (1404, 2, 1),
  (1405, 2, 1),
  (1406, 2, 1),
  (1407, 2, 1),
  (1412, 2, 1),
  (1418, 2, 0);

-- Fix placeholder conflict
UPDATE OPINION SET acceptance = 0 WHERE profileID = 2 AND argumentID = 67;

-- PHRASINGS (46 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (51, 'Getting the vaccine into arms as fast as possible meant removing every unnecessary barrier — that was the only acceptable approach.', 2);
CALL updatePhrasingCache(51);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (61, 'If the bottleneck is hours of operation, run 24-hour vaccine sites — a pandemic does not keep business hours.', 2);
CALL updatePhrasingCache(61);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (66, 'I would have taken a 3am appointment — getting vaccinated mattered more than sleep.', 2);
CALL updatePhrasingCache(66);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (68, 'The COVID vaccines were rushed in time, not in process — no stages were skipped, and a billion-dose safety record confirms that.', 2);
CALL updatePhrasingCache(68);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (341, 'The economic hole COVID dug was enormous — the relief package should have been bigger, not smaller.', 2);
CALL updatePhrasingCache(341);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (358, 'Vaccinating healthcare workers and the vulnerable first is how you save the most lives fastest — prioritization was essential.', 2);
CALL updatePhrasingCache(358);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (359, 'Vaccinating teachers first was the path to getting kids back in school — it should have been a national priority.', 2);
CALL updatePhrasingCache(359);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (360, 'Prolonged school closures did real harm to children — academic, social, and developmental. That cost had to be weighed.', 2);
CALL updatePhrasingCache(360);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (362, 'Reopening schools before it\'s safe trades children\'s health for economic convenience — safety conditions are a floor, not a luxury.', 2);
CALL updatePhrasingCache(362);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (363, 'When the conditions for safety are met, keeping schools closed any longer is its own harm — reopen.', 2);
CALL updatePhrasingCache(363);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (364, 'No one should have to choose between their health and their education or their livelihood — safety conditions for reopening are the non-negotiable.', 2);
CALL updatePhrasingCache(364);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (365, 'We had the science on school reopening — the CDC guidelines existed. The problem was political will, not information.', 2);
CALL updatePhrasingCache(365);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (578, 'COVID killed over a million Americans — the people who minimized it while it was happening have a lot to answer for.', 2);
CALL updatePhrasingCache(578);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (579, 'Reasonable precautions during a lethal pandemic aren\'t an imposition — they\'re what you do when you live around other people.', 2);
CALL updatePhrasingCache(579);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (580, 'Masks were an inconvenience. COVID killed over a million Americans. Put on the mask.', 2);
CALL updatePhrasingCache(580);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (581, 'Six feet of distance was a simple, low-cost way to protect people — the resistance to it was never about freedom, it was about politics.', 2);
CALL updatePhrasingCache(581);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (582, 'COVID spreads through the air in close contact — masks and distance directly address the mechanism of transmission.', 2);
CALL updatePhrasingCache(582);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (666, 'The American Rescue Plan got money to families, extended unemployment, and funded vaccine distribution — that\'s what good policy looks like.', 2);
CALL updatePhrasingCache(666);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (667, 'The American Rescue Plan cut child poverty nearly in half — it is the most effective anti-poverty legislation in decades.', 2);
CALL updatePhrasingCache(667);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (748, 'Better ventilation in schools protects students from COVID and every airborne illness that follows — it is infrastructure worth the investment.', 2);
CALL updatePhrasingCache(748);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (881, 'Canceling large gatherings during a deadly pandemic was not an overreaction — it was public health doing its job.', 2);
CALL updatePhrasingCache(881);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1327, 'The COVID vaccines are safe and effective — the people who got flu shots but balked at mRNA were following politics, not science.', 2);
CALL updatePhrasingCache(1327);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1328, 'Vaccinated adults are dramatically less likely to carry and spread COVID — that is the whole point of vaccination.', 2);
CALL updatePhrasingCache(1328);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1329, 'Full vaccination substantially reduces transmission — that\'s what the science said, and it\'s why the push to vaccinate mattered.', 2);
CALL updatePhrasingCache(1329);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1330, 'Vaccinated adults gathering unmasked indoors don\'t significantly endanger the unvaccinated children around them — the vaccines were that good.', 2);
CALL updatePhrasingCache(1330);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1331, 'The CDC data was reassuring — 0.04 breakthrough infections per 1,000 person-days among the fully vaccinated is extremely low.', 2);
CALL updatePhrasingCache(1331);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1332, 'Vaccines work — time to live like it.', 2);
CALL updatePhrasingCache(1332);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1333, 'Kids weren\'t vaccinated in early 2021 — the appropriate adult response was continued caution on their behalf.', 2);
CALL updatePhrasingCache(1333);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1343, 'The honest answer about COVID variants was "we don\'t know yet" — treating that uncertainty as a reason to drop all precautions was reckless.', 2);
CALL updatePhrasingCache(1343);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1356, 'Protecting unvaccinated children from a novel virus with incomplete transmission data required continued caution — that was the right call in early 2021.', 2);
CALL updatePhrasingCache(1356);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1388, 'Biden\'s administration supported private-sector vaccine verification — treating that as a conspiracy is a misreading of what was actually proposed.', 2);
CALL updatePhrasingCache(1388);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1389, 'A vaccine passport is just proof of vaccination — we have required vaccination records for school and travel for decades.', 2);
CALL updatePhrasingCache(1389);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1391, 'Biden explicitly declined to mandate vaccine passports nationally — the federal government stayed out of it.', 2);
CALL updatePhrasingCache(1391);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1392, 'There was no federal vaccine tracking database — the surveillance conspiracy theories weren\'t grounded in anything real.', 2);
CALL updatePhrasingCache(1392);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1394, 'Coordinating private-sector vaccine verification standards is basic public health infrastructure — the hysteria over it was manufactured.', 2);
CALL updatePhrasingCache(1394);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1395, 'Texas banned vaccine passports while posting some of the country\'s highest COVID death rates — the politics there did not match the public health priorities.', 2);
CALL updatePhrasingCache(1395);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1398, 'Yes, credentials constrain some freedom — the question is always whether the constraint is justified, and in a pandemic it often was.', 2);
CALL updatePhrasingCache(1398);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1399, 'Freedom has never been absolute — every society balances it against collective safety, and a pandemic is exactly when that balance shifts.', 2);
CALL updatePhrasingCache(1399);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1401, 'Requiring vaccination proof for mass transit during an active pandemic is a reasonable limit — you don\'t have a right to expose strangers to a lethal virus.', 2);
CALL updatePhrasingCache(1401);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1402, 'COVID killed millions worldwide — the "plandemic" people who disputed the classification were disputing settled reality.', 2);
CALL updatePhrasingCache(1402);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1403, 'COVID met every clinical and epidemiological definition of a pandemic — the people who denied the classification were playing semantic games with mass death.', 2);
CALL updatePhrasingCache(1403);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1404, 'COVID became endemic — at that point, proportionate ongoing caution is reasonable and emergency-level response is not.', 2);
CALL updatePhrasingCache(1404);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1405, 'Enough time and data accumulated — COVID is no longer the unknown it was in 2020, and policy should reflect that.', 2);
CALL updatePhrasingCache(1405);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1406, 'COVID became a permanent feature of the respiratory landscape — the work now is management, not elimination.', 2);
CALL updatePhrasingCache(1406);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1407, 'Businesses have every right to protect their workers and customers — requiring vaccination proof is exactly what that right enables.', 2);
CALL updatePhrasingCache(1407);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1412, 'Vaccine mandates are not novel — they have 170 years of legal precedent, upheld by the Supreme Court. The outrage was manufactured.', 2);
CALL updatePhrasingCache(1412);
