-- Brianna Barnes (profileID=2) — HEALTH cluster
-- 37 args: 29 accept / 8 reject
-- Fix: arg 895 placeholder was 1; Brianna supports Medicare for All → reject

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (64,  2, 1),
  (336, 2, 1),
  (337, 2, 1),
  (338, 2, 1),
  (339, 2, 1),
  (340, 2, 1),
  (416, 2, 1),
  (417, 2, 0),
  (418, 2, 1),
  (419, 2, 1),
  (424, 2, 0),
  (425, 2, 0),
  (426, 2, 1),
  (427, 2, 1),
  (735, 2, 1),
  (894, 2, 1),
  (895, 2, 0),
  (896, 2, 1),
  (897, 2, 1),
  (898, 2, 1),
  (899, 2, 1),
  (900, 2, 1),
  (901, 2, 1),
  (909, 2, 1),
  (910, 2, 0),
  (911, 2, 0),
  (912, 2, 1),
  (913, 2, 1),
  (914, 2, 1),
  (915, 2, 1),
  (916, 2, 1),
  (917, 2, 1),
  (918, 2, 1),
  (919, 2, 1),
  (920, 2, 0),
  (922, 2, 0),
  (958, 2, 1);

-- Fix placeholder conflict
UPDATE OPINION SET acceptance = 0 WHERE profileID = 2 AND argumentID = 895;

-- PHRASINGS (29 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (64, 'Fluoride in the water supply has cut tooth decay by 25% across all income levels — that\'s not ideology, that\'s a 60-year track record.', 2);
CALL updatePhrasingCache(64);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (336, 'Fifty years of studies across dozens of countries show the fluoride-dental health link — the data isn\'t ambiguous.', 2);
CALL updatePhrasingCache(336);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (337, 'The anti-fluoride research that scares people comes from regions with fluoride at four times the concentration we use — that\'s not the same question.', 2);
CALL updatePhrasingCache(337);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (338, 'The scientific consensus on fluoride at approved levels is clear and has been for decades — this isn\'t a conspiracy, it\'s public health.', 2);
CALL updatePhrasingCache(338);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (339, 'Better dental health prevents systemic infections and reduces long-term costs — the case for fluoridation is economic as much as it is medical.', 2);
CALL updatePhrasingCache(339);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (340, 'Every community that removes fluoride sees tooth decay rates go up — the result is predictable because the evidence is that solid.', 2);
CALL updatePhrasingCache(340);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (416, 'When scientific consensus is unambiguous — vaccines work, fluoride is safe — respecting it isn\'t deference, it\'s logic.', 2);
CALL updatePhrasingCache(416);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (418, 'Prove it works in a controlled trial or don\'t sell it as medicine — that\'s the minimum bar, and it\'s not negotiable.', 2);
CALL updatePhrasingCache(418);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (419, 'Selling products with health claims you can\'t substantiate isn\'t alternative medicine — it\'s fraud, and the supplement industry does it at scale.', 2);
CALL updatePhrasingCache(419);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (426, 'The autism-vaccine link has been tested thousands of times since the fraudulent Wakefield study — the answer is always no link.', 2);
CALL updatePhrasingCache(426);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (427, 'Vaccines are among the most tested medical interventions in history — the safety record is established, not assumed.', 2);
CALL updatePhrasingCache(427);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (735, 'When disease travels with global commerce, vaccination isn\'t just a personal choice — it\'s infrastructure.', 2);
CALL updatePhrasingCache(735);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (894, 'The government has both the responsibility and the leverage to fix a healthcare system this broken — that\'s the job.', 2);
CALL updatePhrasingCache(894);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (896, 'We spend the most on healthcare per person and get some of the worst outcomes in the developed world — that is a broken system by definition.', 2);
CALL updatePhrasingCache(896);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (897, 'We spend 17% of GDP on healthcare and a huge chunk of it goes to insurance overhead — that money should be going to patients.', 2);
CALL updatePhrasingCache(897);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (898, 'The healthcare system doesn\'t just fail — it fails unequally, and Black and brown patients pay the steepest price.', 2);
CALL updatePhrasingCache(898);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (899, 'Our healthcare system is the worst of both worlds — not a true market, not universal coverage, just a thicket of bureaucracy with no one accountable.', 2);
CALL updatePhrasingCache(899);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (900, 'A country that ignores preventive care ends up paying emergency room prices for everything — that\'s what we\'ve built.', 2);
CALL updatePhrasingCache(900);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (901, 'Universal single-payer healthcare would cover everyone, cut the insurance overhead, and let providers actually practice medicine.', 2);
CALL updatePhrasingCache(901);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (909, 'Healthcare tied to employment is a WWII accident — you shouldn\'t lose your coverage when you lose your job, and fixing that starts by ending the link.', 2);
CALL updatePhrasingCache(909);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (912, 'Veterans deserve healthcare that actually works, not a system that keeps them waiting for appointments that arrive too late.', 2);
CALL updatePhrasingCache(912);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (913, 'Veterans gave everything — they deserve healthcare that reflects that, not whatever the bureaucracy had left over.', 2);
CALL updatePhrasingCache(913);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (914, 'I work in hospital billing — I watch private insurers deny medically necessary care every single day, then claim the market is working fine.', 2);
CALL updatePhrasingCache(914);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (915, 'One payer means no claims fighting, no coverage gaps, no administrative waste — the efficiency argument for single-payer is straightforward.', 2);
CALL updatePhrasingCache(915);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (916, 'Veterans sacrificed years of their lives and came home to underfunded VA mental health services — that\'s a national failure, not a budget line.', 2);
CALL updatePhrasingCache(916);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (917, 'Some VA facilities are genuinely excellent — the problem is the accountability and funding gaps that let the failures persist alongside the successes.', 2);
CALL updatePhrasingCache(917);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (918, 'Housing stability is healthcare for veterans — programs that provide it work, and cutting them is a false economy.', 2);
CALL updatePhrasingCache(918);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (919, 'The VA outperforms private insurance on several key metrics — people who attack government healthcare should start there.', 2);
CALL updatePhrasingCache(919);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (958, 'Healthcare is a basic human right — access to treatment shouldn\'t depend on your income, your employer, or your zip code.', 2);
CALL updatePhrasingCache(958);
