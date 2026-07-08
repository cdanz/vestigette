-- Brianna Barnes (profileID=2) — MEDIA cluster
-- 70 args: 67 accept / 3 reject

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (367,  2, 1),
  (368,  2, 1),
  (369,  2, 1),
  (372,  2, 1),
  (373,  2, 1),
  (374,  2, 1),
  (375,  2, 1),
  (376,  2, 1),
  (377,  2, 0),
  (378,  2, 1),
  (463,  2, 1),
  (464,  2, 1),
  (465,  2, 0),
  (466,  2, 1),
  (467,  2, 1),
  (468,  2, 1),
  (488,  2, 1),
  (489,  2, 1),
  (490,  2, 1),
  (498,  2, 0),
  (499,  2, 1),
  (504,  2, 1),
  (505,  2, 1),
  (506,  2, 1),
  (507,  2, 1),
  (508,  2, 1),
  (509,  2, 1),
  (510,  2, 1),
  (511,  2, 1),
  (583,  2, 1),
  (584,  2, 1),
  (585,  2, 1),
  (1249, 2, 1),
  (1284, 2, 1),
  (1285, 2, 1),
  (1286, 2, 1),
  (1287, 2, 1),
  (1288, 2, 1),
  (1289, 2, 1),
  (1290, 2, 1),
  (1291, 2, 1),
  (1292, 2, 1),
  (1293, 2, 1),
  (1294, 2, 1),
  (1295, 2, 1),
  (1414, 2, 1),
  (1415, 2, 1),
  (1416, 2, 1),
  (1505, 2, 1),
  (1506, 2, 1),
  (1507, 2, 1),
  (1508, 2, 1),
  (1509, 2, 1),
  (1510, 2, 1),
  (1511, 2, 1),
  (1512, 2, 1),
  (1513, 2, 1),
  (1514, 2, 1),
  (1515, 2, 1),
  (1516, 2, 1),
  (1517, 2, 1),
  (1518, 2, 1),
  (1519, 2, 1),
  (1520, 2, 1),
  (1521, 2, 1),
  (1522, 2, 1),
  (1585, 2, 1),
  (1586, 2, 1),
  (1587, 2, 1),
  (1588, 2, 1);

-- PHRASINGS (67 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (367, 'Social media\'s outrage engine wasn\'t designed in bad faith — it was designed to keep you clicking, and it works exactly as intended.', 2);
CALL updatePhrasingCache(367);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (368, 'Engagement metrics that reward conflict over resolution have produced a discourse that never resolves — that\'s the design, not a bug.', 2);
CALL updatePhrasingCache(368);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (369, 'Without editorial gatekeepers, social media has no mechanism to distinguish signal from noise — the chaos is structural, not incidental.', 2);
CALL updatePhrasingCache(369);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (372, 'Social media is different from broadcasting because it\'s two-way — the relationship dynamic changes everything about how it works and fails.', 2);
CALL updatePhrasingCache(372);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (373, 'Vestigette is structured around arguments and evidence, not feeds and likes — that\'s a different kind of product.', 2);
CALL updatePhrasingCache(373);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (374, 'Algorithmic curation means your feed confirms what you already believe — you\'re not exploring information, you\'re inhabiting a reflection of yourself.', 2);
CALL updatePhrasingCache(374);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (375, 'Social media connected people across distance and enabled organizing that wasn\'t possible before — the failures don\'t erase those real benefits.', 2);
CALL updatePhrasingCache(375);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (376, 'Social media broke the gatekeeping monopoly on information — voices that couldn\'t get past editors now reach audiences directly, for better and worse.', 2);
CALL updatePhrasingCache(376);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (378, 'The business model of social media is screen time — every design choice flows from maximizing how long you stay, not how well-informed you leave.', 2);
CALL updatePhrasingCache(378);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (463, 'Social media has no editorial process and no one legally accountable for what circulates — traditional media, for all its failures, has structural safeguards that social platforms don\'t.', 2);
CALL updatePhrasingCache(463);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (464, 'Traditional outlets with editorial standards, fact-checkers, and legal liability are generally more reliable than unmoderated social posts — that\'s the structural difference.', 2);
CALL updatePhrasingCache(464);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (466, 'Your social media can be a well-curated information resource or a conspiracy firehose — the content is whatever you\'ve trained the algorithm to show you.', 2);
CALL updatePhrasingCache(466);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (467, 'Subscribe to your local paper — local journalism covers the school board, the city contract, the judge. Nobody else does.', 2);
CALL updatePhrasingCache(467);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (468, 'Both-sides journalism driven by fear of audience alienation is as corrupting as partisan journalism — in different ways, both fail the reader.', 2);
CALL updatePhrasingCache(468);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (488, 'Editors exist to catch what reporters miss — that layer of review is one of the structural features that distinguishes professional journalism from a blog.', 2);
CALL updatePhrasingCache(488);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (489, 'Fact-checkers are one of the things that separate outlets with professional standards from content farms — their presence matters.', 2);
CALL updatePhrasingCache(489);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (490, 'Professional news organizations with editorial standards and legal accountability are generally more trustworthy than outlets without those constraints.', 2);
CALL updatePhrasingCache(490);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (499, 'Facebook\'s deference to conservative outrage has nothing to do with fairness — it\'s about avoiding regulation that would threaten their business model.', 2);
CALL updatePhrasingCache(499);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (504, 'Thirty years of expertise is not the same as reading three articles — the difference is depth, context, and the ability to distinguish signal from noise.', 2);
CALL updatePhrasingCache(504);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (505, 'Expert consensus represents accumulated evidence tested over time — dismissing it because you\'ve done your own "research" is not skepticism, it\'s arrogance.', 2);
CALL updatePhrasingCache(505);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (506, 'Preparation can create false confidence — knowing the theory of avalanche risk makes people more willing to enter terrain they shouldn\'t.', 2);
CALL updatePhrasingCache(506);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (507, 'Arguments built on vanishingly rare edge cases are not useful — if something is only true in exceptional circumstances, say so.', 2);
CALL updatePhrasingCache(507);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (508, 'Avalanche safety classes increase willingness to enter dangerous terrain — knowledge without proportionate experience can make things worse.', 2);
CALL updatePhrasingCache(508);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (509, 'The avalanche safety graduates who die are a selection bias story — they went places others wouldn\'t, because they felt prepared.', 2);
CALL updatePhrasingCache(509);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (510, 'Knowledge is power — which is why controlling access to information has always been a political project.', 2);
CALL updatePhrasingCache(510);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (511, 'Facts should exist and be defensible on their merits — the premise that reality is subjective is how truth gets killed.', 2);
CALL updatePhrasingCache(511);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (583, 'Professional news organizations with accountability structures and editorial standards are a reasonable baseline for trust — imperfect, but better than the alternatives.', 2);
CALL updatePhrasingCache(583);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (584, 'A slick website and a credentialed masthead don\'t tell you whether a source is accurate — standards and track record do.', 2);
CALL updatePhrasingCache(584);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (585, 'Judge a news source by its correction policy, its source transparency, and its track record — not its production values or political valence.', 2);
CALL updatePhrasingCache(585);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1249, 'Media optimized for outrage isn\'t broken — it\'s working exactly as designed to maximize ad revenue. The system is the problem.', 2);
CALL updatePhrasingCache(1249);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1284, 'Arguments that can\'t agree on definitions aren\'t arguments — they\'re people talking past each other with the same words.', 2);
CALL updatePhrasingCache(1284);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1285, 'Labels do more organizing than describing — once you\'ve labeled someone, you\'ve already decided what to think of what they say.', 2);
CALL updatePhrasingCache(1285);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1286, 'When you hear "liberal" or "conservative," you\'re hearing the speaker\'s associations, not a description of the person — the label carries more baggage than information.', 2);
CALL updatePhrasingCache(1286);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1287, 'Social media converts most political discussions into performance — people aren\'t trying to persuade each other, they\'re playing to their audience.', 2);
CALL updatePhrasingCache(1287);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1288, 'Even a one-on-one conversation with perfect intent can result in misunderstanding — adding scale and anonymity makes this dramatically worse.', 2);
CALL updatePhrasingCache(1288);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1289, 'Every person added to a discussion multiplies the possible misunderstandings — large-group discourse needs structure to function at all.', 2);
CALL updatePhrasingCache(1289);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1290, 'Robert\'s Rules exist because large groups need process to function — the formality is not rigidity, it\'s the floor that keeps things from dissolving.', 2);
CALL updatePhrasingCache(1290);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1291, 'Robert\'s Rules are imperfect but the most tested system for managing deliberative groups — something reliably better hasn\'t replaced them.', 2);
CALL updatePhrasingCache(1291);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1292, 'Robert\'s Rules manage process, not content — they keep order without building the trust needed for real consensus.', 2);
CALL updatePhrasingCache(1292);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1293, 'Robert\'s Rules are excellent at what they were designed for — ensuring everyone gets a turn and the agenda gets covered.', 2);
CALL updatePhrasingCache(1293);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1294, 'Genuinely representing all stakeholders would take longer than any meeting allows — there\'s no perfect solution, only better or worse compromises.', 2);
CALL updatePhrasingCache(1294);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1295, 'We need better tools for measuring what people actually believe, not just what they\'re willing to say when given a microphone.', 2);
CALL updatePhrasingCache(1295);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1414, 'Access journalism traded editorial independence for exclusive sourcing — the dependence on insider relationships compromises the coverage.', 2);
CALL updatePhrasingCache(1414);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1415, 'Right-wing media\'s contempt for women is not incidental — it\'s part of the worldview it sells to its audience.', 2);
CALL updatePhrasingCache(1415);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1416, 'Using the least flattering photo of a woman you dislike is a tell — you\'re not critiquing her positions, you\'re punishing her for existing.', 2);
CALL updatePhrasingCache(1416);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1505, 'The internet promised to democratize information and instead created a handful of platforms that monetized division — that\'s the gap between the vision and the outcome.', 2);
CALL updatePhrasingCache(1505);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1506, 'Every transformative technology follows the same arc: hype, crash, stabilization — the internet was not the exception.', 2);
CALL updatePhrasingCache(1506);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1507, 'More information doesn\'t guarantee better-informed people — curation, trust, and media literacy determine what people actually absorb.', 2);
CALL updatePhrasingCache(1507);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1508, 'Big tech\'s editorial control over what\'s allowed online is more comprehensive than any newspaper editor ever had — the fiction that platforms aren\'t publishers is long past its expiration date.', 2);
CALL updatePhrasingCache(1508);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1509, 'Political conversation on social media runs hotter than in person — the format removes context, adds permanence, and strips the social cues that moderate live conflict.', 2);
CALL updatePhrasingCache(1509);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1510, 'Online partisan communities radicalize through positive feedback loops — each cycle of agreement pushes the edge of acceptable belief further out.', 2);
CALL updatePhrasingCache(1510);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1511, 'Selling products with false health claims is fraud, not expression — the rules apply whether the claim is made in a newspaper ad or an Instagram post.', 2);
CALL updatePhrasingCache(1511);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1512, 'Herbal supplement advertising routinely makes health claims that are either unprovable or demonstrably false — most of it should be illegal.', 2);
CALL updatePhrasingCache(1512);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1513, 'The supplement aisle is what\'s left after science filtered out the herbal remedies that actually work and called them medicine.', 2);
CALL updatePhrasingCache(1513);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1514, 'The herbal remedies that proved effective in clinical trials are pharmaceuticals now — what remains in the supplement aisle is untested at best.', 2);
CALL updatePhrasingCache(1514);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1515, 'Consumer fraud protection is a core government responsibility — letting people sell false health claims harms the most vulnerable.', 2);
CALL updatePhrasingCache(1515);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1516, 'Facebook profits from supplement ads it knows are deceptive — banning them isn\'t censorship, it\'s the minimum due diligence of a responsible platform.', 2);
CALL updatePhrasingCache(1516);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1517, 'Free speech protects your right to say things — it has never protected your right to defraud or defame people. That line is as old as the First Amendment.', 2);
CALL updatePhrasingCache(1517);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1518, 'Courts have consistently held that fraud, defamation, and incitement fall outside First Amendment protection — this is not contested law.', 2);
CALL updatePhrasingCache(1518);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1519, 'Herbal supplement MLMs sell hope wrapped in pseudoscience to people who can least afford either.', 2);
CALL updatePhrasingCache(1519);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1520, 'Multi-level marketing requires an ever-expanding base of recruiters to sustain payouts at the top — that\'s the definition of a pyramid scheme.', 2);
CALL updatePhrasingCache(1520);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1521, 'Social media gives extremist recruiters frictionless access to vulnerable people, with no equal and opposite voice providing context or pushback.', 2);
CALL updatePhrasingCache(1521);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1522, 'Negativity travels faster than nuance on social media — the algorithm learned that outrage keeps you scrolling.', 2);
CALL updatePhrasingCache(1522);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1585, 'Nextdoor turns neighborhood anxiety into a tool for racial profiling — it is a social cancer that makes communities worse, not better.', 2);
CALL updatePhrasingCache(1585);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1586, 'The fact that Nextdoor uses real names does moderate some behavior — it proves anonymity isn\'t the only variable in online toxicity.', 2);
CALL updatePhrasingCache(1586);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1587, 'Nextdoor\'s crime and safety threads are a master class in how proximity and anxiety can be weaponized into racial surveillance.', 2);
CALL updatePhrasingCache(1587);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1588, 'Anonymity strips away the social consequences of cruelty — the result is predictable, and it\'s why platform design choices about identity have real moral weight.', 2);
CALL updatePhrasingCache(1588);
