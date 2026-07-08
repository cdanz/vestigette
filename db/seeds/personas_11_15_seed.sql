-- personas_11_15_seed.sql
-- Opinion and endorsement population for profileIDs 11-15
-- Karen Kim (11), Leonard Larson (12), Maria Martinez (13), Nathan Nguyen (14), Olivia O'Brien (15)
--
-- Weights within every (targArgID, profileID, endorseType) group sum to EXACTLY 100.0
-- assertOpinion(op, argID, proID): op=1 accept, op=-1 reject; uses IF NOT EXISTS semantics
-- All personas skip argumentIDs 1-55 (pre-existing GMO test data)

USE vestigette;

-- ============================================================
-- PROFILE 11: KAREN KIM
-- 44yo Korean-American senior software engineer, Bellevue WA, $134k
-- ideology_score: -6 (reliable Democrat, evidence-based)
-- Two kids in public school. Anti-Asian racism real and underdiscussed.
-- Tech has social responsibility it isn't meeting.
-- Hardcoded: education/hard work determines outcomes; immigration = innovation engine;
--            tech has social responsibility; anti-Asian racism real
-- ============================================================

-- === RACISM / RACIAL JUSTICE ===
CALL assertOpinion(1, 100, 11);   -- No system can be completely fair
CALL assertOpinion(-1, 101, 11);  -- Racism is made up (she rejects — it's real)
CALL assertOpinion(1, 103, 11);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 175, 11);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 169, 11);   -- Non-white males statistically paid less per dollar
CALL assertOpinion(1, 207, 11);   -- Black people stopped for looking suspicious far more often
CALL assertOpinion(1, 484, 11);   -- We all have implicit bias
CALL assertOpinion(1, 485, 11);   -- Implicit bias training should be more common
CALL assertOpinion(-1, 487, 11);  -- Implicit bias training can have little effect (she believes it helps)
CALL assertOpinion(1, 486, 11);   -- Distinction between mechanisms of explanation vs change
CALL assertOpinion(1, 320, 11);   -- All people deserve to be treated equally
CALL assertOpinion(-1, 118, 11);  -- Black people are inherently less civil (rejects)
CALL assertOpinion(-1, 108, 11);  -- Black people just commit more crime (rejects)

-- === ANTI-ASIAN RACISM (hardcoded) ===
CALL assertOpinion(1, 279, 11);   -- No individual should suffer harassment based on race
CALL assertOpinion(1, 317, 11);   -- Race is a social construct
CALL assertOpinion(1, 318, 11);   -- Genetic diversity across human race is very small
CALL assertOpinion(1, 240, 11);   -- Equality of any group treated as less human is a priority

-- === IMMIGRATION (hardcoded: engine of innovation) ===
CALL assertOpinion(1, 954, 11);   -- America should welcome immigrants with few restrictions
CALL assertOpinion(1, 946, 11);   -- American culture is better due to immigrants who contribute
CALL assertOpinion(1, 615, 11);   -- There should always be a reasonable path to citizenship
CALL assertOpinion(-1, 612, 11);  -- America should only allow best of best (rejects — too exclusionary)
CALL assertOpinion(1, 972, 11);   -- The GOP is anti-immigrant
CALL assertOpinion(-1, 611, 11);  -- Open borders are a worthy ideal (too radical for her)

-- === TECH SOCIAL RESPONSIBILITY (hardcoded) ===
CALL assertOpinion(1, 463, 11);   -- Social media has fewer safeguards against misinformation
CALL assertOpinion(1, 464, 11);   -- Traditional media outlets more reliable than social media
CALL assertOpinion(-1, 465, 11);  -- Traditional media regularly fails to hold liars accountable (nuanced — she partly agrees)
CALL assertOpinion(-1, 466, 11);  -- Social media as reliable as you curate it (she thinks structural problems remain)
CALL assertOpinion(1, 367, 11);   -- Social media is bad (as currently designed)
CALL assertOpinion(1, 368, 11);   -- Pursuit of greater engagement discourages resolution
CALL assertOpinion(1, 369, 11);   -- Lack of gatekeepers makes social media dialogue chaotic
CALL assertOpinion(1, 374, 11);   -- Social media lets users consume only what they're predisposed to
CALL assertOpinion(1, 378, 11);   -- Social media incentivized to increase screen time for ads
CALL assertOpinion(1, 498, 11);   -- Facebook content moderation biased toward conservatives
CALL assertOpinion(1, 499, 11);   -- Facebook fears conservative ire will result in regulation
CALL assertOpinion(1, 588, 11);   -- Social media democratizes judgment
CALL assertOpinion(-1, 590, 11);  -- Social media gives impression of common wisdom that isn't common
CALL assertOpinion(1, 591, 11);   -- When standards differ from your own, may mean YOUR views are out of step

-- === CLIMATE ===
CALL assertOpinion(1, 321, 11);   -- Human-influenced climate change is an observable fact
CALL assertOpinion(1, 123, 11);   -- We must act on climate change quickly and forcefully
CALL assertOpinion(1, 414, 11);   -- We should ramp up renewable energy capacity ASAP
CALL assertOpinion(1, 476, 11);   -- Fossil fuels need to be left in the ground
CALL assertOpinion(1, 477, 11);   -- Fossil fuels are greatest contributors to climate change
CALL assertOpinion(1, 478, 11);   -- We should utilize nuclear power more readily
CALL assertOpinion(1, 479, 11);   -- Fear of nuclear power is greatly disproportionate to actual risk
CALL assertOpinion(1, 480, 11);   -- Nuclear power is clean and efficient
CALL assertOpinion(-1, 230, 11);  -- Climate change is a hoax (rejects)
CALL assertOpinion(-1, 415, 11);  -- Green energy is unreliable (rejects)
CALL assertOpinion(1, 863, 11);   -- Limiting climate change requires collective action
CALL assertOpinion(1, 892, 11);   -- To avoid climate catastrophe must make avg carbon output net-negative

-- === POLICING (Reform YES, Defund NO) ===
CALL assertOpinion(1, 145, 11);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 11);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 153, 11);   -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 11);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 155, 11);   -- Police procedures and policies are effectively racist too often
CALL assertOpinion(-1, 107, 11);  -- Defund police departments (rejects — not the right frame)
CALL assertOpinion(-1, 560, 11);  -- Police should be abolished (rejects)
CALL assertOpinion(1, 217, 11);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 218, 11);   -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 11);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 11);   -- Qualified immunity unjustly shields police from accountability

-- === BLM / BLM FRAMING ===
CALL assertOpinion(1, 546, 11);   -- BLM movement activists deserve support
CALL assertOpinion(-1, 547, 11);  -- BLM is violent (rejects bad-faith framing)
CALL assertOpinion(-1, 548, 11);  -- BLM in cahoots with Antifa (rejects)
CALL assertOpinion(-1, 349, 11);  -- BLM movement is racist (rejects)
CALL assertOpinion(1, 603, 11);   -- Cities with significant BLM protests had reduction in police homicides

-- === HEALTHCARE ===
CALL assertOpinion(1, 895, 11);   -- US must reform its healthcare system
CALL assertOpinion(1, 896, 11);   -- US healthcare system has terrible health outcomes
CALL assertOpinion(1, 897, 11);   -- US healthcare system is most expensive in world
CALL assertOpinion(1, 898, 11);   -- US healthcare system is inequitable
CALL assertOpinion(1, 899, 11);   -- US healthcare system is inefficient
CALL assertOpinion(1, 958, 11);   -- Basic healthcare is a fundamental human right
CALL assertOpinion(1, 894, 11);   -- Government should optimize the healthcare system
CALL assertOpinion(-1, 910, 11);  -- Government control creates bureaucratic inefficient system (rejects)
CALL assertOpinion(1, 909, 11);   -- Relying on private employers for health insurance is outdated model

-- === VOTING RIGHTS ===
CALL assertOpinion(1, 355, 11);   -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 11);   -- We should have universal voter registration
CALL assertOpinion(1, 357, 11);   -- We should have universal vote-by-mail
CALL assertOpinion(1, 182, 11);   -- Right of every citizen to vote is unassailable principle
CALL assertOpinion(1, 184, 11);   -- Most historically exploited groups also disenfranchised
CALL assertOpinion(-1, 180, 11);  -- Voting rights should not be expanded (rejects)

-- === RANKED CHOICE VOTING ===
CALL assertOpinion(1, 696, 11);   -- We should support ranked choice voting
CALL assertOpinion(1, 697, 11);   -- Washington voters should contact reps supporting SBH1156
CALL assertOpinion(1, 698, 11);   -- Ranked-choice voting eliminates wasted votes/vote splitting
CALL assertOpinion(1, 699, 11);   -- RCV increases diversity of candidates
CALL assertOpinion(-1, 700, 11);  -- RCV is too confusing for the average voter (rejects)
CALL assertOpinion(1, 701, 11);   -- Ranked-choice voting reduces negativity in campaigns
CALL assertOpinion(1, 702, 11);   -- RCV can eliminate the need for primaries

-- === WORKERS RIGHTS ===
CALL assertOpinion(1, 494, 11);   -- Workers should unionize
CALL assertOpinion(1, 495, 11);   -- Collective bargaining helps workers win greater pay and benefits
CALL assertOpinion(1, 496, 11);   -- Biden administration should endorse Amazon workers unionizing
CALL assertOpinion(1, 500, 11);   -- Too many struggle to meet material needs while few have more money than they can spend
CALL assertOpinion(1, 501, 11);   -- People living one unexpected expense away from dire situation have chronic anxiety

-- === WEALTH INEQUALITY ===
CALL assertOpinion(1, 110, 11);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 745, 11);   -- Wealthy should take greater proportion of tax burden
CALL assertOpinion(-1, 193, 11);  -- No such thing as too much wealth concentration (rejects)
CALL assertOpinion(1, 203, 11);   -- Happiness maximized in a more equitable world

-- === 2ND AMENDMENT ===
CALL assertOpinion(-1, 140, 11);  -- 2A grants right to own whatever firearms one deems necessary (rejects absolutism)
CALL assertOpinion(1, 141, 11);   -- There must be limits on the firepower we allow citizens to have
CALL assertOpinion(1, 331, 11);   -- Gun laws limiting ownership are constitutional
CALL assertOpinion(1, 333, 11);   -- Assault weapons should be banned for non-military use

-- === GENDER ESSENTIALISM ===
CALL assertOpinion(-1, 142, 11);  -- There are only two genders (rejects)
CALL assertOpinion(1, 315, 11);   -- A person does not choose their gender
CALL assertOpinion(1, 316, 11);   -- Gender is innate
CALL assertOpinion(1, 544, 11);   -- Trans men should be accepted as men, trans women as women

-- === CANCEL CULTURE ===
CALL assertOpinion(1, 636, 11);   -- There are legitimate cases of excesses of cancel culture
CALL assertOpinion(-1, 652, 11);  -- Six Dr. Seuss books being banned tantamount to book burning (rejects overreach)
CALL assertOpinion(1, 654, 11);   -- A publisher choosing not to publish something is not cancel culture
CALL assertOpinion(1, 655, 11);   -- Dr. Seuss was not canceled in 2021
CALL assertOpinion(1, 293, 11);   -- Cancel culture is merely criticism someone does not support
CALL assertOpinion(1, 295, 11);   -- Dismissing criticism as cancel culture risks chilling useful discussion

-- === EDUCATION ===
CALL assertOpinion(1, 134, 11);   -- We shouldn't punish success (hardcoded: education/hard work determines outcomes)
CALL assertOpinion(1, 416, 11);   -- We must learn to let science be our guide
CALL assertOpinion(1, 504, 11);   -- Expertise is a good thing
CALL assertOpinion(1, 505, 11);   -- There are certifiable experts in a field we should trust

-- === POLITICS / TRUMP ===
CALL assertOpinion(-1, 80, 11);   -- Trump 2024 (rejects)
CALL assertOpinion(1, 89, 11);    -- Trump tacitly endorses racism
CALL assertOpinion(1, 90, 11);    -- GOP agenda is bad for America
CALL assertOpinion(1, 972, 11);   -- GOP is anti-immigrant (already above, idempotent)

-- ============================================================
-- ENDORSEMENTS: KAREN KIM (profileID=11)
-- ============================================================

-- === Climate chain ===
-- Target: 321 (climate change observable fact)
-- Because: 477 (fossil fuels greatest contributor) 60%, 892 (must make carbon output net-negative) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (321, 11, 'Because', 477, 60.0, 1),
       (321, 11, 'Because', 892, 40.0, 1);

-- Target: 321 Therefore: 414 (ramp up renewables) 50%, 476 (fossil fuels in ground) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (321, 11, 'Therefore', 414, 50.0, 1),
       (321, 11, 'Therefore', 476, 50.0, 1);

-- Target: 414 (ramp up renewables) Because: 478 (nuclear) 50%, 863 (collective action needed) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (414, 11, 'Because', 478, 50.0, 1),
       (414, 11, 'Because', 863, 50.0, 1);

-- === Tech responsibility chain ===
-- Target: 463 (social media fewer safeguards)
-- Because: 368 (engagement discourages resolution) 40%, 369 (no gatekeepers chaotic) 35%, 374 (echo chambers) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (463, 11, 'Because', 368, 40.0, 1),
       (463, 11, 'Because', 369, 35.0, 1),
       (463, 11, 'Because', 374, 25.0, 1);

-- Target: 463 Therefore: 498 (Facebook biased moderation) 55%, 499 (Facebook fears conservative ire) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (463, 11, 'Therefore', 498, 55.0, 1),
       (463, 11, 'Therefore', 499, 45.0, 1);

-- === Implicit bias chain ===
-- Target: 484 (we all have implicit bias)
-- Because: 175 (inherent racial bias far-reaching) 55%, 207 (Black people stopped more often) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (484, 11, 'Because', 175, 55.0, 1),
       (484, 11, 'Because', 207, 45.0, 1);

-- Target: 484 Therefore: 485 (implicit bias training should be more common) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (484, 11, 'Therefore', 485, 100.0, 1);

-- === Police reform chain ===
-- Target: 145 (policing must be reformed)
-- Because: 155 (policies effectively racist) 40%, 218 (police see Black people as threat) 35%, 217 (not held accountable) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 11, 'Because', 155, 40.0, 1),
       (145, 11, 'Because', 218, 35.0, 1),
       (145, 11, 'Because', 217, 25.0, 1);

-- Target: 145 Therefore: 148 (de-escalation) 55%, 153 (exhaust options) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 11, 'Therefore', 148, 55.0, 1),
       (145, 11, 'Therefore', 153, 45.0, 1);

-- === Healthcare chain ===
-- Target: 895 (US must reform healthcare)
-- Because: 896 (terrible outcomes) 35%, 897 (most expensive) 35%, 898 (inequitable) 30%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (895, 11, 'Because', 896, 35.0, 1),
       (895, 11, 'Because', 897, 35.0, 1),
       (895, 11, 'Because', 898, 30.0, 1);

-- Target: 895 Therefore: 958 (basic healthcare is fundamental human right) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (895, 11, 'Therefore', 958, 100.0, 1);

-- === Voting rights chain ===
-- Target: 355 (voting rights expanded and protected)
-- Because: 182 (unassailable principle) 50%, 184 (exploited groups disenfranchised) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 11, 'Because', 182, 50.0, 1),
       (355, 11, 'Because', 184, 50.0, 1);

-- Target: 355 Therefore: 356 (universal voter registration) 50%, 357 (universal vote by mail) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 11, 'Therefore', 356, 50.0, 1),
       (355, 11, 'Therefore', 357, 50.0, 1);

-- === Wealth inequality chain ===
-- Target: 110 (wealth inequality beyond acceptable)
-- Because: 500 (too many struggle while few have everything) 60%, 501 (chronic anxiety) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 11, 'Because', 500, 60.0, 1),
       (110, 11, 'Because', 501, 40.0, 1);

-- Target: 110 Therefore: 745 (wealthy should take greater tax burden) 55%, 203 (happiness in equitable world) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 11, 'Therefore', 745, 55.0, 1),
       (110, 11, 'Therefore', 203, 45.0, 1);


-- ============================================================
-- PROFILE 12: LEONARD LARSON
-- 59yo White hardware store owner, Mankato MN, genuine moderate
-- ideology_score: 0 (true centrist)
-- Voted Obama twice, Romney, Biden. Knows customers by name.
-- Both parties too extreme. Fiscal responsibility. Small business = backbone.
-- Key trait: rejects BOTH partisan extremes. Pragmatic middle-ground only.
-- ============================================================

-- === ECONOMY / FISCAL RESPONSIBILITY (hardcoded) ===
CALL assertOpinion(1, 134, 12);   -- We shouldn't punish success (fiscal conservatism)
CALL assertOpinion(1, 136, 12);   -- Capitalism is the best system we got
CALL assertOpinion(1, 136, 12);   -- (idempotent)
CALL assertOpinion(1, 403, 12);   -- The pursuit of good governance should be a priority
CALL assertOpinion(1, 410, 12);   -- Regulations should be simple to understand
CALL assertOpinion(1, 411, 12);   -- Regulations should be designed to be efficiently enforced
CALL assertOpinion(1, 404, 12);   -- Constant vigilance needed to eliminate unnecessary regulations
CALL assertOpinion(-1, 193, 12);  -- No such thing as too much wealth concentration (rejects — unfair)
CALL assertOpinion(1, 189, 12);   -- There is a point of wealth inequality that should be found offensive
CALL assertOpinion(1, 200, 12);   -- More we are separated, less trust and social cohesion is possible
CALL assertOpinion(1, 275, 12);   -- Government projects do not have a profit motive to promote efficiency
CALL assertOpinion(1, 276, 12);   -- Nothing inherent making government enterprise inferior to private
CALL assertOpinion(1, 277, 12);   -- Some projects are better suited to government than private enterprise

-- === SMALL BUSINESS / LOCAL FOCUS (hardcoded) ===
CALL assertOpinion(1, 494, 12);   -- Workers should unionize (supports collective bargaining broadly)
CALL assertOpinion(1, 572, 12);   -- Governments should prioritize and efficiently execute public works
CALL assertOpinion(1, 242, 12);   -- Humans must treat each other with fellowship if we are to succeed
CALL assertOpinion(1, 447, 12);   -- A citizen should always have the best interests of fellow citizen at heart

-- === BOTH PARTIES TOO EXTREME (hardcoded) ===
CALL assertOpinion(-1, 107, 12);  -- Defund police (rejects — too radical left)
CALL assertOpinion(-1, 560, 12);  -- Police should be abolished (rejects — too radical left)
CALL assertOpinion(-1, 140, 12);  -- 2A absolutism — own whatever firearms necessary (rejects — too radical right)
CALL assertOpinion(-1, 230, 12);  -- Climate change is a hoax (rejects — denialism is radical)
CALL assertOpinion(-1, 106, 12);  -- Abolish prison (rejects — too radical)
CALL assertOpinion(-1, 609, 12);  -- Universal Basic Income (rejects — too radical, spending)
CALL assertOpinion(-1, 611, 12);  -- Open borders (rejects — too radical)
CALL assertOpinion(-1, 901, 12);  -- Medicare for All (rejects — too big a change too fast)

-- === MODERATE POLICE REFORM (some, not defund) ===
CALL assertOpinion(1, 145, 12);   -- Policing in America must be reformed (accepts moderate framing)
CALL assertOpinion(1, 148, 12);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 153, 12);   -- Police should exhaust all other options before shooting
CALL assertOpinion(-1, 561, 12);  -- Back the blue (rejects uncritical framing)
CALL assertOpinion(-1, 155, 12);  -- Police policies effectively racist too often (too strong for him)
CALL assertOpinion(1, 165, 12);   -- Police unions not racist; increase cultural training (pragmatic middle)

-- === CLIMATE (real, but not emergency framing) ===
CALL assertOpinion(1, 321, 12);   -- Climate change is an observable fact
CALL assertOpinion(1, 414, 12);   -- Should ramp up renewable energy ASAP
CALL assertOpinion(1, 416, 12);   -- Must let science be our guide
CALL assertOpinion(-1, 527, 12);  -- Will destroy economy before reversing warming (too alarmist rejection)
CALL assertOpinion(1, 530, 12);   -- Should reduce barriers to innovation addressing global warming
CALL assertOpinion(1, 478, 12);   -- Utilize nuclear power more readily

-- === HEALTHCARE REFORM (moderate, not single payer) ===
CALL assertOpinion(1, 895, 12);   -- US must reform its healthcare system
CALL assertOpinion(1, 896, 12);   -- US healthcare system has terrible health outcomes
CALL assertOpinion(1, 897, 12);   -- US healthcare system is most expensive in world
CALL assertOpinion(-1, 910, 12);  -- Government control = bureaucratic inefficient (partly accepts; complex)
CALL assertOpinion(1, 894, 12);   -- Government should optimize the healthcare system

-- === RANKED CHOICE (accepts — pragmatic election reform) ===
CALL assertOpinion(1, 696, 12);   -- Should support ranked choice voting
CALL assertOpinion(1, 698, 12);   -- RCV eliminates wasted votes / vote splitting
CALL assertOpinion(1, 701, 12);   -- RCV reduces negativity in campaigns

-- === GOVERNMENT FUNCTION ===
CALL assertOpinion(1, 409, 12);   -- Bureaucracy breeds corruption
CALL assertOpinion(1, 412, 12);   -- Government is inherently inefficient
CALL assertOpinion(-1, 405, 12);  -- Unchecked government would grow to ruin of nation (too alarmist)
CALL assertOpinion(1, 408, 12);   -- Government should be well-resourced
CALL assertOpinion(1, 433, 12);   -- Should avoid too many veto points in governance
CALL assertOpinion(1, 572, 12);   -- Governments should prioritize and efficiently execute public works

-- === VOTING RIGHTS ===
CALL assertOpinion(1, 355, 12);   -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 12);   -- Universal voter registration
CALL assertOpinion(1, 182, 12);   -- Right of every citizen to vote is unassailable principle

-- === FREE SPEECH / CANCEL CULTURE ===
CALL assertOpinion(1, 636, 12);   -- Legitimate cases of cancel culture excesses exist
CALL assertOpinion(1, 293, 12);   -- Cancel culture is merely criticism someone doesn't support
CALL assertOpinion(-1, 288, 12);  -- Cancel culture must be resisted (too broad a statement for him)

-- === FIREARMS (middle ground) ===
CALL assertOpinion(1, 141, 12);   -- Must be some limits on firepower citizens can have
CALL assertOpinion(1, 329, 12);   -- There is a certain degree of firepower that should be banned
CALL assertOpinion(1, 331, 12);   -- Gun laws limiting ownership are constitutional
CALL assertOpinion(-1, 333, 12);  -- Assault weapons banned for non-military (too specific for him)
CALL assertOpinion(1, 743, 12);   -- Magazine capacities should be limited

-- === FAITH ===
CALL assertOpinion(1, 428, 12);   -- Those that have faith can feel God's presence

-- ============================================================
-- ENDORSEMENTS: LEONARD LARSON (profileID=12)
-- ============================================================

-- === Good governance chain ===
-- Target: 403 (pursuit of good governance should be priority)
-- Because: 410 (regulations should be simple) 50%, 411 (efficiently enforced) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (403, 12, 'Because', 410, 50.0, 1),
       (403, 12, 'Because', 411, 50.0, 1);

-- Target: 403 Therefore: 572 (prioritize efficient public works) 55%, 433 (avoid too many veto points) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (403, 12, 'Therefore', 572, 55.0, 1),
       (403, 12, 'Therefore', 433, 45.0, 1);

-- === Police reform chain (moderate) ===
-- Target: 145 (policing must be reformed)
-- Because: 148 (de-escalation) 50%, 153 (exhaust options) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 12, 'Because', 148, 50.0, 1),
       (145, 12, 'Because', 153, 50.0, 1);

-- === Climate chain ===
-- Target: 321 (climate change observable fact)
-- Because: 416 (let science be our guide) 55%, 530 (reduce barriers to innovation) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (321, 12, 'Because', 416, 55.0, 1),
       (321, 12, 'Because', 530, 45.0, 1);

-- Target: 321 Therefore: 414 (ramp up renewables) 60%, 478 (nuclear power) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (321, 12, 'Therefore', 414, 60.0, 1),
       (321, 12, 'Therefore', 478, 40.0, 1);

-- === Healthcare chain (moderate reform) ===
-- Target: 895 (must reform healthcare)
-- Because: 896 (terrible outcomes) 40%, 897 (most expensive) 35%, 894 (government should optimize) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (895, 12, 'Because', 896, 40.0, 1),
       (895, 12, 'Because', 897, 35.0, 1),
       (895, 12, 'Because', 894, 25.0, 1);

-- === RCV chain ===
-- Target: 696 (support ranked choice voting)
-- Because: 698 (eliminates wasted votes) 50%, 701 (reduces negativity) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (696, 12, 'Because', 698, 50.0, 1),
       (696, 12, 'Because', 701, 50.0, 1);

-- === Voting rights chain ===
-- Target: 355 (voting rights expanded) Because: 182 (unassailable principle) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 12, 'Because', 182, 100.0, 1);

-- Target: 355 Therefore: 356 (universal voter registration) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 12, 'Therefore', 356, 100.0, 1);


-- ============================================================
-- PROFILE 13: MARIA MARTINEZ
-- 32yo Cuban-Puerto Rican single mother, Hialeah FL, two jobs
-- ideology_score: +5 (right-leaning, faith-driven, anti-communist)
-- Family fled Cuba — anti-communism is PRIMARY political filter.
-- Pentecostal. Hard work as moral virtue. Views govt programs as traps.
-- Hardcoded: socialism destroys countries; hard work is only path;
--            children's future is everything; govt programs are traps
-- ============================================================

-- === CAPITALISM / ANTI-SOCIALISM (hardcoded) ===
CALL assertOpinion(1, 134, 13);   -- We shouldn't punish success
CALL assertOpinion(1, 135, 13);   -- Not allowing people to keep what they earned is criminal
CALL assertOpinion(1, 136, 13);   -- Capitalism is the best system we got
CALL assertOpinion(1, 401, 13);   -- Free markets do a better job than any government ever could
CALL assertOpinion(-1, 609, 13);  -- UBI (rejects — socialism trap)
CALL assertOpinion(-1, 606, 13);  -- Government should give direct cash payments to poor (rejects)
CALL assertOpinion(-1, 137, 13);  -- Agreed ideal of wealth distribution is far less weighted to few (rejects as socialist)
CALL assertOpinion(-1, 138, 13);  -- The agreed upon ideal of wealth distribution (rejects)
CALL assertOpinion(-1, 139, 13);  -- Trustfund kids and internet billionaires don't deserve their money (rejects)
CALL assertOpinion(-1, 110, 13);  -- Degree of wealth inequality beyond acceptable (rejects framing)
CALL assertOpinion(-1, 611, 13);  -- Open borders (rejects)
CALL assertOpinion(-1, 107, 13);  -- Defund police (rejects — socialism/chaos)
CALL assertOpinion(-1, 560, 13);  -- Abolish police (rejects)
CALL assertOpinion(-1, 106, 13);  -- Abolish prison (rejects)
CALL assertOpinion(-1, 901, 13);  -- Medicare for All (rejects — socialism)
CALL assertOpinion(-1, 604, 13);  -- Government should eliminate poverty (rejects — govt trap)
CALL assertOpinion(-1, 605, 13);  -- Poverty can be eliminated if we choose to (too idealistic)
CALL assertOpinion(1, 607, 13);   -- If given handouts people will never learn to provide for themselves
CALL assertOpinion(1, 400, 13);   -- Government should stay out of the way
CALL assertOpinion(1, 405, 13);   -- Unchecked government would grow to ruin of nation

-- === HARD WORK / MERITOCRACY (hardcoded) ===
CALL assertOpinion(1, 197, 13);   -- Success should be rewarded with greater share of the spoils
CALL assertOpinion(1, 199, 13);   -- Society should reward people as motivation to strive for success
CALL assertOpinion(1, 201, 13);   -- Innovation should not be encumbered
CALL assertOpinion(1, 226, 13);   -- Freedom should never be infringed

-- === FAITH (Pentecostal — hardcoded) ===
CALL assertOpinion(1, 130, 13);   -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 13);   -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 13);   -- The faithful believe in His glory unconditionally
CALL assertOpinion(-1, 161, 13);  -- For all intents there is no such thing as a god (rejects)
CALL assertOpinion(1, 567, 13);   -- Only God can be sovereign
CALL assertOpinion(1, 568, 13);   -- To have no sovereign but God is what it means to be free

-- === ABORTION (anti-abortion hardcoded) ===
CALL assertOpinion(1, 124, 13);   -- A fetus has a human soul whose life should be protected
CALL assertOpinion(1, 125, 13);   -- Women should take responsibility for pregnancies rather than aborting
CALL assertOpinion(1, 126, 13);   -- Should be limit on how far along pregnancy can be and still aborted
CALL assertOpinion(-1, 127, 13);  -- Can't advocate for fetus without opposing woman's choice (rejects framing)
CALL assertOpinion(-1, 128, 13);  -- Limits on abortion access is cruel punishment (rejects)
CALL assertOpinion(-1, 129, 13);  -- Having a child should not be put on someone like punishment (rejects)
CALL assertOpinion(1, 902, 13);   -- Unborn children deserve right to life recognized
CALL assertOpinion(-1, 964, 13);  -- Contraception and abortion are necessary to modern civilization (rejects)
CALL assertOpinion(-1, 965, 13);  -- Abstinence is an impractical means of birth control (rejects)

-- === TRADITIONAL FAMILY ===
CALL assertOpinion(1, 785, 13);   -- Traditional gender roles exist for a reason
CALL assertOpinion(-1, 544, 13);  -- Trans men accepted as men, trans women as women (rejects)
CALL assertOpinion(-1, 142, 13);  -- There are only two genders (she leans this way; accepts)
CALL assertOpinion(1, 142, 13);   -- (updating: she accepts there are only two genders)

-- === POLICING (anti-crime framing, cautious on accountability) ===
CALL assertOpinion(1, 561, 13);   -- Back the blue
CALL assertOpinion(-1, 107, 13);  -- Defund police (already above, idempotent)
CALL assertOpinion(1, 145, 13);   -- Policing in America must be reformed (barely accepts — cautious)
CALL assertOpinion(1, 153, 13);   -- Police should exhaust all other options before shooting
CALL assertOpinion(-1, 155, 13);  -- Police policies effectively racist too often (rejects framing)
CALL assertOpinion(1, 217, 13);   -- Police not held accountable (accepts — she's seen corruption in Cuba context)

-- === COVID PRECAUTIONS (worked through it, practical) ===
CALL assertOpinion(1, 578, 13);   -- COVID-19 is a serious disease
CALL assertOpinion(1, 579, 13);   -- Take every reasonable precaution to avoid transmission
CALL assertOpinion(1, 580, 13);   -- Wear masks in public during COVID pandemic
CALL assertOpinion(1, 68, 13);    -- COVID vaccines sufficiently safe for broad distribution
CALL assertOpinion(-1, 67, 13);   -- FDA cannot be trusted to determine vaccine safety (rejects)
CALL assertOpinion(-1, 644, 13);  -- I will disobey COVID lockdown mandates (rejects — she followed precautions)

-- === EDUCATION ===
CALL assertOpinion(1, 416, 13);   -- Must let science be our guide
CALL assertOpinion(1, 504, 13);   -- Expertise is a good thing
CALL assertOpinion(-1, 1345, 13); -- Curriculums should be reviewed to combat white supremacy (rejects as political)
CALL assertOpinion(-1, 1347, 13); -- Kids should be taught white supremacy prevents BIPOC achievement (rejects)

-- === IMMIGRATION (complex — she came legally) ===
CALL assertOpinion(1, 615, 13);   -- There should always be a reasonable path to citizenship
CALL assertOpinion(-1, 954, 13);  -- America should welcome immigrants with few restrictions (rejects — rule of law)
CALL assertOpinion(1, 612, 13);   -- America should only allow the best of the best (she leans this way)
CALL assertOpinion(-1, 616, 13);  -- Asylum should be granted to all that seek it (rejects — open borders adjacent)
CALL assertOpinion(1, 617, 13);   -- Family separation at southern US border is an atrocity (accepts — family values)
CALL assertOpinion(1, 619, 13);   -- The separated children are completely innocent

-- === POLITICS ===
CALL assertOpinion(-1, 80, 13);   -- Trump 2024 (neutral-to-reject: she's skeptical of all parties)
CALL assertOpinion(-1, 90, 13);   -- GOP agenda is bad for America (rejects — she leans GOP on economics)
CALL assertOpinion(-1, 104, 13);  -- Vote for Democrats (rejects — Democrats = socialism to her)
CALL assertOpinion(-1, 574, 13);  -- American Democratic Party is terrible (she accepts this framing)
CALL assertOpinion(1, 574, 13);   -- (accept: Democratic Party is terrible)

-- ============================================================
-- ENDORSEMENTS: MARIA MARTINEZ (profileID=13)
-- ============================================================

-- === Capitalism chain ===
-- Target: 136 (capitalism is best system)
-- Because: 134 (shouldn't punish success) 50%, 401 (free markets better than govt) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (136, 13, 'Because', 134, 50.0, 1),
       (136, 13, 'Because', 401, 50.0, 1);

-- Target: 136 Therefore: 400 (government should stay out of the way) 55%, 201 (innovation should not be encumbered) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (136, 13, 'Therefore', 400, 55.0, 1),
       (136, 13, 'Therefore', 201, 45.0, 1);

-- === Faith chain ===
-- Target: 428 (those that have faith can feel God's presence)
-- Because: 130 (can't be certain God does not exist) 55%, 844 (faithful believe in His glory) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (428, 13, 'Because', 130, 55.0, 1),
       (428, 13, 'Because', 844, 45.0, 1);

-- === Abortion chain ===
-- Target: 124 (fetus has human soul)
-- Because: 130 (can't be certain God doesn't exist) 50%, 902 (unborn deserve right to life) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (124, 13, 'Because', 130, 50.0, 1),
       (124, 13, 'Because', 902, 50.0, 1);

-- Target: 124 Therefore: 125 (women should take responsibility) 55%, 126 (limit how far pregnancy can go) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (124, 13, 'Therefore', 125, 55.0, 1),
       (124, 13, 'Therefore', 126, 45.0, 1);

-- === Hard work chain ===
-- Target: 134 (shouldn't punish success)
-- Because: 197 (success rewarded with greater share) 50%, 199 (reward motivates striving) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (134, 13, 'Because', 197, 50.0, 1),
       (134, 13, 'Because', 199, 50.0, 1);

-- Target: 134 Therefore: 135 (not allowing people to keep what they earned is criminal) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (134, 13, 'Therefore', 135, 100.0, 1);

-- === COVID chain ===
-- Target: 578 (COVID is serious disease)
-- Because: 579 (take reasonable precautions) 50%, 580 (wear masks) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (578, 13, 'Because', 579, 50.0, 1),
       (578, 13, 'Because', 580, 50.0, 1);

-- Target: 578 Therefore: 68 (vaccines sufficiently safe) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (578, 13, 'Therefore', 68, 100.0, 1);


-- ============================================================
-- PROFILE 14: NATHAN NGUYEN
-- 26yo Vietnamese-American data analyst, Houston TX, non-voter by choice
-- ideology_score: -1 (heterodox — not consistently left or right)
-- Parents were Vietnamese refugees from communism.
-- Both parties = power not people. Data-literate, sardonically funny.
-- Student debt + housing = generational theft.
-- Hardcoded: both parties = power not people; student debt + housing = generational theft;
--            free inquiry over enforced consensus; his vote doesn't matter (self-aware trap)
-- ============================================================

-- === ANTI-PARTISAN (hardcoded both parties) ===
CALL assertOpinion(-1, 104, 14);  -- Vote for Democrats (rejects — both parties same)
CALL assertOpinion(-1, 94, 14);   -- Do not vote for Republican until major reforms (rejects — same energy)
CALL assertOpinion(-1, 90, 14);   -- GOP agenda is bad for America (too partisan for him)
CALL assertOpinion(-1, 574, 14);  -- American Democratic Party is terrible (rejects partisan framing)
CALL assertOpinion(1, 322, 14);   -- We should never put our full faith in the government
CALL assertOpinion(1, 323, 14);   -- Government is a human and imperfect endeavor
CALL assertOpinion(1, 409, 14);   -- Bureaucracy breeds corruption
CALL assertOpinion(1, 412, 14);   -- Government is inherently inefficient
CALL assertOpinion(1, 406, 14);   -- Power in all forms will never stop seeking greater power for itself
CALL assertOpinion(1, 205, 14);   -- Too few hold too much power in the world

-- === STUDENT DEBT / HOUSING (hardcoded generational theft) ===
CALL assertOpinion(1, 836, 14);   -- Home prices are unacceptably high
CALL assertOpinion(1, 736, 14);   -- Increasing housing density is an effective way to decrease cost
CALL assertOpinion(1, 722, 14);   -- Seattle should zone for more duplexes, triplexes, townhouses
CALL assertOpinion(1, 500, 14);   -- Too many struggle to meet material needs while few have everything
CALL assertOpinion(1, 110, 14);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 483, 14);   -- Wealth accumulation easy if you have money, near impossible if you don't

-- === MEANS TESTING CRITIQUE (hardcoded) ===
CALL assertOpinion(1, 59, 14);    -- Means testing policy proposals generally makes them worse
CALL assertOpinion(1, 268, 14);   -- A means test requires creating an in-group and out-group
CALL assertOpinion(1, 269, 14);   -- Standards used for a means test will always be crude and arbitrary
CALL assertOpinion(1, 270, 14);   -- Means-tested eligibility always results in misclassification
CALL assertOpinion(-1, 267, 14);  -- Means-testing avoids wasting government resources (rejects)
CALL assertOpinion(-1, 273, 14);  -- A means test helps avoid criticism that a policy is unneeded (rejects)
CALL assertOpinion(1, 271, 14);   -- Public goods should be available to all
CALL assertOpinion(1, 272, 14);   -- Means testing needlessly creates opposing interest groups

-- === FREE SPEECH / FREE INQUIRY (hardcoded) ===
CALL assertOpinion(1, 595, 14);   -- Speech cannot cause real harm (absolutist framing)
CALL assertOpinion(1, 596, 14);   -- Our right to free speech is absolute
CALL assertOpinion(-1, 597, 14);  -- Shouldn't be able to scream FIRE in crowded theater (rejects absolute)
CALL assertOpinion(1, 65, 14);    -- Views should only ever be attacked on grounds expressed by those views
CALL assertOpinion(1, 420, 14);   -- Free speech does not give you the right to manipulate people
CALL assertOpinion(1, 540, 14);   -- There should not be any sort of forbidden knowledge
CALL assertOpinion(1, 541, 14);   -- There is never an excuse to ban books
CALL assertOpinion(-1, 289, 14);  -- Cancel culture is harmful to academic freedom (too vague for him)
CALL assertOpinion(1, 293, 14);   -- Cancel culture is merely criticism someone does not support
CALL assertOpinion(1, 294, 14);   -- Cancel culture is too vague a term to be useful
CALL assertOpinion(1, 295, 14);   -- Dismissing criticism as cancel culture risks chilling useful discussion
CALL assertOpinion(-1, 296, 14);  -- Broad opposition to cancel culture adds legitimacy to deserving criticism (too in-group for him)

-- === STRUCTURAL RACISM (accepts exists, rejects some progressive framings) ===
CALL assertOpinion(1, 103, 14);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 175, 14);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(-1, 349, 14);  -- BLM movement is racist (rejects bad-faith framing)
CALL assertOpinion(-1, 350, 14);  -- BLM aims to diminish white people (rejects)
CALL assertOpinion(-1, 547, 14);  -- BLM is violent (rejects)
CALL assertOpinion(1, 317, 14);   -- Race is a social construct
CALL assertOpinion(-1, 101, 14);  -- Racism is made up (rejects)
CALL assertOpinion(-1, 1229, 14); -- It is perfectly okay to be white (rejects dismissive framing)

-- === POLICING (rejects defund AND back the blue uncritically) ===
CALL assertOpinion(-1, 107, 14);  -- Defund police (rejects — too radical)
CALL assertOpinion(-1, 561, 14);  -- Back the blue (rejects — uncritical)
CALL assertOpinion(-1, 560, 14);  -- Abolish police (rejects)
CALL assertOpinion(1, 217, 14);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 219, 14);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 14);   -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(1, 145, 14);   -- Policing in America must be reformed (accepts middle framing)
CALL assertOpinion(1, 148, 14);   -- Police should use de-escalation techniques

-- === CLIMATE (accepts real, rejects both denial AND emergency framing as overblown) ===
CALL assertOpinion(1, 321, 14);   -- Human-influenced climate change is observable fact
CALL assertOpinion(-1, 230, 14);  -- Climate change is a hoax (rejects denial)
CALL assertOpinion(-1, 527, 14);  -- Will destroy economy before reversing warming (too alarmist for him)
CALL assertOpinion(1, 530, 14);   -- Reduce barriers to innovation addressing global warming
CALL assertOpinion(1, 416, 14);   -- Let science be our guide
CALL assertOpinion(1, 414, 14);   -- Ramp up renewable energy ASAP

-- === SOCIAL MEDIA CRITICISM ===
CALL assertOpinion(1, 367, 14);   -- Social media is bad (as designed)
CALL assertOpinion(1, 368, 14);   -- Engagement pursuit discourages resolution
CALL assertOpinion(1, 463, 14);   -- Social media fewer safeguards against misinformation
CALL assertOpinion(1, 588, 14);   -- Social media democratizes judgment
CALL assertOpinion(1, 590, 14);   -- Social media gives impression of common wisdom that isn't common
CALL assertOpinion(1, 592, 14);   -- Everyone thinks they have common sense like most think they're above average drivers
CALL assertOpinion(1, 591, 14);   -- When standards differ, may mean YOUR views are out of step

-- === GOVERNMENT INEFFICIENCY ===
CALL assertOpinion(1, 275, 14);   -- Government projects do not have profit motive to promote efficiency
CALL assertOpinion(1, 276, 14);   -- Nothing inherent making government enterprise inferior
CALL assertOpinion(1, 277, 14);   -- Some projects better suited to government

-- === FREE MARKET VS GOVT ===
CALL assertOpinion(1, 400, 14);   -- Government should stay out of the way (data: often true)
CALL assertOpinion(1, 401, 14);   -- Free markets do better than government (conditionally)
CALL assertOpinion(1, 402, 14);   -- Free market is a complex legal-institutional construct requiring rules

-- === MISC HETERODOX ===
CALL assertOpinion(1, 57, 14);    -- Should remain skeptical of anything unverified under controlled study
CALL assertOpinion(1, 100, 14);   -- No system can be completely fair
CALL assertOpinion(1, 200, 14);   -- More we are separated the less trust and social cohesion is possible
CALL assertOpinion(1, 203, 14);   -- Happiness maximized in a more equitable world

-- ============================================================
-- ENDORSEMENTS: NATHAN NGUYEN (profileID=14)
-- ============================================================

-- === Both parties chain ===
-- Target: 322 (never put full faith in government)
-- Because: 323 (government is human and imperfect) 50%, 406 (power always seeks more power) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (322, 14, 'Because', 323, 50.0, 1),
       (322, 14, 'Because', 406, 50.0, 1);

-- Target: 322 Therefore: 409 (bureaucracy breeds corruption) 50%, 412 (govt inherently inefficient) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (322, 14, 'Therefore', 409, 50.0, 1),
       (322, 14, 'Therefore', 412, 50.0, 1);

-- === Housing chain ===
-- Target: 836 (home prices unacceptably high)
-- Because: 483 (wealth accumulation near impossible without wealth) 55%, 500 (too many struggle) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (836, 14, 'Because', 483, 55.0, 1),
       (836, 14, 'Because', 500, 45.0, 1);

-- Target: 836 Therefore: 736 (housing density decreases cost) 55%, 722 (zone for duplexes/triplexes) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (836, 14, 'Therefore', 736, 55.0, 1),
       (836, 14, 'Therefore', 722, 45.0, 1);

-- === Means testing chain ===
-- Target: 59 (means testing makes policies worse)
-- Because: 268 (creates in-group/out-group) 35%, 269 (standards always crude) 35%, 270 (always misclassification) 30%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (59, 14, 'Because', 268, 35.0, 1),
       (59, 14, 'Because', 269, 35.0, 1),
       (59, 14, 'Because', 270, 30.0, 1);

-- Target: 59 Therefore: 271 (public goods available to all) 55%, 272 (creates opposing interest groups) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (59, 14, 'Therefore', 271, 55.0, 1),
       (59, 14, 'Therefore', 272, 45.0, 1);

-- === Free speech chain ===
-- Target: 596 (free speech is absolute)
-- Because: 595 (speech cannot cause real harm) 50%, 540 (no forbidden knowledge) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (596, 14, 'Because', 595, 50.0, 1),
       (596, 14, 'Because', 540, 50.0, 1);

-- Target: 596 Therefore: 541 (never excuse to ban books) 55%, 65 (views only attacked on own grounds) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (596, 14, 'Therefore', 541, 55.0, 1),
       (596, 14, 'Therefore', 65, 45.0, 1);

-- === Social media chain ===
-- Target: 367 (social media is bad)
-- Because: 368 (engagement discourages resolution) 40%, 463 (fewer safeguards) 35%, 590 (false common wisdom) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (367, 14, 'Because', 368, 40.0, 1),
       (367, 14, 'Because', 463, 35.0, 1),
       (367, 14, 'Because', 590, 25.0, 1);

-- === Police reform (qualified immunity) chain ===
-- Target: 217 (police not held accountable)
-- Because: 219 (qualified immunity) 55%, 539 (immunity unjustly shields) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 14, 'Because', 219, 55.0, 1),
       (217, 14, 'Because', 539, 45.0, 1);

-- Target: 217 Therefore: 145 (policing must be reformed) 55%, 148 (de-escalation) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 14, 'Therefore', 145, 55.0, 1),
       (217, 14, 'Therefore', 148, 45.0, 1);

-- === Free market vs govt chain ===
-- Target: 402 (free market is complex legal-institutional construct)
-- Because: 276 (nothing inherent making govt inferior) 50%, 277 (some projects better for govt) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (402, 14, 'Because', 276, 50.0, 1),
       (402, 14, 'Because', 277, 50.0, 1);


-- ============================================================
-- PROFILE 15: OLIVIA O'BRIEN
-- 48yo White divorced assistant principal, suburban Waukesha WI
-- ideology_score: -4 (center-left, pragmatic, exhausted)
-- Voted Obama, Trump 2016 (regrets), Biden. Sees ideologues daily.
-- Hardcoded: children's wellbeing not partisan; teachers underpaid;
--            mental health is healthcare; made mistake in 2016
-- ============================================================

-- === EDUCATION / TEACHERS UNDERPAID (hardcoded) ===
CALL assertOpinion(1, 359, 15);   -- Teachers should be prioritized for COVID vaccines to reopen schools
CALL assertOpinion(1, 364, 15);   -- Health and safety of students, teachers, and staff is paramount
CALL assertOpinion(1, 748, 15);   -- School districts should focus on upgrading ventilation in schools
CALL assertOpinion(1, 413, 15);   -- Many schools lack necessary resources to protect from COVID spread
CALL assertOpinion(1, 362, 15);   -- Schools should only reopen once students, teachers, and staff are safe
CALL assertOpinion(-1, 361, 15);  -- Schools should be reopened immediately ending COVID lockdowns (rejects — safety first)
CALL assertOpinion(1, 363, 15);   -- Schools are safe to reopen from COVID lockdowns now (with right conditions)
CALL assertOpinion(1, 360, 15);   -- Students' long-term wellbeing at risk the longer lockdowns continue
CALL assertOpinion(1, 365, 15);   -- Guidelines to reopen schools that are scientifically sound

-- === MENTAL HEALTH IS HEALTHCARE (hardcoded) ===
CALL assertOpinion(1, 895, 15);   -- US must reform its healthcare system
CALL assertOpinion(1, 896, 15);   -- US healthcare has terrible health outcomes
CALL assertOpinion(1, 897, 15);   -- US healthcare most expensive in world
CALL assertOpinion(1, 898, 15);   -- US healthcare system is inequitable
CALL assertOpinion(1, 958, 15);   -- Basic healthcare is a fundamental human right
CALL assertOpinion(1, 894, 15);   -- Government should optimize the healthcare system
CALL assertOpinion(1, 909, 15);   -- Relying on private employers for health insurance is outdated model
CALL assertOpinion(-1, 910, 15);  -- Government control creates bureaucratic inefficient system (rejects)

-- === CHILDREN'S SAFETY / WELLBEING (hardcoded) ===
CALL assertOpinion(1, 367, 15);   -- Social media is bad (sees impact on kids daily)
CALL assertOpinion(1, 368, 15);   -- Engagement pursuit discourages resolution
CALL assertOpinion(1, 463, 15);   -- Social media fewer safeguards against misinformation
CALL assertOpinion(1, 374, 15);   -- Social media allows consuming only content predisposed to liking
CALL assertOpinion(1, 378, 15);   -- Social media incentivized to increase screen time
CALL assertOpinion(1, 590, 15);   -- Social media gives false impression of common wisdom

-- === POLICING (school safety daily — reform YES, defund NO) ===
CALL assertOpinion(-1, 107, 15);  -- Defund police (rejects — school safety daily concern)
CALL assertOpinion(-1, 106, 15);  -- Abolish prison (rejects)
CALL assertOpinion(-1, 560, 15);  -- Abolish police (rejects)
CALL assertOpinion(1, 145, 15);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 15);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 153, 15);   -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 15);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 217, 15);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 219, 15);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 15);   -- Qualified immunity unjustly shields police from accountability

-- === HEALTHCARE ===
-- (covered above in hardcoded section)

-- === VOTING RIGHTS ===
CALL assertOpinion(1, 355, 15);   -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 15);   -- We should have universal voter registration
CALL assertOpinion(1, 182, 15);   -- Right of every citizen to vote is unassailable principle
CALL assertOpinion(1, 184, 15);   -- Most historically exploited groups also disenfranchised

-- === RANKED CHOICE VOTING ===
CALL assertOpinion(1, 696, 15);   -- We should support ranked choice voting
CALL assertOpinion(1, 697, 15);   -- WA voters should contact reps for SBH1156
CALL assertOpinion(1, 698, 15);   -- RCV eliminates wasted votes / vote splitting

-- === CANCEL CULTURE (nuanced — accepts some overreach but rejects bad faith) ===
CALL assertOpinion(1, 636, 15);   -- There are legitimate cases of cancel culture excesses
CALL assertOpinion(-1, 288, 15);  -- Cancel culture must be resisted (too broad, bad-faith framing)
CALL assertOpinion(1, 756, 15);   -- Much criticism of cancel culture is bad faith attempt to work the refs
CALL assertOpinion(1, 293, 15);   -- Cancel culture is merely criticism someone does not support
CALL assertOpinion(1, 654, 15);   -- Publisher choosing not to publish is not cancel culture
CALL assertOpinion(1, 295, 15);   -- Dismissing criticism as cancel culture risks chilling useful discussion

-- === BLM (supports goals, nuanced on tactics) ===
CALL assertOpinion(1, 546, 15);   -- BLM movement activists deserve support
CALL assertOpinion(-1, 547, 15);  -- BLM is violent (rejects bad framing)
CALL assertOpinion(-1, 349, 15);  -- BLM movement is racist (rejects)
CALL assertOpinion(1, 603, 15);   -- Cities with significant BLM protests had reduction in police homicides

-- === RACE / IMPLICIT BIAS ===
CALL assertOpinion(1, 175, 15);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 484, 15);   -- We all have implicit bias
CALL assertOpinion(1, 485, 15);   -- Implicit bias training should be more common
CALL assertOpinion(1, 320, 15);   -- All people deserve to be treated equally
CALL assertOpinion(-1, 101, 15);  -- Racism is made up (rejects)

-- === COVID SCHOOL REOPENING ===
CALL assertOpinion(1, 578, 15);   -- COVID is a serious disease
CALL assertOpinion(1, 579, 15);   -- Take every reasonable precaution against transmission
CALL assertOpinion(1, 580, 15);   -- Wear masks during COVID
CALL assertOpinion(1, 68, 15);    -- COVID vaccines sufficiently safe for broad distribution
CALL assertOpinion(-1, 67, 15);   -- FDA cannot be trusted to determine vaccine safety (rejects)

-- === WEALTH / ECONOMY (center-left) ===
CALL assertOpinion(1, 110, 15);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 745, 15);   -- Wealthy should take greater proportion of tax burden
CALL assertOpinion(1, 500, 15);   -- Too many struggle to meet material needs
CALL assertOpinion(-1, 193, 15);  -- No such thing as too much wealth concentration (rejects)

-- === SCIENCE / EXPERTISE ===
CALL assertOpinion(1, 416, 15);   -- Must let science be our guide
CALL assertOpinion(1, 504, 15);   -- Expertise is a good thing
CALL assertOpinion(1, 416, 15);   -- (idempotent)

-- === PARTISAN REJECTS (exhausted pragmatist) ===
CALL assertOpinion(-1, 80, 15);   -- Trump 2024 (rejects — made that mistake)
CALL assertOpinion(1, 100, 15);   -- No system can be completely fair
CALL assertOpinion(1, 242, 15);   -- Humans must treat each other with fellowship to succeed
CALL assertOpinion(1, 200, 15);   -- More we are separated, less trust and social cohesion

-- ============================================================
-- ENDORSEMENTS: OLIVIA O'BRIEN (profileID=15)
-- ============================================================

-- === School safety / COVID reopening chain ===
-- Target: 362 (schools should only reopen when safe)
-- Because: 364 (health and safety of all paramount) 45%, 413 (schools lack resources to protect) 35%, 360 (long-term wellbeing at risk) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (362, 15, 'Because', 364, 45.0, 1),
       (362, 15, 'Because', 413, 35.0, 1),
       (362, 15, 'Because', 360, 20.0, 1);

-- Target: 362 Therefore: 359 (teachers prioritized for vaccines) 55%, 748 (upgrade ventilation) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (362, 15, 'Therefore', 359, 55.0, 1),
       (362, 15, 'Therefore', 748, 45.0, 1);

-- === Healthcare / mental health chain ===
-- Target: 895 (US must reform healthcare)
-- Because: 896 (terrible outcomes) 35%, 897 (most expensive) 35%, 898 (inequitable) 30%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (895, 15, 'Because', 896, 35.0, 1),
       (895, 15, 'Because', 897, 35.0, 1),
       (895, 15, 'Because', 898, 30.0, 1);

-- Target: 895 Therefore: 958 (basic healthcare fundamental right) 60%, 909 (employer insurance outdated) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (895, 15, 'Therefore', 958, 60.0, 1),
       (895, 15, 'Therefore', 909, 40.0, 1);

-- === Police reform chain ===
-- Target: 145 (policing must be reformed)
-- Because: 217 (not held accountable) 40%, 219 (qualified immunity) 35%, 148 (need de-escalation) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 15, 'Because', 217, 40.0, 1),
       (145, 15, 'Because', 219, 35.0, 1),
       (145, 15, 'Because', 148, 25.0, 1);

-- Target: 145 Therefore: 153 (exhaust options before shooting) 55%, 154 (duty to intervene) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 15, 'Therefore', 153, 55.0, 1),
       (145, 15, 'Therefore', 154, 45.0, 1);

-- === Social media harms to kids chain ===
-- Target: 367 (social media is bad)
-- Because: 368 (engagement discourages resolution) 35%, 374 (echo chambers) 35%, 378 (incentivized for screen time) 30%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (367, 15, 'Because', 368, 35.0, 1),
       (367, 15, 'Because', 374, 35.0, 1),
       (367, 15, 'Because', 378, 30.0, 1);

-- Target: 367 Therefore: 463 (fewer safeguards against misinformation) 55%, 590 (false common wisdom) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (367, 15, 'Therefore', 463, 55.0, 1),
       (367, 15, 'Therefore', 590, 45.0, 1);

-- === Voting rights chain ===
-- Target: 355 (voting rights expanded and protected)
-- Because: 182 (unassailable principle) 55%, 184 (exploited groups disenfranchised) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 15, 'Because', 182, 55.0, 1),
       (355, 15, 'Because', 184, 45.0, 1);

-- Target: 355 Therefore: 356 (universal voter registration) 55%, 696 (ranked choice) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 15, 'Therefore', 356, 55.0, 1),
       (355, 15, 'Therefore', 696, 45.0, 1);

-- === RCV chain ===
-- Target: 696 (support RCV) Because: 698 (eliminates wasted votes) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (696, 15, 'Because', 698, 100.0, 1);

-- === Cancel culture (nuanced) chain ===
-- Target: 636 (legitimate cases of cancel culture excesses)
-- Because: 293 (it's merely criticism) 50%, 654 (publisher choice not cancel culture) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (636, 15, 'Because', 293, 50.0, 1),
       (636, 15, 'Because', 654, 50.0, 1);

-- Target: 636 Therefore: 756 (much criticism is bad faith) 55%, 295 (dismissing as cancel culture chills discussion) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (636, 15, 'Therefore', 756, 55.0, 1),
       (636, 15, 'Therefore', 295, 45.0, 1);

-- === Wealth chain ===
-- Target: 110 (wealth inequality beyond acceptable)
-- Because: 500 (too many struggle while few have everything) 60%, 745 (wealthy should take greater burden) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 15, 'Because', 500, 60.0, 1),
       (110, 15, 'Because', 745, 40.0, 1);

-- Target: 110 Therefore: 200 (more separation = less trust) 55%, 242 (must treat each other with fellowship) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (110, 15, 'Therefore', 200, 55.0, 1),
       (110, 15, 'Therefore', 242, 45.0, 1);
