-- personas_2_5_seed.sql
-- Opinion and endorsement population for profileIDs 2-5
-- Brianna Barnes (2), Carlos Castillo (3), Diana Delgado (4), Eleanor Evans (5)
--
-- Weights within every (targArgID, profileID, endorseType) group sum to EXACTLY 100.0
-- assertOpinion(op, argID, proID): op=1 accept, op=-1 reject; uses IF NOT EXISTS semantics
-- Skipped pre-existing args per spec:
--   profileID=2: args 1-51, 66-80
--   profileID=3: args 1-48
--   profileID=4: args 1-48, 83
--   profileID=5: args 1-48

USE vestigette;

-- ============================================================
-- PROFILE 2: BRIANNA BARNES
-- 34yo Black woman, suburban Atlanta GA, healthcare administrator
-- ideology_score: -7 (strong progressive)
-- AME churchgoer, social-gospel faith, anti-racism as structural
-- Key: healthcare access + racial disparities, education, CJ reform
--      (reform NOT abolition — does NOT support defunding/abolishing police)
-- Trusts: Church, HBCU networks, Black-owned media, Michelle Obama
-- Distrusts: GOP, health insurance companies; complex re: police
-- ============================================================

-- === RACISM / RACIAL JUSTICE ===
CALL assertOpinion(1, 100, 2);   -- No system can be completely fair
CALL assertOpinion(-1, 101, 2);  -- Racism is made up
CALL assertOpinion(1, 103, 2);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 105, 2);   -- Police kill black people with impunity
CALL assertOpinion(-1, 108, 2);  -- Black people just commit more crime
CALL assertOpinion(1, 109, 2);   -- Empower black people
CALL assertOpinion(-1, 118, 2);  -- Black people are inherently less civil
CALL assertOpinion(1, 169, 2);   -- Non-white males statistically paid less per dollar
CALL assertOpinion(1, 175, 2);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 207, 2);   -- Black people stopped for looking suspicious far more often
CALL assertOpinion(1, 221, 2);   -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(1, 236, 2);   -- Black Americans are right to feel wronged by society
CALL assertOpinion(1, 240, 2);   -- Equality of any group treated as less than human is a priority
CALL assertOpinion(1, 241, 2);   -- Giving Black Americans the power they deserve should be a priority
CALL assertOpinion(1, 484, 2);   -- We all have implicit bias
CALL assertOpinion(1, 485, 2);   -- Implicit bias training should be more common
CALL assertOpinion(-1, 1197, 2); -- White people most commonly persecuted in today's culture
CALL assertOpinion(-1, 1229, 2); -- It is perfectly okay to be white (rejects it as dismissive framing)

-- === CRIMINAL JUSTICE ===
CALL assertOpinion(1, 111, 2);   -- End cash bail
CALL assertOpinion(1, 112, 2);   -- Implicit bias skews sentencing
CALL assertOpinion(1, 113, 2);   -- Conditions outside Black Americans' control increase crime likelihood
CALL assertOpinion(1, 115, 2);   -- Cash bail criminalizes poverty
CALL assertOpinion(1, 116, 2);   -- Cash bail perpetuates inequities felt by communities of color
CALL assertOpinion(1, 171, 2);   -- Criminal justice system major contributor to racial inequality
CALL assertOpinion(-1, 170, 2);  -- CJ system should not adjust to correct for societal inequalities
CALL assertOpinion(-1, 173, 2);  -- CJ system should not be focus of reform for racial equality
CALL assertOpinion(1, 174, 2);   -- CJ system prejudiced; not accounting for disparities is being blind
CALL assertOpinion(1, 222, 2);   -- CJ inequities are part and parcel of American societal inequities
CALL assertOpinion(1, 223, 2);   -- Preventing racial inequality in justice system should be priority

-- === POLICING (Reform YES, Defund/Abolish NO) ===
CALL assertOpinion(1, 145, 2);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 2);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 151, 2);   -- Police unions too powerful and uphold racist structures
CALL assertOpinion(1, 153, 2);   -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 2);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 155, 2);   -- Police procedures and policies are effectively racist too often
CALL assertOpinion(-1, 107, 2);  -- Defund police departments (Brianna opposes this)
CALL assertOpinion(-1, 560, 2);  -- Police should be abolished (Brianna opposes this)
CALL assertOpinion(1, 163, 2);   -- More policing does not get to root of problem causing crime
CALL assertOpinion(1, 165, 2);   -- Police oversight should be reformed (not policing itself) -- she accepts this too
CALL assertOpinion(1, 217, 2);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 218, 2);   -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 2);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 2);   -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(1, 603, 2);   -- Cities with significant BLM protests had reduction in police homicides
CALL assertOpinion(-1, 561, 2);  -- Back the blue (she rejects this as uncritical)
CALL assertOpinion(-1, 166, 2);  -- Policing doesn't need to be changed, only oversight (too narrow for her)
CALL assertOpinion(1, 1188, 2);  -- Routine traffic stops extremely dangerous for black and brown people
CALL assertOpinion(-1, 1410, 2); -- Safety of police officers should be top priority (framing she rejects)

-- === BLM ===
CALL assertOpinion(1, 1202, 2);  -- BLM protests have by and large been peaceful
CALL assertOpinion(1, 1313, 2);  -- BLM is simply about Black Americans not living in fear
CALL assertOpinion(1, 1314, 2);  -- Black Americans' fear of police is completely legitimate
CALL assertOpinion(1, 1321, 2);  -- BLM makes the clear point that Black people's lives are undervalued
CALL assertOpinion(1, 546, 2);   -- BLM movement activists deserve support
CALL assertOpinion(-1, 349, 2);  -- BLM movement is racist
CALL assertOpinion(-1, 350, 2);  -- BLM aims to diminish white people
CALL assertOpinion(-1, 1319, 2); -- All Lives Matter (she rejects this framing)
CALL assertOpinion(-1, 1320, 2); -- BLM is suggesting Black people are more important than others

-- === HEALTHCARE ===
CALL assertOpinion(1, 894, 2);   -- Government should optimize the healthcare system
CALL assertOpinion(1, 895, 2);   -- US must reform its healthcare system
CALL assertOpinion(1, 896, 2);   -- US healthcare system has terrible health outcomes
CALL assertOpinion(1, 897, 2);   -- US healthcare system is most expensive in the world
CALL assertOpinion(1, 898, 2);   -- US healthcare system is inequitable
CALL assertOpinion(1, 901, 2);   -- US should implement universal single-payer like Medicare for All
CALL assertOpinion(1, 958, 2);   -- Basic healthcare is a fundamental human right
CALL assertOpinion(-1, 910, 2);  -- Government control of healthcare creates bureaucratic inefficient system

-- === EDUCATION / CURRICULUM ===
CALL assertOpinion(1, 1345, 2);  -- Curriculums should be reviewed and adjusted to combat white supremacy
CALL assertOpinion(-1, 1346, 2); -- Kids should be taught white people are racist (too blunt/counterproductive)
CALL assertOpinion(1, 1347, 2);  -- Kids should be taught white supremacy prevents BIPOC achievement
CALL assertOpinion(1, 1351, 2);  -- Kids should be taught the existence of white supremacy in the US

-- === VOTING RIGHTS ===
CALL assertOpinion(1, 182, 2);   -- Right of every citizen to vote is unassailable principle
CALL assertOpinion(1, 184, 2);   -- Most historically exploited groups are also disenfranchised from vote
CALL assertOpinion(1, 355, 2);   -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 2);   -- We should have universal voter registration
CALL assertOpinion(1, 357, 2);   -- We should have universal vote-by-mail
CALL assertOpinion(1, 640, 2);   -- Congress must pass HR1 For The People Act
CALL assertOpinion(-1, 1365, 2); -- Georgia's voting law SB 202 is good policy
CALL assertOpinion(1, 1357, 2);  -- Georgia's election law SB 202 should be condemned
CALL assertOpinion(-1, 1366, 2); -- SB 202 expanded early voting (misleading framing she rejects)
CALL assertOpinion(1, 1380, 2);  -- SB 202 was predicated on the lie of fraud in 2020 election

-- === POLITICS / TRUMP ===
CALL assertOpinion(-1, 80, 2);   -- Trump 2024
CALL assertOpinion(1, 88, 2);    -- Trump is not intellectually curious to a stunning degree
CALL assertOpinion(1, 89, 2);    -- Trump tacitly endorses racism
CALL assertOpinion(1, 90, 2);    -- The GOP agenda is bad for America
CALL assertOpinion(1, 94, 2);    -- Do not vote for a Republican until major reforms
CALL assertOpinion(1, 96, 2);    -- Trump's singular concern is himself
CALL assertOpinion(1, 104, 2);   -- Vote for Democrats
CALL assertOpinion(-1, 120, 2);  -- Trump puts America first
CALL assertOpinion(-1, 574, 2);  -- American Democratic Party is terrible
CALL assertOpinion(1, 972, 2);   -- The GOP is anti-immigrant

-- === FAITH ===
CALL assertOpinion(1, 428, 2);   -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 2);   -- The faithful believe in His glory unconditionally
CALL assertOpinion(-1, 161, 2);  -- For all intents there is no such thing as a god

-- === WEALTH / ECONOMY ===
CALL assertOpinion(1, 110, 2);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 185, 2);   -- A wealth tax would reduce resentment
CALL assertOpinion(1, 192, 2);   -- Wealth taxes should control offensive levels of wealth
CALL assertOpinion(1, 203, 2);   -- Happiness maximized in a more equitable world
CALL assertOpinion(1, 745, 2);   -- Wealthy should take greater proportion of tax burden
CALL assertOpinion(-1, 193, 2);  -- No such thing as too much wealth concentration

-- === ENDORSEMENTS: BRIANNA BARNES (profileID=2) ===
-- Only args she accepted can be used as supportingArgID for Because/Therefore
-- Only args she accepted can counter rejected args in Rebuttal

-- Cluster 1: Police accountability
-- Target: 217 (Police not held accountable)
-- Because: 219 (qualified immunity) 55%, 539 (immunity unjust) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 2, 'Because', 219, 55.0, 1),
       (217, 2, 'Because', 539, 45.0, 1);

-- Target: 217 Therefore: 145 (policing must be reformed) 55%, 148 (de-escalation required) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 2, 'Therefore', 145, 55.0, 1),
       (217, 2, 'Therefore', 148, 45.0, 1);

-- Cluster 2: Why policing must be reformed
-- Target: 145 (policing must be reformed)
-- Because: 155 (policies effectively racist) 40%, 218 (police see Black people as threat) 35%, 207 (stops while Black) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 2, 'Because', 155, 40.0, 1),
       (145, 2, 'Because', 218, 35.0, 1),
       (145, 2, 'Because', 207, 25.0, 1);

-- Target: 145 Therefore: 148 (de-escalation) 55%, 153 (exhaust options before shooting) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 2, 'Therefore', 148, 55.0, 1),
       (145, 2, 'Therefore', 153, 45.0, 1);

-- Cluster 3: Cash bail
-- Target: 111 (end cash bail)
-- Because: 115 (criminalizes poverty) 55%, 116 (perpetuates racial inequities) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (111, 2, 'Because', 115, 55.0, 1),
       (111, 2, 'Because', 116, 45.0, 1);

-- Target: 111 Therefore: 222 (CJ inequities part of broader societal inequities) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (111, 2, 'Therefore', 222, 100.0, 1);

-- Cluster 4: Racial bias in criminal justice
-- Target: 174 (CJ system prejudiced; not accounting is being blind)
-- Because: 112 (implicit bias skews sentencing) 40%, 103 (Black people convicted at disproportionate rate) 35%, 113 (conditions outside control) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (174, 2, 'Because', 112, 40.0, 1),
       (174, 2, 'Because', 103, 35.0, 1),
       (174, 2, 'Because', 113, 25.0, 1);

-- Target: 174 Therefore: 223 (preventing racial inequality in justice should be priority) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (174, 2, 'Therefore', 223, 100.0, 1);

-- Cluster 5: Healthcare as human right
-- Target: 958 (basic healthcare is fundamental human right)
-- Because: 896 (terrible outcomes) 40%, 897 (most expensive) 35%, 898 (inequitable) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (958, 2, 'Because', 896, 40.0, 1),
       (958, 2, 'Because', 897, 35.0, 1),
       (958, 2, 'Because', 898, 25.0, 1);

-- Target: 958 Therefore: 895 (must reform healthcare) 55%, 901 (Medicare for All) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (958, 2, 'Therefore', 895, 55.0, 1),
       (958, 2, 'Therefore', 901, 45.0, 1);

-- Cluster 6: Voting rights
-- Target: 355 (voting rights expanded and protected)
-- Because: 182 (unassailable right) 55%, 184 (historically exploited groups disenfranchised) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 2, 'Because', 182, 55.0, 1),
       (355, 2, 'Because', 184, 45.0, 1);

-- Target: 355 Therefore: 356 (universal registration) 50%, 357 (universal vote-by-mail) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 2, 'Therefore', 356, 50.0, 1),
       (355, 2, 'Therefore', 357, 50.0, 1);

-- Cluster 7: Rebut SB 202 framing
-- Target: 1365 (SB 202 is good policy) -- REJECTED by Brianna
-- Rebuttal: 1357 (SB 202 should be condemned) 55%, 1380 (predicated on fraud lie) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1365, 2, 'Rebuttal', 1357, 55.0, 1),
       (1365, 2, 'Rebuttal', 1380, 45.0, 1);

-- Cluster 8: BLM is legitimate
-- Target: 546 (BLM activists deserve support)
-- Because: 1313 (simply about not living in fear) 40%, 1314 (fear is legitimate) 35%, 1202 (protests mostly peaceful) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 2, 'Because', 1313, 40.0, 1),
       (546, 2, 'Because', 1314, 35.0, 1),
       (546, 2, 'Because', 1202, 25.0, 1);

-- Target: 546 Therefore: 1321 (BLM makes clear point about undervalued lives) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 2, 'Therefore', 1321, 100.0, 1);

-- Cluster 9: Rebut "BLM is racist"
-- Target: 349 (BLM is racist) -- REJECTED
-- Rebuttal: 1313 (simply about not living in fear) 55%, 546 (activists deserve support) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (349, 2, 'Rebuttal', 1313, 55.0, 1),
       (349, 2, 'Rebuttal', 546, 45.0, 1);

-- Cluster 10: Rebut defund police
-- Target: 107 (defund police) -- REJECTED by Brianna (she wants reform, not defund)
-- Rebuttal: 145 (reform policing) 55%, 165 (oversight reform, not abolition) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 2, 'Rebuttal', 145, 55.0, 1),
       (107, 2, 'Rebuttal', 165, 45.0, 1);

-- Cluster 11: Structural racism
-- Target: 175 (inherent racial bias has far-reaching effects)
-- Because: 484 (we all have implicit bias) 55%, 221 (power structures maintaining white supremacy) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (175, 2, 'Because', 484, 55.0, 1),
       (175, 2, 'Because', 221, 45.0, 1);

-- Target: 175 Therefore: 485 (implicit bias training should be more common) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (175, 2, 'Therefore', 485, 100.0, 1);

-- Cluster 12: Rebut "racism is made up"
-- Target: 101 (racism is made up) -- REJECTED
-- Rebuttal: 175 (inherent racial bias has far-reaching effects) 40%, 207 (stopped while Black) 35%, 103 (disproportionate convictions) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (101, 2, 'Rebuttal', 175, 40.0, 1),
       (101, 2, 'Rebuttal', 207, 35.0, 1),
       (101, 2, 'Rebuttal', 103, 25.0, 1);

-- Cluster 13: Trump racism
-- Target: 89 (Trump tacitly endorses racism)
-- Because: 90 (GOP agenda bad for America) 55%, 96 (Trump's singular concern is himself) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (89, 2, 'Because', 90, 55.0, 1),
       (89, 2, 'Because', 96, 45.0, 1);

-- Target: 89 Therefore: 94 (do not vote Republican) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (89, 2, 'Therefore', 94, 100.0, 1);

-- Cluster 14: Wealth inequality
-- Target: 110 (wealth inequality beyond acceptable)
-- Because: 203 (happiness maximized in equitable world) 55%, 185 (wealth tax reduces resentment) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 2, 'Because', 203, 55.0, 1),
       (110, 2, 'Because', 185, 45.0, 1);

-- Target: 110 Therefore: 192 (wealth taxes control offensive wealth) 55%, 745 (wealthy should pay more) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 2, 'Therefore', 192, 55.0, 1),
       (110, 2, 'Therefore', 745, 45.0, 1);


-- ============================================================
-- PROFILE 3: CARLOS CASTILLO
-- 41yo Hispanic (Mexican-American, 3rd gen), suburban San Antonio TX
-- Small HVAC business owner (4 employees), self-made, Catholic
-- ideology_score: 6 (moderately conservative)
-- Obama 2008/2012, skipped 2016, voted Trump 2020
-- Key issues: taxes/regs on small business (#1), immigration (legal process),
--   crime, school curriculum, inflation
-- Trusts: family, priest, other small biz owners, Joe Rogan, employees
-- Distrusts: federal regulators, politicians of both parties, mainstream media, unions
-- ============================================================

-- === TAXES / SMALL BUSINESS / ECONOMY ===
CALL assertOpinion(1, 52, 3);    -- No functional difference between govt giving money and not taxing that amount
CALL assertOpinion(-1, 54, 3);   -- A wealth tax is a critical tool toward societal harmony
CALL assertOpinion(1, 134, 3);   -- We shouldn't punish success
CALL assertOpinion(1, 135, 3);   -- Not allowing people to keep what they earned is criminal
CALL assertOpinion(1, 136, 3);   -- Capitalism is the best system we got
CALL assertOpinion(1, 201, 3);   -- Innovation should not be encumbered
CALL assertOpinion(-1, 203, 3);  -- Happiness maximized in more equitable world (he sees it differently)
CALL assertOpinion(1, 227, 3);   -- Low taxes fuel innovation
CALL assertOpinion(1, 228, 3);   -- Low taxes strengthen the economy
CALL assertOpinion(1, 265, 3);   -- A tax cut allows you to keep more of the money you duly earned
CALL assertOpinion(1, 266, 3);   -- A government check is unearned, other people's money
CALL assertOpinion(1, 267, 3);   -- Means testing avoids wasting government resources
CALL assertOpinion(1, 275, 3);   -- Government projects do not have profit motive for efficiency
CALL assertOpinion(1, 400, 3);   -- Government should stay out of the way
CALL assertOpinion(1, 401, 3);   -- Free markets do a better job than any government
CALL assertOpinion(1, 404, 3);   -- Constant vigilance needed to eliminate unnecessary regulations
CALL assertOpinion(1, 412, 3);   -- Government is inherently inefficient
CALL assertOpinion(1, 449, 3);   -- The US should implement a Flat Tax
CALL assertOpinion(1, 601, 3);   -- Welfare program should ask recipients to do their part
CALL assertOpinion(1, 607, 3);   -- If people are given handouts they will never learn to provide
CALL assertOpinion(1, 727, 3);   -- Unions often employ inflexible rules that impact enterprise's ability to adapt
CALL assertOpinion(1, 920, 3);   -- Government programs are ineffective
CALL assertOpinion(1, 1045, 3);  -- Regulation often imposes burdens far beyond risk-mitigating benefits
CALL assertOpinion(1, 1278, 3);  -- Ideal economy is capitalist
CALL assertOpinion(1, 1591, 3);  -- Socialism has failed every time it was tried
CALL assertOpinion(1, 1597, 3);  -- Socialism is bad
CALL assertOpinion(1, 1602, 3);  -- Means of production should largely be controlled privately
CALL assertOpinion(-1, 494, 3);  -- Workers should unionize
CALL assertOpinion(-1, 495, 3);  -- Collective bargaining helps workers win greater pay and benefits
CALL assertOpinion(-1, 609, 3);  -- US government should implement universal basic income
CALL assertOpinion(-1, 745, 3);  -- Wealthy should take on greater proportion of tax burden

-- === POLITICS ===
CALL assertOpinion(1, 120, 3);   -- Trump puts America first
CALL assertOpinion(-1, 90, 3);   -- The GOP agenda is bad for America
CALL assertOpinion(-1, 94, 3);   -- Do not vote for a Republican political candidate until major reforms
CALL assertOpinion(-1, 104, 3);  -- Vote for Democrats
CALL assertOpinion(1, 229, 3);   -- GOP's main goal is to keep govt out of our business
CALL assertOpinion(1, 322, 3);   -- We should never put our full faith in the government
CALL assertOpinion(1, 288, 3);   -- Cancel culture must be resisted
CALL assertOpinion(1, 291, 3);   -- People should not be fired for their political views
CALL assertOpinion(1, 296, 3);   -- Cancel culture is about power dynamics (he'd oppose both extremes)
CALL assertOpinion(1, 297, 3);   -- Cancel culture is effort to promote conformist liberal viewpoint
CALL assertOpinion(1, 600, 3);   -- The Left only interested in freedom when expressing their ideas
CALL assertOpinion(1, 1562, 3);  -- Woke nonsense is ruining everything
CALL assertOpinion(-1, 293, 3);  -- Cancel culture is merely criticism someone doesn't support

-- === IMMIGRATION (supports legal process, not extreme) ===
CALL assertOpinion(-1, 611, 3);  -- Open borders are a worthy ideal to pursue
CALL assertOpinion(-1, 616, 3);  -- Asylum should be granted to all those that seek it
CALL assertOpinion(1, 612, 3);   -- America should only allow the best of the best to become citizens
CALL assertOpinion(-1, 617, 3);  -- Family separation at the southern US border is an atrocity (he's conflicted; ultimately rejects the policy)
CALL assertOpinion(1, 1159, 3);  -- Immigrants are not dangerous (he knows this from family)
CALL assertOpinion(1, 1160, 3);  -- Immigrants boost the economy
CALL assertOpinion(-1, 1237, 3); -- Migrants crossing border should be treated as enemy invaders (too extreme)
CALL assertOpinion(-1, 972, 3);  -- The GOP is anti-immigrant (he pushes back on this)

-- === POLICING / CRIME ===
CALL assertOpinion(1, 561, 3);   -- Back the blue
CALL assertOpinion(1, 777, 3);   -- Criminals forfeit their rights when they choose a life of crime
CALL assertOpinion(-1, 107, 3);  -- Defund police departments
CALL assertOpinion(-1, 560, 3);  -- Police should be abolished
CALL assertOpinion(1, 1410, 3);  -- Safety of police officers should be top priority
CALL assertOpinion(1, 165, 3);   -- Police oversight should be reformed (not policing itself)
CALL assertOpinion(-1, 145, 3);  -- Policing in America must be reformed (he resists this framing)
CALL assertOpinion(-1, 151, 3);  -- Police unions too powerful and uphold racist structures (he's skeptical of this claim)
CALL assertOpinion(1, 554, 3);   -- We need to crack down on Antifa

-- === RACE / RACISM (nuanced — acknowledges experience but resists systemic framing) ===
CALL assertOpinion(-1, 101, 3);  -- Racism is made up (he's experienced it)
CALL assertOpinion(1, 100, 3);   -- No system can be completely fair
CALL assertOpinion(-1, 108, 3);  -- Black people just commit more crime
CALL assertOpinion(-1, 118, 3);  -- Black people are inherently less civil
CALL assertOpinion(-1, 1345, 3); -- Curriculums should be adjusted to combat white supremacy (he disagrees with framing)
CALL assertOpinion(-1, 1346, 3); -- Kids should be taught white people are racist
CALL assertOpinion(-1, 1347, 3); -- Kids should be taught white supremacy will prevent BIPOC achievement
CALL assertOpinion(1, 1229, 3);  -- It is perfectly okay to be white

-- === GUNS ===
CALL assertOpinion(1, 140, 3);   -- 2A grants right to own whatever firearms I deem necessary
CALL assertOpinion(1, 226, 3);   -- Freedom should never be infringed
CALL assertOpinion(1, 328, 3);   -- We should defend the second amendment
CALL assertOpinion(1, 460, 3);   -- People shouldn't be restricted from responsibly owning guns
CALL assertOpinion(1, 1172, 3);  -- Any regulation of weapons must be in keeping with 2A
CALL assertOpinion(1, 1177, 3);  -- AR-15 has legitimate use cases like any other tool
CALL assertOpinion(1, 1178, 3);  -- Only I can decide what gun I should or should not own
CALL assertOpinion(-1, 1179, 3); -- America needs gun reform now
CALL assertOpinion(-1, 1181, 3); -- Gun ownership in America should be strictly limited
CALL assertOpinion(-1, 462, 3);  -- Society is better off without guns

-- === GENDER ===
CALL assertOpinion(1, 142, 3);   -- There are only two genders
CALL assertOpinion(1, 785, 3);   -- Traditional gender roles exist for a reason
CALL assertOpinion(1, 791, 3);   -- Sports should be separated by biological sex
CALL assertOpinion(1, 849, 3);   -- First duty to your family as a parent is as a protector
CALL assertOpinion(-1, 795, 3);  -- Support trans women by not undermining their gender identity
CALL assertOpinion(-1, 797, 3);  -- Trans girls should be permitted in women's athletics same as any other girls
CALL assertOpinion(1, 801, 3);   -- Leave trans kids out of bullshit culture war battles (he actually agrees with this pragmatically)

-- === CLIMATE ===
CALL assertOpinion(1, 1275, 3);  -- The climate has been changing throughout earth's history
CALL assertOpinion(1, 1276, 3);  -- Recent temperature changes little different from historical swings
CALL assertOpinion(-1, 123, 3);  -- We must act on climate change quickly and forcefully
CALL assertOpinion(-1, 414, 3);  -- We should ramp up renewable energy capacity ASAP

-- === RELIGION ===
CALL assertOpinion(1, 428, 3);   -- Those that have faith can feel God's presence
CALL assertOpinion(-1, 161, 3);  -- For all intents there is no such thing as a god

-- === ENDORSEMENTS: CARLOS CASTILLO (profileID=3) ===

-- Cluster 1: Low taxes + small business
-- Target: 227 (low taxes fuel innovation)
-- Because: 265 (tax cut lets you keep earned money) 55%, 134 (shouldn't punish success) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (227, 3, 'Because', 265, 55.0, 1),
       (227, 3, 'Because', 134, 45.0, 1);

-- Target: 227 Therefore: 228 (low taxes strengthen economy) 55%, 201 (innovation not encumbered) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (227, 3, 'Therefore', 228, 55.0, 1),
       (227, 3, 'Therefore', 201, 45.0, 1);

-- Cluster 2: Government out of the way
-- Target: 400 (government should stay out of the way)
-- Because: 412 (govt inherently inefficient) 40%, 275 (no profit motive) 35%, 1045 (regs impose excessive burdens) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 3, 'Because', 412, 40.0, 1),
       (400, 3, 'Because', 275, 35.0, 1),
       (400, 3, 'Because', 1045, 25.0, 1);

-- Target: 400 Therefore: 401 (free markets do better) 55%, 404 (eliminate unnecessary regs) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 3, 'Therefore', 401, 55.0, 1),
       (400, 3, 'Therefore', 404, 45.0, 1);

-- Cluster 3: Capitalism vs socialism
-- Target: 1597 (socialism is bad)
-- Because: 1591 (failed every time) 55%, 1278 (ideal economy is capitalist) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1597, 3, 'Because', 1591, 55.0, 1),
       (1597, 3, 'Because', 1278, 45.0, 1);

-- Target: 1597 Therefore: 136 (capitalism is the best system) 55%, 1602 (means of production privately controlled) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1597, 3, 'Therefore', 136, 55.0, 1),
       (1597, 3, 'Therefore', 1602, 45.0, 1);

-- Cluster 4: Rebut unions
-- Target: 494 (workers should unionize) -- REJECTED
-- Rebuttal: 727 (unions use inflexible rules) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 3, 'Rebuttal', 727, 100.0, 1);

-- Cluster 5: 2A defense
-- Target: 328 (we should defend the second amendment)
-- Because: 140 (2A grants right) 55%, 226 (freedom never infringed) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (328, 3, 'Because', 140, 55.0, 1),
       (328, 3, 'Because', 226, 45.0, 1);

-- Target: 328 Therefore: 1178 (only I decide my gun) 40%, 1172 (regulation within 2A) 35%, 460 (don't restrict responsible owners) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (328, 3, 'Therefore', 1178, 40.0, 1),
       (328, 3, 'Therefore', 1172, 35.0, 1),
       (328, 3, 'Therefore', 460, 25.0, 1);

-- Cluster 6: Rebut gun control
-- Target: 1179 (America needs gun reform now) -- REJECTED
-- Rebuttal: 140 (2A grants right) 55%, 1178 (only I decide) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1179, 3, 'Rebuttal', 140, 55.0, 1),
       (1179, 3, 'Rebuttal', 1178, 45.0, 1);

-- Cluster 7: Back the blue
-- Target: 561 (back the blue)
-- Because: 1410 (safety of officers top priority) 55%, 777 (criminals forfeit rights) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 3, 'Because', 1410, 55.0, 1),
       (561, 3, 'Because', 777, 45.0, 1);

-- Target: 561 Therefore: 165 (oversight reform, not defunding) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 3, 'Therefore', 165, 100.0, 1);

-- Cluster 8: Cancel culture
-- Target: 288 (cancel culture must be resisted)
-- Because: 291 (people shouldn't be fired for political views) 55%, 297 (conformist liberal viewpoint) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 3, 'Because', 291, 55.0, 1),
       (288, 3, 'Because', 297, 45.0, 1);

-- Target: 288 Therefore: 600 (left only values its own expression) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 3, 'Therefore', 600, 100.0, 1);

-- Cluster 9: Immigration - legal process
-- Target: 1160 (immigrants boost the economy)
-- Because: 1159 (immigrants are not dangerous) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1160, 3, 'Because', 1159, 100.0, 1);

-- Target: 612 (only let the best of the best in)
-- Because: 1160 (immigrants boost economy -- so select the best) 55%, 100 (no system completely fair) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (612, 3, 'Because', 1160, 55.0, 1),
       (612, 3, 'Because', 100, 45.0, 1);

-- Cluster 10: Sports/gender
-- Target: 791 (sports separated by biological sex)
-- Because: 142 (only two genders) 55%, 785 (traditional gender roles exist for a reason) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (791, 3, 'Because', 142, 55.0, 1),
       (791, 3, 'Because', 785, 45.0, 1);

-- Target: 791 Therefore: 793 (trans girls should play among boys) - wait, Carlos didn't accept 793
-- Use: 1172 (any regulation must follow 2A analog framing - not ideal; use 849 instead)
-- Target: 791 Therefore: 849 (first duty as parent is protection) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (791, 3, 'Therefore', 849, 100.0, 1);

-- Cluster 11: Climate skepticism
-- Target: 1275 (climate has been changing throughout earth's history)
-- Because: 1276 (recent changes little different from historical) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1275, 3, 'Because', 1276, 100.0, 1);

-- Target: 1276 Therefore: 1275 (climate has always changed - circular but reflects his view) -- avoid circular
-- Target: 123 (act on climate) -- REJECTED
-- Rebuttal: 1275 (climate always changing) 55%, 1276 (recent changes not unusual) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 3, 'Rebuttal', 1275, 55.0, 1),
       (123, 3, 'Rebuttal', 1276, 45.0, 1);

-- Cluster 12: Welfare means testing
-- Target: 267 (means testing avoids wasting govt resources)
-- Because: 412 (govt inherently inefficient) 55%, 920 (govt programs ineffective) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (267, 3, 'Because', 412, 55.0, 1),
       (267, 3, 'Because', 920, 45.0, 1);

-- Target: 267 Therefore: 601 (welfare should require recipients do their part) 55%, 607 (handouts prevent self-sufficiency) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (267, 3, 'Therefore', 601, 55.0, 1),
       (267, 3, 'Therefore', 607, 45.0, 1);

-- Cluster 13: Rebut wealth tax
-- Target: 54 (wealth tax is critical tool) -- REJECTED
-- Rebuttal: 134 (shouldn't punish success) 55%, 265 (tax cut lets you keep earned money) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (54, 3, 'Rebuttal', 134, 55.0, 1),
       (54, 3, 'Rebuttal', 265, 45.0, 1);

-- Cluster 14: Rebut defund police
-- Target: 107 (defund police) -- REJECTED
-- Rebuttal: 561 (back the blue) 55%, 165 (oversight reform) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 3, 'Rebuttal', 561, 55.0, 1),
       (107, 3, 'Rebuttal', 165, 45.0, 1);


-- ============================================================
-- PROFILE 4: DIANA DELGADO
-- 28yo Hispanic (Puerto Rican, 2nd gen), urban Los Angeles CA
-- Bilingual public elementary school teacher (K-3), single, renting
-- ideology_score: -9 (very progressive, near-left)
-- $36k student loan debt, rent up 30% in 3 years, 5 unhoused kids in class
-- Key issues: housing affordability, education funding, climate (existential),
--   immigration (deeply personal), police brutality + CJ reform
--   -- she supports DEFUNDING/significant restructuring of police (unlike Brianna)
-- Trusts: teachers' union, community organizers, Latina activists/scholars, mother + abuela
-- Distrusts: corporate Dems, charter school advocates, police, landlords, tech companies
-- No religion (spiritual but not religious, former Catholic)
-- ============================================================

-- === CLIMATE (her defining issue) ===
CALL assertOpinion(1, 123, 4);   -- We must act on climate change quickly and forcefully
CALL assertOpinion(1, 321, 4);   -- Human influenced climate change is an observable fact
CALL assertOpinion(1, 414, 4);   -- We should ramp up renewable energy capacity ASAP
CALL assertOpinion(1, 476, 4);   -- Fossil fuels need to be left in the ground
CALL assertOpinion(1, 477, 4);   -- Fossil fuels are the greatest contributors to climate change
CALL assertOpinion(1, 863, 4);   -- Limiting climate change will require collective action
CALL assertOpinion(1, 892, 4);   -- To avoid climate catastrophe we must make average person's carbon output negative
CALL assertOpinion(-1, 230, 4);  -- Climate change is a hoax
CALL assertOpinion(-1, 1275, 4); -- The climate has been changing throughout earth's history (as a deflection)
CALL assertOpinion(-1, 1276, 4); -- Recent changes little different from historical swings

-- === HOUSING ===
CALL assertOpinion(1, 836, 4);   -- Home prices are unacceptably high
CALL assertOpinion(1, 1143, 4);  -- Should be sufficient affordable housing that no one is priced out of a city

-- === POLICING (she supports defunding/significant restructuring) ===
CALL assertOpinion(1, 105, 4);   -- Police kill black people with impunity
CALL assertOpinion(1, 107, 4);   -- Defund police departments
CALL assertOpinion(1, 145, 4);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 4);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 151, 4);   -- Police unions too powerful and uphold racist structures
CALL assertOpinion(1, 153, 4);   -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 4);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 155, 4);   -- Police procedures and policies are effectively racist too often
CALL assertOpinion(1, 163, 4);   -- More policing does not get to root of problem
CALL assertOpinion(1, 207, 4);   -- Black people stopped for looking suspicious far more often
CALL assertOpinion(1, 217, 4);   -- Police not held accountable to just degree
CALL assertOpinion(1, 218, 4);   -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 4);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 4);   -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(1, 560, 4);   -- The police should be abolished (she accepts this as a worthy position)
CALL assertOpinion(-1, 561, 4);  -- Back the blue
CALL assertOpinion(-1, 165, 4);  -- Police oversight should be reformed (not policing itself) -- too timid for her
CALL assertOpinion(-1, 166, 4);  -- Policing doesn't need to be changed, only oversight (rejects)
CALL assertOpinion(1, 1188, 4);  -- Routine traffic stops extremely dangerous for black and brown people
CALL assertOpinion(-1, 1410, 4); -- Safety of police officers should be top priority (framing she rejects)
CALL assertOpinion(-1, 777, 4);  -- Criminals forfeit their rights when they choose a life of crime

-- === RACE / STRUCTURAL RACISM ===
CALL assertOpinion(-1, 101, 4);  -- Racism is made up
CALL assertOpinion(1, 103, 4);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(-1, 108, 4);  -- Black people just commit more crime
CALL assertOpinion(1, 109, 4);   -- Empower black people
CALL assertOpinion(-1, 118, 4);  -- Black people are inherently less civil
CALL assertOpinion(1, 169, 4);   -- Non-white males statistically paid less per dollar
CALL assertOpinion(1, 171, 4);   -- CJ system is major contributor to racial inequality
CALL assertOpinion(1, 174, 4);   -- CJ system prejudiced; not accounting for disparities is being blind
CALL assertOpinion(1, 175, 4);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 221, 4);   -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(1, 236, 4);   -- Black Americans are right to feel wronged by society
CALL assertOpinion(1, 240, 4);   -- Equality of any group treated as less than human is priority
CALL assertOpinion(1, 241, 4);   -- Giving Black Americans the power they deserve should be priority
CALL assertOpinion(1, 484, 4);   -- We all have implicit bias
CALL assertOpinion(1, 485, 4);   -- Implicit bias training should be more common
CALL assertOpinion(1, 1207, 4);  -- CRT attempts to graft notions of power structures onto racism
CALL assertOpinion(1, 1345, 4);  -- Curriculums should be reviewed to combat white supremacy
CALL assertOpinion(1, 1347, 4);  -- Kids should be taught white supremacy prevents BIPOC achievement
CALL assertOpinion(1, 1351, 4);  -- Kids should be taught the existence of white supremacy in the US
CALL assertOpinion(-1, 1197, 4); -- White people most commonly persecuted today
CALL assertOpinion(-1, 1229, 4); -- It is perfectly okay to be white (she sees this as deflection)

-- === BLM ===
CALL assertOpinion(1, 546, 4);   -- BLM movement activists deserve support
CALL assertOpinion(1, 603, 4);   -- Cities with significant BLM protests had reduction in police homicides
CALL assertOpinion(1, 1202, 4);  -- BLM protests have by and large been peaceful
CALL assertOpinion(1, 1313, 4);  -- BLM is simply about Black Americans not living in fear
CALL assertOpinion(1, 1314, 4);  -- Black Americans' fear of police is completely legitimate
CALL assertOpinion(1, 1321, 4);  -- BLM makes the clear point that Black people's lives are undervalued
CALL assertOpinion(-1, 349, 4);  -- BLM is racist
CALL assertOpinion(-1, 350, 4);  -- BLM aims to diminish white people
CALL assertOpinion(-1, 1319, 4); -- All Lives Matter
CALL assertOpinion(-1, 1320, 4); -- BLM is suggesting Black people are more important than others

-- === IMMIGRATION (deeply personal) ===
CALL assertOpinion(1, 617, 4);   -- Family separation at southern US border is an atrocity
CALL assertOpinion(-1, 612, 4);  -- America should only allow the best of the best
CALL assertOpinion(1, 616, 4);   -- Asylum should be granted to all those that seek it
CALL assertOpinion(-1, 611, 4);  -- Open borders worthy ideal (she accepts the ideal but is pragmatic, yet leans toward it)
CALL assertOpinion(1, 1159, 4);  -- Immigrants are not dangerous
CALL assertOpinion(1, 1160, 4);  -- Immigrants boost the economy
CALL assertOpinion(-1, 1237, 4); -- Migrants should be treated as enemy invaders
CALL assertOpinion(1, 972, 4);   -- The GOP is anti-immigrant

-- === EDUCATION ===
CALL assertOpinion(1, 494, 4);   -- Workers should unionize
CALL assertOpinion(1, 495, 4);   -- Collective bargaining helps workers win greater pay and benefits
CALL assertOpinion(-1, 727, 4);  -- Unions often employ inflexible rules (she rejects this framing)

-- === VOTING RIGHTS ===
CALL assertOpinion(1, 182, 4);   -- Right of every citizen to vote is unassailable principle
CALL assertOpinion(1, 184, 4);   -- Most historically exploited groups are also disenfranchised
CALL assertOpinion(1, 355, 4);   -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 4);   -- Universal voter registration
CALL assertOpinion(1, 357, 4);   -- Universal vote-by-mail
CALL assertOpinion(1, 640, 4);   -- Congress must pass HR1 For The People Act
CALL assertOpinion(-1, 1365, 4); -- Georgia voting law SB 202 is good policy
CALL assertOpinion(1, 1357, 4);  -- SB 202 should be condemned
CALL assertOpinion(1, 1380, 4);  -- SB 202 predicated on the fraud lie

-- === POLITICS ===
CALL assertOpinion(-1, 80, 4);   -- Trump 2024
CALL assertOpinion(1, 88, 4);    -- Trump not intellectually curious to a stunning degree
CALL assertOpinion(1, 89, 4);    -- Trump tacitly endorses racism
CALL assertOpinion(1, 90, 4);    -- GOP agenda is bad for America
CALL assertOpinion(1, 94, 4);    -- Do not vote for Republican until major reforms
CALL assertOpinion(1, 96, 4);    -- Trump's singular concern is himself
CALL assertOpinion(1, 104, 4);   -- Vote for Democrats (pragmatically)
CALL assertOpinion(-1, 120, 4);  -- Trump puts America first
-- (arg 972 for profileID=4 already called above in immigration section)

-- === WEALTH / ECONOMY ===
CALL assertOpinion(1, 54, 4);    -- A wealth tax is a critical tool toward societal harmony
CALL assertOpinion(-1, 134, 4);  -- We shouldn't punish success (she sees this framing as protecting the wealthy)
CALL assertOpinion(-1, 135, 4);  -- Not allowing people to keep what they earned is criminal
CALL assertOpinion(1, 110, 4);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 185, 4);   -- A wealth tax would reduce resentment
CALL assertOpinion(1, 192, 4);   -- Wealth taxes should control offensive levels of wealth
CALL assertOpinion(1, 203, 4);   -- Happiness maximized in more equitable world
CALL assertOpinion(1, 204, 4);   -- Estate taxes useful tool for controlling hereditary wealth
CALL assertOpinion(1, 604, 4);   -- Government should eliminate poverty
CALL assertOpinion(1, 606, 4);   -- Government should give direct cash payments to the poor
CALL assertOpinion(1, 609, 4);   -- US should implement universal basic income
CALL assertOpinion(1, 745, 4);   -- Wealthy should take greater proportion of tax burden
CALL assertOpinion(-1, 193, 4);  -- No such thing as too much wealth concentration
CALL assertOpinion(1, 666, 4);   -- American Rescue Plan Act of 2021 is good policy

-- === GENDER / TRANS ===
CALL assertOpinion(-1, 142, 4);  -- There are only two genders
CALL assertOpinion(1, 790, 4);   -- Trans girls should not be forced to play boys sports
CALL assertOpinion(1, 795, 4);   -- Support trans women by not undermining their gender identity
CALL assertOpinion(1, 797, 4);   -- Trans girls permitted in women's athletics same as any other girls
CALL assertOpinion(1, 801, 4);   -- Leave trans kids out of bullshit culture war battles
CALL assertOpinion(-1, 785, 4);  -- Traditional gender roles exist for a reason
CALL assertOpinion(-1, 791, 4);  -- Sports should be separated by biological sex

-- === ENDORSEMENTS: DIANA DELGADO (profileID=4) ===

-- Cluster 1: Climate is existential
-- Target: 123 (we must act on climate change quickly and forcefully)
-- Because: 321 (human influenced CC is observable fact) 40%, 477 (fossil fuels greatest contributors) 35%, 863 (requires collective action) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 4, 'Because', 321, 40.0, 1),
       (123, 4, 'Because', 477, 35.0, 1),
       (123, 4, 'Because', 863, 25.0, 1);

-- Target: 123 Therefore: 414 (ramp up renewables) 40%, 476 (fossil fuels in ground) 35%, 892 (make carbon output negative) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 4, 'Therefore', 414, 40.0, 1),
       (123, 4, 'Therefore', 476, 35.0, 1),
       (123, 4, 'Therefore', 892, 25.0, 1);

-- Cluster 2: Defund/abolish police
-- Target: 107 (defund police departments)
-- Because: 151 (police unions uphold racist structures) 40%, 155 (policies effectively racist) 35%, 163 (more policing doesn't solve root cause) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 4, 'Because', 151, 40.0, 1),
       (107, 4, 'Because', 155, 35.0, 1),
       (107, 4, 'Because', 163, 25.0, 1);

-- Target: 107 Therefore: 560 (police should be abolished -- the logical endpoint in her view) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 4, 'Therefore', 560, 100.0, 1);

-- Cluster 3: Police accountability
-- Target: 539 (qualified immunity unjustly shields police)
-- Because: 219 (police are granted qualified immunity) 55%, 217 (not held accountable) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (539, 4, 'Because', 219, 55.0, 1),
       (539, 4, 'Because', 217, 45.0, 1);

-- Target: 539 Therefore: 148 (de-escalation required) 50%, 153 (exhaust options before shooting) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (539, 4, 'Therefore', 148, 50.0, 1),
       (539, 4, 'Therefore', 153, 50.0, 1);

-- Cluster 4: Immigration
-- Target: 617 (family separation is atrocity)
-- Because: 1159 (immigrants are not dangerous) 55%, 616 (asylum should be granted) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (617, 4, 'Because', 1159, 55.0, 1),
       (617, 4, 'Because', 616, 45.0, 1);

-- Target: 617 Therefore: 972 (GOP is anti-immigrant) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (617, 4, 'Therefore', 972, 100.0, 1);

-- Cluster 5: Wealth inequality
-- Target: 110 (wealth inequality beyond acceptable)
-- Because: 203 (happiness maximized in equitable world) 55%, 192 (wealth taxes should control offensive wealth) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 4, 'Because', 203, 55.0, 1),
       (110, 4, 'Because', 192, 45.0, 1);

-- Target: 110 Therefore: 54 (wealth tax critical tool) 40%, 745 (wealthy should pay more) 35%, 604 (govt should eliminate poverty) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 4, 'Therefore', 54, 40.0, 1),
       (110, 4, 'Therefore', 745, 35.0, 1),
       (110, 4, 'Therefore', 604, 25.0, 1);

-- Cluster 6: Housing
-- Target: 1143 (sufficient affordable housing so no one is priced out)
-- Because: 836 (home prices unacceptably high) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1143, 4, 'Because', 836, 100.0, 1);

-- Target: 1143 Therefore: 604 (govt should eliminate poverty) 55%, 606 (direct cash payments to poor) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1143, 4, 'Therefore', 604, 55.0, 1),
       (1143, 4, 'Therefore', 606, 45.0, 1);

-- Cluster 7: Structural racism
-- Target: 221 (power structures maintaining white supremacy hostile to Black people)
-- Because: 175 (inherent racial bias far-reaching) 55%, 484 (we all have implicit bias) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (221, 4, 'Because', 175, 55.0, 1),
       (221, 4, 'Because', 484, 45.0, 1);

-- Target: 221 Therefore: 1345 (curriculum should combat white supremacy) 55%, 1351 (kids should be taught it exists) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (221, 4, 'Therefore', 1345, 55.0, 1),
       (221, 4, 'Therefore', 1351, 45.0, 1);

-- Cluster 8: Teachers' unions / workers
-- Target: 494 (workers should unionize)
-- Because: 495 (collective bargaining wins greater pay and benefits) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 4, 'Because', 495, 100.0, 1);

-- Target: 495 Therefore: 494 (workers should unionize) -- circular, skip; use 604 instead
-- Target: 495 Therefore: 240 (equality of any group treated as less than human is priority) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (495, 4, 'Therefore', 240, 100.0, 1);

-- Cluster 9: BLM support
-- Target: 546 (BLM activists deserve support)
-- Because: 1313 (simply about not living in fear) 40%, 1202 (protests peaceful) 35%, 603 (reduced police homicides) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 4, 'Because', 1313, 40.0, 1),
       (546, 4, 'Because', 1202, 35.0, 1),
       (546, 4, 'Because', 603, 25.0, 1);

-- Target: 546 Therefore: 107 (defund police) 55%, 163 (more policing doesn't help) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 4, 'Therefore', 107, 55.0, 1),
       (546, 4, 'Therefore', 163, 45.0, 1);

-- Cluster 10: Rebut "back the blue"
-- Target: 561 (back the blue) -- REJECTED
-- Rebuttal: 105 (police kill Black people with impunity) 40%, 217 (not held accountable) 35%, 539 (qualified immunity) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 4, 'Rebuttal', 105, 40.0, 1),
       (561, 4, 'Rebuttal', 217, 35.0, 1),
       (561, 4, 'Rebuttal', 539, 25.0, 1);

-- Cluster 11: Trans rights
-- Target: 797 (trans girls permitted in women's athletics)
-- Because: 795 (support trans women by not undermining identity) 55%, 801 (leave trans kids out of culture war) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 4, 'Because', 795, 55.0, 1),
       (797, 4, 'Because', 801, 45.0, 1);

-- Target: 797 Therefore: 790 (trans girls should not be forced to play boys sports) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 4, 'Therefore', 790, 100.0, 1);

-- Cluster 12: Rebut climate denial
-- Target: 230 (climate change is a hoax) -- REJECTED
-- Rebuttal: 321 (human influenced CC is observable fact) 55%, 477 (fossil fuels greatest contributors) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (230, 4, 'Rebuttal', 321, 55.0, 1),
       (230, 4, 'Rebuttal', 477, 45.0, 1);

-- Cluster 13: Voting rights
-- Target: 355 (voting rights expanded and protected)
-- Because: 182 (right to vote unassailable) 55%, 184 (historically exploited groups disenfranchised) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 4, 'Because', 182, 55.0, 1),
       (355, 4, 'Because', 184, 45.0, 1);

-- Target: 355 Therefore: 356 (universal registration) 50%, 640 (pass HR1) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 4, 'Therefore', 356, 50.0, 1),
       (355, 4, 'Therefore', 640, 50.0, 1);

-- Cluster 14: Rebut SB 202
-- Target: 1365 (SB 202 is good policy) -- REJECTED
-- Rebuttal: 1357 (SB 202 should be condemned) 55%, 1380 (predicated on fraud lie) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1365, 4, 'Rebuttal', 1357, 55.0, 1),
       (1365, 4, 'Rebuttal', 1380, 45.0, 1);


-- ============================================================
-- PROFILE 5: ELEANOR EVANS
-- 72yo White evangelical Southern Baptist widow, rural Cookeville TN
-- Retired bookkeeper. Widowed -- late husband Harold was Vietnam vet (died 7 years ago)
-- ideology_score: 9 (very conservative)
-- Votes Republican since Reagan; considers it Christian duty to vote pro-life above all else
-- Key issues: abortion (non-negotiable pro-life, no exceptions), LGBTQ+ (especially children),
--   prayer in schools + religious freedom, crime + border security
-- Trusts: pastor, church community, Fox News, Franklin Graham, daughter/son-in-law
-- Distrusts: federal government, LGBTQ+ advocacy groups, Planned Parenthood, universities, MSM
-- Religion: Southern Baptist Evangelical, religiosity 5/5 -- faith IS her entire life framework
-- Reasoning style: theological and moral, not empirical; susceptible to framing around children's safety
-- ============================================================

-- === FAITH / RELIGION (her entire framework) ===
CALL assertOpinion(1, 428, 5);   -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 5);   -- The faithful believe in His glory unconditionally
CALL assertOpinion(1, 1385, 5);  -- Jesus is my Lord and Savior
CALL assertOpinion(1, 1386, 5);  -- Jesus is God's only son
CALL assertOpinion(1, 1440, 5);  -- The Bible is the word of God
CALL assertOpinion(-1, 161, 5);  -- For all intents there is no such thing as a god
CALL assertOpinion(-1, 1438, 5); -- The Bible is bullshit

-- === ABORTION (her #1 issue -- no exceptions) ===
CALL assertOpinion(1, 124, 5);   -- A fetus has a human soul whose life should be protected
CALL assertOpinion(1, 125, 5);   -- Woman should take responsibility for her pregnancy rather than aborting
CALL assertOpinion(1, 126, 5);   -- There should be a limit on how far along a pregnancy can be aborted
CALL assertOpinion(1, 902, 5);   -- Unborn children deserve their right to life to be recognized
CALL assertOpinion(1, 1387, 5);  -- Life begins at conception
CALL assertOpinion(-1, 128, 5);  -- Limits on women's access to abortion is cruel punishment
CALL assertOpinion(-1, 129, 5);  -- Having a child should not be put upon someone like a punishment
CALL assertOpinion(-1, 903, 5);  -- A human's personhood should be recognized at the moment of live birth

-- === LGBTQ+ / GENDER / CHILDREN ===
CALL assertOpinion(1, 142, 5);   -- There are only two genders
CALL assertOpinion(1, 143, 5);   -- Homosexuality is a perversion of nature
CALL assertOpinion(1, 785, 5);   -- Traditional gender roles exist for a reason
CALL assertOpinion(1, 791, 5);   -- Sports should be separated by biological sex
CALL assertOpinion(1, 793, 5);   -- Trans girls should be forced to play among boys if they wish to participate
CALL assertOpinion(1, 849, 5);   -- First duty to your family as a parent is as a protector
CALL assertOpinion(-1, 790, 5);  -- Trans girls should not be forced to play boys sports
CALL assertOpinion(-1, 795, 5);  -- Support trans women by not undermining their gender identity
CALL assertOpinion(-1, 797, 5);  -- Trans girls permitted in women's athletics same as any other girls
CALL assertOpinion(-1, 801, 5);  -- Leave trans kids out of bullshit culture war battles (she takes this extremely seriously)
CALL assertOpinion(1, 1562, 5);  -- Woke nonsense is ruining everything

-- === POLICING / LAW AND ORDER ===
CALL assertOpinion(1, 561, 5);   -- Back the blue
CALL assertOpinion(1, 777, 5);   -- Criminals forfeit their rights when they choose a life of crime
CALL assertOpinion(1, 1410, 5);  -- Safety of police officers should be top priority
CALL assertOpinion(1, 1411, 5);  -- Duty to protect those who protect us is sacred
CALL assertOpinion(-1, 107, 5);  -- Defund police departments
CALL assertOpinion(-1, 145, 5);  -- Policing in America must be reformed (she rejects this framing)
CALL assertOpinion(-1, 151, 5);  -- Police unions uphold racist structures (she rejects systemic racism framing)
CALL assertOpinion(-1, 560, 5);  -- Police should be abolished
CALL assertOpinion(1, 165, 5);   -- Police oversight should be reformed (not policing itself)
CALL assertOpinion(1, 166, 5);   -- Policing doesn't need to be changed, only oversight

-- === RACE / BLM (she rejects systemic racism framing entirely) ===
CALL assertOpinion(1, 100, 5);   -- No system can be completely fair
CALL assertOpinion(1, 101, 5);   -- Racism is made up (she believes it's overblown)
CALL assertOpinion(1, 108, 5);   -- Black people just commit more crime (she holds this view uncritically)
CALL assertOpinion(-1, 105, 5);  -- Police kill Black people with impunity
CALL assertOpinion(-1, 109, 5);  -- Empower Black people (as a program she's skeptical of)
CALL assertOpinion(-1, 113, 5);  -- Conditions outside Black Americans' control increase crime likelihood
CALL assertOpinion(-1, 175, 5);  -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 1229, 5);  -- It is perfectly okay to be white
CALL assertOpinion(1, 349, 5);   -- BLM movement is racist (ACCEPTED by Eleanor)
CALL assertOpinion(1, 350, 5);   -- BLM aims to diminish white people (ACCEPTED)
CALL assertOpinion(1, 1319, 5);  -- All Lives Matter (ACCEPTED)
CALL assertOpinion(1, 1320, 5);  -- BLM is suggesting Black people are more important than others
CALL assertOpinion(-1, 546, 5);  -- BLM activists deserve support
CALL assertOpinion(-1, 1313, 5); -- BLM is simply about Black Americans not living in fear
CALL assertOpinion(-1, 1345, 5); -- Curriculums should be reviewed to combat white supremacy
CALL assertOpinion(-1, 1346, 5); -- Kids should be taught white people are racist
CALL assertOpinion(-1, 1347, 5); -- Kids should be taught white supremacy prevents BIPOC achievement

-- === IMMIGRATION / BORDER ===
CALL assertOpinion(-1, 611, 5);  -- Open borders are worthy ideal
CALL assertOpinion(-1, 616, 5);  -- Asylum should be granted to all those that seek it
CALL assertOpinion(-1, 617, 5);  -- Family separation at southern US border is an atrocity
CALL assertOpinion(1, 612, 5);   -- America should only allow the best of the best
CALL assertOpinion(1, 1237, 5);  -- Migrants crossing border should be treated as enemy invaders
CALL assertOpinion(-1, 1159, 5); -- Immigrants are not dangerous
CALL assertOpinion(-1, 1160, 5); -- Immigrants boost the economy

-- === GUNS ===
CALL assertOpinion(1, 140, 5);   -- 2A grants right to own whatever firearms I deem necessary
CALL assertOpinion(1, 226, 5);   -- Freedom should never be infringed
CALL assertOpinion(1, 328, 5);   -- We should defend the second amendment
CALL assertOpinion(1, 460, 5);   -- People shouldn't be restricted from responsibly owning guns
CALL assertOpinion(1, 821, 5);   -- Stockpile guns, ammo, food, supplies and gold before it's too late
CALL assertOpinion(1, 1172, 5);  -- Any regulation of weapons must be in keeping with 2A
CALL assertOpinion(1, 1177, 5);  -- AR-15 has legitimate use cases like any other tool
CALL assertOpinion(1, 1178, 5);  -- Only I can decide what gun I should or should not own
CALL assertOpinion(-1, 462, 5);  -- Society is better off without guns
CALL assertOpinion(-1, 1179, 5); -- America needs gun reform now
CALL assertOpinion(-1, 1181, 5); -- Gun ownership should be strictly limited

-- === POLITICS / TRUMP ===
CALL assertOpinion(1, 80, 5);    -- Trump 2024
CALL assertOpinion(1, 120, 5);   -- Trump puts America first
CALL assertOpinion(-1, 88, 5);   -- Trump not intellectually curious to a stunning degree
CALL assertOpinion(-1, 89, 5);   -- Trump tacitly endorses racism
CALL assertOpinion(-1, 90, 5);   -- GOP agenda is bad for America
CALL assertOpinion(-1, 94, 5);   -- Do not vote for Republican until major reforms
CALL assertOpinion(-1, 104, 5);  -- Vote for Democrats (REJECTED -- Eleanor votes Republican as Christian duty)
CALL assertOpinion(1, 229, 5);   -- GOP's main goal is to keep govt out of our business
CALL assertOpinion(1, 322, 5);   -- We should never put our full faith in the government
CALL assertOpinion(1, 405, 5);   -- Unchecked government would grow and assume greater control
CALL assertOpinion(1, 406, 5);   -- Power in all forms never stops seeking greater power
CALL assertOpinion(1, 407, 5);   -- We must fight big government
CALL assertOpinion(1, 574, 5);   -- The American Democratic Party is terrible

-- === CLIMATE (she is skeptical) ===
CALL assertOpinion(1, 230, 5);   -- Climate change is a hoax
CALL assertOpinion(1, 1275, 5);  -- The climate has been changing throughout earth's history
CALL assertOpinion(1, 1276, 5);  -- Recent changes little different from historical swings
CALL assertOpinion(-1, 123, 5);  -- We must act on climate change quickly and forcefully
CALL assertOpinion(-1, 321, 5);  -- Human influenced climate change is observable fact
CALL assertOpinion(-1, 414, 5);  -- We should ramp up renewable energy capacity ASAP
CALL assertOpinion(-1, 476, 5);  -- Fossil fuels need to be left in the ground

-- === ECONOMY / WELFARE ===
CALL assertOpinion(1, 136, 5);   -- Capitalism is the best system we got
CALL assertOpinion(1, 224, 5);   -- Americans benefit from living in the greatest system ever conceived
CALL assertOpinion(1, 400, 5);   -- Government should stay out of the way
CALL assertOpinion(1, 401, 5);   -- Free markets do a better job than any government
CALL assertOpinion(1, 601, 5);   -- Welfare program should ask recipients to do their part
CALL assertOpinion(1, 607, 5);   -- If people are given handouts they will never learn to provide
CALL assertOpinion(-1, 609, 5);  -- Universal basic income
CALL assertOpinion(1, 920, 5);   -- Government programs are ineffective
CALL assertOpinion(1, 1591, 5);  -- Socialism has failed every time it was tried
CALL assertOpinion(1, 1597, 5);  -- Socialism is bad

-- === CANCEL CULTURE / FREE SPEECH ===
CALL assertOpinion(1, 288, 5);   -- Cancel culture must be resisted
CALL assertOpinion(1, 291, 5);   -- People should not be fired for their political views
CALL assertOpinion(1, 297, 5);   -- Cancel culture promotes conformist liberal viewpoint
CALL assertOpinion(1, 298, 5);   -- Cancel culture is modern form of ostracism
CALL assertOpinion(1, 596, 5);   -- Our right to free speech is absolute
CALL assertOpinion(1, 600, 5);   -- The Left only interested in freedom expressing their own ideas
CALL assertOpinion(-1, 293, 5);  -- Cancel culture is merely criticism someone doesn't support

-- === VETERANS (Harold was a Vietnam vet) ===
CALL assertOpinion(1, 916, 5);   -- Veterans owed basic necessities from government that sent them to war
CALL assertOpinion(1, 912, 5);   -- VA healthcare system fails to meet needs of veterans
CALL assertOpinion(1, 1001, 5);  -- Atrocities committed by US forces in Vietnam will never be fully exposed

-- === ENDORSEMENTS: ELEANOR EVANS (profileID=5) ===

-- Cluster 1: Abortion is murder -- her non-negotiable
-- Target: 902 (unborn children deserve their right to life)
-- Because: 124 (fetus has human soul) 55%, 1387 (life begins at conception) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (902, 5, 'Because', 124, 55.0, 1),
       (902, 5, 'Because', 1387, 45.0, 1);

-- Target: 902 Therefore: 125 (woman should take responsibility, not abort) 55%, 126 (limit on late abortions) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (902, 5, 'Therefore', 125, 55.0, 1),
       (902, 5, 'Therefore', 126, 45.0, 1);

-- Cluster 2: Life begins at conception
-- Target: 1387 (life begins at conception)
-- Because: 1385 (Jesus is Lord) 50%, 1440 (Bible is word of God) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1387, 5, 'Because', 1385, 50.0, 1),
       (1387, 5, 'Because', 1440, 50.0, 1);

-- Target: 1387 Therefore: 902 (unborn children deserve right to life) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1387, 5, 'Therefore', 902, 100.0, 1);

-- Cluster 3: Rebut abortion rights
-- Target: 128 (limits on abortion is cruel punishment) -- REJECTED
-- Rebuttal: 124 (fetus has human soul) 55%, 902 (unborn children deserve right to life) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (128, 5, 'Rebuttal', 124, 55.0, 1),
       (128, 5, 'Rebuttal', 902, 45.0, 1);

-- Cluster 4: Faith is her framework
-- Target: 1385 (Jesus is my Lord and Savior)
-- Because: 1386 (Jesus is God's only son) 55%, 1440 (Bible is word of God) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1385, 5, 'Because', 1386, 55.0, 1),
       (1385, 5, 'Because', 1440, 45.0, 1);

-- Target: 1385 Therefore: 1387 (life begins at conception) 55%, 844 (faithful believe unconditionally) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1385, 5, 'Therefore', 1387, 55.0, 1),
       (1385, 5, 'Therefore', 844, 45.0, 1);

-- Cluster 5: Gender and children's protection
-- Target: 793 (trans girls should be forced to play among boys)
-- Because: 142 (only two genders) 55%, 791 (sports separated by biological sex) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (793, 5, 'Because', 142, 55.0, 1),
       (793, 5, 'Because', 791, 45.0, 1);

-- Target: 793 Therefore: 849 (first duty as parent is protection) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (793, 5, 'Therefore', 849, 100.0, 1);

-- Cluster 6: Rebut trans rights
-- Target: 797 (trans girls permitted in women's athletics) -- REJECTED
-- Rebuttal: 791 (sports separated by biological sex) 55%, 142 (only two genders) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 5, 'Rebuttal', 791, 55.0, 1),
       (797, 5, 'Rebuttal', 142, 45.0, 1);

-- Cluster 7: Back the blue / law and order
-- Target: 561 (back the blue)
-- Because: 1411 (duty to protect those who protect us) 55%, 1410 (safety of officers top priority) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 5, 'Because', 1411, 55.0, 1),
       (561, 5, 'Because', 1410, 45.0, 1);

-- Target: 561 Therefore: 165 (oversight reform not defunding) 55%, 777 (criminals forfeit rights) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 5, 'Therefore', 165, 55.0, 1),
       (561, 5, 'Therefore', 777, 45.0, 1);

-- Cluster 8: Rebut defund police
-- Target: 107 (defund police) -- REJECTED
-- Rebuttal: 561 (back the blue) 55%, 777 (criminals forfeit rights) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 5, 'Rebuttal', 561, 55.0, 1),
       (107, 5, 'Rebuttal', 777, 45.0, 1);

-- Cluster 9: Cancel culture / woke
-- Target: 288 (cancel culture must be resisted)
-- Because: 291 (people shouldn't be fired for political views) 40%, 297 (conformist liberal viewpoint) 35%, 298 (modern ostracism) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 5, 'Because', 291, 40.0, 1),
       (288, 5, 'Because', 297, 35.0, 1),
       (288, 5, 'Because', 298, 25.0, 1);

-- Target: 288 Therefore: 596 (free speech is absolute) 55%, 600 (left values only its own expression) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 5, 'Therefore', 596, 55.0, 1),
       (288, 5, 'Therefore', 600, 45.0, 1);

-- Cluster 10: Immigration / border
-- Target: 1237 (migrants crossing border should be treated as enemy invaders)
-- Because: 612 (only allow best of the best) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1237, 5, 'Because', 612, 100.0, 1);

-- Target: 1237 Therefore: 322 (never put full faith in government -- govt hasn't secured border) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1237, 5, 'Therefore', 322, 100.0, 1);

-- Cluster 11: Rebut open borders / asylum for all
-- Target: 611 (open borders worthy ideal) -- REJECTED
-- Rebuttal: 612 (only best of best) 55%, 1237 (treat as enemy invaders) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (611, 5, 'Rebuttal', 612, 55.0, 1),
       (611, 5, 'Rebuttal', 1237, 45.0, 1);

-- Cluster 12: Climate skepticism
-- Target: 230 (climate change is a hoax)
-- Because: 1275 (climate always changing) 55%, 1276 (recent changes not unusual) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (230, 5, 'Because', 1275, 55.0, 1),
       (230, 5, 'Because', 1276, 45.0, 1);

-- Target: 230 Therefore: 400 (government should stay out of the way) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (230, 5, 'Therefore', 400, 100.0, 1);

-- Cluster 13: 2A
-- Target: 328 (we should defend the second amendment)
-- Because: 140 (2A grants right) 55%, 226 (freedom never infringed) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (328, 5, 'Because', 140, 55.0, 1),
       (328, 5, 'Because', 226, 45.0, 1);

-- Target: 328 Therefore: 1178 (only I decide my gun) 40%, 1177 (AR-15 has legitimate uses) 35%, 460 (don't restrict responsible owners) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (328, 5, 'Therefore', 1178, 40.0, 1),
       (328, 5, 'Therefore', 1177, 35.0, 1),
       (328, 5, 'Therefore', 460, 25.0, 1);

-- Cluster 14: Veterans
-- Target: 916 (veterans owed basic necessities from government)
-- Because: 1001 (atrocities in Vietnam never fully exposed) 55%, 912 (VA fails veterans) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (916, 5, 'Because', 1001, 55.0, 1),
       (916, 5, 'Because', 912, 45.0, 1);

-- Target: 916 Therefore: 1411 (duty to protect those who protect us) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (916, 5, 'Therefore', 1411, 100.0, 1);

-- ============================================================
-- VERIFICATION QUERY
-- Should return 0 rows if all (targArgID, profileID, endorseType) groups sum to exactly 100
-- ============================================================
SELECT targArgID, profileID, endorseType, SUM(weight) as total
FROM ENDORSEMENT
WHERE profileID BETWEEN 2 AND 5
  AND active=1
GROUP BY targArgID, profileID, endorseType
HAVING ABS(SUM(weight)-100) > 0.001;
