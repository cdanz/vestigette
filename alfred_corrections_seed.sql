-- =============================================================================
-- Alfred Anderson (profileID=1) — Opinion corrections + phrasing specificity
-- Generated: 2026-05-24
-- =============================================================================
-- FIXES:
--   1. Args 51, 54: flip ACCEPT → REJECT (wrong in test data; persona would reject)
--   2. Arg 52: add Alfred's specific phrasing (accepted, but had no phrasing)
--   3. All args 1–50 phrasings: rewritten for specificity
--      Old versions were in Alfred's voice but too abstract.
--      Personas enrich the database — their phrasings should name the specific
--      argument, technology, or context so future users get real signal.
-- =============================================================================

USE vestigette;


-- =============================================================================
-- SECTION 1: OPINION CORRECTIONS — Args 51 and 54
-- =============================================================================

-- Arg 51: "Distribution of the COVID-19 vaccine must have as few barriers as possible"
-- Alfred REJECTS. He opposes mandates, government pressure on medical decisions,
-- and anything that smells like forced compliance.
CALL assertOpinion(-1, 51, 1);

-- Add rebuttals Alfred would cite against arg 51 (from args he accepts)
DELETE FROM ENDORSEMENT WHERE profileID=1 AND targArgID=51 AND endorseType='Rebuttal';
INSERT INTO ENDORSEMENT VALUES (51, 1, 'Rebuttal', 1396,  85.00000, NOW(), NOW(), 1); -- no one forced to take vaccine
INSERT INTO ENDORSEMENT VALUES (51, 1, 'Rebuttal', 1397,  80.00000, NOW(), NOW(), 1); -- vaccine passports banned
INSERT INTO ENDORSEMENT VALUES (51, 1, 'Rebuttal',    1,  60.00000, NOW(), NOW(), 1); -- government can't protect us from everything
INSERT INTO ENDORSEMENT VALUES (51, 1, 'Rebuttal',  226,  55.00000, NOW(), NOW(), 1); -- freedom should never be infringed

-- Arg 54: "A wealth tax is a critical tool toward societal harmony."
-- Alfred REJECTS. He's against wealth taxes and deeply skeptical of the
-- "societal harmony" framing — that's the kind of progressive language he resents.
CALL assertOpinion(-1, 54, 1);

-- Add rebuttals Alfred would cite against arg 54
DELETE FROM ENDORSEMENT WHERE profileID=1 AND targArgID=54 AND endorseType='Rebuttal';
INSERT INTO ENDORSEMENT VALUES (54, 1, 'Rebuttal',  265,  85.00000, NOW(), NOW(), 1); -- tax cut = keep money you duly earned
INSERT INTO ENDORSEMENT VALUES (54, 1, 'Rebuttal',  266,  80.00000, NOW(), NOW(), 1); -- government check = other people's money
INSERT INTO ENDORSEMENT VALUES (54, 1, 'Rebuttal',  227,  70.00000, NOW(), NOW(), 1); -- low taxes fuel innovation
INSERT INTO ENDORSEMENT VALUES (54, 1, 'Rebuttal',  193,  60.00000, NOW(), NOW(), 1); -- no such thing as too much wealth concentration (from a free-market view)


-- =============================================================================
-- SECTION 2: ADD PHRASING FOR ARG 52
-- "There is no functional difference between the government giving you money
-- and the government not taxing you that amount of money."
-- Alfred ACCEPTS — but he uses this argument as a rhetorical lever, not as
-- an endorsement of redistribution. He's saying: if keeping his tax cut is
-- fiscally identical to a welfare check, then consistency demands that
-- "welfare state" advocates apply that logic to their own programs too.
-- =============================================================================

CALL newPutForth(52, 1, 'Economists say a tax cut and a welfare check cost the federal budget the same amount. Fine — then stop calling my tax cut a giveaway and start applying that standard to every government program that redistributes it. At least my tax cut doesn''t need a bureaucracy to administer it.');

-- Fix PHRASE_ENDORSE active flag (arg 52 is accepted, so should be active)
UPDATE PHRASE_ENDORSE SET active = 1
WHERE profileID = 1 AND argumentID = 52;


-- =============================================================================
-- SECTION 3: PHRASING SPECIFICITY REWRITES — Args 1–50
--
-- RULE: Personas enrich the database. Under normal use, human phrasings are
-- short and vague — the surrounding argument graph provides context.
-- While seeding with LLM personas, phrasings should explicitly name the
-- technology, policy, or scenario being argued so they carry standalone signal.
--
-- Alfred's voice is preserved: plain, direct, drops subjects, no jargon.
-- But each phrasing now specifically references GMOs, crop science, farming,
-- or the specific policy at hand.
--
-- UPDATE in-place (by phrasingID) rather than inserting new records.
-- =============================================================================

-- phrasingID 1778 — Arg 1: Government/society cannot protect us from everything.
UPDATE PHRASING SET phrasing =
'The government couldn''t stop NAFTA from shipping Ohio''s steel jobs overseas. It couldn''t keep opioids out of rural towns. If it can''t protect us from those things, it sure isn''t going to protect us from a GMO soybean.'
WHERE phrasingID = 1778;

-- phrasingID 1779 — Arg 2: Govt responsibility = check plausible harms only.
UPDATE PHRASING SET phrasing =
'FDA reviews the GMO science, USDA inspects the crops — that''s the job. Once those agencies have checked for real dangers in a GMO variety, government''s role in those sales is done. The rest is between farmers and the market.'
WHERE phrasingID = 1779;

-- phrasingID 1780 — Arg 3: GMOs held under greater scrutiny than any other food.
UPDATE PHRASING SET phrasing =
'A GMO crop goes through years of safety trials — rodent studies, field tests, allergen screening — before a single commercial acre gets planted. The conventional produce sitting next to it in the store goes through far less. If GMOs scare you, everything else on that shelf should terrify you.'
WHERE phrasingID = 1780;

-- phrasingID 1781 — Arg 5: All plausible danger hypotheses shown wrong.
UPDATE PHRASING SET phrasing =
'They''ve been growing GMO soybeans and corn in this country since the nineties. Every cancer warning, every toxin scare, every ecological catastrophe they predicted — not one panned out. Thirty years of real-world data. The danger argument is dead.'
WHERE phrasingID = 1781;

-- phrasingID 1782 — Arg 6: Novel technology requires special care to ensure safety.
UPDATE PHRASING SET phrasing =
'First time you bring a new crop technology to market — GMOs, hybrid seed, synthetic fertilizers — you run the tests and study the effects before you scale it. That''s responsible development, not a reason to keep it locked in a lab or buried under regulations forever.'
WHERE phrasingID = 1782;

-- phrasingID 1783 — Arg 7: When technology is understood it can be incorporated into life.
UPDATE PHRASING SET phrasing =
'We ran the trials, we studied GMO crop safety for decades, and we understood what we were working with. That''s the point — once you understand a technology, the next step is letting farmers actually use it. That''s how every agricultural advance from tractors to hybrid seed got adopted.'
WHERE phrasingID = 1783;

-- phrasingID 1784 — Arg 8: Testing what we only know now won't protect us from unknowns.
UPDATE PHRASING SET phrasing =
'You could run GMO safety studies for another fifty years and still not cover every theoretical risk an activist could imagine. At some point you accept that no test covers every unknown — that was true when we introduced hybrid corn, it''s true of GMO crops, it''s true of farming itself.'
WHERE phrasingID = 1784;

-- phrasingID 1785 — Arg 9: Sales of GMO should be unregulated.
UPDATE PHRASING SET phrasing =
'Farmers have been planting Roundup Ready soybeans since 1996. Grocery stores have carried GMO corn and soy products for decades without incident. The system works. Let farmers and markets keep making these calls without Washington second-guessing every seed purchase.'
WHERE phrasingID = 1785;

-- phrasingID 240 — Arg 10: How can something be limited and still ever be fully trusted?
UPDATE PHRASING SET phrasing =
'If GMO crops are always under provisional approval, emergency-use restrictions, or mandatory special labeling, they never get a fair shot to prove themselves in the market. You can''t build public trust in something you''re treating as permanently under suspicion.'
WHERE phrasingID = 240;

-- phrasingID 1786 — Arg 11: Must draw a line and allow some risk from unknowns.
UPDATE PHRASING SET phrasing =
'We let hybrid corn into the market before we knew everything about it. We allowed synthetic fertilizers and pesticides without a complete long-term picture. At some point you draw a line and let GMO farming proceed — you can''t wait for a certainty that will never fully arrive.'
WHERE phrasingID = 1786;

-- phrasingID 1787 — Arg 16: Research on GMO is expensive.
UPDATE PHRASING SET phrasing =
'Developing a drought-resistant GMO crop variety takes years of lab work and field trials before you can plant a single commercial acre. That kind of agricultural research doesn''t happen on a shoestring — you need serious capital investment to do it at all.'
WHERE phrasingID = 1787;

-- phrasingID 1788 — Arg 17: Research limited to select few with significant funds.
UPDATE PHRASING SET phrasing =
'When GMO crop development costs hundreds of millions of dollars, you don''t have family farms in Iowa running their own biotech labs. It''s Monsanto, Bayer, Syngenta doing the research. That''s the economic reality of crop biotechnology — not a scandal, just scale.'
WHERE phrasingID = 1788;

-- phrasingID 1789 — Arg 18: Corporations demand sufficient return on investment.
UPDATE PHRASING SET phrasing =
'When a seed company spends a billion dollars developing a pest-resistant corn variety, they need to recoup that investment before they''ll fund the next one. That''s not greed — that''s how you sustain any agricultural R&D operation. No return, no next drought-resistant crop.'
WHERE phrasingID = 1789;

-- phrasingID 239 — Arg 19: GMOs can be used to protect intellectual property.
UPDATE PHRASING SET phrasing =
'A seed company that patents a GMO crop variety is protecting years of research investment — same as a drug company patents a new medicine. You develop the agricultural innovation, you protect it through IP law. That''s what makes anyone invest in the next innovation.'
WHERE phrasingID = 239;

-- phrasingID 1790 — Arg 20: Toxins is a term applied too broadly to have clear meaning.
UPDATE PHRASING SET phrasing =
'Anti-GMO activists call these crops ''full of toxins'' without naming a single specific compound, a dose, or a biological mechanism. Water is lethal at the right dose. Calling GMO food ''toxic'' without evidence is a scare tactic dressed up as science — and it works on people who don''t look deeper.'
WHERE phrasingID = 1790;

-- phrasingID 1791 — Arg 25: GMOs can be used to create termination seeds.
UPDATE PHRASING SET phrasing =
'Terminator technology is real — you can engineer a GMO crop so the seeds it produces won''t germinate for replanting. Monsanto and other biotech companies have developed this. Farmers who sign certain GMO licensing agreements are already prohibited from saving seed. This isn''t a conspiracy theory.'
WHERE phrasingID = 1791;

-- phrasingID 1792 — Arg 28: Termination seeds take control from farmers.
UPDATE PHRASING SET phrasing =
'A farmer planting terminator GMO seeds can''t save his own seed for next year — he has to go back to the seed company every single planting season. That''s a dependency these corporations engineered deliberately. Farmers in Ohio and Kansas shouldn''t have that leverage used against them.'
WHERE phrasingID = 1792;

-- phrasingID 1793 — Arg 29: Termination seeds control farmers.
UPDATE PHRASING SET phrasing =
'When your GMO seeds won''t reproduce, you''re not a Monsanto customer once — you''re their customer permanently, every planting season, for as long as you farm. They''ve inserted themselves into your operation''s supply chain by design. That''s control engineered into the biology of the seed.'
WHERE phrasingID = 1793;

-- phrasingID 1794 — Arg 30: Prohibition in some cases is operationally impossible.
UPDATE PHRASING SET phrasing =
'You can''t ban a GMO pollen grain at a state line. You can''t stop cross-pollination in the wind between fields. Once GMO crop varieties are in widespread commercial use, some aspects of that technology become physically impossible to prohibit regardless of what the law says.'
WHERE phrasingID = 1794;

-- phrasingID 1795 — Arg 31: Prohibition never works.
UPDATE PHRASING SET phrasing =
'We banned alcohol and created bootleggers. We banned drugs and created cartels. Ban GMO crop sales and you push the development to China and Brazil — countries with no oversight — while American farmers buy those same seeds on the black market anyway. Prohibition doesn''t work.'
WHERE phrasingID = 1795;

-- phrasingID 1796 — Arg 36: Tech should never be banned when it can be regulated instead.
UPDATE PHRASING SET phrasing =
'We don''t ban cars because people drive drunk — we have DUI laws. We don''t ban chainsaws — we have safety standards. GMO crop technology can be regulated the same way: approved varieties, monitoring requirements, labeling. A blanket ban is a failure to think the problem through.'
WHERE phrasingID = 1796;

-- phrasingID 1797 — Arg 37: Single application shouldn't impugn entire field.
UPDATE PHRASING SET phrasing =
'Terminator seeds are a legitimate concern about corporate control over farmers. But you don''t shut down all of GMO crop science because of that one troubling application — just like you don''t ban all pharmaceutical research because one drug turned out to have bad side effects.'
WHERE phrasingID = 1797;

-- phrasingID 1798 — Arg 40: No government support should be given to GMO research.
UPDATE PHRASING SET phrasing =
'Monsanto, Bayer, and Corteva are already spending billions on GMO crop development without a government check. The moment taxpayers start subsidizing private seed patents, we''ve handed corporate agriculture a welfare program and called it agricultural research policy. Let them fund their own work.'
WHERE phrasingID = 1798;

-- phrasingID 1799 — Arg 43: GMOs best tool for time-sensitive food supply crisis.
UPDATE PHRASING SET phrasing =
'When citrus greening was wiping out Florida''s orange crops, GMO disease resistance was the fastest path forward. When drought hammers the corn belt, GMO drought tolerance can save a harvest in one growing season. No other agricultural tool responds to a food supply crisis that fast.'
WHERE phrasingID = 1799;

-- phrasingID 1800 — Arg 45: Allow GMOs for emergency response.
UPDATE PHRASING SET phrasing =
'Even if you''re skeptical of GMO crops in everyday farming, when a blight is threatening a staple food crop or drought is cutting yields by half, you use every tool available — including GMO varieties that can salvage a harvest before people go without food.'
WHERE phrasingID = 1800;

-- phrasingID 1801 — Arg 46: Emergency-only deployment freezes innovation.
UPDATE PHRASING SET phrasing =
'If GMO drought-resistant crops can only be planted during an officially declared food emergency, no seed company is going to spend a decade and a billion dollars developing them. You kill the R&D pipeline by restricting the market to crisis-only scenarios. Innovation needs a real commercial path.'
WHERE phrasingID = 1801;

-- phrasingID 1802 — Arg 47: Limit tech only if harms outweigh benefits.
UPDATE PHRASING SET phrasing =
'That''s a reasonable standard — apply it honestly to GMO crops. If they were causing cancer rates to spike, destroying ecosystems, or poisoning aquifers, limiting them would make sense. Thirty years of data says none of that is happening. Run the test fairly. GMO crops pass it.'
WHERE phrasingID = 1802;


-- =============================================================================
-- SECTION 4: REFRESH PHRASING CACHE FOR ALL UPDATED ARGS
-- updatePhrasingCache recalculates ARGUMENT.currentPhrasing based on
-- weighted PHRASE_ENDORSE endorsements. Must run after any phrasing change
-- where Alfred's phrasing might now be the top-weighted one.
-- =============================================================================

CALL updatePhrasingCache(1);
CALL updatePhrasingCache(2);
CALL updatePhrasingCache(3);
CALL updatePhrasingCache(5);
CALL updatePhrasingCache(6);
CALL updatePhrasingCache(7);
CALL updatePhrasingCache(8);
CALL updatePhrasingCache(9);
CALL updatePhrasingCache(10);
CALL updatePhrasingCache(11);
CALL updatePhrasingCache(16);
CALL updatePhrasingCache(17);
CALL updatePhrasingCache(18);
CALL updatePhrasingCache(19);
CALL updatePhrasingCache(20);
CALL updatePhrasingCache(25);
CALL updatePhrasingCache(28);
CALL updatePhrasingCache(29);
CALL updatePhrasingCache(30);
CALL updatePhrasingCache(31);
CALL updatePhrasingCache(36);
CALL updatePhrasingCache(37);
CALL updatePhrasingCache(40);
CALL updatePhrasingCache(43);
CALL updatePhrasingCache(45);
CALL updatePhrasingCache(46);
CALL updatePhrasingCache(47);
CALL updatePhrasingCache(52);

-- =============================================================================
-- END
-- Verify:
--   SELECT o.argumentID, o.acceptance, p.phrasing
--   FROM OPINION o
--   LEFT JOIN PHRASE_ENDORSE pe ON pe.profileID=1 AND pe.argumentID=o.argumentID AND pe.active=1
--   LEFT JOIN PHRASING p ON pe.phrasingID=p.phrasingID
--   WHERE o.profileID=1 AND o.argumentID IN (51,52,54)
--   ORDER BY o.argumentID;
-- =============================================================================
