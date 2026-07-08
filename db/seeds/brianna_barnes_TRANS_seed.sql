-- Brianna Barnes (profileID=2) — TRANS cluster
-- 58 args: 44 accept / 14 reject

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (142,  2, 0),
  (143,  2, 0),
  (144,  2, 1),
  (315,  2, 1),
  (316,  2, 1),
  (544,  2, 1),
  (785,  2, 0),
  (790,  2, 1),
  (791,  2, 0),
  (792,  2, 0),
  (793,  2, 0),
  (794,  2, 1),
  (795,  2, 1),
  (796,  2, 1),
  (797,  2, 1),
  (798,  2, 1),
  (799,  2, 1),
  (800,  2, 1),
  (801,  2, 1),
  (802,  2, 1),
  (803,  2, 1),
  (846,  2, 0),
  (847,  2, 1),
  (848,  2, 1),
  (849,  2, 0),
  (850,  2, 1),
  (851,  2, 1),
  (852,  2, 1),
  (853,  2, 1),
  (854,  2, 1),
  (855,  2, 1),
  (856,  2, 1),
  (857,  2, 1),
  (858,  2, 1),
  (859,  2, 1),
  (860,  2, 1),
  (1312, 2, 1),
  (1334, 2, 0),
  (1335, 2, 0),
  (1336, 2, 1),
  (1337, 2, 0),
  (1338, 2, 0),
  (1339, 2, 0),
  (1340, 2, 1),
  (1341, 2, 0),
  (1342, 2, 1),
  (1425, 2, 1),
  (1426, 2, 1),
  (1427, 2, 1),
  (1428, 2, 1),
  (1429, 2, 1),
  (1433, 2, 1),
  (1434, 2, 1),
  (1435, 2, 1),
  (1612, 2, 1),
  (1613, 2, 1),
  (1614, 2, 1),
  (1709, 2, 1);

-- PHRASINGS (44 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (144, 'Who you love and how you live doesn\'t harm anyone else — that\'s the whole case for the liberty to do it.', 2);
CALL updatePhrasingCache(144);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (315, 'Nobody chooses their gender any more than they choose their height — the premise that they do is wrong.', 2);
CALL updatePhrasingCache(315);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (316, 'Gender identity is not a choice or a fashion — it is as fundamental as any other part of who someone is.', 2);
CALL updatePhrasingCache(316);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (544, 'Trans men are men. Trans women are women. The rest is politics.', 2);
CALL updatePhrasingCache(544);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (790, 'Making trans girls play on boys teams to participate in sports is not a policy — it\'s targeted exclusion.', 2);
CALL updatePhrasingCache(790);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (794, 'Sports build confidence, discipline, and belonging — those benefits don\'t come with a gender exception.', 2);
CALL updatePhrasingCache(794);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (795, 'You can\'t claim to support trans women while insisting they\'re not really women — that\'s not support, it\'s tolerance with a footnote.', 2);
CALL updatePhrasingCache(795);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (796, 'Unfair advantages have always been managed in sports — the question is whether the claimed trans advantage actually exists as stated.', 2);
CALL updatePhrasingCache(796);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (797, 'Trans girls are girls — they belong in girls sports on the same terms as any other girl.', 2);
CALL updatePhrasingCache(797);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (798, 'Sports already tolerates enormous genetic variation in physiology — the outrage over trans athletes specifically is not about fairness.', 2);
CALL updatePhrasingCache(798);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (799, 'Fairness in sports has always been managed, never perfectly achieved — the argument is for evidence-based policy, not blanket exclusion.', 2);
CALL updatePhrasingCache(799);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (800, 'This is the bathroom panic recycled — manufactured alarm about trans kids used to justify excluding them from public life.', 2);
CALL updatePhrasingCache(800);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (801, 'Trans kids are children, not political props — stop using them to mobilize a base.', 2);
CALL updatePhrasingCache(801);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (802, 'Adolescence is already brutal — piling on with legislation that says your identity is wrong makes it genuinely dangerous.', 2);
CALL updatePhrasingCache(802);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (803, 'Sex categories in sports are less binary in practice than the trans panic admits — the biology is complicated.', 2);
CALL updatePhrasingCache(803);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (847, 'Women are every bit as capable as men in the things that actually matter — intelligence, judgment, leadership, character.', 2);
CALL updatePhrasingCache(847);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (848, 'Emotional availability and the capacity to nurture aren\'t feminine traits — they\'re human traits men lose by refusing them.', 2);
CALL updatePhrasingCache(848);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (850, 'Stoicism to the point of numbness, aggression as identity, emotional unavailability — those aren\'t features of masculinity, they\'re bugs.', 2);
CALL updatePhrasingCache(850);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (851, 'Suppressing fear doesn\'t make you brave — it makes you brittle and disconnected.', 2);
CALL updatePhrasingCache(851);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (852, 'Not everything in life has to be a competition — there\'s dignity in cooperation the "alpha male" framing completely misses.', 2);
CALL updatePhrasingCache(852);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (853, 'Men\'s dating priorities are shaped by advertising more than they realize — and those priorities do real damage to how women are valued.', 2);
CALL updatePhrasingCache(853);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (854, 'Ultra masculine posturing — the lifted trucks, the aggression cosplay — is compensating for something, and it\'s not subtle.', 2);
CALL updatePhrasingCache(854);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (855, 'We\'re talking about the extreme end of masculinity performance, not the whole spectrum — context matters.', 2);
CALL updatePhrasingCache(855);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (856, 'The performance of ultra masculinity — the chest-puffing, the contempt for softness — is unattractive in every sense.', 2);
CALL updatePhrasingCache(856);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (857, 'Empathy, emotional intelligence, collaboration — qualities coded as feminine that the whole world benefits from.', 2);
CALL updatePhrasingCache(857);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (858, 'Traditional masculinity defines itself by what it refuses to be — its opposition to femininity is structural, not incidental.', 2);
CALL updatePhrasingCache(858);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (859, 'A man who can\'t respect women as equals is performing a strength he doesn\'t actually have.', 2);
CALL updatePhrasingCache(859);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (860, 'Sexual attraction isn\'t a moral choice — shame-based approaches to it cause harm without producing virtue.', 2);
CALL updatePhrasingCache(860);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1312, 'Legislation targeting trans kids in sports doesn\'t protect girls — it singles out one of the most vulnerable groups of children for exclusion.', 2);
CALL updatePhrasingCache(1312);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1336, 'The slope from "trans girl plays JV soccer" to "women\'s athletics collapses" requires a lot of imagination and very little evidence.', 2);
CALL updatePhrasingCache(1336);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1340, 'All sports categories discriminate by design — the question is whether a particular exclusion is justified, not whether exclusion exists.', 2);
CALL updatePhrasingCache(1340);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1342, 'Every girl deserves the same shot at athletic participation — and that includes trans girls.', 2);
CALL updatePhrasingCache(1342);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1425, 'The APA removed trans identity from its disorder list over a decade ago — treating it as pathology is medically outdated and personally cruel.', 2);
CALL updatePhrasingCache(1425);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1426, 'Gender dysphoria is a medical condition deserving treatment — not evidence that the trans person\'s identity is wrong.', 2);
CALL updatePhrasingCache(1426);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1427, 'Medical decisions about gender identity belong to the patient and their family — full stop.', 2);
CALL updatePhrasingCache(1427);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1428, 'State legislators should not be in the exam room with trans kids and their doctors.', 2);
CALL updatePhrasingCache(1428);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1429, 'Erasing trans people from curricula tells trans kids they don\'t exist — that\'s not protection, it\'s harm.', 2);
CALL updatePhrasingCache(1429);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1433, 'The "traditional family" structure placed women in legal and economic dependence on men — that\'s not a model to defend, it\'s one to have escaped.', 2);
CALL updatePhrasingCache(1433);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1434, 'Across abortion, contraception, domestic violence policy, and pay equity, the conservative record on women is structural misogyny, not incidental.', 2);
CALL updatePhrasingCache(1434);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1435, 'A household where one adult defers to the other by gender isn\'t a partnership — it\'s a hierarchy.', 2);
CALL updatePhrasingCache(1435);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1612, 'The number of trans kids in youth sports competing at a level where physiology matters is vanishingly small — the panic is wildly disproportionate.', 2);
CALL updatePhrasingCache(1612);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1613, 'Youth sports are about teamwork, discipline, and belonging — not elite competition. The trans fairness debate doesn\'t belong there.', 2);
CALL updatePhrasingCache(1613);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1614, 'Trans kids need connection with peers who see them — denying that in every social setting is a cruelty.', 2);
CALL updatePhrasingCache(1614);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1709, 'Gender dysphoria and body dysmorphia share surface features but are distinct conditions — conflating them to dismiss trans experience is bad medicine.', 2);
CALL updatePhrasingCache(1709);
