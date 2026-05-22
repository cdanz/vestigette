-- personas_6_10_seed.sql
-- Opinion and endorsement population for profileIDs 6-10
-- Frank Fletcher (6), Gloria Gutierrez (7), Harold Hughes (8), Irene Ingram (9), James Jennings (10)
--
-- Weights within every (targArgID, profileID, endorseType) group sum to EXACTLY 100.0
-- assertOpinion(op, argID, proID): op=1 accept, op=-1 reject; uses IF NOT EXISTS semantics
-- Skip argumentIDs 1-55 (pre-existing GMO test data) for all personas

USE vestigette;

-- ============================================================
-- PROFILE 6: FRANK FLETCHER
-- 52yo White male, Regional Sales Manager, suburban NC, $115k
-- ideology_score: 6 (moderately conservative)
-- Votes Republican mainly on economics; embarrassed by Trump but votes for him
-- Analytical, pro-market, anti-regulation, anti-union
-- Dislikes culture war theatrics; reads WSJ
-- Key: lower taxes better outcomes; govt less efficient than markets;
--      hard work explains outcomes; deficit matters
-- ============================================================

-- === FREE MARKETS / FISCAL CONSERVATISM ===
CALL assertOpinion(1, 134, 6);   -- We shouldn't punish success
CALL assertOpinion(1, 135, 6);   -- Not allowing people to keep what they earned is criminal
CALL assertOpinion(1, 136, 6);   -- Capitalism is the best system we got
CALL assertOpinion(1, 201, 6);   -- Innovation should not be encumbered
CALL assertOpinion(1, 227, 6);   -- Low taxes fuel innovation
CALL assertOpinion(1, 228, 6);   -- Low taxes strengthen the economy
CALL assertOpinion(1, 265, 6);   -- A tax cut allows you to keep more of the money you duly earned
CALL assertOpinion(1, 275, 6);   -- Government projects do not have a profit motive for efficiency
CALL assertOpinion(1, 400, 6);   -- Government should stay out of the way
CALL assertOpinion(1, 401, 6);   -- Free markets do a better job than any government
CALL assertOpinion(1, 404, 6);   -- Constant vigilance needed to eliminate unnecessary regulations
CALL assertOpinion(1, 412, 6);   -- Government is inherently inefficient
CALL assertOpinion(1, 1045, 6);  -- Regulation often imposes burdens far beyond risk-mitigating benefits
CALL assertOpinion(1, 1278, 6);  -- The ideal economy is capitalist
CALL assertOpinion(1, 1602, 6);  -- Means of production should largely be controlled privately
CALL assertOpinion(1, 267, 6);   -- Means-testing avoids wasting government resources
CALL assertOpinion(1, 920, 6);   -- Government programs are ineffective
CALL assertOpinion(1, 607, 6);   -- If people are given handouts they will never learn to provide for themselves
CALL assertOpinion(1, 601, 6);   -- Welfare programs should ask recipients to do their part
CALL assertOpinion(-1, 609, 6);  -- US govt should implement universal basic income (too much)
CALL assertOpinion(-1, 450, 6);  -- Government should respond to slowdowns with greater spending (rejects Keynesian excess)

-- === DEFICIT / FISCAL RESPONSIBILITY ===
CALL assertOpinion(1, 264, 6);   -- Govt policy judged on its net effect on one's wealth
CALL assertOpinion(1, 266, 6);   -- A government check is unearned, other people's money
CALL assertOpinion(1, 322, 6);   -- We should never put our full faith in the government
CALL assertOpinion(-1, 192, 6);  -- Wealth taxes should control offensive levels of wealth (goes too far)
CALL assertOpinion(-1, 745, 6);  -- Wealthy should take on greater proportion of tax burden (rejects this framing)

-- === MERITOCRACY / CAPITALISM ===
CALL assertOpinion(1, 197, 6);   -- Success should be rewarded with a greater share of the spoils
CALL assertOpinion(1, 199, 6);   -- Society should reward people as motivation to strive for success
CALL assertOpinion(1, 1591, 6);  -- Socialism has failed every time it was tried
CALL assertOpinion(1, 1597, 6);  -- Socialism is bad
CALL assertOpinion(-1, 1589, 6); -- Socialism now (rejects this)
CALL assertOpinion(1, 1095, 6);  -- Capitalism should be firmly defined
CALL assertOpinion(1, 1096, 6);  -- Capitalism requires a commitment to fair competition

-- === UNIONS ===
CALL assertOpinion(1, 727, 6);   -- Unions often employ inflexible rules that impact enterprise's ability to adapt
CALL assertOpinion(-1, 494, 6);  -- Workers should unionize (rejects as blanket proposition)
CALL assertOpinion(-1, 495, 6);  -- Collective bargaining helps workers win greater pay (skeptical)

-- === POLICING (some reform ok, not defund) ===
CALL assertOpinion(-1, 107, 6);  -- Defund police departments
CALL assertOpinion(-1, 560, 6);  -- Police should be abolished
CALL assertOpinion(1, 561, 6);   -- Back the blue
CALL assertOpinion(1, 165, 6);   -- Police oversight should be reformed (not policing itself)
CALL assertOpinion(1, 1410, 6);  -- Safety of police officers should be top priority
CALL assertOpinion(1, 148, 6);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(-1, 155, 6);  -- Police procedures effectively racist too often (rejects systemic framing)

-- === CLIMATE (accepts it's real; skeptical of rapid govt response) ===
CALL assertOpinion(1, 321, 6);   -- Human influenced climate change is an observable fact
CALL assertOpinion(1, 530, 6);   -- We should reduce barriers to innovation that could address global warming
CALL assertOpinion(-1, 123, 6);  -- We must act on climate change quickly and forcefully (too fast for him)
CALL assertOpinion(-1, 414, 6);  -- We should ramp up renewable energy ASAP (too aggressive)
CALL assertOpinion(-1, 476, 6);  -- Fossil fuels need to be left in the ground (too extreme)
CALL assertOpinion(1, 527, 6);   -- We will destroy the economy well before reversing global warming
CALL assertOpinion(1, 528, 6);   -- We do not yet have the technology to respond to global warming effectively
CALL assertOpinion(1, 529, 6);   -- We can adapt to climate change as humanity has adapted before

-- === IMMIGRATION (controlled, orderly) ===
CALL assertOpinion(-1, 611, 6);  -- Open borders are a worthy ideal
CALL assertOpinion(-1, 616, 6);  -- Asylum should be granted to all who seek it
CALL assertOpinion(1, 612, 6);   -- America should only allow the best to become citizens
CALL assertOpinion(1, 1160, 6);  -- Immigrants boost the economy
CALL assertOpinion(1, 1159, 6);  -- Immigrants are not dangerous
CALL assertOpinion(-1, 1237, 6); -- Migrants should be treated as enemy invaders (too extreme)

-- === GUNS (2A supporter, but not absolutist) ===
CALL assertOpinion(1, 328, 6);   -- We should defend the second amendment
CALL assertOpinion(1, 140, 6);   -- 2A grants right to own whatever firearms I deem necessary
CALL assertOpinion(1, 460, 6);   -- People shouldn't be restricted from responsibly owning guns
CALL assertOpinion(1, 1172, 6);  -- Any regulation of weapons must be in keeping with 2A
CALL assertOpinion(-1, 1179, 6); -- America needs gun reform now
CALL assertOpinion(-1, 1181, 6); -- Gun ownership in America should be strictly limited

-- === POLITICS (reluctant Republican; anti-culture war) ===
CALL assertOpinion(-1, 90, 6);   -- The GOP agenda is bad for America (pushes back)
CALL assertOpinion(-1, 94, 6);   -- Do not vote for a Republican until major reforms
CALL assertOpinion(-1, 104, 6);  -- Vote for Democrats
CALL assertOpinion(1, 229, 6);   -- GOP's main goal is to keep govt out of our business
CALL assertOpinion(-1, 89, 6);   -- Trump tacitly endorses racism (rejects; embarrassed but defends economics)
CALL assertOpinion(1, 288, 6);   -- Cancel culture must be resisted
CALL assertOpinion(1, 291, 6);   -- People should not be fired for their political views
CALL assertOpinion(-1, 297, 6);  -- Cancel culture is effort to promote conformist liberal viewpoint (too glib for him)
CALL assertOpinion(1, 226, 6);   -- Freedom should never be infringed

-- === RACE (doesn't deny racism exists; rejects systemic framing) ===
CALL assertOpinion(-1, 101, 6);  -- Racism is made up (he doesn't believe this)
CALL assertOpinion(1, 100, 6);   -- No system can be completely fair
CALL assertOpinion(-1, 108, 6);  -- Black people just commit more crime (rejects this)
CALL assertOpinion(-1, 118, 6);  -- Black people are inherently less civil (rejects this)
CALL assertOpinion(-1, 1345, 6); -- Curriculums should be adjusted to combat white supremacy (goes too far)
CALL assertOpinion(-1, 1346, 6); -- Kids should be taught white people are racist (no)
CALL assertOpinion(1, 1229, 6);  -- It is perfectly okay to be white

-- === HEALTHCARE ===
CALL assertOpinion(-1, 901, 6);  -- US should implement Medicare for All
CALL assertOpinion(1, 910, 6);   -- Govt control of healthcare creates bureaucratic, inefficient system
CALL assertOpinion(1, 911, 6);   -- Private enterprise must control healthcare
CALL assertOpinion(1, 895, 6);   -- US must reform its healthcare system (agrees reform needed, just not govt takeover)

-- === ENDORSEMENTS: FRANK FLETCHER (profileID=6) ===

-- Cluster 1: Low taxes = better outcomes
-- Target: 227 (low taxes fuel innovation)
-- Because: 265 (tax cut lets you keep earned money) 55%, 134 (shouldn't punish success) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (227, 6, 'Because', 265, 55.0, 1),
       (227, 6, 'Because', 134, 45.0, 1);

-- Target: 227 Therefore: 228 (low taxes strengthen economy) 55%, 201 (innovation not encumbered) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (227, 6, 'Therefore', 228, 55.0, 1),
       (227, 6, 'Therefore', 201, 45.0, 1);

-- Cluster 2: Government out of the way
-- Target: 400 (govt should stay out of the way)
-- Because: 412 (govt inherently inefficient) 40%, 275 (no profit motive) 35%, 1045 (regs impose excessive burdens) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 6, 'Because', 412, 40.0, 1),
       (400, 6, 'Because', 275, 35.0, 1),
       (400, 6, 'Because', 1045, 25.0, 1);

-- Target: 400 Therefore: 401 (free markets do better) 55%, 404 (eliminate unnecessary regs) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 6, 'Therefore', 401, 55.0, 1),
       (400, 6, 'Therefore', 404, 45.0, 1);

-- Cluster 3: Rebut socialism
-- Target: 1597 (socialism is bad)
-- Because: 1591 (failed every time) 55%, 1278 (ideal economy is capitalist) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1597, 6, 'Because', 1591, 55.0, 1),
       (1597, 6, 'Because', 1278, 45.0, 1);

-- Target: 1597 Therefore: 136 (capitalism is best) 55%, 1602 (means of production privately controlled) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1597, 6, 'Therefore', 136, 55.0, 1),
       (1597, 6, 'Therefore', 1602, 45.0, 1);

-- Cluster 4: Climate nuance — accepts the fact, rejects rapid govt action
-- Target: 321 (human influenced climate change is an observable fact)
-- Because: he accepts the evidence; Therefore: 530 (reduce barriers to innovation) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (321, 6, 'Therefore', 530, 100.0, 1);

-- Target: 123 (act on climate quickly) -- REJECTED
-- Rebuttal: 527 (destroy economy before reversing warming) 55%, 528 (don't yet have technology) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 6, 'Rebuttal', 527, 55.0, 1),
       (123, 6, 'Rebuttal', 528, 45.0, 1);

-- Cluster 5: Rebut defund police
-- Target: 107 (defund police) -- REJECTED
-- Rebuttal: 561 (back the blue) 55%, 165 (oversight reform not defund) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 6, 'Rebuttal', 561, 55.0, 1),
       (107, 6, 'Rebuttal', 165, 45.0, 1);

-- Cluster 6: Free markets over government healthcare
-- Target: 910 (govt healthcare = bureaucratic, inefficient)
-- Because: 412 (govt inherently inefficient) 55%, 920 (govt programs ineffective) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (910, 6, 'Because', 412, 55.0, 1),
       (910, 6, 'Because', 920, 45.0, 1);

-- Target: 910 Therefore: 911 (private enterprise must control healthcare) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (910, 6, 'Therefore', 911, 100.0, 1);

-- Cluster 7: Rebut unions
-- Target: 494 (workers should unionize) -- REJECTED
-- Rebuttal: 727 (unions use inflexible rules) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 6, 'Rebuttal', 727, 100.0, 1);

-- Cluster 8: Meritocracy
-- Target: 197 (success should be rewarded with greater share)
-- Because: 136 (capitalism is best) 55%, 199 (society should reward people to motivate striving) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (197, 6, 'Because', 136, 55.0, 1),
       (197, 6, 'Because', 199, 45.0, 1);

-- Cluster 9: Rebut open borders
-- Target: 611 (open borders worthy ideal) -- REJECTED
-- Rebuttal: 612 (only let the best in) 55%, 1160 (immigrants boost economy, so select carefully) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (611, 6, 'Rebuttal', 612, 55.0, 1),
       (611, 6, 'Rebuttal', 1160, 45.0, 1);

-- Cluster 10: Police reform nuance
-- Target: 148 (de-escalation techniques required)
-- Because: 165 (oversight reform, not the policing itself) 55%, 1410 (officer safety top priority) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (148, 6, 'Because', 165, 55.0, 1),
       (148, 6, 'Because', 1410, 45.0, 1);


-- ============================================================
-- PROFILE 7: GLORIA GUTIERREZ
-- 61yo Latina Catholic woman, part-time Walmart cashier/caregiver
-- Española NM — 7 generations in the region
-- Anti-abortion (hardcoded). Pro-family, pro-community.
-- Limited English. Skeptical of govt but uses services.
-- Non-partisan lean, culturally conservative.
-- She engages only with issues that feel personal and faith-connected.
-- ============================================================

-- === ABORTION / LIFE (hardcoded anti-abortion) ===
CALL assertOpinion(1, 124, 7);   -- A fetus has a human soul whose life should be protected
CALL assertOpinion(1, 902, 7);   -- Unborn children deserve their right to life to be recognized
CALL assertOpinion(1, 125, 7);   -- Woman should take responsibility for their pregnancies
CALL assertOpinion(1, 126, 7);   -- There should be a limit on how far along a pregnancy can be aborted
CALL assertOpinion(-1, 127, 7);  -- Can't advocate for fetus without opposing woman's bodily autonomy (she rejects this framing)
CALL assertOpinion(-1, 128, 7);  -- Limits on abortion access is cruel punishment (she disagrees)
CALL assertOpinion(-1, 129, 7);  -- Having a child should not be put upon someone like a punishment (she disagrees)
CALL assertOpinion(1, 1387, 7);  -- Life begins at conception
CALL assertOpinion(-1, 903, 7);  -- Personhood recognized at live birth (she rejects; life begins at conception)
CALL assertOpinion(-1, 964, 7);  -- Contraception and abortion are necessary to modern civilization
CALL assertOpinion(-1, 975, 7);  -- Goal of pro-life movement is to penalize women (she rejects; it's about life)

-- === FAITH ===
CALL assertOpinion(1, 130, 7);   -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 7);   -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 7);   -- The faithful believe in His glory unconditionally
CALL assertOpinion(1, 1385, 7);  -- Jesus is my Lord and Savior!
CALL assertOpinion(1, 1386, 7);  -- Jesus is God's only son
CALL assertOpinion(1, 1440, 7);  -- The Bible is the word of God
CALL assertOpinion(-1, 161, 7);  -- For all intents there is no such thing as a god
CALL assertOpinion(-1, 1438, 7); -- The Bible is bullshit (she deeply rejects this)
CALL assertOpinion(1, 1645, 7);  -- People should be free to live out their faith

-- === FAMILY / COMMUNITY ===
CALL assertOpinion(1, 849, 7);   -- First duty to your family as a parent is as a protector
CALL assertOpinion(1, 242, 7);   -- Humans must treat each other with fellowship if we are to succeed
CALL assertOpinion(1, 320, 7);   -- All people deserve to be treated equally
CALL assertOpinion(1, 313, 7);   -- Every person deserves a basic level of respect
CALL assertOpinion(1, 598, 7);   -- There is a floor to the standard of living you should be willing to see for your fellow human
CALL assertOpinion(1, 604, 7);   -- Government should eliminate poverty among the populace

-- === LGBTQ (culturally conservative — rejects) ===
CALL assertOpinion(-1, 144, 7);  -- Loving who you want causes no justifiable harm (she can't endorse this framing)
CALL assertOpinion(-1, 143, 7);  -- Homosexuality is a perversion of nature (she avoids this language; rejects argument either way; skip)
CALL assertOpinion(1, 142, 7);   -- There are only two genders
CALL assertOpinion(1, 785, 7);   -- Traditional gender roles exist for a reason
CALL assertOpinion(-1, 795, 7);  -- Support trans women by not undermining their gender identity
CALL assertOpinion(-1, 797, 7);  -- Trans girls should be permitted in women's athletics same as any other girls

-- === LAND / COMMUNITY IDENTITY ===
CALL assertOpinion(1, 237, 7);   -- Native Americans are right to feel wronged by American government
CALL assertOpinion(1, 245, 7);   -- The American government brutally banished native Americans from their homes
CALL assertOpinion(1, 244, 7);   -- Humanity can only move forward as one - leaving no one behind

-- === POLICING (not deeply engaged; basic community safety) ===
CALL assertOpinion(-1, 107, 7);  -- Defund police departments (no — community needs safety)
CALL assertOpinion(-1, 560, 7);  -- Police should be abolished (no)
CALL assertOpinion(1, 154, 7);   -- Police officers have duty to intervene if fellow officer risks harm

-- === POLITICS (non-partisan; avoids most hot takes) ===
CALL assertOpinion(1, 322, 7);   -- We should never put our full faith in the government
CALL assertOpinion(1, 100, 7);   -- No system can be completely fair

-- === ENDORSEMENTS: GLORIA GUTIERREZ (profileID=7) ===

-- Cluster 1: Life begins at conception — the core
-- Target: 124 (fetus has human soul whose life should be protected)
-- Because: 1387 (life begins at conception) 55%, 130 (can't be certain God doesn't exist) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (124, 7, 'Because', 1387, 55.0, 1),
       (124, 7, 'Because', 130, 45.0, 1);

-- Target: 124 Therefore: 902 (unborn children deserve right to life) 55%, 126 (limit on pregnancy term) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (124, 7, 'Therefore', 902, 55.0, 1),
       (124, 7, 'Therefore', 126, 45.0, 1);

-- Cluster 2: Rebut abortion framing
-- Target: 129 (child shouldn't be punishment) -- REJECTED
-- Rebuttal: 124 (fetus has soul) 55%, 1387 (life begins at conception) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (129, 7, 'Rebuttal', 124, 55.0, 1),
       (129, 7, 'Rebuttal', 1387, 45.0, 1);

-- Cluster 3: Faith is the foundation
-- Target: 428 (those with faith can feel God's presence)
-- Because: 130 (you can't be certain God doesn't exist) 55%, 844 (believe in His glory unconditionally) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (428, 7, 'Because', 130, 55.0, 1),
       (428, 7, 'Because', 844, 45.0, 1);

-- Target: 428 Therefore: 1385 (Jesus is my Lord and Savior) 55%, 1386 (Jesus is God's only son) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (428, 7, 'Therefore', 1385, 55.0, 1),
       (428, 7, 'Therefore', 1386, 45.0, 1);

-- Cluster 4: Traditional gender roles
-- Target: 785 (traditional gender roles exist for a reason)
-- Because: 142 (only two genders) 55%, 849 (first duty as parent is protector) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (785, 7, 'Because', 142, 55.0, 1),
       (785, 7, 'Because', 849, 45.0, 1);

-- Cluster 5: Rebut LGBTQ framing
-- Target: 795 (support trans women by not undermining gender identity) -- REJECTED
-- Rebuttal: 142 (only two genders) 55%, 785 (traditional gender roles exist for a reason) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (795, 7, 'Rebuttal', 142, 55.0, 1),
       (795, 7, 'Rebuttal', 785, 45.0, 1);

-- Cluster 6: Community and fellowship
-- Target: 242 (humans must treat each other with fellowship)
-- Because: 244 (humanity can only move forward as one) 55%, 313 (every person deserves basic respect) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (242, 7, 'Because', 244, 55.0, 1),
       (242, 7, 'Because', 313, 45.0, 1);

-- Target: 242 Therefore: 598 (floor to standard of living for fellow human) 55%, 604 (govt should eliminate poverty) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (242, 7, 'Therefore', 598, 55.0, 1),
       (242, 7, 'Therefore', 604, 45.0, 1);

-- Cluster 7: Wrongs done to her people
-- Target: 237 (Native Americans are right to feel wronged by American government)
-- Because: 245 (govt brutally banished Native Americans) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (237, 7, 'Because', 245, 100.0, 1);

-- Cluster 8: Rebut defund police (community safety)
-- Target: 107 (defund police) -- REJECTED
-- Rebuttal: 154 (police duty to intervene) 55%, 313 (every person deserves basic respect) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 7, 'Rebuttal', 154, 55.0, 1),
       (107, 7, 'Rebuttal', 313, 45.0, 1);


-- ============================================================
-- PROFILE 8: HAROLD HUGHES
-- 45yo Black man, Detroit MI, warehouse logistics worker
-- Solo dad of two, irregular voter (skipped 2016)
-- Deeply frustrated. Pro police accountability but NOT abolition/defund.
-- Pro Black community. Anti-establishment Democrat. Class-conscious.
-- Hardcoded: Black fathers disrespected; can be pro-accountability AND anti-crime;
--            economy rigged; kids won't inherit his bitterness
-- ============================================================

-- === RACIAL JUSTICE ===
CALL assertOpinion(1, 103, 8);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 105, 8);   -- Police kill black people with impunity
CALL assertOpinion(1, 109, 8);   -- Empower black people
CALL assertOpinion(1, 169, 8);   -- Non-white males statistically paid less per dollar
CALL assertOpinion(1, 175, 8);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 207, 8);   -- Black people stopped for looking suspicious far more often
CALL assertOpinion(1, 221, 8);   -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(1, 236, 8);   -- Black Americans are right to feel wronged by society
CALL assertOpinion(1, 240, 8);   -- Equality of any group treated as less human is a priority
CALL assertOpinion(1, 241, 8);   -- Giving Black Americans the power they deserve should be a priority
CALL assertOpinion(1, 484, 8);   -- We all have implicit bias
CALL assertOpinion(-1, 101, 8);  -- Racism is made up (he knows better)
CALL assertOpinion(-1, 108, 8);  -- Black people just commit more crime
CALL assertOpinion(-1, 118, 8);  -- Black people are inherently less civil

-- === CRIMINAL JUSTICE ===
CALL assertOpinion(1, 111, 8);   -- End cash bail
CALL assertOpinion(1, 112, 8);   -- Implicit bias skews sentencing
CALL assertOpinion(1, 113, 8);   -- Conditions outside Black Americans' control increase crime likelihood
CALL assertOpinion(1, 115, 8);   -- Cash bail criminalizes poverty
CALL assertOpinion(1, 116, 8);   -- Cash bail perpetuates inequities felt by communities of color
CALL assertOpinion(1, 171, 8);   -- Criminal justice system major contributor to racial inequality
CALL assertOpinion(1, 174, 8);   -- CJ system prejudiced; not accounting for disparities is being blind
CALL assertOpinion(1, 222, 8);   -- CJ inequities are part and parcel of American societal inequities
CALL assertOpinion(1, 223, 8);   -- Preventing racial inequality in justice system should be priority

-- === POLICING (Reform YES — Defund/Abolish NO) ===
CALL assertOpinion(1, 145, 8);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 8);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 153, 8);   -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 8);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 155, 8);   -- Police procedures and policies are effectively racist too often
CALL assertOpinion(1, 217, 8);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 218, 8);   -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 8);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 8);   -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(1, 1498, 8);  -- Qualified immunity for police must end
CALL assertOpinion(1, 603, 8);   -- Cities with significant BLM protests had reduction in police homicides
CALL assertOpinion(1, 1188, 8);  -- Routine traffic stops extremely dangerous for Black and Brown people
CALL assertOpinion(-1, 107, 8);  -- Defund police departments (Harold opposes this — he needs those cops in his neighborhood)
CALL assertOpinion(-1, 560, 8);  -- Police should be abolished (Harold opposes this)
CALL assertOpinion(-1, 561, 8);  -- Back the blue (rejects uncritical framing)
CALL assertOpinion(-1, 166, 8);  -- Policing doesn't need to be changed, only oversight (too narrow for Harold too)

-- === BLM (supports goals, not all tactics) ===
CALL assertOpinion(1, 1313, 8);  -- BLM is simply about Black Americans not living in fear
CALL assertOpinion(1, 1314, 8);  -- Black Americans' fear of police is completely legitimate
CALL assertOpinion(1, 1321, 8);  -- BLM makes the clear point that Black people's lives are undervalued
CALL assertOpinion(1, 546, 8);   -- BLM movement activists deserve support
CALL assertOpinion(1, 1202, 8);  -- BLM protests have by and large been peaceful
CALL assertOpinion(-1, 349, 8);  -- BLM movement is racist
CALL assertOpinion(-1, 350, 8);  -- BLM aims to diminish white people
CALL assertOpinion(-1, 1319, 8); -- All Lives Matter (rejects as deflection)

-- === WEALTH / CLASS / ECONOMY ===
CALL assertOpinion(1, 110, 8);   -- Degree of wealth inequality in America is beyond acceptable
CALL assertOpinion(1, 500, 8);   -- Too many struggle to meet immediate material needs while few have more than they can spend
CALL assertOpinion(1, 501, 8);   -- People living one unexpected expense from dire situation have chronic anxiety
CALL assertOpinion(1, 200, 8);   -- The more we are separated the less trust and social cohesion is possible
CALL assertOpinion(1, 187, 8);   -- The people are right to feel resentment toward elites
CALL assertOpinion(1, 598, 8);   -- There is a floor to the standard of living you should be willing to see for your fellow human
CALL assertOpinion(-1, 266, 8);  -- A government check is unearned, other people's money (he rejects this — he's used assistance)
CALL assertOpinion(-1, 607, 8);  -- If people are given handouts they will never learn (he rejects this shaming)

-- === POLITICS (anti-establishment, reluctant Democrat) ===
CALL assertOpinion(1, 104, 8);   -- Vote for Democrats (necessary evil, not enthusiasm)
CALL assertOpinion(-1, 80, 8);   -- Trump 2024
CALL assertOpinion(1, 89, 8);    -- Trump tacitly endorses racism
CALL assertOpinion(1, 90, 8);    -- The GOP agenda is bad for America
CALL assertOpinion(1, 574, 8);   -- The American Democratic Party is terrible (he agrees — they fail his community)
CALL assertOpinion(1, 575, 8);   -- The DNC's efforts for the common person are meek
CALL assertOpinion(1, 986, 8);   -- The GOP cynically made common cause with the most racist elements of the country

-- === ENDORSEMENTS: HAROLD HUGHES (profileID=8) ===

-- Cluster 1: Police accountability chain
-- Target: 217 (police not held accountable)
-- Because: 219 (qualified immunity) 40%, 539 (immunity unjustly shields) 35%, 218 (police see Black people as threat) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 8, 'Because', 219, 40.0, 1),
       (217, 8, 'Because', 539, 35.0, 1),
       (217, 8, 'Because', 218, 25.0, 1);

-- Target: 217 Therefore: 145 (policing must be reformed) 55%, 1498 (qualified immunity must end) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 8, 'Therefore', 145, 55.0, 1),
       (217, 8, 'Therefore', 1498, 45.0, 1);

-- Cluster 2: Why policing must be reformed
-- Target: 145 (policing must be reformed)
-- Because: 155 (policies effectively racist) 40%, 207 (stopped while Black) 35%, 105 (police kill with impunity) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 8, 'Because', 155, 40.0, 1),
       (145, 8, 'Because', 207, 35.0, 1),
       (145, 8, 'Because', 105, 25.0, 1);

-- Target: 145 Therefore: 148 (de-escalation) 55%, 153 (exhaust options before shooting) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 8, 'Therefore', 148, 55.0, 1),
       (145, 8, 'Therefore', 153, 45.0, 1);

-- Cluster 3: Rebut defund police
-- Target: 107 (defund police) -- REJECTED (Harold wants accountability, not chaos)
-- Rebuttal: 145 (policing must be reformed — not defunded) 60%, 217 (not held accountable — fix that) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 8, 'Rebuttal', 145, 60.0, 1),
       (107, 8, 'Rebuttal', 217, 40.0, 1);

-- Cluster 4: BLM legitimacy
-- Target: 546 (BLM activists deserve support)
-- Because: 1313 (simply about not living in fear) 40%, 1314 (fear is legitimate) 35%, 1202 (protests mostly peaceful) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 8, 'Because', 1313, 40.0, 1),
       (546, 8, 'Because', 1314, 35.0, 1),
       (546, 8, 'Because', 1202, 25.0, 1);

-- Target: 546 Therefore: 1321 (BLM makes clear point about undervalued lives) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 8, 'Therefore', 1321, 100.0, 1);

-- Cluster 5: Rebut BLM is racist
-- Target: 349 (BLM is racist) -- REJECTED
-- Rebuttal: 1313 (simply about not living in fear) 55%, 1202 (protests mostly peaceful) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (349, 8, 'Rebuttal', 1313, 55.0, 1),
       (349, 8, 'Rebuttal', 1202, 45.0, 1);

-- Cluster 6: Cash bail
-- Target: 111 (end cash bail)
-- Because: 115 (criminalizes poverty) 55%, 116 (perpetuates inequities) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (111, 8, 'Because', 115, 55.0, 1),
       (111, 8, 'Because', 116, 45.0, 1);

-- Target: 111 Therefore: 222 (CJ inequities part of broader societal inequities) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (111, 8, 'Therefore', 222, 100.0, 1);

-- Cluster 7: Wealth inequality class-conscious framing
-- Target: 110 (wealth inequality beyond acceptable)
-- Because: 500 (too many struggle) 55%, 501 (chronic anxiety from financial insecurity) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 8, 'Because', 500, 55.0, 1),
       (110, 8, 'Because', 501, 45.0, 1);

-- Target: 110 Therefore: 598 (floor to standard of living for fellow human) 55%, 187 (right to feel resentment toward elites) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 8, 'Therefore', 598, 55.0, 1),
       (110, 8, 'Therefore', 187, 45.0, 1);

-- Cluster 8: CJ racism
-- Target: 174 (CJ system prejudiced; not accounting is being blind)
-- Because: 112 (implicit bias skews sentencing) 40%, 103 (disproportionate convictions) 35%, 113 (conditions outside control) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (174, 8, 'Because', 112, 40.0, 1),
       (174, 8, 'Because', 103, 35.0, 1),
       (174, 8, 'Because', 113, 25.0, 1);

-- Target: 174 Therefore: 223 (preventing racial inequality in justice should be priority) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (174, 8, 'Therefore', 223, 100.0, 1);

-- Cluster 9: Rebut "All Lives Matter"
-- Target: 1319 (All Lives Matter) -- REJECTED
-- Rebuttal: 1321 (BLM makes clear point about undervalued lives) 55%, 1313 (simply about not living in fear) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1319, 8, 'Rebuttal', 1321, 55.0, 1),
       (1319, 8, 'Rebuttal', 1313, 45.0, 1);

-- Cluster 10: Rebut "back the blue" uncritical framing
-- Target: 561 (back the blue) -- REJECTED
-- Rebuttal: 217 (not held accountable) 55%, 539 (qualified immunity) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 8, 'Rebuttal', 217, 55.0, 1),
       (561, 8, 'Rebuttal', 539, 45.0, 1);


-- ============================================================
-- PROFILE 9: IRENE INGRAM
-- 38yo White lesbian UX designer, Somerville MA, $88k
-- Reliable progressive Democrat. LGBTQ rights as existential.
-- Evidence-based. Climate urgency. Pro bodily autonomy.
-- Anti-discrimination. Pro labor. Skeptical of tech company ethics.
-- ============================================================

-- === LGBTQ RIGHTS (existential — non-negotiable) ===
CALL assertOpinion(1, 144, 9);   -- Loving who you want causes no justifiable harm
CALL assertOpinion(1, 543, 9);   -- We should accept people for who they are
CALL assertOpinion(1, 544, 9);   -- Trans men should be accepted as men, trans women as women
CALL assertOpinion(1, 795, 9);   -- Support trans women by not undermining their gender identity
CALL assertOpinion(1, 797, 9);   -- Trans girls should be permitted in women's athletics same as any other girls
CALL assertOpinion(1, 790, 9);   -- Trans girls should not be forced to play boys sports to participate
CALL assertOpinion(1, 315, 9);   -- A person does not choose their gender
CALL assertOpinion(1, 316, 9);   -- Gender is innate
CALL assertOpinion(1, 801, 9);   -- We should endeavor to leave trans kids out of bullshit culture war battles
CALL assertOpinion(1, 1425, 9);  -- Transgenderism is not a mental illness nor any type of malady
CALL assertOpinion(1, 1312, 9);  -- Laws banning trans kids from sports by gender identity are wrong
CALL assertOpinion(-1, 142, 9);  -- There are only two genders
CALL assertOpinion(-1, 785, 9);  -- Traditional gender roles exist for a reason
CALL assertOpinion(-1, 792, 9);  -- Trans girls have unfair advantage over cis girls
CALL assertOpinion(-1, 791, 9);  -- Sports should be separated by biological sex

-- === CLIMATE (emergency-level urgency) ===
CALL assertOpinion(1, 123, 9);   -- We must act on climate change quickly and forcefully
CALL assertOpinion(1, 321, 9);   -- Human influenced climate change is an observable fact
CALL assertOpinion(1, 414, 9);   -- We should ramp up renewable energy capacity ASAP
CALL assertOpinion(1, 476, 9);   -- Fossil fuels need to be left in the ground
CALL assertOpinion(1, 477, 9);   -- Fossil fuels are the greatest contributors to climate change
CALL assertOpinion(1, 863, 9);   -- Limiting climate change will require collective action
CALL assertOpinion(1, 892, 9);   -- To avoid climate catastrophe we must make average person's carbon output negative
CALL assertOpinion(1, 1296, 9);  -- We have added more CO2 since UN climate framework (1992) than in all millennia before
CALL assertOpinion(1, 1298, 9);  -- We are on pace for 3-4C of warming by end of century
CALL assertOpinion(1, 1300, 9);  -- Further delay or half-measures will only result in more costly action later
CALL assertOpinion(1, 1523, 9);  -- We must electrify everything
CALL assertOpinion(-1, 230, 9);  -- Climate change is a hoax
CALL assertOpinion(-1, 1275, 9); -- Climate has been changing throughout earth's history (as deflection)
CALL assertOpinion(-1, 1276, 9); -- Recent changes little different from historical swings

-- === BODILY AUTONOMY / ABORTION ===
CALL assertOpinion(-1, 124, 9);  -- A fetus has a human soul whose life should be protected (rejects)
CALL assertOpinion(-1, 125, 9);  -- Woman should take responsibility for pregnancies rather than aborting (rejects)
CALL assertOpinion(1, 127, 9);   -- Can't advocate for fetus without opposing woman's bodily autonomy
CALL assertOpinion(1, 128, 9);   -- Limits on abortion access is cruel punishment
CALL assertOpinion(1, 129, 9);   -- Having a child should not be put upon someone like a punishment
CALL assertOpinion(1, 964, 9);   -- Contraception and abortion are necessary to modern civilization
CALL assertOpinion(1, 975, 9);   -- Goal of pro-life movement is to penalize and shame young women
CALL assertOpinion(1, 977, 9);   -- 'Pro-Life' is a misnomer
CALL assertOpinion(1, 998, 9);   -- The pro-life movement is inherently misogynistic

-- === POLICE REFORM (not abolition) ===
CALL assertOpinion(1, 145, 9);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 9);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 153, 9);   -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 9);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 217, 9);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 539, 9);   -- Qualified immunity unjustly shields police
CALL assertOpinion(1, 1498, 9);  -- Qualified immunity for police must end
CALL assertOpinion(-1, 107, 9);  -- Defund police departments (she supports reform, not defunding)
CALL assertOpinion(-1, 561, 9);  -- Back the blue (rejects uncritical framing)

-- === HEALTHCARE ===
CALL assertOpinion(1, 895, 9);   -- US must reform its healthcare system
CALL assertOpinion(1, 896, 9);   -- US healthcare system has terrible health outcomes
CALL assertOpinion(1, 897, 9);   -- US healthcare system is most expensive in the world
CALL assertOpinion(1, 898, 9);   -- US healthcare system is inequitable
CALL assertOpinion(1, 901, 9);   -- US should implement universal single-payer like Medicare for All
CALL assertOpinion(1, 958, 9);   -- Basic healthcare is a fundamental human right
CALL assertOpinion(-1, 910, 9);  -- Govt control of healthcare = bureaucratic, inefficient (rejects)
CALL assertOpinion(-1, 911, 9);  -- Private enterprise must control healthcare (rejects)

-- === RANKED CHOICE VOTING ===
CALL assertOpinion(1, 696, 9);   -- We should support efforts to move to ranked choice voting
CALL assertOpinion(1, 698, 9);   -- Ranked-choice voting would eliminate wasted votes
CALL assertOpinion(1, 699, 9);   -- Ranked-choice voting increases diversity of candidates
CALL assertOpinion(1, 701, 9);   -- Ranked-choice voting reduces negativity in campaigns
CALL assertOpinion(1, 702, 9);   -- Ranked-choice voting can eliminate need for primaries
CALL assertOpinion(-1, 700, 9);  -- Ranked-choice voting is too confusing for average voter (rejects)

-- === WORKERS' RIGHTS ===
CALL assertOpinion(1, 494, 9);   -- Workers should unionize
CALL assertOpinion(1, 495, 9);   -- Collective bargaining helps workers win greater pay and benefits
CALL assertOpinion(1, 496, 9);   -- Biden administration should endorse Amazon workers unionize
CALL assertOpinion(1, 1200, 9);  -- Workers deserve some measure of leverage against management
CALL assertOpinion(1, 1201, 9);  -- A solitary worker is easily exploited by their employer

-- === GUNS (not absolutist) ===
CALL assertOpinion(-1, 140, 9);  -- 2A grants right to own whatever firearms I deem necessary
CALL assertOpinion(1, 141, 9);   -- There must be some limits on the firepower citizens access
CALL assertOpinion(1, 1179, 9);  -- America needs gun reform now
CALL assertOpinion(1, 1180, 9);  -- America's problem with gun violence is exceptional compared to the world
CALL assertOpinion(-1, 1177, 9); -- AR-15 has legitimate use cases (she rejects this)

-- === CANCEL CULTURE (rejects the framing) ===
CALL assertOpinion(-1, 288, 9);  -- Cancel culture must be resisted (she rejects this framing)
CALL assertOpinion(1, 293, 9);   -- Cancel culture is merely criticism someone doesn't support
CALL assertOpinion(1, 294, 9);   -- Cancel culture is too vague a term to be useful
CALL assertOpinion(1, 295, 9);   -- Dismissing criticism as cancel culture risks chilling useful discussion
CALL assertOpinion(-1, 297, 9);  -- Cancel culture is effort to promote conformist liberal viewpoint (rejects)

-- === RACIAL JUSTICE ===
CALL assertOpinion(1, 103, 9);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 105, 9);   -- Police kill black people with impunity
CALL assertOpinion(1, 175, 9);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 484, 9);   -- We all have implicit bias
CALL assertOpinion(1, 485, 9);   -- Implicit bias training should be more common
CALL assertOpinion(-1, 101, 9);  -- Racism is made up

-- === ENDORSEMENTS: IRENE INGRAM (profileID=9) ===

-- Cluster 1: LGBTQ rights — trans inclusion in sports
-- Target: 797 (trans girls should be permitted in women's athletics same as any other girls)
-- Because: 315 (person doesn't choose gender) 40%, 316 (gender is innate) 35%, 790 (trans girls shouldn't be forced to play boys) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 9, 'Because', 315, 40.0, 1),
       (797, 9, 'Because', 316, 35.0, 1),
       (797, 9, 'Because', 790, 25.0, 1);

-- Target: 797 Therefore: 801 (leave trans kids out of culture war battles) 55%, 1312 (laws banning trans kids from sports are wrong) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 9, 'Therefore', 801, 55.0, 1),
       (797, 9, 'Therefore', 1312, 45.0, 1);

-- Cluster 2: Rebut gender essentialism
-- Target: 142 (there are only two genders) -- REJECTED
-- Rebuttal: 315 (person doesn't choose gender) 55%, 316 (gender is innate) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (142, 9, 'Rebuttal', 315, 55.0, 1),
       (142, 9, 'Rebuttal', 316, 45.0, 1);

-- Cluster 3: Climate emergency
-- Target: 123 (must act on climate quickly and forcefully)
-- Because: 321 (human influenced climate change observable fact) 35%, 1296 (more CO2 added since 1992 than all millennia before) 35%, 1298 (on pace for 3-4C) 30%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 9, 'Because', 321, 35.0, 1),
       (123, 9, 'Because', 1296, 35.0, 1),
       (123, 9, 'Because', 1298, 30.0, 1);

-- Target: 123 Therefore: 414 (ramp up renewable energy) 40%, 476 (fossil fuels must stay in ground) 35%, 863 (requires collective action) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 9, 'Therefore', 414, 40.0, 1),
       (123, 9, 'Therefore', 476, 35.0, 1),
       (123, 9, 'Therefore', 863, 25.0, 1);

-- Cluster 4: Bodily autonomy
-- Target: 127 (can't advocate for fetus without opposing woman's bodily autonomy)
-- Because: 128 (limits on abortion are cruel punishment) 55%, 129 (child shouldn't be punishment) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (127, 9, 'Because', 128, 55.0, 1),
       (127, 9, 'Because', 129, 45.0, 1);

-- Target: 127 Therefore: 964 (contraception and abortion necessary to modern civilization) 55%, 977 (pro-life is a misnomer) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (127, 9, 'Therefore', 964, 55.0, 1),
       (127, 9, 'Therefore', 977, 45.0, 1);

-- Cluster 5: Healthcare as human right
-- Target: 958 (basic healthcare is a fundamental human right)
-- Because: 896 (terrible outcomes) 40%, 897 (most expensive) 35%, 898 (inequitable) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (958, 9, 'Because', 896, 40.0, 1),
       (958, 9, 'Because', 897, 35.0, 1),
       (958, 9, 'Because', 898, 25.0, 1);

-- Target: 958 Therefore: 895 (must reform healthcare) 55%, 901 (Medicare for All) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (958, 9, 'Therefore', 895, 55.0, 1),
       (958, 9, 'Therefore', 901, 45.0, 1);

-- Cluster 6: Ranked choice voting
-- Target: 696 (should support ranked choice voting efforts)
-- Because: 698 (eliminates wasted votes) 40%, 699 (increases diversity of candidates) 35%, 701 (reduces negativity) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (696, 9, 'Because', 698, 40.0, 1),
       (696, 9, 'Because', 699, 35.0, 1),
       (696, 9, 'Because', 701, 25.0, 1);

-- Target: 696 Therefore: 702 (can eliminate need for primaries) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (696, 9, 'Therefore', 702, 100.0, 1);

-- Cluster 7: Workers' rights
-- Target: 494 (workers should unionize)
-- Because: 1200 (workers deserve leverage against management) 55%, 1201 (solitary worker easily exploited) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 9, 'Because', 1200, 55.0, 1),
       (494, 9, 'Because', 1201, 45.0, 1);

-- Target: 494 Therefore: 495 (collective bargaining helps workers win greater pay) 55%, 496 (Biden admin should support Amazon union) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 9, 'Therefore', 495, 55.0, 1),
       (494, 9, 'Therefore', 496, 45.0, 1);

-- Cluster 8: Rebut anti-climate stall tactics
-- Target: 1275 (climate has been changing throughout earth's history — used as deflection) -- REJECTED
-- Rebuttal: 321 (human influenced climate change is observable fact) 55%, 1296 (more CO2 added since 1992 than all millennia before) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1275, 9, 'Rebuttal', 321, 55.0, 1),
       (1275, 9, 'Rebuttal', 1296, 45.0, 1);

-- Cluster 9: Rebut cancel culture framing
-- Target: 288 (cancel culture must be resisted) -- REJECTED
-- Rebuttal: 293 (merely criticism someone doesn't support) 55%, 295 (dismissing as cancel culture chills discussion) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 9, 'Rebuttal', 293, 55.0, 1),
       (288, 9, 'Rebuttal', 295, 45.0, 1);

-- Cluster 10: Implicit bias
-- Target: 484 (we all have implicit bias)
-- Because: 175 (inherent racial bias has far-reaching effects) 55%, 103 (disproportionate convictions) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (484, 9, 'Because', 175, 55.0, 1),
       (484, 9, 'Because', 103, 45.0, 1);

-- Target: 484 Therefore: 485 (implicit bias training should be more common) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (484, 9, 'Therefore', 485, 100.0, 1);


-- ============================================================
-- PROFILE 10: JAMES JENNINGS
-- 55yo disabled White former coal miner, rural WV, black lung disease
-- MAGA. Deeply resentful of Democrats for coal's decline.
-- 2nd Amendment sacred. Anti-immigration. Christian traditional values.
-- Trusts Trump, Fox, OANN. 2020 election stolen.
-- Hardcoded: Democrats killed coal; 2A sacred; immigration is threat;
--            Black Lung benefits EARNED not welfare; 2020 stolen
-- ============================================================

-- === TRUMP / POLITICS ===
CALL assertOpinion(1, 80, 10);   -- Trump 2024
CALL assertOpinion(1, 120, 10);  -- Trump puts America first
CALL assertOpinion(-1, 90, 10);  -- The GOP agenda is bad for America (rejects strongly)
CALL assertOpinion(-1, 94, 10);  -- Do not vote for a Republican until major reforms
CALL assertOpinion(-1, 104, 10); -- Vote for Democrats
CALL assertOpinion(-1, 88, 10);  -- Trump not intellectually curious to a stunning degree
CALL assertOpinion(-1, 89, 10);  -- Trump tacitly endorses racism
CALL assertOpinion(1, 229, 10);  -- GOP's main goal is to keep government out of our business
CALL assertOpinion(-1, 383, 10); -- The GOP is mostly interested in concentrating its own power (he pushes back on this)

-- === GUNS (2A is sacred — absolute) ===
CALL assertOpinion(1, 140, 10);  -- 2A grants right to own whatever firearms I deem necessary
CALL assertOpinion(1, 226, 10);  -- Freedom should never be infringed
CALL assertOpinion(1, 328, 10);  -- We should defend the second amendment
CALL assertOpinion(1, 324, 10);  -- It is our right not to rely fully on government for our own protection
CALL assertOpinion(1, 326, 10);  -- Spirit of 2A is to preserve right to protect ourselves without aid of government
CALL assertOpinion(1, 327, 10);  -- Spirit of 2A is to preserve right to defend against threat our own government may pose
CALL assertOpinion(1, 460, 10);  -- People shouldn't be restricted from responsibly owning guns
CALL assertOpinion(1, 461, 10);  -- Handgun bans are unconstitutional
CALL assertOpinion(1, 1172, 10); -- Any regulation of weapons must be in keeping with 2A
CALL assertOpinion(1, 1177, 10); -- AR-15 has legitimate use cases just like any other tool
CALL assertOpinion(1, 1178, 10); -- Only I can decide what gun I should or should not own
CALL assertOpinion(-1, 329, 10); -- There is a certain degree of firepower that should be banned (rejects)
CALL assertOpinion(-1, 331, 10); -- Gun laws limiting ownership are constitutional (rejects)
CALL assertOpinion(-1, 333, 10); -- Assault weapons should be banned for non-military purposes (rejects)
CALL assertOpinion(-1, 1179, 10); -- America needs gun reform now (rejects)
CALL assertOpinion(-1, 1181, 10); -- Gun ownership in America should be strictly limited (rejects)
CALL assertOpinion(-1, 462, 10);  -- Society is better off without guns (rejects)

-- === IMMIGRATION (threat framing) ===
CALL assertOpinion(-1, 611, 10); -- Open borders are a worthy ideal (strongly rejects)
CALL assertOpinion(-1, 615, 10); -- There should always be a reasonable path to citizenship (skeptical)
CALL assertOpinion(-1, 616, 10); -- Asylum should be granted to all who seek it (rejects)
CALL assertOpinion(-1, 617, 10); -- Family separation at southern border is an atrocity (rejects)
CALL assertOpinion(1, 618, 10);  -- Parents illegally crossing with children deserve to be separated
CALL assertOpinion(1, 1237, 10); -- Migrants crossing border should be treated as enemy invaders
CALL assertOpinion(-1, 1159, 10); -- Immigrants are not dangerous (rejects)
CALL assertOpinion(-1, 1160, 10); -- Immigrants boost the economy (rejects)
CALL assertOpinion(-1, 972, 10);  -- GOP is anti-immigrant (rejects; he sees it as pro-security)

-- === POLICING / BLM (back the blue, anti-BLM) ===
CALL assertOpinion(1, 561, 10);  -- Back the blue
CALL assertOpinion(1, 1410, 10); -- Safety of police officers should be top priority
CALL assertOpinion(1, 777, 10);  -- Criminals forfeit their rights when they choose a life of crime
CALL assertOpinion(-1, 107, 10); -- Defund police departments
CALL assertOpinion(-1, 145, 10); -- Policing in America must be reformed (rejects this framing)
CALL assertOpinion(-1, 560, 10); -- Police should be abolished
CALL assertOpinion(1, 349, 10);  -- BLM movement is racist
CALL assertOpinion(1, 350, 10);  -- BLM aims to diminish white people
CALL assertOpinion(1, 547, 10);  -- Black Lives Matter is violent
CALL assertOpinion(1, 548, 10);  -- BLM is in cahoots with Antifa
CALL assertOpinion(1, 549, 10);  -- Antifa are violent extremists
CALL assertOpinion(1, 554, 10);  -- We need to crack down on Antifa
CALL assertOpinion(1, 555, 10);  -- We need to crack down on BLM activists
CALL assertOpinion(-1, 546, 10); -- BLM movement activists deserve support (rejects)
CALL assertOpinion(-1, 1202, 10); -- BLM protests have by and large been peaceful (rejects)

-- === CANCEL CULTURE (strong defender of traditional culture) ===
CALL assertOpinion(1, 288, 10);  -- Cancel culture must be resisted
CALL assertOpinion(1, 291, 10);  -- People should not be fired for their political views
CALL assertOpinion(1, 297, 10);  -- Cancel culture is effort to promote conformist liberal viewpoint
CALL assertOpinion(1, 600, 10);  -- The Left only interested in freedom when expressing ideas they like
CALL assertOpinion(1, 651, 10);  -- Dr. Seuss books are another victim of social justice warriors
CALL assertOpinion(1, 652, 10);  -- Six Dr. Seuss books being banned is tantamount to digital book burning
CALL assertOpinion(1, 658, 10);  -- Social Justice Warriors threaten to damage reputation of businesses
CALL assertOpinion(1, 659, 10);  -- SJWs are bad
CALL assertOpinion(1, 1562, 10); -- Woke nonsense is ruining everything

-- === FAITH / CHRISTIAN VALUES ===
CALL assertOpinion(1, 130, 10);  -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 10);  -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 10);  -- The faithful believe in His glory unconditionally
CALL assertOpinion(1, 1385, 10); -- Jesus is my Lord and Savior!
CALL assertOpinion(1, 1386, 10); -- Jesus is God's only son
CALL assertOpinion(1, 1440, 10); -- The Bible is the word of God
CALL assertOpinion(-1, 161, 10); -- For all intents there is no such thing as a god

-- === CLIMATE (rejects urgency, denies problem) ===
CALL assertOpinion(-1, 123, 10); -- We must act on climate change quickly and forcefully
CALL assertOpinion(-1, 414, 10); -- We should ramp up renewable energy ASAP
CALL assertOpinion(-1, 476, 10); -- Fossil fuels need to be left in the ground (his livelihood)
CALL assertOpinion(1, 230, 10);  -- Climate change is a hoax
CALL assertOpinion(1, 1275, 10); -- The climate has been changing throughout earth's history
CALL assertOpinion(1, 1276, 10); -- Recent changes little different from historical swings

-- === ECONOMY / GOVT ===
CALL assertOpinion(1, 134, 10);  -- We shouldn't punish success
CALL assertOpinion(1, 400, 10);  -- Government should stay out of the way
CALL assertOpinion(1, 412, 10);  -- Government is inherently inefficient
CALL assertOpinion(-1, 609, 10); -- US govt should implement universal basic income (welfare)
CALL assertOpinion(1, 266, 10);  -- A government check is unearned, other people's money
CALL assertOpinion(1, 267, 10);  -- Means-testing avoids wasting government resources
-- Note: He views his Black Lung benefits as EARNED compensation, not welfare

-- === RACE / WHITE IDENTITY ===
CALL assertOpinion(1, 1229, 10); -- It is perfectly okay to be white
CALL assertOpinion(1, 1197, 10); -- In today's culture, white people are the ones most commonly persecuted
CALL assertOpinion(-1, 175, 10); -- Inherent racial bias has far-reaching effects (rejects)
CALL assertOpinion(-1, 484, 10); -- We all have implicit bias (rejects)
CALL assertOpinion(-1, 485, 10); -- Implicit bias training should be more common (rejects)
CALL assertOpinion(-1, 1345, 10); -- Curriculums should be adjusted to combat white supremacy (strongly rejects)
CALL assertOpinion(-1, 1347, 10); -- Kids should be taught white supremacy prevents BIPOC achievement (rejects)

-- === ENDORSEMENTS: JAMES JENNINGS (profileID=10) ===

-- Cluster 1: 2A is sacred
-- Target: 328 (we should defend the second amendment)
-- Because: 140 (2A grants right) 40%, 226 (freedom never infringed) 35%, 327 (right to defend against own govt) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (328, 10, 'Because', 140, 40.0, 1),
       (328, 10, 'Because', 226, 35.0, 1),
       (328, 10, 'Because', 327, 25.0, 1);

-- Target: 328 Therefore: 1178 (only I decide my gun) 40%, 1172 (regulation must follow 2A) 35%, 460 (don't restrict responsible owners) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (328, 10, 'Therefore', 1178, 40.0, 1),
       (328, 10, 'Therefore', 1172, 35.0, 1),
       (328, 10, 'Therefore', 460, 25.0, 1);

-- Cluster 2: Rebut gun reform
-- Target: 1179 (America needs gun reform now) -- REJECTED
-- Rebuttal: 140 (2A grants right) 55%, 1178 (only I decide) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1179, 10, 'Rebuttal', 140, 55.0, 1),
       (1179, 10, 'Rebuttal', 1178, 45.0, 1);

-- Cluster 3: Rebut assault weapon ban
-- Target: 333 (assault weapons should be banned) -- REJECTED
-- Rebuttal: 1177 (AR-15 has legitimate use cases) 55%, 140 (2A grants right) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (333, 10, 'Rebuttal', 1177, 55.0, 1),
       (333, 10, 'Rebuttal', 140, 45.0, 1);

-- Cluster 4: Back the blue
-- Target: 561 (back the blue)
-- Because: 1410 (safety of officers top priority) 55%, 777 (criminals forfeit rights) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 10, 'Because', 1410, 55.0, 1),
       (561, 10, 'Because', 777, 45.0, 1);

-- Target: 561 Therefore: 554 (crack down on Antifa) 50%, 555 (crack down on BLM activists) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 10, 'Therefore', 554, 50.0, 1),
       (561, 10, 'Therefore', 555, 50.0, 1);

-- Cluster 5: BLM is violent and racist
-- Target: 349 (BLM movement is racist)
-- Because: 547 (BLM is violent) 40%, 548 (in cahoots with Antifa) 35%, 350 (aims to diminish white people) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (349, 10, 'Because', 547, 40.0, 1),
       (349, 10, 'Because', 548, 35.0, 1),
       (349, 10, 'Because', 350, 25.0, 1);

-- Target: 349 Therefore: 555 (crack down on BLM activists) 55%, 554 (crack down on Antifa) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (349, 10, 'Therefore', 555, 55.0, 1),
       (349, 10, 'Therefore', 554, 45.0, 1);

-- Cluster 6: Rebut policing reform
-- Target: 145 (policing must be reformed) -- REJECTED (James sees this as attacking police)
-- Rebuttal: 561 (back the blue) 55%, 1410 (officer safety top priority) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 10, 'Rebuttal', 561, 55.0, 1),
       (145, 10, 'Rebuttal', 1410, 45.0, 1);

-- Cluster 7: Climate change is a hoax
-- Target: 230 (climate change is a hoax)
-- Because: 1275 (climate has been changing throughout earth's history) 55%, 1276 (recent changes not unusual) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (230, 10, 'Because', 1275, 55.0, 1),
       (230, 10, 'Because', 1276, 45.0, 1);

-- Target: 123 (act on climate quickly) -- REJECTED
-- Rebuttal: 230 (climate change is a hoax) 55%, 1275 (climate always changing) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 10, 'Rebuttal', 230, 55.0, 1),
       (123, 10, 'Rebuttal', 1275, 45.0, 1);

-- Cluster 8: Cancel culture must be resisted
-- Target: 288 (cancel culture must be resisted)
-- Because: 291 (people shouldn't be fired for political views) 40%, 297 (conformist liberal viewpoint) 35%, 600 (Left only values own expression) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 10, 'Because', 291, 40.0, 1),
       (288, 10, 'Because', 297, 35.0, 1),
       (288, 10, 'Because', 600, 25.0, 1);

-- Target: 288 Therefore: 651 (Dr. Seuss victim of SJWs) 50%, 659 (SJWs are bad) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 10, 'Therefore', 651, 50.0, 1),
       (288, 10, 'Therefore', 659, 50.0, 1);

-- Cluster 9: Faith is anchor
-- Target: 428 (those with faith can feel God's presence)
-- Because: 130 (can't be certain God doesn't exist) 55%, 844 (believe in His glory unconditionally) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (428, 10, 'Because', 130, 55.0, 1),
       (428, 10, 'Because', 844, 45.0, 1);

-- Target: 428 Therefore: 1385 (Jesus is my Lord and Savior) 55%, 1440 (the Bible is the word of God) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (428, 10, 'Therefore', 1385, 55.0, 1),
       (428, 10, 'Therefore', 1440, 45.0, 1);

-- Cluster 10: Immigration is a threat
-- Target: 1237 (migrants crossing border should be treated as enemy invaders)
-- Because: 618 (parents illegally crossing with children deserve separation) 55%, 777 (criminals forfeit rights) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1237, 10, 'Because', 618, 55.0, 1),
       (1237, 10, 'Because', 777, 45.0, 1);

-- Target: 616 (asylum should be granted to all) -- REJECTED
-- Rebuttal: 1237 (treat as enemy invaders) 55%, 618 (deserve separation) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (616, 10, 'Rebuttal', 1237, 55.0, 1),
       (616, 10, 'Rebuttal', 618, 45.0, 1);

-- Cluster 11: Trump 2024
-- Target: 80 (Trump 2024)
-- Because: 120 (Trump puts America first) 55%, 229 (GOP keeps govt out of business) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (80, 10, 'Because', 120, 55.0, 1),
       (80, 10, 'Because', 229, 45.0, 1);
