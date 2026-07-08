-- Brianna Barnes (profileID=2) — CLIMATE cluster
-- 62 args: 43 accept / 19 reject
-- Overlap: 864(1✓), 866(1✓) already in DB from GOP — phrasings written there, no new phrasings

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (123,  2, 1),
  (230,  2, 0),
  (321,  2, 1),
  (414,  2, 1),
  (415,  2, 0),
  (476,  2, 1),
  (477,  2, 1),
  (478,  2, 0),
  (479,  2, 1),
  (480,  2, 1),
  (527,  2, 0),
  (528,  2, 0),
  (529,  2, 0),
  (530,  2, 1),
  (730,  2, 0),
  (863,  2, 1),
  (864,  2, 1),
  (865,  2, 0),
  (866,  2, 1),
  (867,  2, 1),
  (868,  2, 0),
  (869,  2, 0),
  (870,  2, 0),
  (892,  2, 1),
  (893,  2, 1),
  (1007, 2, 0),
  (1009, 2, 1),
  (1010, 2, 1),
  (1011, 2, 1),
  (1034, 2, 0),
  (1035, 2, 0),
  (1036, 2, 1),
  (1037, 2, 0),
  (1038, 2, 1),
  (1039, 2, 1),
  (1040, 2, 1),
  (1041, 2, 1),
  (1042, 2, 1),
  (1043, 2, 1),
  (1044, 2, 1),
  (1275, 2, 0),
  (1276, 2, 0),
  (1277, 2, 1),
  (1296, 2, 1),
  (1297, 2, 1),
  (1298, 2, 1),
  (1299, 2, 1),
  (1300, 2, 1),
  (1383, 2, 1),
  (1523, 2, 1),
  (1524, 2, 0),
  (1525, 2, 1),
  (1526, 2, 1),
  (1527, 2, 1),
  (1528, 2, 1),
  (1529, 2, 0),
  (1530, 2, 1),
  (1532, 2, 1),
  (1533, 2, 1),
  (1534, 2, 1),
  (1535, 2, 1),
  (1536, 2, 1);

-- PHRASINGS (41 new accepts; 864,866 already phrased in GOP)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (123, 'The window for avoiding the worst of climate change is closing — urgency is not hyperbole, it\'s physics.', 2);
CALL updatePhrasingCache(123);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (321, 'Human-caused climate change is not a theory under debate — it\'s directly measurable in the atmosphere, the oceans, and the ice record.', 2);
CALL updatePhrasingCache(321);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (414, 'Every solar panel and wind turbine installed is one more piece of the transition we needed to start decades ago — faster is better.', 2);
CALL updatePhrasingCache(414);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (476, 'The carbon in those reserves cannot enter the atmosphere if we want a livable planet — leaving it in the ground is the math.', 2);
CALL updatePhrasingCache(476);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (477, 'The science is unambiguous: burning fossil fuels is the primary driver of the warming that is already killing people.', 2);
CALL updatePhrasingCache(477);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (479, 'Coal kills hundreds of thousands annually through air pollution — nuclear\'s safety record, per unit of energy produced, is actually the best of any source.', 2);
CALL updatePhrasingCache(479);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (480, 'Nuclear provides zero-emissions baseload power regardless of weather — it belongs in any serious climate solution.', 2);
CALL updatePhrasingCache(480);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (530, 'Advanced nuclear and geothermal are stalled in regulatory limbo while the climate crisis advances — streamline the permitting pathways.', 2);
CALL updatePhrasingCache(530);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (863, 'No individual recycling program or consumer choice gets us there — the scale of climate change demands collective, coordinated action.', 2);
CALL updatePhrasingCache(863);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (867, 'Markets are excellent at many things — solving collective action problems against their own interests isn\'t one of them. That\'s what government is for.', 2);
CALL updatePhrasingCache(867);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (892, 'Individual carbon footprint reduction is necessary but not sufficient — net negative requires structural transformation, not just better consumer choices.', 2);
CALL updatePhrasingCache(892);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (893, 'The greenhouse gases already in the atmosphere guarantee some level of dangerous warming regardless of what we do today — that\'s how much time we\'ve lost.', 2);
CALL updatePhrasingCache(893);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1009, 'Population growth is only a problem if each person is a net carbon burden — redesign the system and more people means more problem-solvers.', 2);
CALL updatePhrasingCache(1009);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1010, 'Population control programs historically fall hardest on poor women and women of color — that\'s not a coincidence, it\'s a feature.', 2);
CALL updatePhrasingCache(1010);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1011, 'Energy efficiency is good business even before you count the climate benefit — there\'s no ideological excuse for wasting energy.', 2);
CALL updatePhrasingCache(1011);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1036, 'The priority should be producing less waste in the first place — recycling is downstream cleanup, not a solution.', 2);
CALL updatePhrasingCache(1036);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1038, 'When recycling programs accept materials that can\'t be sorted, they\'re recycling theater — the contamination goes straight to landfill.', 2);
CALL updatePhrasingCache(1038);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1039, 'Modern landfills are engineered facilities with leachate control and methane capture — not the open dumps that shaped our cultural aversion to them.', 2);
CALL updatePhrasingCache(1039);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1040, 'The landfill stigma is 50 years out of date — modern managed facilities are dramatically better than what people picture.', 2);
CALL updatePhrasingCache(1040);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1041, 'Waste-to-energy works at scale in Sweden and Japan — American opposition to it has cost us decades of better waste management.', 2);
CALL updatePhrasingCache(1041);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1042, 'Landfill methane is 25 times more potent than CO2 — waste-to-energy with energy recovery is the better climate choice.', 2);
CALL updatePhrasingCache(1042);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1043, 'Modern waste incinerators recover metals, generate energy, and reduce landfill volume — the co-benefits of the system are significant.', 2);
CALL updatePhrasingCache(1043);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1044, 'Burning biogenic carbon returns to the cycle it came from — that\'s categorically different from releasing sequestered fossil carbon.', 2);
CALL updatePhrasingCache(1044);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1277, 'The rate of current warming is unprecedented in the geological record — nothing in Earth\'s natural history matches the pace of what\'s happening now.', 2);
CALL updatePhrasingCache(1277);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1296, 'Since the UN climate framework launched in 1992, we\'ve emitted more CO2 than in all prior human history — the framework didn\'t work.', 2);
CALL updatePhrasingCache(1296);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1297, 'Every ton of carbon we emit now is a choice — we know exactly what it does, and we keep doing it anyway.', 2);
CALL updatePhrasingCache(1297);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1298, 'Current trajectories point to 3-4°C of warming by 2100 — an unrecognizable planet for our grandchildren.', 2);
CALL updatePhrasingCache(1298);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1299, 'The window to avoid the worst immediate impacts of climate change has closed — we are now managing how bad it gets, not whether it happens.', 2);
CALL updatePhrasingCache(1299);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1300, 'Every decade of delay on climate action multiplies the eventual cost — the cheapest solution was thirty years ago; the second cheapest is now.', 2);
CALL updatePhrasingCache(1300);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1383, 'Aviation is one of the highest-impact individual carbon choices — flying less is one of the most meaningful things a person can do.', 2);
CALL updatePhrasingCache(1383);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1523, 'Electrification is the path — replace every gas furnace, every combustion engine, every gas stove with electric alternatives powered by a clean grid.', 2);
CALL updatePhrasingCache(1523);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1525, 'A future run by Elon Musk — antisemitism-tolerant social media, workforce exploitation, debt-bound Mars colonists — is a dystopia, not a dream.', 2);
CALL updatePhrasingCache(1525);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1526, 'Electric cars are necessary but nowhere near sufficient — transportation is one slice of the emissions pie, and cars are one slice of transportation.', 2);
CALL updatePhrasingCache(1526);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1527, 'Moving from individual car trips to mass transit is one of the highest-impact transportation interventions available — and better urbanism too.', 2);
CALL updatePhrasingCache(1527);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1528, 'Musk\'s "transit solution" is tunnels for individual cars — that\'s not innovation, it\'s the same car dependency with higher construction costs.', 2);
CALL updatePhrasingCache(1528);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1530, 'The good Musk has done on EVs doesn\'t offset the damage he\'s done amplifying bigotry and dismantling institutional safeguards — on net, he sucks.', 2);
CALL updatePhrasingCache(1530);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1532, 'Car tunnels sized for one car per lane are the least efficient transportation infrastructure imaginable — a subway moves a hundred times the people.', 2);
CALL updatePhrasingCache(1532);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1533, 'You cannot solve urban congestion with single-occupancy vehicle tunnels — the economics and physics of capacity don\'t work.', 2);
CALL updatePhrasingCache(1533);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1534, 'Musk\'s Mars plan calls for colonists to work off their debt to SpaceX — that\'s not exploration, that\'s indentured servitude in space.', 2);
CALL updatePhrasingCache(1534);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1535, 'Every new highway generates new car traffic — adding lanes doesn\'t reduce congestion, it invites more driving. Stop building.', 2);
CALL updatePhrasingCache(1535);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1536, 'Car dependency is an infrastructure choice, not a law of nature — policy should make transit so good that car ownership becomes optional.', 2);
CALL updatePhrasingCache(1536);
