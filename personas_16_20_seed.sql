-- personas_16_20_seed.sql
-- Opinion and endorsement population for profileIDs 16-20
-- Patricia Powell (16), Quinn Quigley (17), Robert Ramirez (18), Sandra Sullivan (19), Thomas Turner (20)
--
-- Weights within every (targArgID, profileID, endorseType) group sum to EXACTLY 100.0
-- assertOpinion(op, argID, proID): op=1 accept, op=-1 reject; uses IF NOT EXISTS semantics
-- Skip pre-existing GMO args 1-55 per spec

USE vestigette;

-- ============================================================
-- PROFILE 16: PATRICIA POWELL
-- 63yo Black Baptist woman, rural Mississippi
-- 30-year NAACP organizer, raising two grandchildren (daughter in prison)
-- ideology_score: -8 (strong progressive, faith-rooted justice framework)
-- Voting is sacred — bought with blood. Racism ongoing and operational.
-- Criminal justice criminalizes Blackness. Deep mistrust of police + MS govt.
-- Reform-minded on policing (not abolition), faith fully aligned with social justice
-- ============================================================

-- === VOTING RIGHTS (HARDCODED CORE) ===
CALL assertOpinion(1, 355, 16);   -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 16);   -- We should have universal voter registration
CALL assertOpinion(1, 357, 16);   -- We should have universal vote-by-mail
CALL assertOpinion(1, 640, 16);   -- Congress must pass HR1 - For The People Act
CALL assertOpinion(1, 775, 16);   -- Conviction of a crime should not disenfranchise right to vote
CALL assertOpinion(1, 182, 16);   -- Right of every citizen to vote is unassailable principle
CALL assertOpinion(1, 184, 16);   -- Most historically exploited groups also systemically disenfranchised
CALL assertOpinion(1, 770, 16);   -- One person, one vote is the only way democracy works
CALL assertOpinion(-1, 180, 16);  -- Voting rights should not be expanded (rejects)
CALL assertOpinion(-1, 181, 16);  -- Voting rights advocacy is attempt to tip scales for Democrats (rejects)
CALL assertOpinion(-1, 183, 16);  -- Reject mail-in voting initiatives (rejects)
CALL assertOpinion(1, 1357, 16);  -- Georgia's election law SB 202 should be condemned
CALL assertOpinion(-1, 1365, 16); -- Georgia's voting law SB 202 is good policy (rejects)
CALL assertOpinion(1, 1380, 16);  -- SB 202 predicated on the lie of fraud in 2020 election

-- === RACISM / RACIAL JUSTICE (HARDCODED CORE) ===
CALL assertOpinion(1, 103, 16);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 105, 16);   -- Police kill black people with impunity
CALL assertOpinion(1, 169, 16);   -- Non-white males statistically paid less per dollar
CALL assertOpinion(1, 175, 16);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 221, 16);   -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(-1, 101, 16);  -- Racism is made up (hardcoded reject)
CALL assertOpinion(1, 207, 16);   -- Black people stopped for looking suspicious far more often
CALL assertOpinion(1, 236, 16);   -- Black Americans are right to feel wronged by society
CALL assertOpinion(1, 240, 16);   -- Equality of any group treated as less than human is a priority
CALL assertOpinion(1, 241, 16);   -- Giving Black Americans the power they deserve should be priority
CALL assertOpinion(1, 484, 16);   -- We all have implicit bias
CALL assertOpinion(1, 485, 16);   -- Implicit bias training should be more common
CALL assertOpinion(1, 100, 16);   -- No system can be completely fair
CALL assertOpinion(-1, 108, 16);  -- Black people just commit more crime (rejects)
CALL assertOpinion(-1, 118, 16);  -- Black people are inherently less civil (rejects)
CALL assertOpinion(1, 238, 16);   -- American society is white supremacist
CALL assertOpinion(1, 1005, 16);  -- Scope and degree of racism in US is largely understated
CALL assertOpinion(-1, 1197, 16); -- White people most commonly persecuted in today's culture (rejects)
CALL assertOpinion(-1, 1229, 16); -- It is perfectly okay to be white (rejects as dismissive framing)

-- === CRIMINAL JUSTICE CRIMINALIZES BLACKNESS (HARDCODED CORE) ===
CALL assertOpinion(1, 111, 16);   -- End cash bail
CALL assertOpinion(1, 112, 16);   -- Implicit bias skews sentencing
CALL assertOpinion(1, 113, 16);   -- Conditions outside Black Americans' control increase crime likelihood
CALL assertOpinion(1, 115, 16);   -- Cash bail criminalizes poverty
CALL assertOpinion(1, 116, 16);   -- Cash bail perpetuates inequities felt by communities of color
CALL assertOpinion(1, 171, 16);   -- Criminal justice system major contributor to racial inequality
CALL assertOpinion(1, 174, 16);   -- CJ system prejudiced; not accounting for disparities is being blind
CALL assertOpinion(1, 222, 16);   -- CJ inequities part and parcel of American societal inequities
CALL assertOpinion(1, 223, 16);   -- Preventing racial inequality in justice system should be priority
CALL assertOpinion(-1, 170, 16);  -- CJ system should not adjust to correct for societal inequalities (rejects)
CALL assertOpinion(-1, 173, 16);  -- CJ system should not be focus of reform for racial equality (rejects)

-- === POLICING (Reform YES, Defund/Abolish NO) ===
CALL assertOpinion(1, 145, 16);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 16);   -- Police should be required to use de-escalation techniques
CALL assertOpinion(1, 151, 16);   -- Police unions too powerful and uphold racist structures
CALL assertOpinion(1, 153, 16);   -- Police should exhaust all other options before shooting
CALL assertOpinion(1, 154, 16);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 155, 16);   -- Police procedures and policies are effectively racist too often
CALL assertOpinion(1, 217, 16);   -- Police not held accountable for their actions to a just degree
CALL assertOpinion(1, 218, 16);   -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 16);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 16);   -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(-1, 107, 16);  -- Defund police departments (Patricia opposes -- reform, not defund)
CALL assertOpinion(-1, 560, 16);  -- Police should be abolished (Patricia opposes)
CALL assertOpinion(-1, 561, 16);  -- Back the blue (rejects uncritical framing)
CALL assertOpinion(1, 1188, 16);  -- Routine traffic stops extremely dangerous for black and brown people
CALL assertOpinion(-1, 1410, 16); -- Safety of police officers should be top priority (framing she rejects)

-- === BLM ===
CALL assertOpinion(1, 546, 16);   -- BLM movement activists deserve support
CALL assertOpinion(1, 551, 16);   -- BLM movement is peaceful but exists amid oppositional violence
CALL assertOpinion(1, 603, 16);   -- Cities with significant BLM protests had reduction in police homicides
CALL assertOpinion(1, 1202, 16);  -- BLM protests have by and large been peaceful
CALL assertOpinion(1, 1313, 16);  -- BLM is simply about Black Americans not living in fear
CALL assertOpinion(1, 1314, 16);  -- Black Americans' fear of police is completely legitimate
CALL assertOpinion(1, 1321, 16);  -- BLM makes clear point that Black people's lives are undervalued
CALL assertOpinion(-1, 349, 16);  -- BLM movement is racist (rejects)
CALL assertOpinion(-1, 350, 16);  -- BLM aims to diminish white people (rejects)
CALL assertOpinion(-1, 547, 16);  -- Black Lives Matter is violent (rejects)
CALL assertOpinion(-1, 549, 16);  -- Antifa are violent extremists (rejects framing)

-- === WEALTH INEQUALITY ===
CALL assertOpinion(1, 110, 16);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 500, 16);   -- Too many struggle to meet material needs while few have billions
CALL assertOpinion(1, 745, 16);   -- Wealthy should take greater proportion of tax burden

-- === FAITH (Baptist — fully aligned with social justice) ===
CALL assertOpinion(1, 130, 16);   -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 16);   -- Those that have faith can feel God's presence
CALL assertOpinion(1, 844, 16);   -- The faithful believe in His glory unconditionally
CALL assertOpinion(1, 1385, 16);  -- Jesus is my Lord and Savior!
CALL assertOpinion(1, 1440, 16);  -- The Bible is the word of God
CALL assertOpinion(-1, 161, 16);  -- For all intents there is no such thing as a god (rejects)

-- === POLITICS / TRUMP / DEMOCRACY ===
CALL assertOpinion(-1, 80, 16);   -- Trump 2024 (rejects)
CALL assertOpinion(1, 88, 16);    -- Trump not intellectually curious to a stunning degree
CALL assertOpinion(1, 89, 16);    -- Trump tacitly endorses racism
CALL assertOpinion(1, 90, 16);    -- GOP agenda is bad for America
CALL assertOpinion(1, 94, 16);    -- Do not vote for a Republican until major reforms
CALL assertOpinion(1, 96, 16);    -- Trump's singular concern is himself
CALL assertOpinion(1, 104, 16);   -- Vote for Democrats
CALL assertOpinion(1, 346, 16);   -- Impeach and convict Donald Trump
CALL assertOpinion(1, 347, 16);   -- Presidents who encourage insurrection must not hold office again
CALL assertOpinion(-1, 120, 16);  -- Trump puts America first (rejects)
CALL assertOpinion(1, 972, 16);   -- The GOP is anti-immigrant

-- === CHILDREN / EDUCATION ===
-- "Children not responsible for what the world did before they arrived"
CALL assertOpinion(1, 1345, 16);  -- Curriculums should be reviewed to combat white supremacy
CALL assertOpinion(1, 1347, 16);  -- Kids should be taught white supremacy prevents BIPOC achievement
CALL assertOpinion(1, 1351, 16);  -- Kids should be taught existence of white supremacy in US
CALL assertOpinion(-1, 1346, 16); -- Kids should be taught white people are racist (too blunt)

-- === LGBTQ (faith-adjacent, not hostile) ===
CALL assertOpinion(1, 144, 16);   -- Loving who you want causes no justifiable harm
CALL assertOpinion(1, 543, 16);   -- We should accept people for who they are

-- === IMMIGRATION ===
CALL assertOpinion(1, 615, 16);   -- There should always be a reasonable path to citizenship
CALL assertOpinion(1, 617, 16);   -- Family separation at the southern US border is an atrocity
CALL assertOpinion(-1, 618, 16);  -- Parents illegally crossing deserve to have children separated (rejects)

-- === ENDORSEMENTS: PATRICIA POWELL (profileID=16) ===

-- Cluster 1: Voting rights — sacred, bought with blood
-- Target: 355 (voting rights should be expanded)
-- Because: 184 (historically exploited groups disenfranchised) 55%, 182 (unassailable principle) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 16, 'Because', 184, 55.0, 1),
       (355, 16, 'Because', 182, 45.0, 1);

-- Target: 355 Therefore: 640 (Congress must pass HR1) 60%, 356 (universal voter reg) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (355, 16, 'Therefore', 640, 60.0, 1),
       (355, 16, 'Therefore', 356, 40.0, 1);

-- Cluster 2: CJ criminalizes Blackness
-- Target: 171 (CJ major contributor to racial inequality)
-- Because: 103 (convicted at disproportionate rate) 40%, 112 (bias skews sentencing) 35%, 115 (cash bail criminalizes poverty) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (171, 16, 'Because', 103, 40.0, 1),
       (171, 16, 'Because', 112, 35.0, 1),
       (171, 16, 'Because', 115, 25.0, 1);

-- Target: 171 Therefore: 223 (prevent racial inequality in justice) 55%, 174 (CJ prejudiced) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (171, 16, 'Therefore', 223, 55.0, 1),
       (171, 16, 'Therefore', 174, 45.0, 1);

-- Cluster 3: Police accountability
-- Target: 217 (police not held accountable)
-- Because: 219 (qualified immunity) 50%, 218 (see Black people as threat) 30%, 539 (immunity unjust) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 16, 'Because', 219, 50.0, 1),
       (217, 16, 'Because', 218, 30.0, 1),
       (217, 16, 'Because', 539, 20.0, 1);

-- Target: 217 Therefore: 145 (policing must be reformed) 55%, 148 (de-escalation) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 16, 'Therefore', 145, 55.0, 1),
       (217, 16, 'Therefore', 148, 45.0, 1);

-- Cluster 4: Policing must be reformed
-- Target: 145 (policing must be reformed)
-- Because: 155 (effectively racist) 40%, 217 (not held accountable) 35%, 207 (stops while Black) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 16, 'Because', 155, 40.0, 1),
       (145, 16, 'Because', 217, 35.0, 1),
       (145, 16, 'Because', 207, 25.0, 1);

-- Target: 145 Therefore: 148 (de-escalation required) 55%, 153 (exhaust options before shooting) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (145, 16, 'Therefore', 148, 55.0, 1),
       (145, 16, 'Therefore', 153, 45.0, 1);

-- Cluster 5: Racism is ongoing
-- Target: 221 (power structures maintaining white supremacy)
-- Because: 175 (inherent racial bias far-reaching) 50%, 484 (we all have implicit bias) 30%, 103 (disproportionate conviction) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (221, 16, 'Because', 175, 50.0, 1),
       (221, 16, 'Because', 484, 30.0, 1),
       (221, 16, 'Because', 103, 20.0, 1);

-- Target: 221 Therefore: 240 (equality is priority) 50%, 241 (give Black Americans power) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (221, 16, 'Therefore', 240, 50.0, 1),
       (221, 16, 'Therefore', 241, 50.0, 1);

-- Cluster 6: Faith and social justice — no contradiction
-- Target: 428 (those with faith feel God's presence)
-- Because: 130 (can't be certain God doesn't exist) 55%, 844 (believe unconditionally) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (428, 16, 'Because', 130, 55.0, 1),
       (428, 16, 'Because', 844, 45.0, 1);

-- Target: 428 Therefore: 1385 (Jesus is Lord) 60%, 1440 (Bible is word of God) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (428, 16, 'Therefore', 1385, 60.0, 1),
       (428, 16, 'Therefore', 1440, 40.0, 1);

-- Cluster 7: BLM is peaceful and deserves support
-- Target: 546 (BLM activists deserve support)
-- Because: 603 (BLM protests reduced police homicides) 40%, 1202 (protests peaceful) 35%, 1313 (about not living in fear) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 16, 'Because', 603, 40.0, 1),
       (546, 16, 'Because', 1202, 35.0, 1),
       (546, 16, 'Because', 1313, 25.0, 1);

-- Target: 546 Therefore: 1321 (Black people's lives undervalued) 55%, 551 (peaceful amid opposition) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (546, 16, 'Therefore', 1321, 55.0, 1),
       (546, 16, 'Therefore', 551, 45.0, 1);


-- ============================================================
-- PROFILE 17: QUINN QUIGLEY
-- 24yo non-binary multiracial barista + student, Portland OR
-- Non-voter by considered choice. Anti-capitalist. Trans rights as existential.
-- Community care > individualism. Deeply skeptical of Democratic Party as institution.
-- ideology_score: -9 (radical left, outside electoral politics)
-- ============================================================

-- === TRANS RIGHTS (HARDCODED NON-NEGOTIABLE) ===
CALL assertOpinion(-1, 142, 17);  -- There are only two genders (rejects — hardcoded)
CALL assertOpinion(-1, 143, 17);  -- Homosexuality is a perversion of nature (rejects — hardcoded)
CALL assertOpinion(1, 144, 17);   -- Loving who you want causes no justifiable harm
CALL assertOpinion(1, 315, 17);   -- A person does not choose their gender
CALL assertOpinion(1, 316, 17);   -- Gender is innate
CALL assertOpinion(1, 543, 17);   -- We should accept people for who they are
CALL assertOpinion(1, 544, 17);   -- Trans men should be accepted as men and trans women as women
CALL assertOpinion(1, 790, 17);   -- Trans girls should not be forced to play boys sports
CALL assertOpinion(1, 795, 17);   -- Support trans women by not undermining their gender identity
CALL assertOpinion(1, 797, 17);   -- Trans girls should be permitted to participate in women's athletics
CALL assertOpinion(1, 800, 17);   -- Trans sports debate is overblown proxy argument for hating trans people
CALL assertOpinion(1, 801, 17);   -- We should endeavor to leave trans kids out of culture war battles
CALL assertOpinion(-1, 785, 17);  -- Traditional gender roles exist for a reason (rejects)
CALL assertOpinion(-1, 791, 17);  -- Sports should be separated by biological sex (rejects)
CALL assertOpinion(-1, 792, 17);  -- Trans girls have unfair advantage over cis girls (rejects)
CALL assertOpinion(-1, 793, 17);  -- Trans girls should be forced to play among boys (rejects)
CALL assertOpinion(1, 1312, 17);  -- Laws banning trans kids from sports by gender identity are wrong
CALL assertOpinion(1, 1425, 17);  -- Being transgender or non-binary is not a mental disorder
CALL assertOpinion(1, 1429, 17);  -- Censoring portrayals of transgenderism in schools denies legitimacy

-- === ECONOMIC SYSTEM / ANTI-CAPITALISM (HARDCODED) ===
CALL assertOpinion(1, 500, 17);   -- Too many struggle to meet material needs while few have billions
CALL assertOpinion(1, 481, 17);   -- Rules of the game for acquiring wealth should be fundamentally changed
CALL assertOpinion(1, 482, 17);   -- A fair game should start easier then get harder as you advance
CALL assertOpinion(1, 483, 17);   -- Wealth accumulation easy if you have money, near impossible if not
CALL assertOpinion(1, 110, 17);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 501, 17);   -- People living one expense from dire situation have chronic anxiety
CALL assertOpinion(1, 502, 17);   -- Powers label financial insecurity pain as 'mental health crisis'
CALL assertOpinion(1, 137, 17);   -- Agreed upon ideal of wealth distribution is far less weighted to few
CALL assertOpinion(1, 138, 17);   -- Agreed upon ideal of wealth distribution
CALL assertOpinion(1, 139, 17);   -- Trustfund kids and internet billionaires don't deserve their money
CALL assertOpinion(-1, 136, 17);  -- Capitalism is the best system we got (rejects)

-- === POLICING / ABOLITION ===
CALL assertOpinion(1, 560, 17);   -- The police should be abolished
CALL assertOpinion(1, 107, 17);   -- Defund police departments
CALL assertOpinion(-1, 561, 17);  -- Back the blue (rejects)
CALL assertOpinion(1, 105, 17);   -- Police kill black people with impunity
CALL assertOpinion(1, 151, 17);   -- Police unions too powerful and uphold racist structures
CALL assertOpinion(1, 217, 17);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 218, 17);   -- Police in general see Black people as greater threat
CALL assertOpinion(1, 219, 17);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 17);   -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(-1, 547, 17);  -- Black Lives Matter is violent (rejects)
CALL assertOpinion(1, 546, 17);   -- BLM activists deserve support
CALL assertOpinion(1, 556, 17);   -- Antifa only violent in defense of its community
CALL assertOpinion(1, 557, 17);   -- Antifa is a response to fascism imposed upon community
CALL assertOpinion(1, 558, 17);   -- Antifa deserves support
CALL assertOpinion(1, 763, 17);   -- Anti-fascist researchers do some of the most dedicated work
CALL assertOpinion(1, 766, 17);   -- Antifa exposes nazis to their communities
CALL assertOpinion(1, 767, 17);   -- Antifa humiliates fascists like Proud Boys
CALL assertOpinion(1, 768, 17);   -- Antifa researchers spend hours IDing fascists to protect communities

-- === HOUSING / HOMELESSNESS ===
CALL assertOpinion(1, 682, 17);   -- Homelessness should be treated as the crisis that it is
CALL assertOpinion(1, 683, 17);   -- It is wrong to make the unhoused work harder to sleep comfortably
CALL assertOpinion(1, 684, 17);   -- Cleanup efforts of encampments are cruel
CALL assertOpinion(1, 685, 17);   -- Encampments should be provided basic sanitation services
CALL assertOpinion(1, 692, 17);   -- First priority in homelessness crisis: get everyone adequate shelter
CALL assertOpinion(1, 693, 17);   -- Government should designate land for basic shelters
CALL assertOpinion(1, 719, 17);   -- There is ample opportunity to build more densely
CALL assertOpinion(1, 722, 17);   -- Seattle should zone for more duplexes, triplexes, townhouses
CALL assertOpinion(1, 721, 17);   -- No one should be completely priced out of a city
CALL assertOpinion(1, 836, 17);   -- Home prices are unacceptably high
CALL assertOpinion(1, 1143, 17);  -- There should be sufficient affordable housing

-- === SOCIAL MEDIA CRITIQUE ===
CALL assertOpinion(1, 367, 17);   -- Social media is bad
CALL assertOpinion(1, 368, 17);   -- Pursuit of greater engagement discourages resolution
CALL assertOpinion(1, 369, 17);   -- Lack of gatekeepers makes dialogue over social media chaotic
CALL assertOpinion(1, 374, 17);   -- Social media allows users to consume only content they like
CALL assertOpinion(1, 588, 17);   -- Social media democratizes judgement

-- === CANCEL CULTURE (nuanced — protects marginalized) ===
CALL assertOpinion(1, 293, 17);   -- Cancel culture is merely criticism someone doesn't support
CALL assertOpinion(1, 294, 17);   -- Cancel culture is too vague a term to be useful
CALL assertOpinion(1, 295, 17);   -- Dismissing criticism as cancel culture risks chilling useful discussion
CALL assertOpinion(1, 296, 17);   -- Broad opposition to cancel culture adds legitimacy to deserving criticism
CALL assertOpinion(-1, 288, 17);  -- Cancel Culture must be resisted (rejects the conservative framing)
CALL assertOpinion(-1, 297, 17);  -- Cancel culture is effort to promote conformist liberal viewpoint (rejects)

-- === FREE SPEECH (with limits) ===
CALL assertOpinion(1, 422, 17);   -- Free speech gives right to express up to point of direct harm
CALL assertOpinion(1, 597, 17);   -- You shouldn't be able to scream FIRE in crowded theater without consequences

-- === BOTH PARTIES SKEPTICISM ===
CALL assertOpinion(-1, 80, 17);   -- Trump 2024 (rejects)
CALL assertOpinion(1, 574, 17);   -- The American Democratic Party is terrible
CALL assertOpinion(1, 575, 17);   -- DNC efforts for common person are meek
CALL assertOpinion(1, 576, 17);   -- World faces dire threats DNC is unwilling to meet
CALL assertOpinion(-1, 104, 17);  -- Vote for Democrats (Quinn doesn't vote — rejects as oversimplified)
CALL assertOpinion(1, 89, 17);    -- Trump tacitly endorses racism
CALL assertOpinion(1, 90, 17);    -- GOP agenda is bad for America

-- === LGBTQ FULL SUITE ===
CALL assertOpinion(1, 278, 17);   -- No individual should suffer harassment based on sexual orientation

-- === UNIONS / WORKERS ===
CALL assertOpinion(1, 494, 17);   -- Workers should unionize
CALL assertOpinion(1, 495, 17);   -- Collective bargaining helps workers win greater pay and benefits
CALL assertOpinion(1, 496, 17);   -- Biden administration should endorse Amazon workers' drive to unionize
CALL assertOpinion(1, 1200, 17);  -- Workers deserve some measure of leverage against management
CALL assertOpinion(1, 1201, 17);  -- A solitary worker is easily exploited by their employer

-- === RANKED CHOICE ===
CALL assertOpinion(1, 696, 17);   -- We should support ranked choice voting

-- === ENDORSEMENTS: QUINN QUIGLEY (profileID=17) ===

-- Cluster 1: Trans rights as existential
-- Target: 797 (trans girls should be permitted to participate in women's athletics)
-- Because: 315 (don't choose gender) 40%, 316 (gender is innate) 35%, 790 (shouldn't be forced to play boys) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 17, 'Because', 315, 40.0, 1),
       (797, 17, 'Because', 316, 35.0, 1),
       (797, 17, 'Because', 790, 25.0, 1);

-- Target: 797 Therefore: 801 (leave trans kids out of culture war) 55%, 800 (overblown proxy argument) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (797, 17, 'Therefore', 801, 55.0, 1),
       (797, 17, 'Therefore', 800, 45.0, 1);

-- Cluster 2: Anti-capitalism / economic system
-- Target: 500 (too many struggle while few have billions)
-- Because: 483 (wealth accumulation easy if have money) 40%, 481 (rules must fundamentally change) 35%, 110 (wealth inequality beyond acceptable) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (500, 17, 'Because', 483, 40.0, 1),
       (500, 17, 'Because', 481, 35.0, 1),
       (500, 17, 'Because', 110, 25.0, 1);

-- Target: 500 Therefore: 501 (chronic anxiety from precarity) 55%, 502 (powers label it mental health) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (500, 17, 'Therefore', 501, 55.0, 1),
       (500, 17, 'Therefore', 502, 45.0, 1);

-- Cluster 3: Police abolition
-- Target: 560 (police should be abolished)
-- Because: 217 (not held accountable) 40%, 539 (qualified immunity unjust) 35%, 107 (defund first step) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (560, 17, 'Because', 217, 40.0, 1),
       (560, 17, 'Because', 539, 35.0, 1),
       (560, 17, 'Because', 107, 25.0, 1);

-- Target: 561 (back the blue — REJECTED by Quinn), Rebuttal: 560 (police should be abolished — ACCEPTED) 60%, 107 (defund — ACCEPTED) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 17, 'Rebuttal', 560, 60.0, 1),
       (561, 17, 'Rebuttal', 107, 40.0, 1);

-- Cluster 4: Anti-fascist work
-- Target: 763 (anti-fascist researchers do most dedicated work)
-- Because: 766 (expose nazis) 40%, 768 (spend hours IDing fascists) 35%, 767 (humiliate fascists) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (763, 17, 'Because', 766, 40.0, 1),
       (763, 17, 'Because', 768, 35.0, 1),
       (763, 17, 'Because', 767, 25.0, 1);

-- Cluster 5: Homelessness crisis
-- Target: 682 (homelessness should be treated as crisis)
-- Because: 836 (home prices unacceptably high) 45%, 1143 (need sufficient affordable housing) 35%, 692 (priority: shelter) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (682, 17, 'Because', 836, 45.0, 1),
       (682, 17, 'Because', 1143, 35.0, 1),
       (682, 17, 'Because', 692, 20.0, 1);

-- Target: 682 Therefore: 693 (designate land for shelters) 60%, 685 (provide sanitation) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (682, 17, 'Therefore', 693, 60.0, 1),
       (682, 17, 'Therefore', 685, 40.0, 1);

-- Cluster 6: Union support
-- Target: 494 (workers should unionize)
-- Because: 1200 (deserve leverage) 50%, 1201 (solitary worker easily exploited) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 17, 'Because', 1200, 50.0, 1),
       (494, 17, 'Because', 1201, 50.0, 1);

-- Target: 494 Therefore: 495 (collective bargaining helps win pay/benefits) 60%, 496 (Biden should endorse Amazon) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 17, 'Therefore', 495, 60.0, 1),
       (494, 17, 'Therefore', 496, 40.0, 1);

-- Cluster 7: Cancel culture — protecting marginalized is different
-- Target: 293 (cancel culture is merely criticism)
-- Because: 294 (too vague) 45%, 295 (chills useful discussion) 35%, 296 (adds legitimacy to bad views) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (293, 17, 'Because', 294, 45.0, 1),
       (293, 17, 'Because', 295, 35.0, 1),
       (293, 17, 'Because', 296, 20.0, 1);

-- Target: 288 (cancel culture must be resisted — REJECTED by Quinn), Rebuttal with accepted args
-- Rebuttal: 293 (merely criticism) 45%, 294 (too vague) 35%, 295 (chills useful discussion) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 17, 'Rebuttal', 293, 45.0, 1),
       (288, 17, 'Rebuttal', 294, 35.0, 1),
       (288, 17, 'Rebuttal', 295, 20.0, 1);


-- ============================================================
-- PROFILE 18: ROBERT RAMIREZ
-- 50yo White evangelical construction owner, rural Missouri, 6 employees
-- MAGA enthusiast. Voted Trump twice with enthusiasm. Believes 2020 stolen.
-- America is a Christian nation. 2A non-negotiable. Anti-EPA/OSHA as obstacles.
-- ideology_score: +9 (strong MAGA conservative)
-- ============================================================

-- === CHRISTIAN NATION / FAITH (HARDCODED) ===
CALL assertOpinion(1, 130, 18);   -- You can't be certain God does not exist
CALL assertOpinion(1, 428, 18);   -- Those that have faith can feel God's presence
CALL assertOpinion(1, 567, 18);   -- Only God can be sovereign
CALL assertOpinion(1, 568, 18);   -- To have no sovereign but God is what it means to be free
CALL assertOpinion(1, 1385, 18);  -- Jesus is my Lord and Savior!
CALL assertOpinion(1, 1386, 18);  -- Jesus is God's only son
CALL assertOpinion(1, 1440, 18);  -- The Bible is the word of God
CALL assertOpinion(-1, 161, 18);  -- For all intents there is no such thing as a god (rejects)
CALL assertOpinion(1, 844, 18);   -- The faithful believe in His glory unconditionally

-- === 2ND AMENDMENT (HARDCODED SHALL NOT BE INFRINGED) ===
CALL assertOpinion(1, 140, 18);   -- Second amendment grants right to own whatever firearms I deem necessary
CALL assertOpinion(1, 326, 18);   -- Spirit of 2A is to preserve right to protect ourselves without government
CALL assertOpinion(1, 327, 18);   -- Spirit of 2A is to defend against threat our own government may pose
CALL assertOpinion(1, 328, 18);   -- We should defend the second amendment
CALL assertOpinion(1, 460, 18);   -- People shouldn't be restricted from responsibly owning guns
CALL assertOpinion(1, 461, 18);   -- Handgun bans are unconstitutional
CALL assertOpinion(-1, 141, 18);  -- There must be some limits on firepower (rejects)
CALL assertOpinion(-1, 329, 18);  -- There is a certain degree of firepower that should be banned (rejects)
CALL assertOpinion(-1, 331, 18);  -- Gun laws limiting ownership are constitutional (rejects)
CALL assertOpinion(-1, 333, 18);  -- Assault weapons should be banned (rejects)
CALL assertOpinion(-1, 729, 18);  -- Assault weapon too broad a term to legislate (rejects this nuance)
CALL assertOpinion(-1, 743, 18);  -- Magazine capacities should be limited (rejects)
CALL assertOpinion(-1, 746, 18);  -- Bump stocks should be illegal (rejects)
CALL assertOpinion(-1, 747, 18);  -- Automatic weapons should be illegal (rejects)
CALL assertOpinion(1, 1027, 18);  -- Mass shootings would be prevented if one person in crowd was armed
CALL assertOpinion(-1, 1028, 18); -- Good guy with gun more likely to exacerbate active shooter (rejects)

-- === TRUMP / MAGA (HARDCODED) ===
CALL assertOpinion(1, 80, 18);    -- Trump 2024
CALL assertOpinion(1, 120, 18);   -- Trump puts America first
CALL assertOpinion(1, 121, 18);   -- Trump makes whiny social justice warriors cry
CALL assertOpinion(-1, 346, 18);  -- Impeach and convict Donald Trump (rejects — believes 2020 stolen)
CALL assertOpinion(-1, 88, 18);   -- Trump not intellectually curious (rejects)
CALL assertOpinion(-1, 89, 18);   -- Trump tacitly endorses racism (rejects)
CALL assertOpinion(-1, 90, 18);   -- GOP agenda is bad for America (rejects)
CALL assertOpinion(-1, 94, 18);   -- Do not vote Republican (rejects)
CALL assertOpinion(-1, 96, 18);   -- Trump's singular concern is himself (rejects)
CALL assertOpinion(-1, 104, 18);  -- Vote for Democrats (rejects)

-- === IMMIGRATION MUST STOP (HARDCODED) ===
CALL assertOpinion(-1, 611, 18);  -- Open borders are a worthy ideal (rejects)
CALL assertOpinion(-1, 615, 18);  -- There should always be a reasonable path to citizenship (rejects)
CALL assertOpinion(-1, 616, 18);  -- Asylum should be granted to all those that seek it (rejects)
CALL assertOpinion(1, 612, 18);   -- America should only allow the best of the best to become citizens
CALL assertOpinion(1, 618, 18);   -- Parents illegally crossing deserve to have children separated
CALL assertOpinion(1, 1237, 18);  -- Migrants attempting to cross should be treated as enemy invaders
-- Note: Robert accepts 618 (consequence framing) but would not call 617 an "atrocity"

-- === BACK THE BLUE / ANTI-BLM ===
CALL assertOpinion(1, 561, 18);   -- Back the blue
CALL assertOpinion(1, 777, 18);   -- Criminals forfeit their rights when they choose a life of crime
CALL assertOpinion(1, 1410, 18);  -- Safety of police officers should be top priority
CALL assertOpinion(1, 1411, 18);  -- Duty to protect those who protect us is sacred
CALL assertOpinion(1, 349, 18);   -- The Black Lives Matter movement is racist
CALL assertOpinion(1, 547, 18);   -- Black Lives Matter is violent
CALL assertOpinion(1, 548, 18);   -- BLM is in cahoots with Antifa
CALL assertOpinion(1, 549, 18);   -- Antifa are violent extremists
CALL assertOpinion(1, 554, 18);   -- We need to crack down on Antifa
CALL assertOpinion(1, 555, 18);   -- We need to crack down on BLM activists
CALL assertOpinion(-1, 107, 18);  -- Defund police (rejects)
CALL assertOpinion(-1, 560, 18);  -- Abolish police (rejects)
CALL assertOpinion(-1, 145, 18);  -- Policing must be reformed (rejects reform framing)
CALL assertOpinion(1, 602, 18);   -- BLM protests didn't improve anything

-- === FREE MARKET / ANTI-REGULATION ===
CALL assertOpinion(1, 400, 18);   -- Government should stay out of the way
CALL assertOpinion(1, 401, 18);   -- Free markets do better than any government ever could
CALL assertOpinion(1, 136, 18);   -- Capitalism is the best system we got
CALL assertOpinion(1, 134, 18);   -- We shouldn't punish success
CALL assertOpinion(1, 135, 18);   -- Not allowing people to keep what they earned is criminal
CALL assertOpinion(1, 404, 18);   -- Constant vigilance needed to eliminate unnecessary regulations
CALL assertOpinion(1, 407, 18);   -- We must fight big government
CALL assertOpinion(1, 405, 18);   -- Unchecked government would grow to ruin of nation
CALL assertOpinion(-1, 110, 18);  -- Degree of wealth inequality is beyond acceptable (rejects)
CALL assertOpinion(-1, 606, 18);  -- Government should give direct cash payments to poor (rejects)
CALL assertOpinion(-1, 609, 18);  -- US government should implement universal basic income (rejects)

-- === ANTI-CANCEL CULTURE ===
CALL assertOpinion(1, 288, 18);   -- Cancel Culture must be resisted
CALL assertOpinion(1, 297, 18);   -- Cancel culture is effort to promote conformist liberal viewpoint
CALL assertOpinion(1, 651, 18);   -- Dr. Seuss books victim of social justice warriors blackmailing business
CALL assertOpinion(1, 652, 18);   -- Six Dr. Seuss books banned tantamount to digital book burning
CALL assertOpinion(1, 658, 18);   -- Social Justice Warriors threaten to damage reputations
CALL assertOpinion(1, 659, 18);   -- SJWs are bad

-- === CLIMATE CHANGE (REJECTS ACTION) ===
CALL assertOpinion(-1, 123, 18);  -- We must act on climate change quickly (rejects)
CALL assertOpinion(1, 230, 18);   -- Climate change is a hoax
CALL assertOpinion(-1, 414, 18);  -- Ramp up renewable energy as soon as possible (rejects)
CALL assertOpinion(-1, 321, 18);  -- Human influenced climate change is observable fact (rejects)
CALL assertOpinion(-1, 476, 18);  -- Fossil fuels need to be left in ground (rejects)
CALL assertOpinion(1, 1275, 18);  -- Climate has been changing throughout earth's history
CALL assertOpinion(1, 1276, 18);  -- Recent changes little different from historical swings

-- === ABORTION / PRO-LIFE ===
CALL assertOpinion(1, 124, 18);   -- A fetus has a human soul whose life should be protected
CALL assertOpinion(1, 125, 18);   -- Woman should take responsibility for pregnancies rather than aborting
CALL assertOpinion(1, 902, 18);   -- Unborn children deserve their right to life to be recognized
CALL assertOpinion(1, 1387, 18);  -- Life begins at conception

-- === TRADITIONAL VALUES ===
CALL assertOpinion(1, 849, 18);   -- First duty as parent is as protector which men excel at
CALL assertOpinion(-1, 315, 18);  -- A person does not choose their gender (rejects)
CALL assertOpinion(-1, 543, 18);  -- We should accept people for who they are (rejects in this context)

-- === ENDORSEMENTS: ROBERT RAMIREZ (profileID=18) ===

-- Cluster 1: 2A is non-negotiable
-- Target: 140 (2A grants right to own whatever firearms I deem necessary)
-- Because: 326 (spirit is self-protection without govt) 45%, 327 (defend against government threat) 35%, 460 (shouldn't restrict responsible owners) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (140, 18, 'Because', 326, 45.0, 1),
       (140, 18, 'Because', 327, 35.0, 1),
       (140, 18, 'Because', 460, 20.0, 1);

-- Target: 140 Therefore: 328 (defend the second amendment) 55%, 461 (handgun bans unconstitutional) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (140, 18, 'Therefore', 328, 55.0, 1),
       (140, 18, 'Therefore', 461, 45.0, 1);

-- Cluster 2: America is a Christian nation
-- Target: 567 (only God can be sovereign)
-- Because: 428 (faith can feel God's presence) 50%, 1440 (Bible is word of God) 30%, 1385 (Jesus is Lord) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (567, 18, 'Because', 428, 50.0, 1),
       (567, 18, 'Because', 1440, 30.0, 1),
       (567, 18, 'Because', 1385, 20.0, 1);

-- Target: 567 Therefore: 568 (no sovereign but God = freedom) 100%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (567, 18, 'Therefore', 568, 100.0, 1);

-- Cluster 3: Back the blue / anti-BLM
-- Target: 561 (back the blue)
-- Because: 1410 (safety of officers top priority) 40%, 777 (criminals forfeit rights) 35%, 1411 (duty to protect those who protect us) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (561, 18, 'Because', 1410, 40.0, 1),
       (561, 18, 'Because', 777, 35.0, 1),
       (561, 18, 'Because', 1411, 25.0, 1);

-- Target: 105 (police kill Black people with impunity — REJECTED by Robert), Rebuttal: 561 (back the blue — ACCEPTED) 55%, 1410 (officer safety top priority — ACCEPTED) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (105, 18, 'Rebuttal', 561, 55.0, 1),
       (105, 18, 'Rebuttal', 1410, 45.0, 1);

-- Cluster 4: BLM is violent / racist
-- Target: 347 (BLM movement is racist)
-- Because: 547 (BLM is violent) 45%, 548 (in cahoots with Antifa) 35%, 549 (Antifa violent extremists) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (349, 18, 'Because', 547, 45.0, 1),
       (349, 18, 'Because', 548, 35.0, 1),
       (349, 18, 'Because', 549, 20.0, 1);

-- Target: 349 Therefore: 554 (crack down on Antifa) 50%, 555 (crack down on BLM) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (349, 18, 'Therefore', 554, 50.0, 1),
       (349, 18, 'Therefore', 555, 50.0, 1);

-- Cluster 5: Free market / anti-government
-- Target: 400 (government should stay out of the way)
-- Because: 401 (free markets better than government) 50%, 405 (unchecked govt would grow) 30%, 134 (shouldn't punish success) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 18, 'Because', 401, 50.0, 1),
       (400, 18, 'Because', 405, 30.0, 1),
       (400, 18, 'Because', 134, 20.0, 1);

-- Target: 400 Therefore: 404 (eliminate unnecessary regulations) 55%, 407 (fight big government) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 18, 'Therefore', 404, 55.0, 1),
       (400, 18, 'Therefore', 407, 45.0, 1);

-- Cluster 6: Climate change is a hoax
-- Target: 230 (climate change is a hoax)
-- Because: 1275 (climate has always changed) 55%, 1276 (recent changes not different from history) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (230, 18, 'Because', 1275, 55.0, 1),
       (230, 18, 'Because', 1276, 45.0, 1);

-- Target: 321 (human climate change observable fact — REJECTED by Robert), Rebuttal: 230 (hoax — ACCEPTED) 55%, 1275 (climate always changing — ACCEPTED) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (321, 18, 'Rebuttal', 230, 55.0, 1),
       (321, 18, 'Rebuttal', 1275, 45.0, 1);

-- Cluster 7: Anti-cancel culture
-- Target: 288 (cancel culture must be resisted)
-- Because: 297 (effort to promote conformist viewpoint) 45%, 658 (SJWs threaten reputations) 35%, 651 (Dr. Seuss victim) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 18, 'Because', 297, 45.0, 1),
       (288, 18, 'Because', 658, 35.0, 1),
       (288, 18, 'Because', 651, 20.0, 1);

-- Target: 288 Therefore: 659 (SJWs are bad) 60%, 652 (book burning) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (288, 18, 'Therefore', 659, 60.0, 1),
       (288, 18, 'Therefore', 652, 40.0, 1);


-- ============================================================
-- PROFILE 19: SANDRA SULLIVAN
-- 57yo Jewish plaintiff-side employment attorney, Scarsdale NY
-- Reliable Democrat with complicated new relationship to progressive left since Oct 7
-- Democracy and rule of law are existential. Antisemitism never acceptable.
-- Workers deserve legal protection. Holocaust as organizing historical lesson.
-- ideology_score: -6 (progressive Democrat, rule-of-law center-left)
-- ============================================================

-- === DEMOCRACY / RULE OF LAW (HARDCODED CORE) ===
CALL assertOpinion(1, 346, 19);   -- Impeach and convict Donald Trump
CALL assertOpinion(1, 347, 19);   -- Presidents who encourage insurrection must not hold office again
CALL assertOpinion(1, 355, 19);   -- Voting rights should be expanded and protected
CALL assertOpinion(1, 356, 19);   -- We should have universal voter registration
CALL assertOpinion(1, 357, 19);   -- We should have universal vote-by-mail
CALL assertOpinion(1, 389, 19);   -- Democratic Party must enforce political behavioral norms
CALL assertOpinion(1, 640, 19);   -- Congress must pass HR1 - For The People Act
CALL assertOpinion(1, 182, 19);   -- Right of every citizen to vote is unassailable principle
CALL assertOpinion(1, 184, 19);   -- Most historically exploited groups also disenfranchised
CALL assertOpinion(1, 770, 19);   -- One person, one vote is the only way democracy works

-- === TRUMP / GOP (CATEGORICAL REJECTION) ===
CALL assertOpinion(-1, 80, 19);   -- Trump 2024 (rejects)
CALL assertOpinion(1, 88, 19);    -- Trump not intellectually curious
CALL assertOpinion(1, 89, 19);    -- Trump tacitly endorses racism
CALL assertOpinion(1, 90, 19);    -- GOP agenda is bad for America
CALL assertOpinion(1, 91, 19);    -- GOP primarily interested in concentrating wealth among few
CALL assertOpinion(1, 92, 19);    -- GOP influenced by anti-government worldview
CALL assertOpinion(1, 93, 19);    -- GOP by and large denies climate change
CALL assertOpinion(1, 94, 19);    -- Do not vote for a Republican until major reforms
CALL assertOpinion(1, 96, 19);    -- Trump's singular concern is himself
CALL assertOpinion(1, 97, 19);    -- Trump too stupid to trust with decision making
CALL assertOpinion(1, 104, 19);   -- Vote for Democrats
CALL assertOpinion(-1, 120, 19);  -- Trump puts America first (rejects)
CALL assertOpinion(1, 383, 19);   -- GOP mostly interested in concentrating its own power
CALL assertOpinion(1, 384, 19);   -- GOP acts with ruthlessness
CALL assertOpinion(1, 386, 19);   -- GOP should never be trusted
CALL assertOpinion(1, 387, 19);   -- GOP has little concern for common welfare
CALL assertOpinion(1, 457, 19);   -- GOP agenda upholds white supremacy
CALL assertOpinion(1, 864, 19);   -- GOP is beholden to fossil fuel special interests
CALL assertOpinion(1, 866, 19);   -- GOP is beholden to moneyed elites resistant to change

-- === WORKERS RIGHTS (HARDCODED) ===
CALL assertOpinion(1, 494, 19);   -- Workers should unionize
CALL assertOpinion(1, 495, 19);   -- Collective bargaining helps workers win greater pay and benefits
CALL assertOpinion(1, 496, 19);   -- Biden should endorse Amazon workers' drive to unionize
CALL assertOpinion(1, 1200, 19);  -- Workers deserve some measure of leverage against management
CALL assertOpinion(1, 1201, 19);  -- A solitary worker is easily exploited by their employer

-- === CLIMATE CHANGE ===
CALL assertOpinion(1, 123, 19);   -- We must act on climate change quickly and forcefully
CALL assertOpinion(1, 321, 19);   -- Human influenced climate change is observable fact
CALL assertOpinion(1, 414, 19);   -- Ramp up renewable energy as soon as possible
CALL assertOpinion(1, 476, 19);   -- Fossil fuels need to be left in ground
CALL assertOpinion(1, 863, 19);   -- Limiting climate change requires collective action
CALL assertOpinion(-1, 230, 19);  -- Climate change is a hoax (rejects)
CALL assertOpinion(-1, 1275, 19); -- Climate has always been changing (rejects as deflection)

-- === HEALTHCARE REFORM ===
CALL assertOpinion(1, 894, 19);   -- Government should optimize healthcare system
CALL assertOpinion(1, 895, 19);   -- US must reform healthcare system
CALL assertOpinion(1, 896, 19);   -- US healthcare system has terrible health outcomes
CALL assertOpinion(1, 897, 19);   -- US healthcare system is most expensive in world
CALL assertOpinion(1, 898, 19);   -- US healthcare system is inequitable
CALL assertOpinion(1, 958, 19);   -- Basic healthcare is a fundamental human right
CALL assertOpinion(1, 909, 19);   -- Relying on private employers for health insurance is outdated model
CALL assertOpinion(-1, 910, 19);  -- Government control of healthcare creates bureaucratic inefficiency (rejects)

-- === POLICING (Reform YES, supports accountability) ===
CALL assertOpinion(1, 145, 19);   -- Policing in America must be reformed
CALL assertOpinion(1, 148, 19);   -- Police should use de-escalation techniques
CALL assertOpinion(1, 151, 19);   -- Police unions too powerful and uphold racist structures
CALL assertOpinion(1, 153, 19);   -- Police should exhaust other options before shooting
CALL assertOpinion(1, 154, 19);   -- Police officers have duty to intervene if fellow officer risks harm
CALL assertOpinion(1, 155, 19);   -- Police procedures and policies are effectively racist too often
CALL assertOpinion(1, 217, 19);   -- Police not held accountable to a just degree
CALL assertOpinion(1, 219, 19);   -- Police are granted qualified immunity
CALL assertOpinion(1, 539, 19);   -- Qualified immunity unjustly shields police from accountability
CALL assertOpinion(-1, 561, 19);  -- Back the blue uncritically (rejects)

-- === WEALTH INEQUALITY ===
CALL assertOpinion(1, 110, 19);   -- Degree of wealth inequality is beyond acceptable
CALL assertOpinion(1, 137, 19);   -- Agreed upon ideal of wealth distribution far less weighted to few
CALL assertOpinion(1, 745, 19);   -- Wealthy should take greater proportion of tax burden
CALL assertOpinion(-1, 193, 19);  -- No such thing as too much wealth concentration (rejects)

-- === FILIBUSTER / VOTING REFORM ===
CALL assertOpinion(1, 434, 19);   -- 60-vote filibuster should be abolished in US Senate
CALL assertOpinion(1, 441, 19);   -- Each additional veto point makes govt less responsive to public will
CALL assertOpinion(1, 435, 19);   -- US Senate is not representative of the people it has power over
CALL assertOpinion(1, 456, 19);   -- The filibuster is racist
CALL assertOpinion(1, 469, 19);   -- Washington DC should be added as a state
CALL assertOpinion(1, 470, 19);   -- We should support statehood for Washington DC
CALL assertOpinion(1, 696, 19);   -- We should support ranked choice voting
CALL assertOpinion(1, 698, 19);   -- Ranked-choice voting eliminates wasted votes

-- === FREE SPEECH (with limits) ===
CALL assertOpinion(1, 422, 19);   -- Free speech gives right to express up to point of direct harm
CALL assertOpinion(1, 597, 19);   -- You shouldn't scream FIRE in crowded theater without consequences

-- === CANCEL CULTURE (nuanced — some concerns) ===
CALL assertOpinion(1, 756, 19);   -- Much criticism of cancel culture is bad faith attempt to work refs
CALL assertOpinion(-1, 288, 19);  -- Cancel culture must be resisted (too broad — rejects)

-- === RACIAL JUSTICE ===
CALL assertOpinion(1, 103, 19);   -- Black people convicted at grossly disproportionate rate
CALL assertOpinion(1, 105, 19);   -- Police kill black people with impunity
CALL assertOpinion(1, 169, 19);   -- Non-white males statistically paid less per dollar
CALL assertOpinion(1, 175, 19);   -- Inherent racial bias has far-reaching effects
CALL assertOpinion(1, 221, 19);   -- Power structures maintaining white supremacy hostile to Black people
CALL assertOpinion(-1, 101, 19);  -- Racism is made up (rejects)
CALL assertOpinion(1, 1005, 19);  -- Scope and degree of racism in US is largely understated

-- === BLM (supports reform, not abolition) ===
CALL assertOpinion(1, 546, 19);   -- BLM activists deserve support
CALL assertOpinion(1, 1202, 19);  -- BLM protests have been peaceful
CALL assertOpinion(1, 1313, 19);  -- BLM is simply about Black Americans not living in fear
CALL assertOpinion(-1, 349, 19);  -- BLM movement is racist (rejects)
CALL assertOpinion(-1, 547, 19);  -- BLM is violent (rejects)

-- === ENDORSEMENTS: SANDRA SULLIVAN (profileID=19) ===

-- Cluster 1: Democracy and rule of law are existential
-- Target: 346 (impeach and convict Donald Trump)
-- Because: 347 (insurrectionists must not hold office) 55%, 389 (Dems must enforce norms) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (346, 19, 'Because', 347, 55.0, 1),
       (346, 19, 'Because', 389, 45.0, 1);

-- Target: 346 Therefore: 355 (voting rights must be expanded) 55%, 640 (Congress must pass HR1) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (346, 19, 'Therefore', 355, 55.0, 1),
       (346, 19, 'Therefore', 640, 45.0, 1);

-- Cluster 2: Workers deserve legal protection
-- Target: 494 (workers should unionize)
-- Because: 1200 (workers deserve leverage) 50%, 1201 (solitary worker easily exploited) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 19, 'Because', 1200, 50.0, 1),
       (494, 19, 'Because', 1201, 50.0, 1);

-- Target: 494 Therefore: 495 (collective bargaining wins better conditions) 60%, 496 (Biden should endorse Amazon) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (494, 19, 'Therefore', 495, 60.0, 1),
       (494, 19, 'Therefore', 496, 40.0, 1);

-- Cluster 3: Climate action
-- Target: 123 (must act on climate quickly)
-- Because: 321 (human climate change observable fact) 45%, 863 (limiting requires collective action) 35%, 864 (GOP beholden to fossil fuel) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 19, 'Because', 321, 45.0, 1),
       (123, 19, 'Because', 863, 35.0, 1),
       (123, 19, 'Because', 864, 20.0, 1);

-- Target: 123 Therefore: 414 (ramp up renewable energy) 55%, 476 (fossil fuels in ground) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 19, 'Therefore', 414, 55.0, 1),
       (123, 19, 'Therefore', 476, 45.0, 1);

-- Cluster 4: Healthcare reform
-- Target: 895 (US must reform healthcare)
-- Because: 896 (terrible health outcomes) 40%, 897 (most expensive) 35%, 898 (inequitable) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (895, 19, 'Because', 896, 40.0, 1),
       (895, 19, 'Because', 897, 35.0, 1),
       (895, 19, 'Because', 898, 25.0, 1);

-- Target: 895 Therefore: 909 (private employer insurance outdated) 55%, 958 (healthcare as human right) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (895, 19, 'Therefore', 909, 55.0, 1),
       (895, 19, 'Therefore', 958, 45.0, 1);

-- Cluster 5: Police accountability
-- Target: 217 (police not held accountable)
-- Because: 219 (qualified immunity) 50%, 539 (immunity unjust) 30%, 155 (procedures effectively racist) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 19, 'Because', 219, 50.0, 1),
       (217, 19, 'Because', 539, 30.0, 1),
       (217, 19, 'Because', 155, 20.0, 1);

-- Target: 217 Therefore: 145 (policing must be reformed) 55%, 148 (de-escalation required) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (217, 19, 'Therefore', 145, 55.0, 1),
       (217, 19, 'Therefore', 148, 45.0, 1);

-- Cluster 6: Senate reform / filibuster
-- Target: 434 (60-vote filibuster should be abolished)
-- Because: 435 (Senate not representative) 45%, 441 (each veto point reduces responsiveness) 35%, 456 (filibuster is racist) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (434, 19, 'Because', 435, 45.0, 1),
       (434, 19, 'Because', 441, 35.0, 1),
       (434, 19, 'Because', 456, 20.0, 1);

-- Target: 434 Therefore: 469 (DC statehood) 50%, 696 (ranked choice) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (434, 19, 'Therefore', 469, 50.0, 1),
       (434, 19, 'Therefore', 696, 50.0, 1);

-- Cluster 7: GOP categorical rejection
-- Target: 90 (GOP agenda is bad for America)
-- Because: 91 (concentrates wealth) 35%, 93 (denies climate) 35%, 457 (upholds white supremacy) 30%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (90, 19, 'Because', 91, 35.0, 1),
       (90, 19, 'Because', 93, 35.0, 1),
       (90, 19, 'Because', 457, 30.0, 1);

-- Target: 90 Therefore: 94 (do not vote Republican) 55%, 389 (Dems must enforce norms) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (90, 19, 'Therefore', 94, 55.0, 1),
       (90, 19, 'Therefore', 389, 45.0, 1);


-- ============================================================
-- PROFILE 20: THOMAS TURNER
-- 35yo White SaaS sales exec, suburban Denver CO
-- Libertarian-leaning, voted Gary Johnson then Trump.
-- Fiscally conservative, socially liberal — genuine live-and-let-live.
-- Anti-government regardless of party. Colorado environment worth protecting.
-- ideology_score: +2 (libertarian, socially liberal, fiscally conservative)
-- ============================================================

-- === LIVE-AND-LET-LIVE / PERSONAL FREEDOM (HARDCODED) ===
CALL assertOpinion(1, 144, 20);   -- Loving who you want causes no justifiable harm
CALL assertOpinion(1, 543, 20);   -- We should accept people for who they are
CALL assertOpinion(1, 544, 20);   -- Trans men should be accepted as men and trans women as women
CALL assertOpinion(-1, 142, 20);  -- There are only two genders (rejects)
CALL assertOpinion(-1, 143, 20);  -- Homosexuality is a perversion of nature (rejects)
CALL assertOpinion(1, 459, 20);   -- We should have right to decide for ourselves what tools are safe
CALL assertOpinion(1, 460, 20);   -- People shouldn't be restricted from responsibly owning guns
CALL assertOpinion(1, 226, 20);   -- Freedom should never be infringed
CALL assertOpinion(1, 596, 20);   -- Our right to free speech is absolute

-- === FISCAL CONSERVATISM (HARDCODED) ===
CALL assertOpinion(-1, 606, 20);  -- Government should give direct cash payments to poor (rejects)
CALL assertOpinion(-1, 609, 20);  -- US government should implement universal basic income (rejects)
CALL assertOpinion(-1, 667, 20);  -- American Rescue Plan poised to fight poverty (rejects)
CALL assertOpinion(-1, 341, 20);  -- COVID relief package should be more generous (rejects)
CALL assertOpinion(1, 134, 20);   -- We shouldn't punish success
CALL assertOpinion(1, 135, 20);   -- Not allowing people to keep what they earned is criminal
CALL assertOpinion(1, 136, 20);   -- Capitalism is the best system we got
CALL assertOpinion(1, 400, 20);   -- Government should stay out of the way
CALL assertOpinion(1, 401, 20);   -- Free markets do better than any government ever could
CALL assertOpinion(1, 197, 20);   -- Success should be rewarded with greater share of spoils
CALL assertOpinion(-1, 110, 20);  -- Degree of wealth inequality is beyond acceptable (rejects framing)

-- === ANTI-GOVERNMENT REGARDLESS OF PARTY ===
CALL assertOpinion(1, 404, 20);   -- Constant vigilance needed to eliminate unnecessary regulations
CALL assertOpinion(1, 407, 20);   -- We must fight big government
CALL assertOpinion(1, 405, 20);   -- Unchecked government would grow and assume greater control
CALL assertOpinion(-1, 80, 20);   -- Trump 2024 (skeptical of both parties)
CALL assertOpinion(-1, 574, 20);  -- The American Democratic Party is terrible (rejects excesses)
CALL assertOpinion(1, 322, 20);   -- We should never put our full faith in government
CALL assertOpinion(1, 323, 20);   -- Government is a human and imperfect endeavor
CALL assertOpinion(-1, 104, 20);  -- Vote for Democrats (rejects partisan loyalty)

-- === COLORADO ENVIRONMENT (EXCEPTION TO ANTI-REGULATION) ===
CALL assertOpinion(1, 123, 20);   -- We must act on climate change quickly (accepts for environment)
CALL assertOpinion(1, 321, 20);   -- Human influenced climate change is observable fact
CALL assertOpinion(1, 414, 20);   -- Ramp up renewable energy as soon as possible
CALL assertOpinion(1, 863, 20);   -- Limiting climate change requires collective action
CALL assertOpinion(-1, 230, 20);  -- Climate change is a hoax (rejects)

-- === LGBTQ (live-and-let-live angle, not progressive) ===
CALL assertOpinion(1, 278, 20);   -- No individual should suffer harassment based on sexual orientation
CALL assertOpinion(1, 315, 20);   -- A person does not choose their gender
CALL assertOpinion(1, 790, 20);   -- Trans girls should not be forced to play boys sports
CALL assertOpinion(-1, 793, 20);  -- Trans girls should be forced to play among boys (rejects)

-- === ANTI-UNION (rejects govt mandated labor rules) ===
CALL assertOpinion(-1, 494, 20);  -- Workers should unionize (Thomas skeptical of union power)
CALL assertOpinion(1, 727, 20);   -- Unions often employ inflexible rules impacting enterprise's ability to adapt

-- === CANCEL CULTURE (rejects) ===
CALL assertOpinion(1, 288, 20);   -- Cancel Culture must be resisted
CALL assertOpinion(1, 297, 20);   -- Cancel culture is effort to promote conformist viewpoint

-- === HOUSING / DENSITY (Colorado-specific) ===
CALL assertOpinion(1, 736, 20);   -- Increasing housing density is effective way of decreasing cost
CALL assertOpinion(1, 739, 20);   -- More housing stock has overall depressing effect on housing prices
CALL assertOpinion(1, 740, 20);   -- Building luxury housing makes other units more affordable

-- === SOCIAL MEDIA CRITIQUE ===
CALL assertOpinion(1, 367, 20);   -- Social media is bad
CALL assertOpinion(1, 368, 20);   -- Pursuit of greater engagement discourages resolution
CALL assertOpinion(1, 369, 20);   -- Lack of gatekeepers makes dialogue chaotic

-- === RANKED CHOICE ===
CALL assertOpinion(1, 696, 20);   -- We should support ranked choice voting
CALL assertOpinion(1, 698, 20);   -- Ranked-choice voting eliminates wasted votes
CALL assertOpinion(1, 701, 20);   -- Ranked-choice voting reduces negativity in campaigns
CALL assertOpinion(1, 702, 20);   -- Ranked-choice voting can eliminate need for primaries

-- === 2ND AMENDMENT (live-and-let-live angle) ===
CALL assertOpinion(1, 326, 20);   -- Spirit of 2A is to preserve right to protect ourselves
CALL assertOpinion(1, 140, 20);   -- 2A grants right to own firearms I deem necessary
CALL assertOpinion(1, 328, 20);   -- We should defend the second amendment
CALL assertOpinion(-1, 334, 20);  -- Police should resist militarization (agrees but not from a police angle)
CALL assertOpinion(-1, 335, 20);  -- Militarization of police presents moral hazard (skeptical of govt excess — accepts)

-- === FREE SPEECH ===
CALL assertOpinion(1, 422, 20);   -- Free speech up to point of direct harm
CALL assertOpinion(1, 420, 20);   -- Free speech does not give right to manipulate people

-- === POLICING (rejects both defund AND militarization) ===
CALL assertOpinion(-1, 107, 20);  -- Defund police departments (rejects)
CALL assertOpinion(-1, 560, 20);  -- Police should be abolished (rejects)
CALL assertOpinion(-1, 561, 20);  -- Back the blue uncritically (rejects — too partisan)
CALL assertOpinion(1, 334, 20);   -- Police should resist militarization
CALL assertOpinion(1, 335, 20);   -- Militarization of police presents moral hazard

-- === ENDORSEMENTS: THOMAS TURNER (profileID=20) ===

-- Cluster 1: Personal freedom — live and let live
-- Target: 144 (loving who you want causes no justifiable harm)
-- Because: 226 (freedom should never be infringed) 55%, 459 (right to decide for ourselves) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (144, 20, 'Because', 226, 55.0, 1),
       (144, 20, 'Because', 459, 45.0, 1);

-- Target: 144 Therefore: 543 (accept people for who they are) 55%, 544 (trans men = men) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (144, 20, 'Therefore', 543, 55.0, 1),
       (144, 20, 'Therefore', 544, 45.0, 1);

-- Cluster 2: Fiscal conservatism
-- Target: 136 (capitalism is the best system we got)
-- Because: 134 (shouldn't punish success) 45%, 401 (free markets better than govt) 35%, 197 (success should be rewarded) 20%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (136, 20, 'Because', 134, 45.0, 1),
       (136, 20, 'Because', 401, 35.0, 1),
       (136, 20, 'Because', 197, 20.0, 1);

-- Target: 136 Therefore: 400 (government should stay out of the way) 55%, 404 (eliminate unnecessary regulations) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (136, 20, 'Therefore', 400, 55.0, 1),
       (136, 20, 'Therefore', 404, 45.0, 1);

-- Cluster 3: Colorado environment — climate exception
-- Target: 123 (must act on climate)
-- Because: 321 (human climate change is observable fact) 55%, 863 (limiting requires collective action) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 20, 'Because', 321, 55.0, 1),
       (123, 20, 'Because', 863, 45.0, 1);

-- Target: 123 Therefore: 414 (ramp up renewables) 60%, 530 (reduce barriers to innovation) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (123, 20, 'Therefore', 414, 60.0, 1),
       (123, 20, 'Therefore', 530, 40.0, 1);

-- Cluster 4: Housing density
-- Target: 736 (increasing density decreases cost)
-- Because: 739 (more housing stock depresses prices) 55%, 740 (luxury housing makes others affordable) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (736, 20, 'Because', 739, 55.0, 1),
       (736, 20, 'Because', 740, 45.0, 1);

-- Cluster 5: Ranked choice voting
-- Target: 696 (support ranked choice voting)
-- Because: 698 (eliminates wasted votes) 40%, 701 (reduces negativity) 35%, 702 (eliminate primaries) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (696, 20, 'Because', 698, 40.0, 1),
       (696, 20, 'Because', 701, 35.0, 1),
       (696, 20, 'Because', 702, 25.0, 1);

-- Cluster 6: Anti-government broadly
-- Target: 400 (government should stay out of the way)
-- Because: 322 (never put full faith in government) 40%, 405 (unchecked govt grows) 35%, 323 (government is imperfect) 25%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 20, 'Because', 322, 40.0, 1),
       (400, 20, 'Because', 405, 35.0, 1),
       (400, 20, 'Because', 323, 25.0, 1);

-- Target: 400 Therefore: 404 (eliminate unnecessary regulations) 50%, 407 (fight big government) 50%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (400, 20, 'Therefore', 404, 50.0, 1),
       (400, 20, 'Therefore', 407, 50.0, 1);

-- Cluster 7: 2A — personal liberty angle
-- Target: 140 (2A grants right to own firearms I deem necessary)
-- Because: 326 (spirit is self-protection) 55%, 459 (right to decide for ourselves) 45%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (140, 20, 'Because', 326, 55.0, 1),
       (140, 20, 'Because', 459, 45.0, 1);

-- Target: 140 Therefore: 328 (defend second amendment) 60%, 460 (shouldn't restrict responsible owners) 40%
INSERT IGNORE INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)
VALUES (140, 20, 'Therefore', 328, 60.0, 1),
       (140, 20, 'Therefore', 460, 40.0, 1);
