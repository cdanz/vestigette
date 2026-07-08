-- =============================================================================
-- Alfred Anderson (profileID=1) — Arguments 1–50 Population
-- Generated: 2026-05-24
-- =============================================================================
-- Persona: Age 67, retired White steelworker, Zanesville OH, widower.
-- Ideology score 7/10 conservative. High trust: VFW, Farm Bureau, Fox News,
-- police, local churches. Low trust: federal government, universities, MSM,
-- corporations that outsourced jobs. Plain-spoken. Hates being lectured.
-- Reasoning style: experiential and concrete, not data-driven.
--
-- GMO context (args 1–47):
--   Alfred is pro-farmer, anti-regulation, anti-ban, and pragmatic.
--   He accepts the safety of GMOs (no danger found), distrusts alarmism,
--   but has genuine sympathy for farmers against corporate control
--   (termination seeds anger him). He sees prohibition as futile.
--
-- WHAT THIS SCRIPT DOES:
--   1. Deletes Alfred's bogus placeholder endorsements for args 1–50
--   2. Corrects 21 OPINION records to match Alfred's actual character
--   3. Adds Alfred's voice to accepted argument phrasings
--   4. Updates existing explications to sources Alfred would actually use
--   5. Adds new explications for additional accepted arguments
--   6. Inserts logical Because/Therefore endorsements for accepted args
--   7. Inserts Rebuttal endorsements for rejected args
--   8. Fixes PHRASE_ENDORSE active flags to match corrected opinions
--
-- FINAL ACCEPT/REJECT BREAKDOWN (args 1–50):
--   ACCEPTED (27): 1,2,3,5,6,7,8,9,10,11,16,17,18,19,20,25,28,29,30,31,
--                  36,37,40,43,45,46,47
--   REJECTED (21): 4,12,13,14,15,21,22,23,24,26,27,32,33,34,35,38,39,41,
--                  42,44,50
--   SKIPPED  (2):  48,49 (test arguments — no changes needed)
-- =============================================================================

USE vestigette;

-- =============================================================================
-- SECTION 1: CLEAN UP BOGUS PLACEHOLDER ENDORSEMENTS
-- The existing endorsement data for args 1–50 was auto-generated with no
-- logical basis. Wipe it and start fresh.
-- =============================================================================

DELETE FROM ENDORSEMENT WHERE profileID = 1 AND targArgID BETWEEN 1 AND 50;


-- =============================================================================
-- SECTION 2: OPINION CORRECTIONS
-- assertOpinion(op, argID, profileID): op=1 accept, op=-1 reject
-- Only corrects records that diverge from Alfred's actual character.
-- =============================================================================

-- --- CHANGE ACCEPT → REJECT ---
-- These were marked accepted in old test data but Alfred would reject them.

CALL assertOpinion(-1, 4, 1);   -- "GMO should receive more testing" — anti-regulation stance
CALL assertOpinion(-1, 12, 1);  -- "Sales of GMOs require additional regulations" — anti-regulation
CALL assertOpinion(-1, 13, 1);  -- "GMOs exhibit significant enough danger to be banned" — anti-ban + anti-alarmism
CALL assertOpinion(-1, 14, 1);  -- "GMO's contain toxins" — fearmongering Alfred dismisses
CALL assertOpinion(-1, 15, 1);  -- "You shouldn't eat GMOs because they are bad for you" — nanny state
CALL assertOpinion(-1, 21, 1);  -- "GMO technology can have terrible side-effects" — alarmism
CALL assertOpinion(-1, 22, 1);  -- "GMOs greatly increase chances of 'super weeds'" — environmental alarmism
CALL assertOpinion(-1, 23, 1);  -- "Shouldn't buy GMO — environmental harm" — environmental alarmism
CALL assertOpinion(-1, 50, 1);  -- "Elizabeth Warren should be President" — obviously

-- --- CHANGE REJECT → ACCEPT ---
-- These were marked rejected but Alfred actually agrees with them.

CALL assertOpinion(1, 25, 1);   -- "GMOs can be used to create termination seeds" — factual; Alfred accepts
CALL assertOpinion(1, 28, 1);   -- "Termination seeds take control from farmers" — Alfred sympathizes with farmers
CALL assertOpinion(1, 29, 1);   -- "Termination seeds control farmers" — same sympathy
CALL assertOpinion(1, 30, 1);   -- "Prohibition in some cases is operationally impossible" — Alfred is a pragmatist
CALL assertOpinion(1, 31, 1);   -- "Prohibition never works" — Alfred absolutely believes this
CALL assertOpinion(1, 36, 1);   -- "Tech should never be banned when it can be regulated instead" — anti-ban
CALL assertOpinion(1, 37, 1);   -- "A single application shouldn't impugn an entire field" — fair-minded
CALL assertOpinion(1, 40, 1);   -- "No government support should be given to GMO research" — anti-govt spending
CALL assertOpinion(1, 43, 1);   -- "GMOs are the best known tool for time-sensitive food crisis" — pragmatic
CALL assertOpinion(1, 45, 1);   -- "Allow GMOs for emergency response" — accepts minimum
CALL assertOpinion(1, 46, 1);   -- "Emergency-only deployment freezes innovation" — anti-restriction
CALL assertOpinion(1, 47, 1);   -- "Limit tech only if harms outweigh benefits" — common-sense standard


-- =============================================================================
-- SECTION 3: PHRASINGS
-- Alfred's voice: plain, direct, minimal. Drops subjects ("Can't protect you").
-- Uses "That's just the truth" and "That's just how it is."
-- Never uses jargon. Hates being lectured.
-- Existing phrasings for args 10 and 19 are kept (already good).
-- =============================================================================

-- Arg 1: Government/society cannot protect us from everything.
CALL newPutForth(1, 1, 'Can''t protect you from everything. That''s just the truth of it.');

-- Arg 2: Our government's responsibility extends only to verifying plausible avenues of harm are assessed.
CALL newPutForth(2, 1, 'Government''s job stops at making sure the real risks got looked at. That''s it.');

-- Arg 3: GMOs are held under greater experimental scrutiny than any other food.
CALL newPutForth(3, 1, 'GMOs go through more testing than just about anything else on your grocery shelf.');

-- Arg 5: All plausible hypothesis of GMOs posing a danger have been shown wrong.
CALL newPutForth(5, 1, 'They haven''t found a real danger yet. Not one. The science came back clean.');

-- Arg 6: Novel Technology requires special care to ensure safety.
CALL newPutForth(6, 1, 'New technology, you take your time with it. That''s just common sense.');

-- Arg 7: When technology is understood it can be incorporated into life.
CALL newPutForth(7, 1, 'Once people know how something works, they put it to use. Simple as that.');

-- Arg 8: Testing what we only know now won't protect us from unknowns.
CALL newPutForth(8, 1, 'Can''t test for what you don''t know about. Never could.');

-- Arg 9: Sales of GMO should be unregulated.
CALL newPutForth(9, 1, 'Let farmers and grocers decide. Government''s got no business getting in the way.');

-- Arg 10: kept — "Nothing can be fully incorporated into daily life so long as it is limited."

-- Arg 11: There must be a line drawn where we allow some risk from unknowns.
CALL newPutForth(11, 1, 'At some point you''ve got to let things move forward. Accept there''ll be unknowns.');

-- Arg 16: Research on GMO is expensive.
CALL newPutForth(16, 1, 'GMO research doesn''t come cheap. Somebody''s got to pay for it.');

-- Arg 17: Research into GMOs is limited to a select few with significant funds.
CALL newPutForth(17, 1, 'If research costs that much, only the big outfits can play. That''s just how it is.');

-- Arg 18: Corporations demand sufficient return on their investment.
CALL newPutForth(18, 1, 'Corporations put up the money, they need to see it come back. That''s business.');

-- Arg 19: kept — "GMOs are used to protect intellectual property."

-- Arg 20: Toxins is a term applied too broadly to have clear meaning.
CALL newPutForth(20, 1, 'Everyone throws the word ''toxin'' around like it means something. Half the time it doesn''t.');

-- Arg 25: GMOs can be used to create 'termination seeds'.
CALL newPutForth(25, 1, 'You can engineer GMO seeds so they won''t reproduce. That''s just a fact.');

-- Arg 28: 'Termination seeds' take control from farmers.
CALL newPutForth(28, 1, 'When seeds can''t reproduce, farmers lose their independence. They''re beholden to whoever sold ''em.');

-- Arg 29: 'Termination seeds' control farmers.
CALL newPutForth(29, 1, 'Terminator seeds mean you''re back to the seed company every single year. They''ve got you.');

-- Arg 30: Prohibition in some cases is operationally impossible.
CALL newPutForth(30, 1, 'Some things can''t be policed no matter what the law says.');

-- Arg 31: Prohibition never works.
CALL newPutForth(31, 1, 'Never worked once. Not with booze, not with drugs. Why would this be any different?');

-- Arg 36: Technology should never be banned when it can be regulated instead.
CALL newPutForth(36, 1, 'Before you ban something, figure out if you can regulate it instead. Banning''s the lazy answer.');

-- Arg 37: A single application shouldn't impugn an entire field of technology.
CALL newPutForth(37, 1, 'One bad actor doesn''t mean you shut down the whole industry. That''s not how it works.');

-- Arg 40: No government support should be given to GMO research.
CALL newPutForth(40, 1, 'Government shouldn''t be picking winners. Let the companies fund their own research.');

-- Arg 43: GMOs are the best known tool for responding to time sensitive crisis in the food supply.
CALL newPutForth(43, 1, 'When there''s a food crisis and you need a fast fix, GMOs are the best tool there is. Period.');

-- Arg 45: Allow GMOs for emergency response.
CALL newPutForth(45, 1, 'At least use them when there''s a real emergency. That much makes sense.');

-- Arg 46: Allowing new innovations to only be deployed in emergencies would freeze innovation.
CALL newPutForth(46, 1, 'Lock innovations behind emergency-only rules and you kill the drive to develop them.');

-- Arg 47: The standard is that any new technology must be limited if its harms outweigh its benefits.
CALL newPutForth(47, 1, 'Simple standard: if it does more harm than good, limit it. But show me the harm first.');


-- =============================================================================
-- SECTION 4: EXPLICATIONS
-- Alfred trusts: American Farm Bureau, Heartland Institute, National Review,
-- Reason Magazine, AGWeb/Farm Journal, WSJ, Heritage Foundation.
-- Alfred distrusts: NYT, Slate, Sci American, advocacy sites.
-- =============================================================================

-- Update existing explications (IDs 1–10) to sources Alfred would actually use.
-- Note: explicationID=4 is for arg 4 which Alfred now rejects — it will be
-- deactivated automatically by assertOpinion above. Update it anyway for
-- correctness if opinion ever changes.

UPDATE EXPLICATION SET
    hyperlink  = 'https://www.fb.org/issues/innovation-technology/biotechnology',
    publisher  = 'American Farm Bureau Federation',
    title      = 'Biotechnology and GMOs: A Farmer''s Perspective'
WHERE explicationID = 1;  -- arg 1

UPDATE EXPLICATION SET
    hyperlink  = 'https://heartland.org/topics/government/',
    publisher  = 'Heartland Institute',
    title      = 'The Proper Role of Government in a Free Society'
WHERE explicationID = 2;  -- arg 2

UPDATE EXPLICATION SET
    hyperlink  = 'https://www.fb.org/issues/innovation-technology/biotechnology',
    publisher  = 'American Farm Bureau Federation',
    title      = 'GMO Safety and Testing: What Farmers Know'
WHERE explicationID = 3;  -- arg 3

UPDATE EXPLICATION SET
    hyperlink  = 'https://www.heritage.org/government-regulation/commentary/gmo-regulation-congress',
    publisher  = 'Heritage Foundation',
    title      = 'GMO Regulation: Less Is More'
WHERE explicationID = 4;  -- arg 4 (Alfred rejects, but update source regardless)

UPDATE EXPLICATION SET
    hyperlink  = 'https://heartland.org/publications-resources/publications/are-gmos-safe/',
    publisher  = 'Heartland Institute',
    title      = 'Are GMOs Safe? What the Science Actually Says'
WHERE explicationID = 5;  -- arg 5

UPDATE EXPLICATION SET
    hyperlink  = 'https://www.nationalreview.com/2018/08/food-technology-safety-record/',
    publisher  = 'National Review',
    title      = 'Our Food Technology Has a Strong Safety Record'
WHERE explicationID = 6;  -- arg 6

UPDATE EXPLICATION SET
    hyperlink  = 'https://agweb.com/markets/crops/gmos-a-farmers-view',
    publisher  = 'AGWeb — Farm Journal',
    title      = 'GMOs: A Farmer''s View'
WHERE explicationID = 7;  -- arg 7

-- explicationID = 8 (arg 8, AGWeek "Your food choices this Thanksgiving? GMOs help.")
-- This one is actually good for Alfred — keeping it as-is.

UPDATE EXPLICATION SET
    hyperlink  = 'https://reason.com/tag/food-freedom/',
    publisher  = 'Reason Magazine',
    title      = 'Food Freedom: The Case Against Government Intervention in Markets'
WHERE explicationID = 9;  -- arg 9

UPDATE EXPLICATION SET
    hyperlink  = 'https://heartland.org/topics/agriculture/',
    publisher  = 'Heartland Institute',
    title      = 'Agriculture and Innovation: Why Restrictions Hurt Farmers'
WHERE explicationID = 10; -- arg 10

-- New explications for additional accepted arguments
CALL newExplication(11, 1, 'https://reason.com/2018/09/12/risk-regulation-and-common-sense/');
CALL newExplication(17, 1, 'https://www.wsj.com/articles/corporate-investment-drives-agriculture-innovation');
CALL newExplication(18, 1, 'https://www.wsj.com/articles/return-on-investment-agriculture-biotech');
CALL newExplication(20, 1, 'https://reason.com/2019/03/14/the-word-toxin-is-meaningless/');
CALL newExplication(28, 1, 'https://agweb.com/article/terminator-seeds-farmer-independence');
CALL newExplication(31, 1, 'https://www.nationalreview.com/2020/01/drug-prohibition-failure-lessons-from-history/');
CALL newExplication(36, 1, 'https://reason.com/tag/regulation/');
CALL newExplication(43, 1, 'https://www.fb.org/issues/innovation-technology/biotechnology');
CALL newExplication(47, 1, 'https://www.heritage.org/government-regulation/commentary/simple-cost-benefit-test-regulation');


-- =============================================================================
-- SECTION 5: ENDORSEMENTS — ACCEPTED ARGUMENTS (Because / Therefore pairs)
--
-- For each logical support relationship "A supports B" (A is a reason for B):
--   Row 1 — from B's view:  (targArgID=B, 'Because',   supportingArgID=A)
--   Row 2 — from A's view:  (targArgID=A, 'Therefore', supportingArgID=B)
--
-- active=1 because these are accepted arguments.
-- Column order: targArgID, profileID, endorseType, supportingArgID,
--               weight, firstVisit, lastVisit, active
-- =============================================================================

-- ---- Arg 8 → Arg 1 (can't test unknowns SUPPORTS can't protect everything, w=80) ----
INSERT INTO ENDORSEMENT VALUES (1, 1, 'Because',    8,  80.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (8, 1, 'Therefore',  1,  80.00000, NOW(), NOW(), 1);

-- ---- Arg 11 → Arg 1 (must accept some risk SUPPORTS can't protect everything, w=60) ----
INSERT INTO ENDORSEMENT VALUES ( 1, 1, 'Because',    11, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (11, 1, 'Therefore',   1, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 1 → Arg 2 (can't protect everything SUPPORTS govt role limited, w=55) ----
INSERT INTO ENDORSEMENT VALUES ( 2, 1, 'Because',    1, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 1, 1, 'Therefore',  2, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 6 → Arg 2 (novel tech needs care SUPPORTS govt checks plausible harms, w=50) ----
INSERT INTO ENDORSEMENT VALUES ( 2, 1, 'Because',    6, 50.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 6, 1, 'Therefore',  2, 50.00000, NOW(), NOW(), 1);

-- ---- Arg 11 → Arg 2 (accept some risk SUPPORTS govt role limited, w=50) ----
INSERT INTO ENDORSEMENT VALUES ( 2, 1, 'Because',   11, 50.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (11, 1, 'Therefore',  2, 50.00000, NOW(), NOW(), 1);

-- ---- Arg 40 → Arg 2 (no govt support confirms govt role limited, w=50) ----
INSERT INTO ENDORSEMENT VALUES ( 2, 1, 'Because',   40, 50.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (40, 1, 'Therefore',  2, 50.00000, NOW(), NOW(), 1);

-- ---- Arg 16 → Arg 3 (expensive research = serious scrutiny SUPPORTS rigorous testing claim, w=45) ----
INSERT INTO ENDORSEMENT VALUES ( 3, 1, 'Because',   16, 45.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (16, 1, 'Therefore',  3, 45.00000, NOW(), NOW(), 1);

-- ---- Arg 3 → Arg 5 (rigorous scrutiny SUPPORTS danger hypotheses shown wrong, w=70) ----
INSERT INTO ENDORSEMENT VALUES ( 5, 1, 'Because',    3, 70.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 3, 1, 'Therefore',  5, 70.00000, NOW(), NOW(), 1);

-- ---- Arg 20 → Arg 5 (toxins = misnomer SUPPORTS danger shown wrong, w=55) ----
INSERT INTO ENDORSEMENT VALUES ( 5, 1, 'Because',   20, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (20, 1, 'Therefore',  5, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 3 → Arg 7 (rigorous scrutiny SUPPORTS tech can be incorporated, w=60) ----
INSERT INTO ENDORSEMENT VALUES ( 7, 1, 'Because',    3, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 3, 1, 'Therefore',  7, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 5 → Arg 7 (danger shown wrong SUPPORTS tech incorporated into life, w=65) ----
INSERT INTO ENDORSEMENT VALUES ( 7, 1, 'Because',    5, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 5, 1, 'Therefore',  7, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 9 → Arg 7 (unregulated access SUPPORTS incorporation into life, w=55) ----
INSERT INTO ENDORSEMENT VALUES ( 7, 1, 'Because',    9, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Therefore',  7, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 1 → Arg 9 (can't protect everything SUPPORTS unregulated sales, w=70) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',    1, 70.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 1, 1, 'Therefore',  9, 70.00000, NOW(), NOW(), 1);

-- ---- Arg 2 → Arg 9 (govt role limited SUPPORTS unregulated sales, w=75) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',    2, 75.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 2, 1, 'Therefore',  9, 75.00000, NOW(), NOW(), 1);

-- ---- Arg 3 → Arg 9 (rigorous scrutiny SUPPORTS unregulated sales, w=65) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',    3, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 3, 1, 'Therefore',  9, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 5 → Arg 9 (danger shown wrong SUPPORTS unregulated sales, w=80) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',    5, 80.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 5, 1, 'Therefore',  9, 80.00000, NOW(), NOW(), 1);

-- ---- Arg 7 → Arg 9 (when understood, incorporate → SUPPORTS unregulated, w=60) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',    7, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 7, 1, 'Therefore',  9, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 10 → Arg 9 (limited = never trusted SUPPORTS unregulated, w=60) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',   10, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (10, 1, 'Therefore',  9, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 20 → Arg 9 (no real toxins = no reason to restrict, w=60) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',   20, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (20, 1, 'Therefore',  9, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 37 → Arg 9 (single app shouldn't impugn field SUPPORTS unregulated, w=55) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',   37, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (37, 1, 'Therefore',  9, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 43 → Arg 9 (best tool for crisis needs unregulated access, w=55) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',   43, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (43, 1, 'Therefore',  9, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 46 → Arg 9 (emergency-only freezes innovation SUPPORTS unregulated, w=65) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',   46, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (46, 1, 'Therefore',  9, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 47 → Arg 9 (benefits > harms for GMOs → unregulated ok, w=55) ----
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Because',   47, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (47, 1, 'Therefore',  9, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 46 → Arg 10 (emergency-only limitation validates arg10's point, w=60) ----
INSERT INTO ENDORSEMENT VALUES (10, 1, 'Because',   46, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (46, 1, 'Therefore', 10, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 8 → Arg 11 (can't test unknowns SUPPORTS must accept some risk, w=65) ----
INSERT INTO ENDORSEMENT VALUES (11, 1, 'Because',    8, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 8, 1, 'Therefore', 11, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 1 → Arg 11 (can't protect everything SUPPORTS must accept some risk, w=65) ----
INSERT INTO ENDORSEMENT VALUES (11, 1, 'Because',    1, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 1, 1, 'Therefore', 11, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 16 → Arg 17 (research expensive SUPPORTS limited to few with funds, w=75) ----
INSERT INTO ENDORSEMENT VALUES (17, 1, 'Because',   16, 75.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (16, 1, 'Therefore', 17, 75.00000, NOW(), NOW(), 1);

-- ---- Arg 18 → Arg 16 (ROI motive explains why research is expensive, w=55) ----
INSERT INTO ENDORSEMENT VALUES (16, 1, 'Because',   18, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (18, 1, 'Therefore', 16, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 17 → Arg 18 (limited to few with funds SUPPORTS corporations need returns, w=65) ----
INSERT INTO ENDORSEMENT VALUES (18, 1, 'Because',   17, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (17, 1, 'Therefore', 18, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 18 → Arg 17 (ROI requirements concentrate research, w=65) ----
INSERT INTO ENDORSEMENT VALUES (17, 1, 'Because',   18, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (18, 1, 'Therefore', 17, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 18 → Arg 19 (corporations need returns SUPPORTS GMOs used to protect IP, w=80) ----
INSERT INTO ENDORSEMENT VALUES (19, 1, 'Because',   18, 80.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (18, 1, 'Therefore', 19, 80.00000, NOW(), NOW(), 1);

-- ---- Arg 17 → Arg 40 (market already leads research SUPPORTS no govt support, w=55) ----
INSERT INTO ENDORSEMENT VALUES (40, 1, 'Because',   17, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (17, 1, 'Therefore', 40, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 2 → Arg 40 (govt role limited SUPPORTS no govt support for research, w=60) ----
INSERT INTO ENDORSEMENT VALUES (40, 1, 'Because',    2, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 2, 1, 'Therefore', 40, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 19 → Arg 25 (IP protection motivation SUPPORTS termination seeds exist, w=75) ----
INSERT INTO ENDORSEMENT VALUES (25, 1, 'Because',   19, 75.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (19, 1, 'Therefore', 25, 75.00000, NOW(), NOW(), 1);

-- ---- Arg 25 → Arg 28 (termination seeds exist SUPPORTS takes control from farmers, w=80) ----
INSERT INTO ENDORSEMENT VALUES (28, 1, 'Because',   25, 80.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (25, 1, 'Therefore', 28, 80.00000, NOW(), NOW(), 1);

-- ---- Arg 19 → Arg 28 (IP protection logic SUPPORTS takes control from farmers, w=65) ----
INSERT INTO ENDORSEMENT VALUES (28, 1, 'Because',   19, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (19, 1, 'Therefore', 28, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 25 → Arg 29 (termination seeds exist SUPPORTS controls farmers, w=80) ----
INSERT INTO ENDORSEMENT VALUES (29, 1, 'Because',   25, 80.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (25, 1, 'Therefore', 29, 80.00000, NOW(), NOW(), 1);

-- ---- Arg 28 → Arg 29 (taking control from farmers IS controlling farmers, w=75) ----
INSERT INTO ENDORSEMENT VALUES (29, 1, 'Because',   28, 75.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (28, 1, 'Therefore', 29, 75.00000, NOW(), NOW(), 1);

-- ---- Arg 11 → Arg 36 (accept some risk SUPPORTS regulate not ban, w=60) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',   11, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (11, 1, 'Therefore', 36, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 5 → Arg 36 (danger shown wrong SUPPORTS regulate not ban, w=55) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',    5, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 5, 1, 'Therefore', 36, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 7 → Arg 36 (when understood SUPPORTS regulate not ban, w=65) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',    7, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 7, 1, 'Therefore', 36, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 20 → Arg 36 (no real toxins SUPPORTS no reason to ban, w=50) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',   20, 50.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (20, 1, 'Therefore', 36, 50.00000, NOW(), NOW(), 1);

-- ---- Arg 30 → Arg 36 (prohibition sometimes impossible SUPPORTS regulate not ban, w=65) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',   30, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (30, 1, 'Therefore', 36, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 31 → Arg 36 (prohibition never works SUPPORTS regulate not ban, w=70) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',   31, 70.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (31, 1, 'Therefore', 36, 70.00000, NOW(), NOW(), 1);

-- ---- Arg 37 → Arg 36 (single app shouldn't impugn SUPPORTS regulate not ban, w=60) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',   37, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (37, 1, 'Therefore', 36, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 46 → Arg 36 (emergency-only is too restrictive SUPPORTS regulate not ban, w=55) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',   46, 55.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (46, 1, 'Therefore', 36, 55.00000, NOW(), NOW(), 1);

-- ---- Arg 47 → Arg 36 (limit only if harms > benefits → for GMOs regulate not ban, w=65) ----
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Because',   47, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (47, 1, 'Therefore', 36, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 36 → Arg 37 (regulate not ban SUPPORTS single app shouldn't condemn field, w=60) ----
INSERT INTO ENDORSEMENT VALUES (37, 1, 'Because',   36, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (36, 1, 'Therefore', 37, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 31 → Arg 30 (prohibition never works SUPPORTS sometimes impossible, w=65) ----
INSERT INTO ENDORSEMENT VALUES (30, 1, 'Because',   31, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (31, 1, 'Therefore', 30, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 43 → Arg 45 (GMOs best tool for crisis SUPPORTS allow for emergency, w=65) ----
INSERT INTO ENDORSEMENT VALUES (45, 1, 'Because',   43, 65.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (43, 1, 'Therefore', 45, 65.00000, NOW(), NOW(), 1);

-- ---- Arg 45 → Arg 43 (emergency allowance confirms they're best tool, w=60) ----
INSERT INTO ENDORSEMENT VALUES (43, 1, 'Because',   45, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES (45, 1, 'Therefore', 43, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 9 → Arg 43 (unregulated access makes GMOs accessible for crisis, w=60) ----
INSERT INTO ENDORSEMENT VALUES (43, 1, 'Because',    9, 60.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 9, 1, 'Therefore', 43, 60.00000, NOW(), NOW(), 1);

-- ---- Arg 6 → Arg 47 (novel tech needs special care SUPPORTS limit if harms > benefits, w=70) ----
INSERT INTO ENDORSEMENT VALUES (47, 1, 'Because',    6, 70.00000, NOW(), NOW(), 1);
INSERT INTO ENDORSEMENT VALUES ( 6, 1, 'Therefore', 47, 70.00000, NOW(), NOW(), 1);


-- =============================================================================
-- SECTION 6: ENDORSEMENTS — REJECTED ARGUMENTS (Rebuttal)
--
-- Alfred as a REJECTOR points to accepted arguments that counter the rejected
-- argument. active=1 because these are for his rejected-argument views.
-- Column order: targArgID, profileID, 'Rebuttal', supportingArgID,
--               weight, firstVisit, lastVisit, active
-- =============================================================================

-- Arg 4 REJECTED: "GMO should receive more testing before sale"
-- Alfred: Already tested more than anything else. Can't test for unknowns anyway.
INSERT INTO ENDORSEMENT VALUES (4, 1, 'Rebuttal',  3, 70.00000, NOW(), NOW(), 1); -- already rigorous scrutiny
INSERT INTO ENDORSEMENT VALUES (4, 1, 'Rebuttal',  5, 65.00000, NOW(), NOW(), 1); -- danger hypotheses shown wrong
INSERT INTO ENDORSEMENT VALUES (4, 1, 'Rebuttal',  8, 50.00000, NOW(), NOW(), 1); -- can't test for unknowns anyway

-- Arg 12 REJECTED: "Sales of GMOs require additional regulations"
-- Alfred: Government's already done its job. More rules don't make things safer.
INSERT INTO ENDORSEMENT VALUES (12, 1, 'Rebuttal',  9, 80.00000, NOW(), NOW(), 1); -- should be unregulated
INSERT INTO ENDORSEMENT VALUES (12, 1, 'Rebuttal',  1, 70.00000, NOW(), NOW(), 1); -- can't protect everything
INSERT INTO ENDORSEMENT VALUES (12, 1, 'Rebuttal', 36, 60.00000, NOW(), NOW(), 1); -- regulate what's there, don't add more
INSERT INTO ENDORSEMENT VALUES (12, 1, 'Rebuttal',  3, 45.00000, NOW(), NOW(), 1); -- already heavily scrutinized

-- Arg 13 REJECTED: "GMOs exhibit a significant enough danger that they should be banned"
-- Alfred: No danger's been found. One bad apple doesn't ruin the whole barrel. Banning's lazy.
INSERT INTO ENDORSEMENT VALUES (13, 1, 'Rebuttal',  5, 90.00000, NOW(), NOW(), 1); -- all danger hypotheses shown wrong
INSERT INTO ENDORSEMENT VALUES (13, 1, 'Rebuttal', 37, 70.00000, NOW(), NOW(), 1); -- single app shouldn't impugn whole field
INSERT INTO ENDORSEMENT VALUES (13, 1, 'Rebuttal',  3, 65.00000, NOW(), NOW(), 1); -- rigorous scrutiny already applied
INSERT INTO ENDORSEMENT VALUES (13, 1, 'Rebuttal', 36, 60.00000, NOW(), NOW(), 1); -- regulate not ban
INSERT INTO ENDORSEMENT VALUES (13, 1, 'Rebuttal', 20, 55.00000, NOW(), NOW(), 1); -- toxins = misnomer

-- Arg 14 REJECTED: "GMO's contain toxins"
-- Alfred: Everybody says "toxins" like it means something. The science doesn't back it up.
INSERT INTO ENDORSEMENT VALUES (14, 1, 'Rebuttal', 20, 90.00000, NOW(), NOW(), 1); -- toxins term applied too broadly
INSERT INTO ENDORSEMENT VALUES (14, 1, 'Rebuttal',  5, 70.00000, NOW(), NOW(), 1); -- danger shown wrong
INSERT INTO ENDORSEMENT VALUES (14, 1, 'Rebuttal',  3, 55.00000, NOW(), NOW(), 1); -- rigorous scrutiny clears it

-- Arg 15 REJECTED: "You shouldn't eat GMOs because they are bad for you"
-- Alfred: Mind your own business. Science says they're fine. Personal choice.
INSERT INTO ENDORSEMENT VALUES (15, 1, 'Rebuttal',  5, 80.00000, NOW(), NOW(), 1); -- danger shown wrong
INSERT INTO ENDORSEMENT VALUES (15, 1, 'Rebuttal', 20, 70.00000, NOW(), NOW(), 1); -- toxins = misnomer
INSERT INTO ENDORSEMENT VALUES (15, 1, 'Rebuttal',  9, 50.00000, NOW(), NOW(), 1); -- personal choice, unregulated

-- Arg 21 REJECTED: "GMO technology can have terrible side-effects"
-- Alfred: Nobody's found any. This is just alarmism.
INSERT INTO ENDORSEMENT VALUES (21, 1, 'Rebuttal',  5, 80.00000, NOW(), NOW(), 1); -- danger hypotheses shown wrong
INSERT INTO ENDORSEMENT VALUES (21, 1, 'Rebuttal',  3, 70.00000, NOW(), NOW(), 1); -- held under greater scrutiny
INSERT INTO ENDORSEMENT VALUES (21, 1, 'Rebuttal', 37, 55.00000, NOW(), NOW(), 1); -- single issue doesn't indict whole tech

-- Arg 22 REJECTED: "GMOs greatly increase the chances of 'super weeds'"
-- Alfred: One possible problem doesn't mean you throw out the whole thing.
INSERT INTO ENDORSEMENT VALUES (22, 1, 'Rebuttal',  5, 75.00000, NOW(), NOW(), 1); -- danger shown wrong
INSERT INTO ENDORSEMENT VALUES (22, 1, 'Rebuttal', 37, 65.00000, NOW(), NOW(), 1); -- one issue doesn't condemn whole field
INSERT INTO ENDORSEMENT VALUES (22, 1, 'Rebuttal', 47, 55.00000, NOW(), NOW(), 1); -- harms don't clearly outweigh benefits

-- Arg 23 REJECTED: "You shouldn't buy GMO because increased market could bring about environmental harm"
-- Alfred: Same alarmism. Nobody's proven the harm. Personal choice.
INSERT INTO ENDORSEMENT VALUES (23, 1, 'Rebuttal',  5, 80.00000, NOW(), NOW(), 1); -- danger shown wrong
INSERT INTO ENDORSEMENT VALUES (23, 1, 'Rebuttal', 37, 65.00000, NOW(), NOW(), 1); -- one concern doesn't condemn whole field
INSERT INTO ENDORSEMENT VALUES (23, 1, 'Rebuttal',  9, 45.00000, NOW(), NOW(), 1); -- personal choice

-- Arg 24 REJECTED: "Danger for GMOs leading to species serving special interests at humanity's expense"
-- Alfred: Too academic, too vague. Sounds like university-professor talk.
INSERT INTO ENDORSEMENT VALUES (24, 1, 'Rebuttal', 37, 70.00000, NOW(), NOW(), 1); -- one app shouldn't impugn whole field
INSERT INTO ENDORSEMENT VALUES (24, 1, 'Rebuttal', 47, 65.00000, NOW(), NOW(), 1); -- evaluate actual harms vs benefits
INSERT INTO ENDORSEMENT VALUES (24, 1, 'Rebuttal',  5, 55.00000, NOW(), NOW(), 1); -- danger hypotheses shown wrong

-- Arg 26 REJECTED: "Single dangerous application justifies treaties to limit technology (like nuclear)"
-- Alfred: Prohibition never works. Regulate the bad actor, don't kill the whole field.
INSERT INTO ENDORSEMENT VALUES (26, 1, 'Rebuttal', 31, 80.00000, NOW(), NOW(), 1); -- prohibition never works
INSERT INTO ENDORSEMENT VALUES (26, 1, 'Rebuttal', 36, 70.00000, NOW(), NOW(), 1); -- regulate not ban
INSERT INTO ENDORSEMENT VALUES (26, 1, 'Rebuttal', 37, 65.00000, NOW(), NOW(), 1); -- single app shouldn't impugn whole field

-- Arg 27 REJECTED: "We can rely on our government to implement effective regulation"
-- Alfred: I'll tell you what — I've never seen that work. Government's got limits.
INSERT INTO ENDORSEMENT VALUES (27, 1, 'Rebuttal',  1, 85.00000, NOW(), NOW(), 1); -- can't protect us from everything
INSERT INTO ENDORSEMENT VALUES (27, 1, 'Rebuttal',  2, 70.00000, NOW(), NOW(), 1); -- govt responsibility is limited
INSERT INTO ENDORSEMENT VALUES (27, 1, 'Rebuttal', 31, 60.00000, NOW(), NOW(), 1); -- prohibition/govt enforcement never works

-- Arg 32 REJECTED: "You shouldn't eat GMOs"
-- Alfred: Who's telling me what to eat? They've found no danger.
INSERT INTO ENDORSEMENT VALUES (32, 1, 'Rebuttal',  5, 80.00000, NOW(), NOW(), 1); -- danger shown wrong
INSERT INTO ENDORSEMENT VALUES (32, 1, 'Rebuttal', 20, 70.00000, NOW(), NOW(), 1); -- toxins = misnomer
INSERT INTO ENDORSEMENT VALUES (32, 1, 'Rebuttal',  9, 60.00000, NOW(), NOW(), 1); -- personal choice, unregulated

-- Arg 33 REJECTED: "Termination seeds should be banned"
-- Alfred: I get it — termination seeds are wrong. But prohibition doesn't work.
-- Better to protect farmers through contracts and law, not a blanket ban.
INSERT INTO ENDORSEMENT VALUES (33, 1, 'Rebuttal', 36, 80.00000, NOW(), NOW(), 1); -- regulate not ban
INSERT INTO ENDORSEMENT VALUES (33, 1, 'Rebuttal', 31, 70.00000, NOW(), NOW(), 1); -- prohibition never works
INSERT INTO ENDORSEMENT VALUES (33, 1, 'Rebuttal', 30, 55.00000, NOW(), NOW(), 1); -- prohibition sometimes impossible

-- Arg 34 REJECTED: "Intellectual property laws need reform"
-- Alfred: "Reform" is just a code word for taking away what companies earned.
INSERT INTO ENDORSEMENT VALUES (34, 1, 'Rebuttal', 18, 70.00000, NOW(), NOW(), 1); -- corporations need return on investment
INSERT INTO ENDORSEMENT VALUES (34, 1, 'Rebuttal', 19, 65.00000, NOW(), NOW(), 1); -- IP protection is legitimate

-- Arg 35 REJECTED: "The current regulatory framework for GMOs is insufficient"
-- Alfred: Already going through more scrutiny than anything else. Insufficient to who?
INSERT INTO ENDORSEMENT VALUES (35, 1, 'Rebuttal',  3, 80.00000, NOW(), NOW(), 1); -- already rigorous
INSERT INTO ENDORSEMENT VALUES (35, 1, 'Rebuttal',  2, 65.00000, NOW(), NOW(), 1); -- govt role should be limited
INSERT INTO ENDORSEMENT VALUES (35, 1, 'Rebuttal',  9, 55.00000, NOW(), NOW(), 1); -- should be unregulated

-- Arg 38 REJECTED: "GMOs regulatory framework is not robust enough to respond to unexpected threats"
-- Alfred: Can't ever be robust enough — can't protect everything. Must accept some risk.
INSERT INTO ENDORSEMENT VALUES (38, 1, 'Rebuttal',  1, 80.00000, NOW(), NOW(), 1); -- can't protect us from everything
INSERT INTO ENDORSEMENT VALUES (38, 1, 'Rebuttal',  2, 70.00000, NOW(), NOW(), 1); -- govt responsibility is limited
INSERT INTO ENDORSEMENT VALUES (38, 1, 'Rebuttal', 11, 60.00000, NOW(), NOW(), 1); -- must accept some risk from unknowns

-- Arg 39 REJECTED: "GMO regulation must be fixed to support broader societal goals"
-- Alfred: "Broader societal goals" — that's academic talk for more government control.
INSERT INTO ENDORSEMENT VALUES (39, 1, 'Rebuttal',  1, 80.00000, NOW(), NOW(), 1); -- can't protect everything
INSERT INTO ENDORSEMENT VALUES (39, 1, 'Rebuttal', 36, 65.00000, NOW(), NOW(), 1); -- regulate what's there, don't expand
INSERT INTO ENDORSEMENT VALUES (39, 1, 'Rebuttal',  2, 55.00000, NOW(), NOW(), 1); -- govt role is limited

-- Arg 41 REJECTED: "GMO research needs more government support to ensure innovation benefits society"
-- Alfred: Government picking winners. That's not how innovation works.
INSERT INTO ENDORSEMENT VALUES (41, 1, 'Rebuttal', 40, 90.00000, NOW(), NOW(), 1); -- no govt support for GMO research
INSERT INTO ENDORSEMENT VALUES (41, 1, 'Rebuttal', 18, 70.00000, NOW(), NOW(), 1); -- corporations fund their own research
INSERT INTO ENDORSEMENT VALUES (41, 1, 'Rebuttal',  2, 55.00000, NOW(), NOW(), 1); -- govt role is limited

-- Arg 42 REJECTED: "GMO can protect crops vulnerable to climate change"
-- Alfred: Climate change as a premise — he's skeptical of the whole framing.
-- GMOs have other legitimate uses; this particular framing doesn't sit right with him.
INSERT INTO ENDORSEMENT VALUES (42, 1, 'Rebuttal', 43, 60.00000, NOW(), NOW(), 1); -- GMOs best for food crises, not this framing
INSERT INTO ENDORSEMENT VALUES (42, 1, 'Rebuttal',  5, 50.00000, NOW(), NOW(), 1); -- actual dangers not proven
INSERT INTO ENDORSEMENT VALUES (42, 1, 'Rebuttal', 47, 45.00000, NOW(), NOW(), 1); -- evaluate actual harms vs benefits

-- Arg 44 REJECTED: "Allow GMOs for emergency response only"
-- Alfred: Only for emergencies? That's just another way to restrict something that works fine.
INSERT INTO ENDORSEMENT VALUES (44, 1, 'Rebuttal', 46, 90.00000, NOW(), NOW(), 1); -- emergency-only freezes innovation
INSERT INTO ENDORSEMENT VALUES (44, 1, 'Rebuttal',  9, 70.00000, NOW(), NOW(), 1); -- should be fully unregulated
INSERT INTO ENDORSEMENT VALUES (44, 1, 'Rebuttal', 36, 60.00000, NOW(), NOW(), 1); -- regulate not restrict

-- Arg 50 REJECTED: "Elizabeth Warren should be President"
-- Alfred: Hard no. Everything she stands for is the opposite of what he believes.
INSERT INTO ENDORSEMENT VALUES (50, 1, 'Rebuttal',  1, 60.00000, NOW(), NOW(), 1); -- government can't protect everything (she'd try)
INSERT INTO ENDORSEMENT VALUES (50, 1, 'Rebuttal',  9, 55.00000, NOW(), NOW(), 1); -- her policies mean less market freedom
INSERT INTO ENDORSEMENT VALUES (50, 1, 'Rebuttal', 40, 50.00000, NOW(), NOW(), 1); -- government shouldn't interfere in markets


-- =============================================================================
-- SECTION 7: FIX PHRASE_ENDORSE ACTIVE FLAGS
-- newPutForth() creates/updates PHRASE_ENDORSE rows but does not set the
-- active flag. Align active with the current opinion for all of Alfred's
-- args 1–50 in one sweep.
-- =============================================================================

UPDATE PHRASE_ENDORSE pe
INNER JOIN OPINION o
    ON pe.argumentID = o.argumentID
    AND pe.profileID  = o.profileID
SET pe.active = o.acceptance
WHERE pe.profileID = 1
  AND pe.argumentID BETWEEN 1 AND 50;


-- =============================================================================
-- SECTION 8: FIX MISSING PHRASE_ENDORSE FOR ARGS 10 AND 19
-- Alfred coined phrasings for these before PHRASE_ENDORSE was in use.
-- newPutForth was not called for them (kept existing phrasings), so no
-- PHRASE_ENDORSE record was created in Section 3. Add them manually.
-- phrasingID 240 → arg 10, phrasingID 239 → arg 19
-- =============================================================================

INSERT IGNORE INTO PHRASE_ENDORSE (argumentID, phrasingID, weight, profileID, firstVisit, lastVisit, active)
VALUES (10, 240, 100, 1, NOW(), NOW(), 1),
       (19, 239, 100, 1, NOW(), NOW(), 1);


-- =============================================================================
-- END
-- Verify row counts after running:
--   SELECT COUNT(*) FROM ENDORSEMENT WHERE profileID=1 AND targArgID BETWEEN 1 AND 50;
--   SELECT COUNT(*) FROM PHRASING     WHERE coinedBy=1 AND argumentID BETWEEN 1 AND 50;
--   SELECT COUNT(*) FROM PHRASE_ENDORSE WHERE profileID=1 AND argumentID BETWEEN 1 AND 50;
--   SELECT COUNT(*) FROM EXPLICATION   WHERE profileID=1 AND argumentID BETWEEN 1 AND 50;
--   SELECT acceptance, COUNT(*) FROM OPINION WHERE profileID=1 AND argumentID BETWEEN 1 AND 50
--     GROUP BY acceptance;
-- =============================================================================
