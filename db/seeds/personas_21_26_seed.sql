-- personas_21_26_seed.sql
-- Opinion and endorsement population for profileIDs 21-26 (Batch 4 of 4)
-- Ursula Underwood (21), Victor Vasquez (22), Wendy Walsh (23),
-- Xavier Xiong (24), Yvonne Young (25), Zachary Zeller (26)
--
-- Weights within every (targArgID, profileID, endorseType) group sum to EXACTLY 100.0
-- assertOpinion(op, argID, proID): op=1 accept, op=-1 reject
-- INSERT IGNORE INTO ENDORSEMENT VALUES(targArgID, profileID, endorseType, supportingArgID, weight, NOW(), NOW(), TRUE)
-- Skipped: args 1-55 (pre-existing GMO data)
--
-- Association/endorsement structure derived from ENDORSEMENT table relType data

USE vestigette;

-- ============================================================
-- PROFILE 21: URSULA UNDERWOOD
-- 42yo White evangelical Baptist stay-at-home mother, rural Indiana
-- Homeschools 4 children. Faith = operating system. Parental authority
-- over children's formation is non-negotiable. Anti-abortion always.
-- LGBTQ ideology near children = harmful.
-- ideology_score: 9 (strong conservative/social conservative)
-- ============================================================

-- === FAITH ===
CALL assertOpinion(1, 130, 21);  -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 21);  -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 21);  -- The faithful believe in His glory unconditionally
CALL assertOpinion(1, 1385, 21); -- Jesus is my Lord and Savior!
CALL assertOpinion(1, 1386, 21); -- Jesus is God's only son
CALL assertOpinion(1, 1440, 21); -- The Bible is the word of God
CALL assertOpinion(-1, 161, 21); -- For all intents there is no such thing as a god

-- === ABORTION / PRO-LIFE ===
CALL assertOpinion(1, 124, 21);  -- A fetus has a human soul whose life should be protected
CALL assertOpinion(1, 125, 21);  -- Women should take responsibility for their pregnancies rather than aborting
CALL assertOpinion(1, 126, 21);  -- There should be a limit on how far along a pregnancy can be and still be aborted
CALL assertOpinion(1, 902, 21);  -- Unborn children deserve their right to life to be recognized
CALL assertOpinion(1, 1387, 21); -- Life begins at conception
CALL assertOpinion(-1, 127, 21); -- You can't advocate for a fetus without opposing a woman's right to choose
CALL assertOpinion(-1, 128, 21); -- Limits on abortion access are cruel punishment
CALL assertOpinion(-1, 129, 21); -- Having a child should not be put upon someone like a punishment
CALL assertOpinion(-1, 964, 21); -- Contraception and abortion are necessary to modern civilization
CALL assertOpinion(-1, 977, 21); -- 'Pro-Life' is a misnomer

-- === PARENTAL AUTHORITY / SCHOOL / GOVERNMENT OVERREACH ===
CALL assertOpinion(-1, 672, 21); -- School boards should be appointed by rather than independent of government
CALL assertOpinion(-1, 1345, 21); -- Curriculums should be reviewed and adjusted to combat white supremacy
CALL assertOpinion(-1, 1347, 21); -- Kids should be taught white supremacy will prevent BIPOC achievement
CALL assertOpinion(-1, 1351, 21); -- Kids should be taught the existence of white supremacy in the US

-- === TRADITIONAL FAMILY / LGBTQ ===
CALL assertOpinion(1, 142, 21);  -- There are only two genders
CALL assertOpinion(1, 785, 21);  -- Traditional gender roles exist for a reason
CALL assertOpinion(1, 849, 21);  -- The first duty as a parent/protector is as protector, which men excel at
CALL assertOpinion(-1, 143, 21); -- Homosexuality is a perversion of nature (hardcoded reject of 143)
CALL assertOpinion(-1, 144, 21); -- Loving who you want causes no justifiable harm (she disagrees in context of children)
CALL assertOpinion(-1, 315, 21); -- A person does not choose their gender
CALL assertOpinion(-1, 316, 21); -- Gender is innate
CALL assertOpinion(-1, 543, 21); -- We should accept people for who they are (trans acceptance framing)
CALL assertOpinion(-1, 544, 21); -- Trans men should be accepted as men / trans women as women
CALL assertOpinion(-1, 790, 21); -- Trans girls should not be forced to play boys sports
CALL assertOpinion(-1, 795, 21); -- Support trans women by not undermining their gender identity
CALL assertOpinion(-1, 797, 21); -- Trans girls should be permitted to participate in women's athletics
CALL assertOpinion(-1, 800, 21); -- Trans girls in sports is an overblown proxy argument
CALL assertOpinion(-1, 801, 21); -- We should leave trans kids out of culture war battles
CALL assertOpinion(1, 791, 21);  -- Sports should be separated by biological sex
CALL assertOpinion(1, 793, 21);  -- Trans girls should be forced to play among boys if they wish to participate
CALL assertOpinion(-1, 1312, 21); -- Laws banning trans kids from participating in sports by gender identity are wrong
CALL assertOpinion(-1, 1425, 21); -- Being transgender or non-binary is not a mental disorder
CALL assertOpinion(-1, 1614, 21); -- Trans kids should have unfettered opportunities to socialize as their gender

-- === CANCEL CULTURE / FREE SPEECH ===
CALL assertOpinion(1, 288, 21);  -- 'Cancel culture' must be resisted
CALL assertOpinion(1, 291, 21);  -- People should not be fired for their political views
CALL assertOpinion(1, 297, 21);  -- Cancel culture promotes conformist liberal norms re: social issues
CALL assertOpinion(1, 298, 21);  -- Cancel culture is a modern form of ostracism
CALL assertOpinion(1, 651, 21);  -- Dr. Seuss books are another victim of social justice warriors
CALL assertOpinion(1, 652, 21);  -- The Dr. Seuss book banning is tantamount to digital book burning
CALL assertOpinion(-1, 293, 21); -- Cancel culture is merely criticism someone doesn't support
CALL assertOpinion(-1, 295, 21); -- Dismissing criticism as cancel culture risks chilling discussion

-- === FISCAL CONSERVATISM / FREE MARKET ===
CALL assertOpinion(1, 134, 21);  -- We shouldn't punish success
CALL assertOpinion(1, 135, 21);  -- Not allowing people to keep what they earned is criminal
CALL assertOpinion(1, 136, 21);  -- Capitalism is the best system we got
CALL assertOpinion(1, 400, 21);  -- Government should stay out of the way
CALL assertOpinion(1, 401, 21);  -- Free markets do a better job than any government
CALL assertOpinion(1, 412, 21);  -- Government is inherently inefficient
CALL assertOpinion(1, 601, 21);  -- Welfare should ask recipients to do their part
CALL assertOpinion(1, 607, 21);  -- If people are given handouts they will never learn to provide
CALL assertOpinion(-1, 110, 21); -- The degree of wealth inequality in America is beyond acceptable
CALL assertOpinion(-1, 192, 21); -- Wealth taxes should control offensive levels of wealth
CALL assertOpinion(-1, 604, 21); -- Government should eliminate poverty
CALL assertOpinion(-1, 606, 21); -- Government should give direct cash payments to the poor

-- === POLICING / LAW AND ORDER ===
CALL assertOpinion(1, 561, 21);  -- Back the blue
CALL assertOpinion(1, 777, 21);  -- Criminals forfeit their rights when they choose a life of crime
CALL assertOpinion(-1, 107, 21); -- Defund police departments
CALL assertOpinion(-1, 560, 21); -- The police should be abolished
CALL assertOpinion(-1, 349, 21); -- The Black Lives Matter movement is racist (lean accept)
CALL assertOpinion(-1, 546, 21); -- BLM activists deserve support
CALL assertOpinion(-1, 551, 21); -- BLM is peaceful but exists amid oppositional violence

-- === HEALTHCARE ===
CALL assertOpinion(-1, 901, 21); -- US should implement universal single-payer Medicare for All
CALL assertOpinion(-1, 958, 21); -- Basic healthcare is a fundamental human right (govt role framing)
CALL assertOpinion(1, 910, 21);  -- Government control of healthcare creates bureaucratic inefficiency
CALL assertOpinion(1, 920, 21);  -- Government programs are ineffective

-- === GOVERNMENT / SKEPTICISM ===
CALL assertOpinion(1, 322, 21);  -- We should never put our full faith in the government
CALL assertOpinion(1, 323, 21);  -- Government is a human and imperfect endeavor


-- === ENDORSEMENTS: URSULA UNDERWOOD (profileID=21) ===

-- Cluster 1: Pro-life chain
-- Target: 124 (fetus has human soul, life protected)
-- Because: 1387 (life begins at conception) 60%, 130 (can't be certain God doesn't exist) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (124, 21, 'Because', 1387, 60.0, NOW(), NOW(), TRUE),
       (124, 21, 'Because', 130, 40.0, NOW(), NOW(), TRUE);

-- Target: 124 Therefore: 902 (unborn children deserve right to life) 55%, 125 (take responsibility) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (124, 21, 'Therefore', 902, 55.0, NOW(), NOW(), TRUE),
       (124, 21, 'Therefore', 125, 45.0, NOW(), NOW(), TRUE);

-- Cluster 2: Rebut pro-abortion arguments
-- Target: 127 (can't advocate for fetus without opposing woman's right) -- REJECTED
-- Rebuttal: 124 (fetus has soul) 55%, 902 (unborn deserve right to life) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (127, 21, 'Rebuttal', 124, 55.0, NOW(), NOW(), TRUE),
       (127, 21, 'Rebuttal', 902, 45.0, NOW(), NOW(), TRUE);

-- Target: 128 (abortion limits are cruel punishment) -- REJECTED
-- Rebuttal: 124 (fetus has soul) 60%, 1387 (life begins at conception) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (128, 21, 'Rebuttal', 124, 60.0, NOW(), NOW(), TRUE),
       (128, 21, 'Rebuttal', 1387, 40.0, NOW(), NOW(), TRUE);

-- Cluster 3: Traditional family / gender roles
-- Target: 785 (traditional gender roles exist for a reason)
-- Because: 142 (two genders) 55%, 849 (men as protectors) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (785, 21, 'Because', 142, 55.0, NOW(), NOW(), TRUE),
       (785, 21, 'Because', 849, 45.0, NOW(), NOW(), TRUE);

-- Cluster 4: Rebut trans acceptance
-- Target: 795 (support trans women by not undermining gender identity) -- REJECTED
-- Rebuttal: 142 (two genders) 55%, 791 (sports by biological sex) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (795, 21, 'Rebuttal', 142, 55.0, NOW(), NOW(), TRUE),
       (795, 21, 'Rebuttal', 791, 45.0, NOW(), NOW(), TRUE);

-- Cluster 5: Cancel culture
-- Target: 288 (cancel culture must be resisted)
-- Because: 297 (promotes conformist liberal norms) 50%, 291 (people fired for views) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (288, 21, 'Because', 297, 50.0, NOW(), NOW(), TRUE),
       (288, 21, 'Because', 291, 50.0, NOW(), NOW(), TRUE);

-- Target: 288 Therefore: 651 (Dr. Seuss victim of SJWs) 55%, 652 (book burning) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (288, 21, 'Therefore', 651, 55.0, NOW(), NOW(), TRUE),
       (288, 21, 'Therefore', 652, 45.0, NOW(), NOW(), TRUE);

-- Cluster 6: Faith chain
-- Target: 428 (those with faith can feel God's presence)
-- Because: 130 (can't be certain God doesn't exist) 55%, 844 (believe in His glory) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (428, 21, 'Because', 130, 55.0, NOW(), NOW(), TRUE),
       (428, 21, 'Because', 844, 45.0, NOW(), NOW(), TRUE);

-- Target: 428 Therefore: 1385 (Jesus is Lord) 55%, 1440 (Bible is word of God) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (428, 21, 'Therefore', 1385, 55.0, NOW(), NOW(), TRUE),
       (428, 21, 'Therefore', 1440, 45.0, NOW(), NOW(), TRUE);

-- Cluster 7: Free market / anti-redistribution
-- Target: 136 (capitalism is the best system we got)
-- Because: 134 (shouldn't punish success) 55%, 401 (free markets do better) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (136, 21, 'Because', 134, 55.0, NOW(), NOW(), TRUE),
       (136, 21, 'Because', 401, 45.0, NOW(), NOW(), TRUE);

-- Target: 136 Therefore: 400 (government stay out) 55%, 412 (government inefficient) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (136, 21, 'Therefore', 400, 55.0, NOW(), NOW(), TRUE),
       (136, 21, 'Therefore', 412, 45.0, NOW(), NOW(), TRUE);

-- Cluster 8: Back the blue
-- Target: 561 (back the blue)
-- Rebuttal: 105 (police kill Black people) -- she rejects 105 so this is a rebuttal for arg 107
-- Target: 107 (defund) -- REJECTED
-- Rebuttal: 561 (back the blue) 55%, 777 (criminals forfeit rights) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (107, 21, 'Rebuttal', 561, 55.0, NOW(), NOW(), TRUE),
       (107, 21, 'Rebuttal', 777, 45.0, NOW(), NOW(), TRUE);


-- ============================================================
-- PROFILE 22: VICTOR VASQUEZ
-- 30yo Black financial analyst, Atlanta GA, Morehouse grad
-- Non-voter by considered choice. Black wealth-building = most durable
-- path to liberation. Intellectual independence. Corporate DEI = theater.
-- ideology_score: 0 (independent / ideologically eclectic)
-- ============================================================

-- === BLACK WEALTH BUILDING / ECONOMIC INEQUALITY ===
CALL assertOpinion(1, 110, 22);  -- Degree of wealth inequality in America is beyond acceptable
CALL assertOpinion(1, 500, 22);  -- Too many struggle to meet immediate material needs
CALL assertOpinion(1, 481, 22);  -- Rules for acquiring wealth should be fundamentally changed
CALL assertOpinion(1, 482, 22);  -- A fair game should start easier then get harder as you advance
CALL assertOpinion(1, 483, 22);  -- Wealth accumulation is easy if you have money, near impossible if you don't
CALL assertOpinion(1, 136, 22);  -- Capitalism is the best system we got (as tool for Black empowerment, nuanced)
CALL assertOpinion(1, 501, 22);  -- People living one unexpected expense away have chronic anxiety
CALL assertOpinion(1, 502, 22);  -- Powers that be label the pain of financial precarity as laziness

-- === RACIAL DISPARITIES (accept data, reject some progressive framing) ===
CALL assertOpinion(1, 103, 22);  -- Black people convicted of crimes at grossly disproportionate rate
CALL assertOpinion(1, 169, 22);  -- Non-white males statistically paid less per dollar
CALL assertOpinion(1, 175, 22);  -- Inherent racial bias has far-reaching effects
CALL assertOpinion(-1, 101, 22); -- Racism is made up
CALL assertOpinion(-1, 108, 22); -- Black people just commit more crime
CALL assertOpinion(-1, 118, 22); -- Black people are inherently less civil
CALL assertOpinion(-1, 1197, 22); -- In today's culture white people most commonly persecuted

-- === POLICING (accountability YES, abolition NO) ===
CALL assertOpinion(1, 145, 22);  -- Policing in America must be reformed
CALL assertOpinion(1, 217, 22);  -- Police are not held accountable to a just degree
CALL assertOpinion(1, 218, 22);  -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 22);  -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 22);  -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(-1, 107, 22); -- Defund police departments (he rejects this)
CALL assertOpinion(-1, 560, 22); -- The police should be abolished (he rejects this)
CALL assertOpinion(-1, 561, 22); -- Back the blue (uncritical — he rejects this framing)
CALL assertOpinion(-1, 104, 22); -- Vote for Democrats (he rejects partisan cheerleading)

-- === BLM (nuanced — supports goals, skeptical of some tactics) ===
CALL assertOpinion(1, 546, 22);  -- BLM activists deserve support
CALL assertOpinion(1, 603, 22);  -- Cities with significant BLM protests had reduction in police homicides
CALL assertOpinion(-1, 349, 22); -- BLM movement is racist
CALL assertOpinion(-1, 350, 22); -- BLM aims to diminish white people
CALL assertOpinion(-1, 547, 22); -- BLM is violent
CALL assertOpinion(-1, 548, 22); -- BLM is in cahoots with Antifa
CALL assertOpinion(-1, 1319, 22); -- All Lives Matter (rejects this framing)
CALL assertOpinion(-1, 1320, 22); -- BLM is suggesting Black people more important than others

-- === SOCIAL MEDIA CRITIQUE ===
CALL assertOpinion(1, 367, 22);  -- Social media is bad
CALL assertOpinion(1, 498, 22);  -- Facebook content moderation rules biased toward conservatives
CALL assertOpinion(1, 499, 22);  -- Facebook fears conservative ire will result in harmful regulation
CALL assertOpinion(1, 590, 22);  -- Social media gives impression of common wisdom that isn't common

-- === DEI / CORPORATE CRITIQUE ===
CALL assertOpinion(-1, 485, 22); -- Implicit bias training should be more common (theater without economic power)
CALL assertOpinion(1, 486, 22);  -- Distinction between mechanisms of explanation vs. mechanisms of change

-- === POLITICAL INDEPENDENCE / ANTI-PARTISAN ===
CALL assertOpinion(1, 322, 22);  -- We should never put our full faith in the government
CALL assertOpinion(1, 323, 22);  -- Government is a human and imperfect endeavor
CALL assertOpinion(-1, 90, 22);  -- GOP agenda is bad for America (rejects partisan framing)
CALL assertOpinion(-1, 94, 22);  -- Do not vote for a Republican until major reforms (partisan)
CALL assertOpinion(-1, 574, 22); -- The American Democratic Party is terrible (he'd agree Dems failed Black voters, but rejects this framing)

-- === FREE MARKETS (nuanced) ===
CALL assertOpinion(1, 400, 22);  -- Government should stay out of the way (limited)
CALL assertOpinion(1, 401, 22);  -- Free markets do a better job than any government

-- === ENDORSEMENTS: VICTOR VASQUEZ (profileID=22) ===

-- Cluster 1: Black wealth-building chain
-- Target: 500 (too many struggle while few have more than they can spend)
-- Because: 483 (wealth easy with money, near impossible without) 55%, 110 (inequality beyond acceptable) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (500, 22, 'Because', 483, 55.0, NOW(), NOW(), TRUE),
       (500, 22, 'Because', 110, 45.0, NOW(), NOW(), TRUE);

-- Target: 500 Therefore: 501 (chronic anxiety) 55%, 481 (rules must change) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (500, 22, 'Therefore', 501, 55.0, NOW(), NOW(), TRUE),
       (500, 22, 'Therefore', 481, 45.0, NOW(), NOW(), TRUE);

-- Cluster 2: Police accountability
-- Target: 217 (police not held accountable to just degree)
-- Because: 219 (qualified immunity) 55%, 539 (immunity unjust shields) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (217, 22, 'Because', 219, 55.0, NOW(), NOW(), TRUE),
       (217, 22, 'Because', 539, 45.0, NOW(), NOW(), TRUE);

-- Target: 217 Therefore: 145 (policing must be reformed) 60%, 148 (de-escalation) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (217, 22, 'Therefore', 145, 60.0, NOW(), NOW(), TRUE),
       (217, 22, 'Therefore', 148, 40.0, NOW(), NOW(), TRUE);

-- Cluster 3: Racial disparity
-- Target: 175 (inherent racial bias has far-reaching effects)
-- Because: 103 (disproportionate convictions) 45%, 169 (pay gap) 35%, 484 (implicit bias) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (175, 22, 'Because', 103, 45.0, NOW(), NOW(), TRUE),
       (175, 22, 'Because', 169, 35.0, NOW(), NOW(), TRUE),
       (175, 22, 'Because', 484, 20.0, NOW(), NOW(), TRUE);

-- Cluster 4: Rebut "racism is made up"
-- Target: 101 (racism is made up) -- REJECTED
-- Rebuttal: 175 (inherent racial bias) 50%, 103 (disproportionate convictions) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (101, 22, 'Rebuttal', 175, 50.0, NOW(), NOW(), TRUE),
       (101, 22, 'Rebuttal', 103, 50.0, NOW(), NOW(), TRUE);

-- Cluster 5: BLM
-- Target: 546 (BLM activists deserve support)
-- Because: 603 (BLM protests reduced police homicides) 55%, 218 (police see Black people as threat) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (546, 22, 'Because', 603, 55.0, NOW(), NOW(), TRUE),
       (546, 22, 'Because', 218, 45.0, NOW(), NOW(), TRUE);

-- Cluster 6: Rebut BLM is racist
-- Target: 349 (BLM is racist) -- REJECTED
-- Rebuttal: 546 (activists deserve support) 55%, 603 (protests reduced homicides) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (349, 22, 'Rebuttal', 546, 55.0, NOW(), NOW(), TRUE),
       (349, 22, 'Rebuttal', 603, 45.0, NOW(), NOW(), TRUE);

-- Cluster 7: Capitalism as tool
-- Target: 136 (capitalism is the best system we got)
-- Because: 481 (rules need to change) 40%, 482 (fair game structure) 35%, 401 (free markets) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (136, 22, 'Because', 481, 40.0, NOW(), NOW(), TRUE),
       (136, 22, 'Because', 482, 35.0, NOW(), NOW(), TRUE),
       (136, 22, 'Because', 401, 25.0, NOW(), NOW(), TRUE);

-- Cluster 8: Social media critique
-- Target: 367 (social media is bad)
-- Because: 590 (false impression of common wisdom) 50%, 499 (Facebook fears regulation) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (367, 22, 'Because', 590, 50.0, NOW(), NOW(), TRUE),
       (367, 22, 'Because', 499, 50.0, NOW(), NOW(), TRUE);


-- ============================================================
-- PROFILE 23: WENDY WALSH
-- 77yo devout Catholic widow, Scranton PA. 40yr Democrat, switched
-- Republican in 2016 over crime and immigration fears. Bank teller 30yr.
-- Social Security and Medicare are EARNED and untouchable. Fox News.
-- ideology_score: 6 (moderately conservative, was moderate Democrat)
-- ============================================================

-- === LAW AND ORDER / POLICING ===
CALL assertOpinion(1, 561, 23);  -- Back the blue
CALL assertOpinion(1, 777, 23);  -- Criminals forfeit their rights when they choose a life of crime
CALL assertOpinion(-1, 107, 23); -- Defund police departments
CALL assertOpinion(-1, 560, 23); -- The police should be abolished
CALL assertOpinion(-1, 551, 23); -- BLM is peaceful but amid oppositional violence (skeptical)
CALL assertOpinion(-1, 546, 23); -- BLM activists deserve support
CALL assertOpinion(-1, 349, 23); -- BLM movement is racist (cautious lean — Fox News framing)

-- === IMMIGRATION ===
CALL assertOpinion(-1, 611, 23); -- Open borders are a worthy ideal
CALL assertOpinion(-1, 615, 23); -- There should always be a reasonable path to citizenship (she'd want control)
CALL assertOpinion(-1, 616, 23); -- Asylum should be granted to all those that seek it
CALL assertOpinion(-1, 617, 23); -- Family separation at the southern border is an atrocity
CALL assertOpinion(1, 612, 23);  -- America should only allow the best to become citizens
CALL assertOpinion(1, 1237, 23); -- Migrants attempting to cross border should be treated as enemy invaders (Fox framing)

-- === FAITH ===
CALL assertOpinion(1, 130, 23);  -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 23);  -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 23);  -- The faithful believe in His glory unconditionally
CALL assertOpinion(1, 1385, 23); -- Jesus is my Lord and Savior!
CALL assertOpinion(1, 1440, 23); -- The Bible is the word of God
CALL assertOpinion(-1, 161, 23); -- For all intents there is no such thing as a god

-- === PRO-LIFE (Catholic tradition) ===
CALL assertOpinion(1, 124, 23);  -- A fetus has a human soul whose life should be protected
CALL assertOpinion(1, 125, 23);  -- Women should take responsibility for their pregnancies
CALL assertOpinion(1, 902, 23);  -- Unborn children deserve their right to life
CALL assertOpinion(1, 1387, 23); -- Life begins at conception
CALL assertOpinion(-1, 127, 23); -- Can't advocate fetus without opposing woman's choice
CALL assertOpinion(-1, 129, 23); -- Having a child shouldn't be put upon someone like punishment

-- === CANCEL CULTURE / TRADITIONAL VALUES ===
CALL assertOpinion(1, 288, 23);  -- Cancel culture must be resisted
CALL assertOpinion(1, 297, 23);  -- Cancel culture promotes conformist liberal norms
CALL assertOpinion(1, 651, 23);  -- Dr. Seuss books are victim of social justice warriors
CALL assertOpinion(1, 652, 23);  -- Dr. Seuss banning tantamount to book burning

-- === HEALTHCARE (she uses Medicare — protect it) ===
CALL assertOpinion(1, 897, 23);  -- US healthcare system is most expensive in the world
CALL assertOpinion(1, 898, 23);  -- US healthcare system is inequitable
CALL assertOpinion(-1, 901, 23); -- US should implement universal single-payer Medicare for All (govt overreach to her)
CALL assertOpinion(1, 910, 23);  -- Government control of healthcare creates bureaucratic inefficiency
CALL assertOpinion(1, 920, 23);  -- Government programs are ineffective

-- === GOVERNMENT / FISCAL ===
CALL assertOpinion(1, 134, 23);  -- We shouldn't punish success
CALL assertOpinion(1, 322, 23);  -- We should never put our full faith in the government
CALL assertOpinion(1, 400, 23);  -- Government should stay out of the way
CALL assertOpinion(1, 412, 23);  -- Government is inherently inefficient
CALL assertOpinion(-1, 110, 23); -- Degree of wealth inequality beyond acceptable
CALL assertOpinion(-1, 192, 23); -- Wealth taxes should control offensive levels of wealth

-- === CLIMATE (she thinks it's somewhat real, not urgent) ===
CALL assertOpinion(-1, 123, 23); -- We must act on climate change quickly and forcefully (not urgent to her)
CALL assertOpinion(-1, 230, 23); -- Climate change is a hoax (too far — she thinks it's somewhat real)

-- === SOCIAL / BLM / RACE ===
CALL assertOpinion(-1, 103, 23); -- Black people convicted at disproportionate rate (skeptical)
CALL assertOpinion(-1, 105, 23); -- Police kill Black people with impunity
CALL assertOpinion(1, 101, 23);  -- Racism is made up (Fox News lean)
CALL assertOpinion(-1, 145, 23); -- Policing in America must be reformed
CALL assertOpinion(1, 165, 23);  -- Policing doesn't need to be changed, only oversight


-- === ENDORSEMENTS: WENDY WALSH (profileID=23) ===

-- Cluster 1: Back the blue
-- Target: 561 (back the blue)
-- Because: 777 (criminals forfeit rights) 55%, 1410 (safety of police = top priority) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (561, 23, 'Because', 777, 55.0, NOW(), NOW(), TRUE),
       (561, 23, 'Because', 1410, 45.0, NOW(), NOW(), TRUE);

-- Target: 561 Rebuttal for: 107 (defund police) -- she rejects defund
-- Rebuttal: 561 (back the blue) 60%, 777 (criminals forfeit rights) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (107, 23, 'Rebuttal', 561, 60.0, NOW(), NOW(), TRUE),
       (107, 23, 'Rebuttal', 777, 40.0, NOW(), NOW(), TRUE);

-- Cluster 2: Immigration control
-- Target: 611 (open borders worthy ideal) -- REJECTED
-- Rebuttal: 612 (only best should become citizens) 55%, 1237 (treat as invaders) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (611, 23, 'Rebuttal', 612, 55.0, NOW(), NOW(), TRUE),
       (611, 23, 'Rebuttal', 1237, 45.0, NOW(), NOW(), TRUE);

-- Cluster 3: Faith chain
-- Target: 428 (those with faith can feel God's presence)
-- Because: 130 (can't be certain God doesn't exist) 55%, 844 (believe in His glory) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (428, 23, 'Because', 130, 55.0, NOW(), NOW(), TRUE),
       (428, 23, 'Because', 844, 45.0, NOW(), NOW(), TRUE);

-- Target: 428 Therefore: 1385 (Jesus is Lord) 60%, 1440 (Bible is word of God) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (428, 23, 'Therefore', 1385, 60.0, NOW(), NOW(), TRUE),
       (428, 23, 'Therefore', 1440, 40.0, NOW(), NOW(), TRUE);

-- Cluster 4: Pro-life (Catholic)
-- Target: 124 (fetus has soul, life protected)
-- Because: 1387 (life begins at conception) 55%, 902 (unborn deserve right to life) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (124, 23, 'Because', 1387, 55.0, NOW(), NOW(), TRUE),
       (124, 23, 'Because', 902, 45.0, NOW(), NOW(), TRUE);

-- Cluster 5: Cancel culture
-- Target: 288 (cancel culture must be resisted)
-- Because: 297 (promotes conformist liberal norms) 55%, 651 (Dr. Seuss) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (288, 23, 'Because', 297, 55.0, NOW(), NOW(), TRUE),
       (288, 23, 'Because', 651, 45.0, NOW(), NOW(), TRUE);

-- Cluster 6: Government inefficiency
-- Target: 920 (government programs are ineffective)
-- Because: 412 (government inherently inefficient) 55%, 910 (govt healthcare bureaucratic) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (920, 23, 'Because', 412, 55.0, NOW(), NOW(), TRUE),
       (920, 23, 'Because', 910, 45.0, NOW(), NOW(), TRUE);


-- === ADDITIONAL OPINIONS: YVONNE (25) — need 33+ more to reach 80 ===
-- (inserted after initial block above, before profile 24)

-- === POLICING DETAIL (Yvonne) ===
CALL assertOpinion(1, 163, 25);  -- More policing does not get to root of problem causing crime and unrest
CALL assertOpinion(1, 334, 25);  -- Police and sheriff departments should resist militarization
CALL assertOpinion(1, 335, 25);  -- Militarization of police presents a moral hazard
CALL assertOpinion(1, 1188, 25); -- Routine traffic stops extremely dangerous for Black and brown people
CALL assertOpinion(1, 1498, 25); -- Qualified immunity for police must end

-- === RACIAL JUSTICE DETAIL (Yvonne) ===
CALL assertOpinion(1, 207, 25);  -- Black people stopped for looking suspicious far more often
CALL assertOpinion(1, 221, 25);  -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(1, 238, 25);  -- American society is white supremacist
CALL assertOpinion(1, 239, 25);  -- Whiteness is a convenient line to hoard power within
CALL assertOpinion(1, 279, 25);  -- No individual should suffer harassment or attack based on race
CALL assertOpinion(1, 280, 25);  -- No individual should suffer harassment or attack based on gender
CALL assertOpinion(1, 313, 25);  -- Every person deserves a basic-level of respect
CALL assertOpinion(1, 317, 25);  -- Race is a social construct
CALL assertOpinion(1, 320, 25);  -- All people deserve to be treated equally
CALL assertOpinion(1, 351, 25);  -- Black people don't have institutional power to be racist
CALL assertOpinion(1, 352, 25);  -- Racism requires a power differential
CALL assertOpinion(1, 353, 25);  -- There is no such thing as reverse-racism
CALL assertOpinion(-1, 118, 25); -- (already inserted above — skip duplicate via IF NOT EXISTS in assertOpinion)
CALL assertOpinion(1, 484, 25);  -- We all have implicit bias
CALL assertOpinion(1, 485, 25);  -- Implicit bias training should be more common
CALL assertOpinion(1, 1345, 25); -- Curriculums should be reviewed to combat white supremacy
CALL assertOpinion(1, 1347, 25); -- Kids should be taught white supremacy will prevent BIPOC achievement
CALL assertOpinion(1, 1351, 25); -- Kids should be taught existence of white supremacy in US

-- === ECONOMIC JUSTICE (Yvonne) ===
CALL assertOpinion(1, 110, 25);  -- Degree of wealth inequality in America is beyond acceptable
CALL assertOpinion(1, 500, 25);  -- Too many struggle to meet immediate material needs
CALL assertOpinion(1, 604, 25);  -- Government should eliminate poverty
CALL assertOpinion(1, 606, 25);  -- Government should give direct cash payments to the poor
CALL assertOpinion(1, 609, 25);  -- US should implement universal basic income
CALL assertOpinion(1, 598, 25);  -- There is a floor to the standard of living you should be willing to see for your fellow humans

-- === MISC PROGRESSIVE (Yvonne) ===
CALL assertOpinion(1, 278, 25);  -- No individual should suffer harassment/attack based on sexual orientation
CALL assertOpinion(1, 1312, 25); -- Laws banning trans kids from sports by gender identity are wrong
CALL assertOpinion(1, 1425, 25); -- Being transgender or non-binary is not a mental disorder
CALL assertOpinion(1, 543, 25);  -- We should accept people for who they are
CALL assertOpinion(1, 544, 25);  -- Trans men should be accepted as men / trans women as women

-- ============================================================
-- PROFILE 24: XAVIER XIONG
-- 39yo Hmong American CNC machinist, St. Paul MN. Born in Thai refugee camp.
-- Father was Secret War soldier abandoned by US. Evangelical Christian.
-- 2A = right not to be defenseless. Govt will abandon you — history not paranoia.
-- Voted Democrat until 2020 Minneapolis police withdrawal = betrayal.
-- ideology_score: 4 (right-leaning independent, 2A and anti-govt focus)
-- ============================================================

-- === 2ND AMENDMENT (core identity) ===
CALL assertOpinion(1, 140, 24);  -- 2nd amendment grants right to own whatever firearms deemed necessary
CALL assertOpinion(1, 226, 24);  -- Freedom should never be infringed
CALL assertOpinion(1, 324, 24);  -- It is our right not to rely fully on government for our own protection
CALL assertOpinion(1, 325, 24);  -- It is our right to be prepared to defend ourselves against government
CALL assertOpinion(1, 326, 24);  -- Spirit of 2A: preserve right to protect ourselves without govt aid
CALL assertOpinion(1, 327, 24);  -- Spirit of 2A: preserve right to defend against threat our own govt may pose
CALL assertOpinion(1, 328, 24);  -- We should defend the second amendment
CALL assertOpinion(1, 459, 24);  -- We should have the right to decide for ourselves what tools are safe to use
CALL assertOpinion(1, 460, 24);  -- People shouldn't be restricted from responsibly owning guns
CALL assertOpinion(1, 461, 24);  -- Handgun bans are unconstitutional
CALL assertOpinion(1, 1002, 24); -- Owning guns doesn't necessitate being an obsessive gun fan
CALL assertOpinion(-1, 329, 24); -- There is a certain degree of firepower that should be banned
CALL assertOpinion(-1, 331, 24); -- Gun laws limiting ownership are constitutional
CALL assertOpinion(-1, 333, 24); -- Assault weapons should be banned for non-military purposes
CALL assertOpinion(-1, 743, 24); -- Magazine capacities should be limited
CALL assertOpinion(-1, 746, 24); -- Bump stocks should be illegal
CALL assertOpinion(-1, 747, 24); -- Automatic weapons should be illegal
CALL assertOpinion(-1, 462, 24); -- Society is better off without guns
CALL assertOpinion(-1, 1179, 24); -- America needs gun reform now
CALL assertOpinion(-1, 1181, 24); -- Gun ownership in America should be strictly limited

-- === GOVERNMENT ABANDONMENT (historical trauma, not paranoia) ===
CALL assertOpinion(-1, 27, 24);  -- Can rely on government for protection (REJECT — family proved otherwise)
CALL assertOpinion(1, 322, 24);  -- We should never put our full faith in the government
CALL assertOpinion(1, 323, 24);  -- Government is a human and imperfect endeavor
CALL assertOpinion(1, 1001, 24); -- Atrocities committed by US forces in Vietnam will never be fully exposed

-- === FAITH ===
CALL assertOpinion(1, 130, 24);  -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 24);  -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 24);  -- The faithful believe in His glory unconditionally

-- === POLICING (complicated — wants police, wants accountability) ===
CALL assertOpinion(1, 148, 24);  -- Police should be required to use de-escalation techniques
CALL assertOpinion(-1, 107, 24); -- Defund police departments (betrayal framing — Minneapolis)
CALL assertOpinion(-1, 560, 24); -- The police should be abolished
CALL assertOpinion(-1, 561, 24); -- Back the blue (uncritical — he wants accountable police)
CALL assertOpinion(1, 217, 24);  -- Police not held accountable to a just degree
CALL assertOpinion(1, 219, 24);  -- Police are granted qualified immunity

-- === RACIAL DISPARITIES (nuanced — accepts exist, rejects some framing) ===
CALL assertOpinion(1, 103, 24);  -- Black people convicted at disproportionate rate
CALL assertOpinion(1, 175, 24);  -- Inherent racial bias has far-reaching effects
CALL assertOpinion(-1, 101, 24); -- Racism is made up

-- === PUBLIC LANDS / ENVIRONMENT ===
CALL assertOpinion(-1, 780, 24); -- Public lands should maximize economic output
CALL assertOpinion(1, 781, 24);  -- Public lands belong to all Americans
CALL assertOpinion(1, 782, 24);  -- Public lands should be managed to balance all uses
CALL assertOpinion(1, 783, 24);  -- Public lands should be protected from development

-- === SMALL GOVERNMENT ===
CALL assertOpinion(1, 400, 24);  -- Government should stay out of the way
CALL assertOpinion(1, 404, 24);  -- Constant vigilance to eliminate unnecessary regulations
CALL assertOpinion(1, 407, 24);  -- Government is too big and should be reduced
CALL assertOpinion(1, 412, 24);  -- Government is inherently inefficient

-- === WOLF REINTRODUCTION (has rural relatives — complicated) ===
CALL assertOpinion(-1, 839, 24); -- Reintroduction of wolves to western US was a mistake (rural relatives' view)
CALL assertOpinion(-1, 841, 24); -- Wolf hunting should be encouraged and unregulated (ambivalent)
CALL assertOpinion(1, 842, 24);  -- Wolves are integral part of natural healthy ecosystem


-- === ENDORSEMENTS: XAVIER XIONG (profileID=24) ===

-- Cluster 1: 2A core
-- Target: 140 (2A grants right to own whatever firearms deemed necessary)
-- Because: 326 (spirit of 2A without govt) 40%, 327 (defend against govt threat) 35%, 324 (right not to rely on govt) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (140, 24, 'Because', 326, 40.0, NOW(), NOW(), TRUE),
       (140, 24, 'Because', 327, 35.0, NOW(), NOW(), TRUE),
       (140, 24, 'Because', 324, 25.0, NOW(), NOW(), TRUE);

-- Target: 140 Therefore: 328 (defend 2A) 50%, 460 (responsible ownership) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (140, 24, 'Therefore', 328, 50.0, NOW(), NOW(), TRUE),
       (140, 24, 'Therefore', 460, 50.0, NOW(), NOW(), TRUE);

-- Cluster 2: Government abandonment
-- Target: 322 (never put full faith in government)
-- Because: 323 (human/imperfect endeavor) 55%, 1001 (Vietnam atrocities) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (322, 24, 'Because', 323, 55.0, NOW(), NOW(), TRUE),
       (322, 24, 'Because', 1001, 45.0, NOW(), NOW(), TRUE);

-- Target: 322 Therefore: 324 (right not to rely on govt for protection) 55%, 325 (right to defend against govt) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (322, 24, 'Therefore', 324, 55.0, NOW(), NOW(), TRUE),
       (322, 24, 'Therefore', 325, 45.0, NOW(), NOW(), TRUE);

-- Cluster 3: Rebut gun control
-- Target: 329 (certain firepower should be banned) -- REJECTED
-- Rebuttal: 140 (2A grants right) 55%, 460 (responsible ownership) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (329, 24, 'Rebuttal', 140, 55.0, NOW(), NOW(), TRUE),
       (329, 24, 'Rebuttal', 460, 45.0, NOW(), NOW(), TRUE);

-- Target: 333 (assault weapons should be banned) -- REJECTED
-- Rebuttal: 1177 (AR-15 has legitimate use cases) 55%, 140 (2A right) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (333, 24, 'Rebuttal', 1177, 55.0, NOW(), NOW(), TRUE),
       (333, 24, 'Rebuttal', 140, 45.0, NOW(), NOW(), TRUE);

-- Cluster 4: Defund police (betrayal framing)
-- Target: 107 (defund police) -- REJECTED
-- Rebuttal: 217 (police not accountable) 50%, 148 (de-escalation instead) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (107, 24, 'Rebuttal', 217, 50.0, NOW(), NOW(), TRUE),
       (107, 24, 'Rebuttal', 148, 50.0, NOW(), NOW(), TRUE);

-- Cluster 5: Faith chain
-- Target: 428 (faith can feel God's presence)
-- Because: 130 (can't be certain God doesn't exist) 55%, 844 (believe in His glory) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (428, 24, 'Because', 130, 55.0, NOW(), NOW(), TRUE),
       (428, 24, 'Because', 844, 45.0, NOW(), NOW(), TRUE);

-- Cluster 6: Public lands
-- Target: 781 (public lands belong to all Americans)
-- Because: 782 (balance all uses) 55%, 783 (protect from development) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (781, 24, 'Because', 782, 55.0, NOW(), NOW(), TRUE),
       (781, 24, 'Because', 783, 45.0, NOW(), NOW(), TRUE);

-- Cluster 7: Small government
-- Target: 407 (government too big)
-- Because: 412 (inherently inefficient) 50%, 400 (stay out of the way) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (407, 24, 'Because', 412, 50.0, NOW(), NOW(), TRUE),
       (407, 24, 'Because', 400, 50.0, NOW(), NOW(), TRUE);

-- Target: 407 Therefore: 404 (eliminate unnecessary regulations) 55%, 322 (don't rely on govt) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (407, 24, 'Therefore', 404, 55.0, NOW(), NOW(), TRUE),
       (407, 24, 'Therefore', 322, 45.0, NOW(), NOW(), TRUE);


-- === ADDITIONAL OPINIONS: XAVIER (24) — need 13+ more to reach 80 ===

-- === IMMIGRATION (complicated, personal, not simple anti) ===
CALL assertOpinion(-1, 611, 24); -- Open borders are a worthy ideal (not simple anti — just complicated)
CALL assertOpinion(1, 615, 24);  -- There should always be a reasonable path to citizenship
CALL assertOpinion(-1, 616, 24); -- Asylum should be granted to all those that seek it (complicated)
CALL assertOpinion(-1, 617, 24); -- Family separation at southern border is atrocity (family values)

-- === RACIAL DISPARITIES (Xavier accepts exist) ===
CALL assertOpinion(-1, 118, 24); -- Black people are inherently less civil
CALL assertOpinion(-1, 108, 24); -- Black people just commit more crime
CALL assertOpinion(1, 169, 24);  -- Non-white males statistically paid less

-- === MISC CONSERVATIVE / FAITH (Xavier) ===
CALL assertOpinion(1, 313, 24);  -- Every person deserves a basic-level of respect
CALL assertOpinion(1, 320, 24);  -- All people deserve to be treated equally
CALL assertOpinion(1, 1440, 24); -- The Bible is the word of God
CALL assertOpinion(1, 1385, 24); -- Jesus is my Lord and Savior!
CALL assertOpinion(1, 1386, 24); -- Jesus is God's only son
CALL assertOpinion(-1, 161, 24); -- For all intents there is no such thing as a god

-- === 2A SUPPORTING ARGUMENTS (Xavier) ===
CALL assertOpinion(1, 330, 24);  -- Individuals should never be in possession of nuclear weapons (but otherwise support 2A)
CALL assertOpinion(1, 1177, 24); -- The AR-15 has legitimate use cases just like any other tool
CALL assertOpinion(1, 1002, 24); -- (already inserted — assertOpinion IF NOT EXISTS is safe)

-- ============================================================
-- PROFILE 25: YVONNE YOUNG
-- 21yo Black woman, New Orleans LA. HBCU junior, social work major.
-- Cousin in prison. City is flooding. Deeply engaged progressive.
-- CJ criminalizes poverty. Climate already destroying Black/poor communities.
-- Inherited problems she didn't create.
-- ideology_score: -9 (strong progressive)
-- ============================================================

-- === CLIMATE JUSTICE (New Orleans flooding = personal) ===
CALL assertOpinion(1, 123, 25);  -- We must act on climate change quickly and forcefully
CALL assertOpinion(1, 321, 25);  -- Human-influenced climate change is an observable fact
CALL assertOpinion(1, 476, 25);  -- Fossil fuels need to be left in the ground
CALL assertOpinion(1, 477, 25);  -- Fossil fuels are greatest contributors to climate change
CALL assertOpinion(1, 863, 25);  -- Limiting climate change will require collective action
CALL assertOpinion(1, 892, 25);  -- Must find a way to make the average person's carbon output sustainable
CALL assertOpinion(1, 893, 25);  -- Existing greenhouse gases will already push us past 2 degrees
CALL assertOpinion(-1, 230, 25); -- Climate change is a hoax
CALL assertOpinion(-1, 527, 25); -- We will destroy the economy before reversing global warming

-- === CRIMINAL JUSTICE (cousin in prison — it's personal) ===
CALL assertOpinion(1, 111, 25);  -- End cash bail
CALL assertOpinion(1, 112, 25);  -- Implicit bias skews sentencing
CALL assertOpinion(1, 113, 25);  -- Conditions outside Black Americans' control increase crime likelihood
CALL assertOpinion(1, 114, 25);  -- White people would commit as much crime under similar conditions
CALL assertOpinion(1, 115, 25);  -- Cash bail criminalizes poverty
CALL assertOpinion(1, 116, 25);  -- Cash bail perpetuates inequities felt by communities of color
CALL assertOpinion(1, 171, 25);  -- CJ system is major contributor to racial inequality
CALL assertOpinion(1, 174, 25);  -- CJ is prejudiced; not accounting for disparities = blind
CALL assertOpinion(1, 222, 25);  -- CJ inequities are part and parcel of broader societal inequities
CALL assertOpinion(1, 223, 25);  -- Preventing racial inequality in justice system should be priority
CALL assertOpinion(1, 545, 25);  -- A just system would give punishment a person can realistically meet
CALL assertOpinion(-1, 170, 25); -- CJ system should not adjust to correct for societal inequalities
CALL assertOpinion(-1, 173, 25); -- CJ system should not be focus of reform for racial equality

-- === POLICING ===
CALL assertOpinion(1, 145, 25);  -- Policing in America must be reformed
CALL assertOpinion(1, 148, 25);  -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 151, 25);  -- Police unions too powerful and uphold racist structures
CALL assertOpinion(1, 153, 25);  -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 25);  -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 155, 25);  -- Police procedures and policies effectively racist too often
CALL assertOpinion(1, 217, 25);  -- Police not held accountable to just degree
CALL assertOpinion(1, 218, 25);  -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 25);  -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 25);  -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(-1, 107, 25); -- Defund police (cautious — her community still needs safety)
CALL assertOpinion(-1, 560, 25); -- The police should be abolished (not quite)
CALL assertOpinion(-1, 561, 25); -- Back the blue

-- === BLM ===
CALL assertOpinion(1, 546, 25);  -- BLM activists deserve support
CALL assertOpinion(1, 551, 25);  -- BLM is peaceful but exists amid oppositional violence
CALL assertOpinion(1, 603, 25);  -- Cities with BLM protests had reduction in police homicides
CALL assertOpinion(1, 1313, 25); -- BLM is simply about Black Americans not living in fear
CALL assertOpinion(1, 1314, 25); -- Black Americans' fear of police is completely legitimate
CALL assertOpinion(1, 1321, 25); -- BLM makes clear point that Black people's lives undervalued
CALL assertOpinion(-1, 349, 25); -- BLM movement is racist
CALL assertOpinion(-1, 350, 25); -- BLM aims to diminish white people
CALL assertOpinion(-1, 547, 25); -- BLM is violent
CALL assertOpinion(-1, 1319, 25); -- All Lives Matter
CALL assertOpinion(-1, 1320, 25); -- BLM suggesting Black people more important than others

-- === RACIAL JUSTICE ===
CALL assertOpinion(1, 103, 25);  -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 105, 25);  -- Police kill Black people with impunity
CALL assertOpinion(1, 109, 25);  -- Empower Black people
CALL assertOpinion(1, 169, 25);  -- Non-white males statistically paid less
CALL assertOpinion(1, 175, 25);  -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 221, 25);  -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(1, 236, 25);  -- Black Americans are right to feel wronged by society
CALL assertOpinion(1, 240, 25);  -- Equality of any group treated as less than human is a priority
CALL assertOpinion(1, 241, 25);  -- Giving Black Americans the power they deserve should be a priority
CALL assertOpinion(-1, 101, 25); -- Racism is made up
CALL assertOpinion(-1, 108, 25); -- Black people just commit more crime
CALL assertOpinion(-1, 118, 25); -- Black people are inherently less civil

-- === VOTING RIGHTS ===
CALL assertOpinion(1, 182, 25);  -- Right of every citizen to vote is unassailable principle
CALL assertOpinion(1, 184, 25);  -- Most historically exploited groups are also disenfranchised
CALL assertOpinion(1, 355, 25);  -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 25);  -- We should have universal voter registration
CALL assertOpinion(1, 357, 25);  -- We should have universal vote-by-mail
CALL assertOpinion(1, 640, 25);  -- Congress must pass HR1 For The People Act

-- === HOUSING ===
CALL assertOpinion(1, 682, 25);  -- Homelessness should be treated as the crisis it is
CALL assertOpinion(1, 683, 25);  -- Wrong to make the unhoused work harder than they already do to sleep safely
CALL assertOpinion(1, 684, 25);  -- Clean up efforts of encampments are cruel
CALL assertOpinion(1, 685, 25);  -- Encampments should be provided basic sanitation services
CALL assertOpinion(1, 692, 25);  -- First priority in homelessness crisis: get everyone adequate shelter
CALL assertOpinion(1, 693, 25);  -- Government should designate land for basic shelters

-- === FAITH (cultural inheritance) ===
CALL assertOpinion(1, 130, 25);  -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 25);  -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 25);  -- The faithful believe in His glory unconditionally


-- === ENDORSEMENTS: YVONNE YOUNG (profileID=25) ===

-- Cluster 1: Climate + flooding = personal
-- Target: 123 (must act on climate change quickly and forcefully)
-- Because: 321 (human-caused climate change is observable fact) 40%, 863 (requires collective action) 35%, 893 (already past 2 degrees) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (123, 25, 'Because', 321, 40.0, NOW(), NOW(), TRUE),
       (123, 25, 'Because', 863, 35.0, NOW(), NOW(), TRUE),
       (123, 25, 'Because', 893, 25.0, NOW(), NOW(), TRUE);

-- Target: 123 Therefore: 892 (make average person's carbon output sustainable) 55%, 476 (fossil fuels in ground) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (123, 25, 'Therefore', 892, 55.0, NOW(), NOW(), TRUE),
       (123, 25, 'Therefore', 476, 45.0, NOW(), NOW(), TRUE);

-- Cluster 2: Cash bail = criminalizes poverty
-- Target: 111 (end cash bail)
-- Because: 115 (criminalizes poverty) 55%, 116 (perpetuates inequities) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (111, 25, 'Because', 115, 55.0, NOW(), NOW(), TRUE),
       (111, 25, 'Because', 116, 45.0, NOW(), NOW(), TRUE);

-- Target: 111 Therefore: 222 (CJ inequities are part of broader inequities) 55%, 545 (just punishment = realistic) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (111, 25, 'Therefore', 222, 55.0, NOW(), NOW(), TRUE),
       (111, 25, 'Therefore', 545, 45.0, NOW(), NOW(), TRUE);

-- Cluster 3: Police accountability chain
-- Target: 217 (police not held accountable)
-- Because: 219 (qualified immunity) 40%, 539 (immunity unjust) 35%, 218 (see Black people as threat) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (217, 25, 'Because', 219, 40.0, NOW(), NOW(), TRUE),
       (217, 25, 'Because', 539, 35.0, NOW(), NOW(), TRUE),
       (217, 25, 'Because', 218, 25.0, NOW(), NOW(), TRUE);

-- Target: 217 Therefore: 145 (policing must be reformed) 50%, 153 (exhaust options before shooting) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (217, 25, 'Therefore', 145, 50.0, NOW(), NOW(), TRUE),
       (217, 25, 'Therefore', 153, 50.0, NOW(), NOW(), TRUE);

-- Cluster 4: BLM support
-- Target: 546 (BLM activists deserve support)
-- Because: 1313 (simply about not living in fear) 40%, 1314 (fear is legitimate) 35%, 603 (protests reduced homicides) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (546, 25, 'Because', 1313, 40.0, NOW(), NOW(), TRUE),
       (546, 25, 'Because', 1314, 35.0, NOW(), NOW(), TRUE),
       (546, 25, 'Because', 603, 25.0, NOW(), NOW(), TRUE);

-- Target: 546 Therefore: 1321 (BLM makes clear point) 55%, 551 (peaceful amid oppositional violence) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (546, 25, 'Therefore', 1321, 55.0, NOW(), NOW(), TRUE),
       (546, 25, 'Therefore', 551, 45.0, NOW(), NOW(), TRUE);

-- Cluster 5: Racial justice chain
-- Target: 175 (inherent racial bias has far-reaching effects)
-- Because: 103 (disproportionate convictions) 40%, 221 (power structures hostile to Black people) 35%, 169 (pay gap) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (175, 25, 'Because', 103, 40.0, NOW(), NOW(), TRUE),
       (175, 25, 'Because', 221, 35.0, NOW(), NOW(), TRUE),
       (175, 25, 'Because', 169, 25.0, NOW(), NOW(), TRUE);

-- Target: 175 Therefore: 240 (equality of any group treated as less human) 50%, 241 (power to Black Americans) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (175, 25, 'Therefore', 240, 50.0, NOW(), NOW(), TRUE),
       (175, 25, 'Therefore', 241, 50.0, NOW(), NOW(), TRUE);

-- Cluster 6: Voting rights
-- Target: 355 (voting rights should be expanded and protected)
-- Because: 182 (unassailable right) 55%, 184 (exploited groups disenfranchised) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (355, 25, 'Because', 182, 55.0, NOW(), NOW(), TRUE),
       (355, 25, 'Because', 184, 45.0, NOW(), NOW(), TRUE);

-- Target: 355 Therefore: 356 (universal registration) 40%, 357 (universal vote-by-mail) 35%, 640 (HR1) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (355, 25, 'Therefore', 356, 40.0, NOW(), NOW(), TRUE),
       (355, 25, 'Therefore', 357, 35.0, NOW(), NOW(), TRUE),
       (355, 25, 'Therefore', 640, 25.0, NOW(), NOW(), TRUE);

-- Cluster 7: Housing crisis
-- Target: 682 (homelessness should be treated as crisis)
-- Because: 692 (first priority = adequate shelter) 55%, 693 (govt should designate land) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (682, 25, 'Because', 692, 55.0, NOW(), NOW(), TRUE),
       (682, 25, 'Because', 693, 45.0, NOW(), NOW(), TRUE);

-- Target: 682 Therefore: 685 (provide sanitation) 55%, 684 (clean-ups are cruel) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (682, 25, 'Therefore', 685, 55.0, NOW(), NOW(), TRUE),
       (682, 25, 'Therefore', 684, 45.0, NOW(), NOW(), TRUE);

-- Cluster 8: Faith chain
-- Target: 428 (faith can feel God's presence)
-- Because: 130 (can't be certain God doesn't exist) 55%, 844 (believe in His glory) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (428, 25, 'Because', 130, 55.0, NOW(), NOW(), TRUE),
       (428, 25, 'Because', 844, 45.0, NOW(), NOW(), TRUE);


-- ============================================================
-- PROFILE 26: ZACHARY ZELLER
-- 18yo Lakota Sioux young man, Standing Rock reservation, ND.
-- Non-voter — electoral politics irrelevant to tribal sovereignty.
-- Water and land are not resources, they are relations.
-- US govt has broken every treaty. Community protects community.
-- MMIW crisis under-discussed. Just graduated high school.
-- ideology_score: -5 (anti-government Indigenous sovereignty perspective)
-- ============================================================

-- === WATER / LAND AS RELATIONS (hardcoded worldview) ===
CALL assertOpinion(-1, 780, 26); -- Public lands should maximize economic output (land is not just resource)
CALL assertOpinion(1, 781, 26);  -- Public lands belong to all Americans (closest to his view)
CALL assertOpinion(1, 782, 26);  -- Public lands managed to balance all uses
CALL assertOpinion(1, 783, 26);  -- Public lands protected from development
CALL assertOpinion(-1, 772, 26); -- National Environmental Policy Act should be repealed
CALL assertOpinion(-1, 773, 26); -- NEPA harms rural communities (framing he'd reject)
CALL assertOpinion(-1, 776, 26); -- NEPA hinders economic development on public lands

-- === SNAKE RIVER DAMS / SALMON / ORCA ===
CALL assertOpinion(1, 786, 26);  -- Remove the lower Snake River dams!
CALL assertOpinion(1, 787, 26);  -- Columbia river salmon facing extinction
CALL assertOpinion(1, 788, 26);  -- Southern Resident orca populations need drastic action
CALL assertOpinion(1, 789, 26);  -- Damming rivers increases water temperature and slows flow
CALL assertOpinion(1, 806, 26);  -- Wild free-flowing Snake River would provide vast environmental and recreational benefits
CALL assertOpinion(1, 825, 26);  -- Economic value of 4 lower Snake River dams is overstated (accept — dams unjustified)
CALL assertOpinion(1, 827, 26);  -- Current Columbia River salmon fishery is fraction of historic levels

-- === GOVERNMENT ABANDONMENT / TREATY BETRAYAL ===
CALL assertOpinion(-1, 27, 26);  -- Can rely on government (REJECT — US broke every treaty)
CALL assertOpinion(1, 322, 26);  -- We should never put our full faith in the government
CALL assertOpinion(1, 323, 26);  -- Government is a human and imperfect endeavor

-- === ENVIRONMENTAL PROTECTION ===
CALL assertOpinion(1, 757, 26);  -- Providing clean and healthy environment should be priority of government
CALL assertOpinion(1, 762, 26);  -- Native species should be prioritized over non-native species
CALL assertOpinion(1, 123, 26);  -- We must act on climate change quickly and forcefully (water/land angle)
CALL assertOpinion(1, 321, 26);  -- Human-influenced climate change is an observable fact
CALL assertOpinion(-1, 230, 26); -- Climate change is a hoax

-- === WOLVES / NATIVE SPECIES ===
CALL assertOpinion(-1, 839, 26); -- Reintroduction of wolves was a mistake (REJECT — wolves belong)
CALL assertOpinion(-1, 841, 26); -- Wolf hunting should be encouraged and unregulated (REJECT)
CALL assertOpinion(1, 842, 26);  -- Wolves are integral part of natural healthy ecosystem
CALL assertOpinion(1, 843, 26);  -- Wolves nearly never attack humans, domestic animal predation is rare

-- === POLICING (rejects back the blue; community protects community) ===
CALL assertOpinion(-1, 561, 26); -- Back the blue
CALL assertOpinion(-1, 107, 26); -- Defund police (doesn't engage partisan framing; community protection)
CALL assertOpinion(-1, 560, 26); -- Abolish police (doesn't engage; community protection is the frame)

-- === HOUSING / HOMELESSNESS (community care framing) ===
CALL assertOpinion(1, 682, 26);  -- Homelessness should be treated as crisis it is
CALL assertOpinion(1, 685, 26);  -- Encampments should be provided basic sanitation services
CALL assertOpinion(1, 692, 26);  -- First priority: get everyone adequate shelter

-- === SKIPS MOST PARTISAN CONTENT ===
-- (No opinions on abortion, national elections -- not his arena)
-- Accept a few environmental specifics and human dignity
CALL assertOpinion(1, 477, 26);  -- Fossil fuels are greatest contributors to climate change
CALL assertOpinion(1, 863, 26);  -- Limiting climate change requires collective action
CALL assertOpinion(1, 892, 26);  -- Must make average person's carbon output sustainable
CALL assertOpinion(1, 476, 26);  -- Fossil fuels need to be left in the ground
CALL assertOpinion(1, 893, 26);  -- Existing greenhouse gases will push us past 2 degrees

-- === NATIVE RIGHTS / TREATY / SOVEREIGNTY (Zachary) ===
CALL assertOpinion(1, 237, 26);  -- Native Americans are right to feel wronged by American government
CALL assertOpinion(1, 245, 26);  -- The American government brutally banished native Americans from their homes
CALL assertOpinion(1, 238, 26);  -- American society is white supremacist
CALL assertOpinion(1, 320, 26);  -- All people deserve to be treated equally
CALL assertOpinion(1, 313, 26);  -- Every person deserves a basic-level of respect
CALL assertOpinion(1, 279, 26);  -- No individual should suffer harassment or attack based on race
CALL assertOpinion(1, 281, 26);  -- No individual should suffer harassment or attack based on nationality
CALL assertOpinion(1, 282, 26);  -- No individual should suffer harassment or attack based on religion
CALL assertOpinion(1, 242, 26);  -- Humans must treat each other with fellowship if we are to succeed
CALL assertOpinion(1, 244, 26);  -- Humanity can only move forward as one — leaving no one behind

-- === ANTI-GOVERNMENT / ANTI-EXTRACTION ===
CALL assertOpinion(1, 405, 26);  -- Unchecked, government would grow and assume greater control to ruin
CALL assertOpinion(1, 406, 26);  -- Power — in all forms — will never stop seeking greater power for itself
CALL assertOpinion(-1, 400, 26); -- Government should stay out of the way (he's anti-govt, but pro-environmental govt)
CALL assertOpinion(-1, 412, 26); -- Government is inherently inefficient (he accepts government has role in protection)
CALL assertOpinion(1, 784, 26);  -- Motorized vehicles should be limited to established forest service roads
CALL assertOpinion(1, 774, 26);  -- Rural communities most at risk when NEPA is not followed

-- === RACIAL JUSTICE AWARENESS ===
CALL assertOpinion(1, 103, 26);  -- Black people convicted at disproportionate rate
CALL assertOpinion(1, 175, 26);  -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 221, 26);  -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(-1, 101, 26); -- Racism is made up

-- === WATER IS LIFE / DAMS (additional) ===
CALL assertOpinion(1, 414, 26);  -- We should ramp up renewable energy capacity as soon as possible
CALL assertOpinion(1, 530, 26);  -- We should reduce barriers to innovation that could address global warming
CALL assertOpinion(-1, 527, 26); -- We will destroy the economy well before reversing global warming (reject this defeatism)
CALL assertOpinion(-1, 528, 26); -- We don't yet have the technology to address global warming effectively (reject)
CALL assertOpinion(1, 416, 26);  -- We must learn to let science be our guide
CALL assertOpinion(1, 598, 26);  -- There is a floor to the standard of living you should be willing to see for your fellow humans
CALL assertOpinion(1, 242, 26);  -- (already inserted — assertOpinion handles duplicates)
CALL assertOpinion(1, 317, 26);  -- Race is a social construct
CALL assertOpinion(1, 318, 26);  -- The genetic diversity that exists across the entire human race is very, very small
CALL assertOpinion(1, 319, 26);  -- Race isn't a good proxy for what genetic diversity does exist
CALL assertOpinion(1, 278, 26);  -- No individual should suffer harassment or attack based on sexual orientation
CALL assertOpinion(1, 280, 26);  -- No individual should suffer harassment or attack based on gender
CALL assertOpinion(1, 283, 26);  -- Claiming your religion demands a view doesn't insulate it from criticism
CALL assertOpinion(1, 285, 26);  -- No individual should suffer harassment or attack based on personal views
CALL assertOpinion(1, 226, 26);  -- Freedom should never be infringed (sovereignty angle)
CALL assertOpinion(-1, 840, 26); -- Wolves are dangerous to pets and humans -- REJECT
CALL assertOpinion(1, 704, 26);  -- Unless you are willing to act unilaterally you should not expect others to act collectively
CALL assertOpinion(1, 706, 26);  -- Some issues require collective action because individual action would be inadequate


-- === ENDORSEMENTS: ZACHARY ZELLER (profileID=26) ===

-- Cluster 1: Snake River dams (core issue)
-- Target: 786 (remove lower Snake River dams!)
-- Because: 787 (salmon facing extinction) 40%, 789 (dams increase water temp) 35%, 788 (orca need drastic action) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (786, 26, 'Because', 787, 40.0, NOW(), NOW(), TRUE),
       (786, 26, 'Because', 789, 35.0, NOW(), NOW(), TRUE),
       (786, 26, 'Because', 788, 25.0, NOW(), NOW(), TRUE);

-- Target: 786 Therefore: 806 (wild Snake River = vast benefits) 55%, 827 (Columbia salmon fraction of historic) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (786, 26, 'Therefore', 806, 55.0, NOW(), NOW(), TRUE),
       (786, 26, 'Therefore', 827, 45.0, NOW(), NOW(), TRUE);

-- Cluster 2: Government treaty betrayal
-- Target: 322 (never put full faith in government)
-- Because: 323 (human and imperfect) 55%, 245 (government brutally banished native Americans) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (322, 26, 'Because', 323, 55.0, NOW(), NOW(), TRUE),
       (322, 26, 'Because', 245, 45.0, NOW(), NOW(), TRUE);

-- Cluster 3: Public lands protection
-- Target: 783 (public lands protected from development)
-- Because: 781 (belong to all Americans) 55%, 782 (balance all uses) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (783, 26, 'Because', 781, 55.0, NOW(), NOW(), TRUE),
       (783, 26, 'Because', 782, 45.0, NOW(), NOW(), TRUE);

-- Target: 783 Rebuttal of 780 (maximize economic output) -- REJECTED
-- Rebuttal: 781 (public lands belong to all) 55%, 757 (clean environment priority) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (780, 26, 'Rebuttal', 781, 55.0, NOW(), NOW(), TRUE),
       (780, 26, 'Rebuttal', 757, 45.0, NOW(), NOW(), TRUE);

-- Cluster 4: Wolves belong
-- Target: 842 (wolves are integral part of natural healthy ecosystem)
-- Because: 843 (wolves rarely attack humans) 55%, 762 (native species should be prioritized) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (842, 26, 'Because', 843, 55.0, NOW(), NOW(), TRUE),
       (842, 26, 'Because', 762, 45.0, NOW(), NOW(), TRUE);

-- Target: 839 (wolf reintroduction was mistake) -- REJECTED
-- Rebuttal: 842 (wolves are integral to ecosystem) 55%, 843 (rarely attack humans) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (839, 26, 'Rebuttal', 842, 55.0, NOW(), NOW(), TRUE),
       (839, 26, 'Rebuttal', 843, 45.0, NOW(), NOW(), TRUE);

-- Cluster 5: Climate / water angle
-- Target: 123 (must act on climate quickly and forcefully)
-- Because: 321 (observable fact) 40%, 863 (requires collective action) 35%, 892 (sustainable carbon output) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (123, 26, 'Because', 321, 40.0, NOW(), NOW(), TRUE),
       (123, 26, 'Because', 863, 35.0, NOW(), NOW(), TRUE),
       (123, 26, 'Because', 892, 25.0, NOW(), NOW(), TRUE);

-- Cluster 6: Housing / community care
-- Target: 682 (homelessness should be treated as crisis)
-- Because: 692 (first priority: adequate shelter) 55%, 685 (provide sanitation) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (682, 26, 'Because', 692, 55.0, NOW(), NOW(), TRUE),
       (682, 26, 'Because', 685, 45.0, NOW(), NOW(), TRUE);

-- Cluster 7: Environmental protection is governance priority
-- Target: 757 (clean healthy environment should be government priority)
-- Because: 762 (native species prioritized) 50%, 321 (climate change is observable fact) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, firstVisit, lastVisit, active)
VALUES (757, 26, 'Because', 762, 50.0, NOW(), NOW(), TRUE),
       (757, 26, 'Because', 321, 50.0, NOW(), NOW(), TRUE);
