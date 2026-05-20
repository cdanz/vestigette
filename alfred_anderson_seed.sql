-- Alfred Anderson (profileID=1) opinion and endorsement population
-- Persona: Age 68, retired military, rural Minnesota, ideology_score 7/10 conservative
-- Trusts: VFW, Fox News, churches, police | Distrusts: federal govt, MSM, universities
-- Key issues: 2nd Amendment, immigration control, anti-big-govt, traditional values, veterans
--
-- NOTE: assertOpinion uses IF NOT EXISTS semantics - won't overwrite existing opinions.
-- Existing opinions for profileID=1 cover args 1-55 and 62-65 (pre-existing test data).
-- This script adds Alfred's persona opinions for all other arguments he'd weigh in on.

USE vestigette;

-- ============================================================
-- SECOND AMENDMENT (Alfred's top priority)
-- ============================================================
CALL assertOpinion(1, 140, 1);   -- 2A grants right to own whatever firearms I deem necessary
CALL assertOpinion(1, 226, 1);   -- Freedom should never be infringed
CALL assertOpinion(1, 324, 1);   -- Right not to rely fully on govt for protection
CALL assertOpinion(1, 325, 1);   -- Right to be prepared to defend against govt entities
CALL assertOpinion(1, 326, 1);   -- 2A spirit: protect ourselves without aid of govt
CALL assertOpinion(1, 327, 1);   -- 2A spirit: defend against threat our own govt may pose
CALL assertOpinion(1, 328, 1);   -- We should defend the second amendment
CALL assertOpinion(1, 459, 1);   -- Right to decide for ourselves what tools are safe to use
CALL assertOpinion(1, 460, 1);   -- Shouldn't restrict gun ownership for few misusers
CALL assertOpinion(1, 461, 1);   -- Handgun bans are unconstitutional
CALL assertOpinion(1, 596, 1);   -- Our right to free speech is absolute
CALL assertOpinion(1, 665, 1);   -- Restricting ownership only valid if can cause extraordinary harm
CALL assertOpinion(1, 1002, 1);  -- Owning guns doesn't mean being obsessive about gun culture
CALL assertOpinion(1, 1027, 1);  -- Mass shootings prevented if one person in crowd was armed
CALL assertOpinion(1, 1172, 1);  -- Any regulation of weapons must keep with 2A
CALL assertOpinion(1, 1176, 1);  -- Rural folks need AR-15 for feral hogs
CALL assertOpinion(1, 1177, 1);  -- The AR-15 has legitimate use cases like any other tool
CALL assertOpinion(1, 1178, 1);  -- Only I can decide what gun I should or should not own
CALL assertOpinion(-1, 329, 1);  -- Certain degree of firepower should be banned for private ownership
CALL assertOpinion(-1, 333, 1);  -- Assault weapons should be banned for non-military use
CALL assertOpinion(-1, 462, 1);  -- Society is better off without guns
CALL assertOpinion(-1, 743, 1);  -- Magazine capacities should be limited
CALL assertOpinion(-1, 746, 1);  -- Bump stocks should be illegal
CALL assertOpinion(-1, 747, 1);  -- Automatic weapons should be illegal
CALL assertOpinion(-1, 1179, 1); -- America needs gun reform now
CALL assertOpinion(-1, 1181, 1); -- Gun ownership in America should be strictly limited
CALL assertOpinion(-1, 1182, 1); -- The second amendment is bad
CALL assertOpinion(-1, 1189, 1); -- Assault weapons should be bought back for cash or tax credit

-- ============================================================
-- ANTI-BIG-GOVERNMENT / FREE MARKETS
-- ============================================================
CALL assertOpinion(1, 136, 1);   -- Capitalism is the best system we got
CALL assertOpinion(1, 193, 1);   -- No such thing as too much wealth concentration
CALL assertOpinion(1, 201, 1);   -- Innovation should not be encumbered
CALL assertOpinion(1, 224, 1);   -- Americans benefit from living in the greatest system ever conceived
CALL assertOpinion(1, 275, 1);   -- Govt projects have no profit motive to promote efficiency
CALL assertOpinion(1, 322, 1);   -- We should never put our full faith in the government
CALL assertOpinion(1, 323, 1);   -- Government is a human and imperfect endeavor
CALL assertOpinion(1, 400, 1);   -- Government should stay out of the way
CALL assertOpinion(1, 401, 1);   -- Free markets do a better job than any government
CALL assertOpinion(1, 404, 1);   -- Constant vigilance needed to eliminate unnecessary regs
CALL assertOpinion(1, 405, 1);   -- Unchecked, govt would grow and assume greater control
CALL assertOpinion(1, 406, 1);   -- Power in all forms never stops seeking greater power
CALL assertOpinion(1, 407, 1);   -- We must fight big government
CALL assertOpinion(1, 412, 1);   -- Government is inherently inefficient
CALL assertOpinion(1, 440, 1);   -- Win by constitution rules, not change them
CALL assertOpinion(1, 920, 1);   -- Government programs are ineffective
CALL assertOpinion(1, 1045, 1);  -- Regs impose burdens on industry beyond risk-mitigating benefits
CALL assertOpinion(1, 1278, 1);  -- The ideal economy is capitalist
CALL assertOpinion(1, 1591, 1);  -- Socialism has failed every time it has been tried
CALL assertOpinion(1, 1593, 1);  -- Commitment to capitalism is best defense against socialism
CALL assertOpinion(1, 1597, 1);  -- Socialism is bad
CALL assertOpinion(1, 1602, 1);  -- Means of production should largely be controlled privately
CALL assertOpinion(-1, 276, 1);  -- Nothing inherent making govt enterprise inferior (Alfred disagrees)
CALL assertOpinion(-1, 277, 1);  -- Some projects better suited to be run by govt (Alfred rejects)
CALL assertOpinion(-1, 450, 1);  -- Govt should respond to economic slowdowns with more spending
CALL assertOpinion(-1, 452, 1);  -- Govt spending can redistribute concentrated wealth

-- ============================================================
-- LOW TAXES / FISCAL CONSERVATISM
-- ============================================================
CALL assertOpinion(1, 227, 1);   -- Low taxes fuel innovation
CALL assertOpinion(1, 228, 1);   -- Low taxes strengthen the economy
CALL assertOpinion(1, 265, 1);   -- Tax cut lets you keep more of the money you duly earned
CALL assertOpinion(1, 266, 1);   -- A government check is unearned, other people's money
CALL assertOpinion(1, 449, 1);   -- The US should implement a Flat Tax
CALL assertOpinion(-1, 185, 1);  -- A wealth tax would reduce resentment
CALL assertOpinion(-1, 192, 1);  -- Wealth taxes should control offensive levels of wealth
CALL assertOpinion(-1, 204, 1);  -- Estate taxes are useful tool for controlling hereditary wealth
CALL assertOpinion(-1, 745, 1);  -- The wealthy should take a greater proportion of the tax burden

-- ============================================================
-- IMMIGRATION (Alfred is restrictionist)
-- ============================================================
CALL assertOpinion(1, 612, 1);   -- America should only allow the best of the best immigrants
CALL assertOpinion(-1, 611, 1);  -- Open borders are a worthy ideal to pursue
CALL assertOpinion(-1, 616, 1);  -- Asylum should be granted to all who seek it
CALL assertOpinion(-1, 617, 1);  -- Family separation at the southern US border is an atrocity
CALL assertOpinion(-1, 954, 1);  -- America should welcome immigrants with few restrictions
CALL assertOpinion(-1, 1159, 1); -- Immigrants are not dangerous
CALL assertOpinion(-1, 1162, 1); -- Bias toward allowing more immigrants through with less processing

-- ============================================================
-- POLICING / LAW AND ORDER
-- ============================================================
CALL assertOpinion(1, 165, 1);   -- Oversight of policing should be reformed, not policing itself
CALL assertOpinion(1, 166, 1);   -- Policing doesn't need to be changed; checks and balances do
CALL assertOpinion(1, 554, 1);   -- We need to crack down on Antifa
CALL assertOpinion(1, 561, 1);   -- Back the blue
CALL assertOpinion(1, 777, 1);   -- Criminals forfeit their rights when they choose a life of crime
CALL assertOpinion(1, 1410, 1);  -- Safety of police officers should be the top priority
CALL assertOpinion(1, 1411, 1);  -- Duty to protect those who protect us is sacred
CALL assertOpinion(-1, 105, 1);  -- Police kill black people with impunity
CALL assertOpinion(-1, 107, 1);  -- Defund police departments
CALL assertOpinion(-1, 145, 1);  -- Policing in America must be reformed
CALL assertOpinion(-1, 146, 1);  -- Policing in America must be reformed (duplicate arg)
CALL assertOpinion(-1, 151, 1);  -- Police unions are too powerful and uphold racist structures
CALL assertOpinion(-1, 163, 1);  -- More policing doesn't get to root of problem causing crime
CALL assertOpinion(-1, 560, 1);  -- The police should be abolished

-- ============================================================
-- CANCEL CULTURE / FREE SPEECH
-- ============================================================
CALL assertOpinion(1, 288, 1);   -- Cancel culture must be resisted
CALL assertOpinion(1, 291, 1);   -- People should not be fired for their political views
CALL assertOpinion(1, 297, 1);   -- Cancel culture is conformist liberal viewpoint on social issues
CALL assertOpinion(1, 298, 1);   -- Cancel culture is modern form of ostracism
CALL assertOpinion(1, 600, 1);   -- The Left is only interested in freedom when expressing their views
CALL assertOpinion(1, 1562, 1);  -- Woke nonsense is ruining everything
CALL assertOpinion(-1, 293, 1);  -- Cancel culture is merely criticism someone does not support
CALL assertOpinion(-1, 294, 1);  -- Cancel culture is too vague a term to be useful
CALL assertOpinion(-1, 295, 1);  -- Dismissing CC as such risks chilling useful discussion

-- ============================================================
-- VOTING RIGHTS (Alfred opposes expanding)
-- ============================================================
CALL assertOpinion(1, 180, 1);   -- Voting rights should not be expanded
CALL assertOpinion(1, 183, 1);   -- Reject mail-in voting initiatives
CALL assertOpinion(1, 1365, 1);  -- Georgia's voting law SB 202 is good policy
CALL assertOpinion(1, 1366, 1);  -- SB 202 expanded early voting including weekends
CALL assertOpinion(1, 1367, 1);  -- SB 202 enforces strict ID requirements to vote
CALL assertOpinion(-1, 355, 1);  -- Voting rights should be expanded and protected
CALL assertOpinion(-1, 356, 1);  -- We should have universal voter registration
CALL assertOpinion(-1, 357, 1);  -- We should have universal vote-by-mail
CALL assertOpinion(-1, 640, 1);  -- Congress must pass HR1 For The People Act

-- ============================================================
-- CLIMATE CHANGE (Alfred is skeptical)
-- ============================================================
CALL assertOpinion(1, 230, 1);   -- Climate change is a hoax
CALL assertOpinion(1, 415, 1);   -- Green energy is unreliable
CALL assertOpinion(1, 527, 1);   -- We'll destroy the economy before reversing global warming
CALL assertOpinion(1, 1275, 1);  -- The climate has been changing throughout Earth's history
CALL assertOpinion(1, 1276, 1);  -- Recent temp changes no different from historical swings
CALL assertOpinion(-1, 123, 1);  -- We must act on climate change quickly and forcefully
CALL assertOpinion(-1, 321, 1);  -- Human influenced climate change is an observable fact
CALL assertOpinion(-1, 414, 1);  -- We should ramp up renewable energy capacity ASAP
CALL assertOpinion(-1, 476, 1);  -- Fossil fuels need to be left in the ground
CALL assertOpinion(-1, 477, 1);  -- Fossil fuels are the greatest contributors to climate change

-- ============================================================
-- RELIGION / FAITH (Alfred is devout Christian)
-- ============================================================
CALL assertOpinion(1, 428, 1);   -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 1);   -- The faithful believe in His glory unconditionally
CALL assertOpinion(1, 1385, 1);  -- Jesus is my Lord and Savior
CALL assertOpinion(1, 1386, 1);  -- Jesus is God's only son
CALL assertOpinion(1, 1387, 1);  -- Life begins at conception
CALL assertOpinion(1, 1440, 1);  -- The Bible is the word of God
CALL assertOpinion(-1, 161, 1);  -- For all intents there is no such thing as a god
CALL assertOpinion(-1, 1438, 1); -- The Bible is bullshit

-- ============================================================
-- VETERANS / MILITARY (Alfred served in the Army)
-- ============================================================
CALL assertOpinion(1, 724, 1);   -- War should be difficult to wage
CALL assertOpinion(1, 912, 1);   -- The VA healthcare system fails to meet the needs of veterans
CALL assertOpinion(1, 913, 1);   -- Veterans deserve the best healthcare available
CALL assertOpinion(1, 916, 1);   -- Veterans owed basic necessities from the government that sent them
CALL assertOpinion(1, 995, 1);   -- The Vietnam War was a shameful mistake of American government
CALL assertOpinion(1, 1477, 1);  -- War must be avoided unless it is the very last resort
CALL assertOpinion(1, 1478, 1);  -- A war should be regularly re-examined by congress
CALL assertOpinion(1, 1482, 1);  -- The US war in Afghanistan should be ended as soon as possible
CALL assertOpinion(1, 1486, 1);  -- The Taliban must be destroyed

-- ============================================================
-- COVID / MANDATES (Alfred opposes mandates but not all vaccines)
-- ============================================================
CALL assertOpinion(1, 644, 1);   -- I will disobey any COVID lockdown mandates
CALL assertOpinion(1, 1393, 1);  -- There shall be no federal mandate to receive a COVID vaccine
CALL assertOpinion(1, 1396, 1);  -- No one should be forced to take a vaccine to go about everyday life
CALL assertOpinion(1, 1397, 1);  -- Vaccine passports should be banned
CALL assertOpinion(-1, 580, 1);  -- Wear masks in public during the COVID pandemic
CALL assertOpinion(-1, 1401, 1); -- Mandate proof of vaccination for mass transportation is acceptable
CALL assertOpinion(-1, 1407, 1); -- Private business can mandate proof of vaccination

-- ============================================================
-- GENDER / TRADITIONAL VALUES
-- ============================================================
CALL assertOpinion(1, 142, 1);   -- There are only two genders
CALL assertOpinion(1, 785, 1);   -- Traditional gender roles exist for a reason
CALL assertOpinion(1, 791, 1);   -- Sports should be separated by biological sex
CALL assertOpinion(1, 849, 1);   -- First duty as parent is as protector, which men excel at
CALL assertOpinion(-1, 790, 1);  -- Trans girls should not be forced to play boys sports
CALL assertOpinion(-1, 795, 1);  -- Support trans women by not undermining gender identity
CALL assertOpinion(-1, 797, 1);  -- Trans girls permitted in women's athletics same as any other girls
CALL assertOpinion(-1, 801, 1);  -- Leave trans kids out of bullshit culture war battles

-- ============================================================
-- WELFARE / SOCIAL SAFETY NET
-- ============================================================
CALL assertOpinion(1, 601, 1);   -- Welfare should ask recipients to do their part supporting themselves
CALL assertOpinion(1, 607, 1);   -- If people are given handouts they will never learn to provide for themselves
CALL assertOpinion(1, 642, 1);   -- Reject any coercion toward obligation to your neighbor
CALL assertOpinion(1, 643, 1);   -- Suggestion of shared obligation is a grievous personal insult
CALL assertOpinion(1, 705, 1);   -- Housing the poor should be responsibility of charity not govt
CALL assertOpinion(-1, 606, 1);  -- Govt should give direct cash payments to the poor
CALL assertOpinion(-1, 609, 1);  -- The US govt should implement universal basic income
CALL assertOpinion(-1, 666, 1);  -- H.R.1319 American Rescue Plan Act of 2021 is good policy
CALL assertOpinion(-1, 901, 1);  -- US should implement universal single-payer Medicare for All

-- ============================================================
-- ISRAEL / FOREIGN POLICY
-- ============================================================
CALL assertOpinion(1, 1625, 1);  -- Israel has a right to defend themselves against Palestinian aggression
CALL assertOpinion(1, 1627, 1);  -- Israel has a right to exist
CALL assertOpinion(-1, 1617, 1); -- Zionism is a racist ideology
CALL assertOpinion(-1, 1618, 1); -- Israeli subjugation of Palestinians is apartheid
CALL assertOpinion(-1, 1649, 1); -- Any authority that can should call for a ceasefire in Israel

-- ============================================================
-- MISCELLANEOUS CONSERVATIVE POSITIONS
-- ============================================================
CALL assertOpinion(1, 120, 1);   -- Trump puts America first
CALL assertOpinion(1, 179, 1);   -- American govt grown too large, Trump broke it down more effectively
CALL assertOpinion(1, 229, 1);   -- GOP's main goal is to keep the government out of our business
CALL assertOpinion(1, 264, 1);   -- Govt policy should be judged on net effect on one's wealth
CALL assertOpinion(1, 267, 1);   -- Means testing policy avoids wasting government resources
CALL assertOpinion(1, 574, 1);   -- The American Democratic Party is terrible
CALL assertOpinion(1, 727, 1);   -- Unions often employ inflexible rules impacting enterprise ability
CALL assertOpinion(1, 780, 1);   -- Public lands should be used to maximize economic output
CALL assertOpinion(1, 821, 1);   -- Stockpile guns, ammo, food, supplies and gold before it's too late
CALL assertOpinion(1, 839, 1);   -- Reintroduction of wolves to western US was a mistake
CALL assertOpinion(1, 841, 1);   -- Wolf hunting should be encouraged and unregulated
CALL assertOpinion(1, 905, 1);   -- American football is the best sport
CALL assertOpinion(1, 910, 1);   -- Government control of healthcare will create bureaucratic system
CALL assertOpinion(1, 930, 1);   -- Baseball is a cherished American tradition
CALL assertOpinion(1, 1197, 1);  -- In today's culture, white people are most commonly persecuted
CALL assertOpinion(1, 1229, 1);  -- It is perfectly okay to be white
CALL assertOpinion(-1, 104, 1);  -- Vote for Democrats
CALL assertOpinion(-1, 1345, 1); -- Curriculums should be reviewed to combat white supremacy
CALL assertOpinion(-1, 1346, 1); -- Kids should be taught white people are racist
CALL assertOpinion(-1, 1347, 1); -- Kids should be taught white supremacy prevents BIPOC achievement
CALL assertOpinion(-1, 1598, 1); -- Abolish the death penalty (Alfred supports capital punishment)
CALL assertOpinion(-1, 1617, 1); -- Zionism is a racist ideology (duplicate of above, harmless skip)


-- ============================================================
-- ENDORSEMENTS
-- Because = why this argument is true (supporting reason)
-- Therefore = what follows if this argument is true (consequence)
-- Rebuttal = argument that counters a rejected claim
-- INSERT IGNORE handles any duplicate PK gracefully
-- ============================================================

-- === SECOND AMENDMENT CLUSTER ===
-- arg 140: 2A grants right to own whatever firearms
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (140, 1, 'Because', 226, 90.0, 1),   -- freedom never infringed
       (140, 1, 'Because', 326, 85.0, 1),   -- 2A spirit: self-protection without govt
       (140, 1, 'Therefore', 328, 90.0, 1), -- we should defend 2A
       (140, 1, 'Therefore', 460, 80.0, 1), -- don't restrict owners for few misusers
       (140, 1, 'Therefore', 461, 85.0, 1); -- handgun bans unconstitutional

-- arg 328: We should defend the second amendment
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (328, 1, 'Because', 140, 90.0, 1),    -- 2A grants right
       (328, 1, 'Because', 325, 80.0, 1),    -- right to defend against govt
       (328, 1, 'Because', 226, 85.0, 1),    -- freedom never infringed
       (328, 1, 'Therefore', 1172, 80.0, 1), -- regulation must keep with 2A
       (328, 1, 'Therefore', 1177, 75.0, 1), -- AR-15 has legitimate uses
       (328, 1, 'Therefore', 1178, 85.0, 1); -- only I decide what gun I own

-- arg 1177: AR-15 has legitimate use cases
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1177, 1, 'Because', 1176, 80.0, 1),    -- rural folks need it for feral hogs
       (1177, 1, 'Because', 1002, 60.0, 1),    -- owning guns doesn't mean obsessive fan
       (1177, 1, 'Therefore', 1178, 80.0, 1),  -- only I decide what gun I own
       (1177, 1, 'Therefore', 1172, 70.0, 1);  -- regulation must keep with 2A

-- arg 462: Society better off without guns (REJECTED - Alfred's rebuttals)
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (462, 1, 'Rebuttal', 140, 90.0, 1),   -- 2A grants right
       (462, 1, 'Rebuttal', 1027, 70.0, 1);  -- good guy with gun prevents mass shootings

-- arg 1181: Gun ownership should be strictly limited (REJECTED)
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1181, 1, 'Rebuttal', 140, 90.0, 1),   -- 2A grants right
       (1181, 1, 'Rebuttal', 1178, 85.0, 1),  -- only I decide what gun I own
       (1181, 1, 'Rebuttal', 1172, 75.0, 1);  -- regulation must keep with 2A

-- arg 107: Defund police (REJECTED)
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (107, 1, 'Rebuttal', 561, 90.0, 1),  -- back the blue
       (107, 1, 'Rebuttal', 165, 80.0, 1);  -- oversight not defunding

-- === ANTI-BIG-GOVERNMENT CLUSTER ===
-- arg 400: Government should stay out of the way
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 1, 'Because', 406, 80.0, 1),    -- power always seeks greater power
       (400, 1, 'Because', 405, 85.0, 1),    -- unchecked govt grows to ruin nation
       (400, 1, 'Because', 412, 80.0, 1),    -- govt is inherently inefficient
       (400, 1, 'Therefore', 401, 85.0, 1),  -- free markets do better
       (400, 1, 'Therefore', 404, 75.0, 1);  -- eliminate unnecessary regs

-- arg 407: We must fight big government
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (407, 1, 'Because', 405, 85.0, 1),   -- unchecked govt grows
       (407, 1, 'Because', 406, 80.0, 1),   -- power seeks greater power
       (407, 1, 'Because', 412, 80.0, 1),   -- govt is inefficient
       (407, 1, 'Therefore', 400, 80.0, 1), -- govt should stay out
       (407, 1, 'Therefore', 401, 75.0, 1); -- free markets do better

-- arg 1597: Socialism is bad
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1597, 1, 'Because', 1591, 90.0, 1),    -- socialism failed every time
       (1597, 1, 'Because', 1593, 85.0, 1),    -- capitalism is best defense against socialism
       (1597, 1, 'Therefore', 1602, 80.0, 1),  -- means of production privately controlled
       (1597, 1, 'Therefore', 1278, 75.0, 1);  -- ideal economy is capitalist

-- === LOW TAXES CLUSTER ===
-- arg 227: Low taxes fuel innovation
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (227, 1, 'Because', 265, 80.0, 1),    -- tax cut lets you keep earned money
       (227, 1, 'Because', 201, 75.0, 1),    -- innovation should not be encumbered
       (227, 1, 'Therefore', 228, 85.0, 1),  -- low taxes strengthen economy
       (227, 1, 'Therefore', 449, 70.0, 1);  -- implement flat tax

-- arg 54 (REJECTED by Alfred): Wealth tax is critical tool
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (54, 1, 'Rebuttal', 193, 80.0, 1),  -- no such thing as too much wealth concentration
       (54, 1, 'Rebuttal', 265, 85.0, 1),  -- tax cut lets you keep earned money
       (54, 1, 'Rebuttal', 266, 75.0, 1);  -- govt check is unearned, other people's money

-- === POLICING CLUSTER ===
-- arg 561: Back the blue
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 1, 'Because', 1411, 90.0, 1),   -- duty to protect those who protect us
       (561, 1, 'Because', 1410, 85.0, 1),   -- safety of officers top priority
       (561, 1, 'Therefore', 165, 80.0, 1);  -- oversight not defunding is what's needed

-- arg 560: Police should be abolished (REJECTED)
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (560, 1, 'Rebuttal', 561, 90.0, 1),  -- back the blue
       (560, 1, 'Rebuttal', 777, 75.0, 1);  -- criminals forfeit their rights

-- === CANCEL CULTURE CLUSTER ===
-- arg 288: Cancel culture must be resisted
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 1, 'Because', 291, 85.0, 1),    -- people shouldn't be fired for political views
       (288, 1, 'Because', 297, 80.0, 1),    -- CC is conformist liberal viewpoint
       (288, 1, 'Therefore', 596, 85.0, 1),  -- right to free speech is absolute
       (288, 1, 'Therefore', 600, 80.0, 1);  -- Left only values their own expression

-- arg 293 (REJECTED): Cancel culture is merely criticism
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (293, 1, 'Rebuttal', 288, 80.0, 1),  -- cancel culture must be resisted
       (293, 1, 'Rebuttal', 291, 75.0, 1);  -- people fired for political views

-- === CLIMATE CHANGE CLUSTER ===
-- arg 230: Climate change is a hoax
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (230, 1, 'Because', 1275, 80.0, 1),   -- climate always changing throughout history
       (230, 1, 'Because', 1276, 75.0, 1),   -- recent changes no different from historical
       (230, 1, 'Therefore', 527, 70.0, 1),  -- economy destroyed before warming reversed
       (230, 1, 'Therefore', 415, 70.0, 1);  -- green energy is unreliable

-- arg 123 (REJECTED): Must act on climate change quickly
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 1, 'Rebuttal', 230, 80.0, 1),  -- climate change is a hoax
       (123, 1, 'Rebuttal', 527, 75.0, 1);  -- economy destroyed before warming reversed

-- === RELIGION CLUSTER ===
-- arg 1385: Jesus is my Lord and Savior
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1385, 1, 'Because', 1386, 90.0, 1),   -- Jesus is God's only son
       (1385, 1, 'Because', 1440, 90.0, 1),   -- Bible is word of God
       (1385, 1, 'Therefore', 1387, 80.0, 1); -- life begins at conception

-- arg 1387: Life begins at conception
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1387, 1, 'Because', 1385, 80.0, 1),  -- Jesus is Lord and Savior
       (1387, 1, 'Because', 1440, 75.0, 1);  -- Bible is word of God

-- === VETERANS CLUSTER ===
-- arg 913: Veterans deserve the best healthcare
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (913, 1, 'Because', 916, 90.0, 1),    -- veterans owed basic necessities from govt
       (913, 1, 'Because', 1411, 85.0, 1),   -- duty to protect those who protect us
       (913, 1, 'Therefore', 912, 75.0, 1);  -- VA fails veterans - so VA must be fixed

-- === VOTING RIGHTS CLUSTER ===
-- arg 355 (REJECTED): Voting rights should be expanded
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 1, 'Rebuttal', 180, 85.0, 1),  -- voting rights should not be expanded
       (355, 1, 'Rebuttal', 183, 80.0, 1);  -- reject mail-in voting

-- arg 1365: Georgia voting law SB 202 is good policy
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1365, 1, 'Because', 1366, 80.0, 1),  -- SB 202 expanded early voting
       (1365, 1, 'Because', 1367, 85.0, 1);  -- SB 202 enforces strict ID requirements

-- === IMMIGRATION CLUSTER ===
-- arg 611 (REJECTED): Open borders worthy ideal
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (611, 1, 'Rebuttal', 612, 85.0, 1);  -- only allow best of best immigrants

-- arg 617 (REJECTED): Family separation at border is atrocity
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (617, 1, 'Rebuttal', 618, 70.0, 1);  -- parents illegally crossing deserve consequences

-- === WELFARE CLUSTER ===
-- arg 604 (REJECTED): Govt should eliminate poverty
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (604, 1, 'Rebuttal', 705, 80.0, 1),  -- housing poor is charity's responsibility
       (604, 1, 'Rebuttal', 920, 80.0, 1);  -- govt programs are ineffective

-- arg 901 (REJECTED): Medicare for All
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (901, 1, 'Rebuttal', 910, 85.0, 1),  -- govt control of healthcare is bureaucratic
       (901, 1, 'Rebuttal', 920, 80.0, 1);  -- govt programs are ineffective

-- arg 609 (REJECTED): Universal basic income
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (609, 1, 'Rebuttal', 601, 80.0, 1),  -- welfare should require recipients do their part
       (609, 1, 'Rebuttal', 607, 75.0, 1);  -- handouts prevent self-sufficiency

-- === GENDER / TRANS SPORTS ===
-- arg 791: Sports should be separated by biological sex
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (791, 1, 'Because', 142, 85.0, 1),   -- there are only two genders
       (791, 1, 'Because', 785, 75.0, 1);   -- traditional gender roles exist for a reason

-- arg 797 (REJECTED): Trans girls permitted in women's athletics
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 1, 'Rebuttal', 791, 85.0, 1),  -- sports should be separated by biological sex
       (797, 1, 'Rebuttal', 142, 80.0, 1);  -- there are only two genders

-- === ISRAEL / FOREIGN POLICY ===
-- arg 1627: Israel has a right to exist
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1627, 1, 'Because', 1625, 80.0, 1);  -- right to defend against Palestinian aggression

-- arg 1617 (REJECTED): Zionism is racist ideology
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (1617, 1, 'Rebuttal', 1627, 80.0, 1),  -- Israel has right to exist
       (1617, 1, 'Rebuttal', 1625, 75.0, 1);  -- Israel has right to defend itself

SELECT 'Alfred Anderson opinions and endorsements loaded successfully.' AS status;
