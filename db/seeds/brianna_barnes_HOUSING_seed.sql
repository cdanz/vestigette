-- Brianna Barnes (profileID=2) — HOUSING cluster
-- 105 args: 92 accept / 13 reject

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (413,  2, 1),
  (430,  2, 0),
  (431,  2, 1),
  (432,  2, 1),
  (436,  2, 1),
  (437,  2, 1),
  (438,  2, 1),
  (444,  2, 1),
  (453,  2, 1),
  (471,  2, 1),
  (472,  2, 1),
  (473,  2, 1),
  (520,  2, 1),
  (572,  2, 1),
  (573,  2, 1),
  (682,  2, 1),
  (683,  2, 1),
  (684,  2, 1),
  (685,  2, 1),
  (690,  2, 1),
  (691,  2, 1),
  (692,  2, 1),
  (693,  2, 1),
  (694,  2, 1),
  (695,  2, 1),
  (703,  2, 1),
  (709,  2, 0),
  (710,  2, 1),
  (711,  2, 0),
  (712,  2, 0),
  (713,  2, 0),
  (714,  2, 0),
  (715,  2, 1),
  (716,  2, 1),
  (717,  2, 1),
  (718,  2, 1),
  (719,  2, 1),
  (720,  2, 1),
  (721,  2, 1),
  (722,  2, 1),
  (723,  2, 0),
  (726,  2, 1),
  (733,  2, 1),
  (736,  2, 1),
  (737,  2, 1),
  (739,  2, 1),
  (740,  2, 1),
  (741,  2, 1),
  (836,  2, 1),
  (1012, 2, 1),
  (1141, 2, 1),
  (1142, 2, 1),
  (1143, 2, 1),
  (1144, 2, 1),
  (1145, 2, 1),
  (1251, 2, 1),
  (1252, 2, 1),
  (1253, 2, 1),
  (1254, 2, 1),
  (1255, 2, 1),
  (1256, 2, 1),
  (1257, 2, 1),
  (1258, 2, 0),
  (1259, 2, 1),
  (1260, 2, 1),
  (1261, 2, 0),
  (1262, 2, 1),
  (1263, 2, 1),
  (1264, 2, 1),
  (1265, 2, 0),
  (1266, 2, 1),
  (1267, 2, 1),
  (1268, 2, 1),
  (1269, 2, 1),
  (1273, 2, 1),
  (1352, 2, 1),
  (1353, 2, 1),
  (1354, 2, 1),
  (1355, 2, 1),
  (1545, 2, 1),
  (1546, 2, 1),
  (1547, 2, 1),
  (1548, 2, 1),
  (1549, 2, 1),
  (1550, 2, 1),
  (1551, 2, 1),
  (1552, 2, 1),
  (1553, 2, 1),
  (1554, 2, 1),
  (1555, 2, 1),
  (1556, 2, 1),
  (1557, 2, 1),
  (1558, 2, 1),
  (1559, 2, 1),
  (1560, 2, 1),
  (1561, 2, 1),
  (1568, 2, 0),
  (1569, 2, 0),
  (1570, 2, 1),
  (1571, 2, 1),
  (1572, 2, 0),
  (1573, 2, 1),
  (1574, 2, 1),
  (1575, 2, 1),
  (1576, 2, 1);

-- PHRASINGS (92 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (413, 'The pandemic proved public schools are chronically underfunded — they couldn\'t afford ventilation upgrades or substitute teachers when lives depended on it.', 2);
CALL updatePhrasingCache(413);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (431, 'Bikes don\'t cause measurable road wear — a tax on cyclists to fund road repairs they didn\'t cause is just wrong.', 2);
CALL updatePhrasingCache(431);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (432, 'Subsidize bike infrastructure and fewer people drive — the road math is overwhelmingly in bikes\' favor.', 2);
CALL updatePhrasingCache(432);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (436, 'Road damage scales with the fourth power of axle weight — the math on who actually destroys pavement is not subtle.', 2);
CALL updatePhrasingCache(436);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (437, 'One Hummer does the same road damage as over 360,000 bike trips — the idea that cyclists should fund road repairs is absurd on the data.', 2);
CALL updatePhrasingCache(437);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (438, 'Axle weight to the fourth power determines road damage — bikes are functionally weightless in that calculation.', 2);
CALL updatePhrasingCache(438);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (444, 'Rural areas tend to run more conservative — that\'s a reliable data point about how geography and economic structure shape politics.', 2);
CALL updatePhrasingCache(444);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (453, 'Every car trip replaced by a bike trip saves road maintenance money — bikes cause negligible pavement wear.', 2);
CALL updatePhrasingCache(453);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (471, 'Reclaiming road space for bikes and pedestrians where the math supports it is good urban planning — not a war on drivers.', 2);
CALL updatePhrasingCache(471);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (472, 'Pike Place Market would work better without through-traffic — close it to private vehicles, keep delivery access, and the experience improves for thousands.', 2);
CALL updatePhrasingCache(472);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (473, 'The Pike Place road crawls at pedestrian pace and consumes public space for minimal transport value — it serves almost no one well.', 2);
CALL updatePhrasingCache(473);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (520, 'Trained reporters with editorial accountability beat unfiltered content on accuracy and depth — professional journalism has real flaws and real value.', 2);
CALL updatePhrasingCache(520);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (572, 'The hard part of lidding I-5 isn\'t the vote to do it — it\'s the design, contracting, and construction where public projects succeed or fail.', 2);
CALL updatePhrasingCache(572);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (573, 'Lidding I-5 would reconnect severed neighborhoods, reduce noise and pollution, and create acres of usable public space — ambitious, expensive, and worth doing.', 2);
CALL updatePhrasingCache(573);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (682, 'People are dying on Seattle\'s streets — if you wouldn\'t accept this level of crisis in any other public domain, you shouldn\'t accept it here.', 2);
CALL updatePhrasingCache(682);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (683, 'Making life harder for people sleeping outside isn\'t a policy — it\'s cruelty disguised as one.', 2);
CALL updatePhrasingCache(683);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (684, 'Sweeping encampments without providing somewhere to go just moves suffering down the block — that\'s not a solution.', 2);
CALL updatePhrasingCache(684);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (685, 'Until there\'s enough shelter, portable toilets and trash pickup at encampments are basic harm reduction — you don\'t solve a crisis by making it dirtier.', 2);
CALL updatePhrasingCache(685);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (690, 'Sanitation without shelter is managing a crisis that should be ending — you can\'t stop at the minimum when the minimum isn\'t enough.', 2);
CALL updatePhrasingCache(690);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (691, 'Encampments expand when left unmanaged — that\'s the argument for moving faster on shelter, not for tolerating indefinite growth of improvised camps.', 2);
CALL updatePhrasingCache(691);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (692, 'No one should be sleeping outside — get people out of the elements first, then build the structures that keep them from coming back.', 2);
CALL updatePhrasingCache(692);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (693, 'A sanctioned camp with services is better than a chaos camp with nothing — managing the transition to shelter matters.', 2);
CALL updatePhrasingCache(693);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (694, 'King County has repeatedly failed to move people from emergency shelter to permanent housing at real scale — the political will and follow-through have been intermittent at best.', 2);
CALL updatePhrasingCache(694);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (695, 'The people with the power to fix homelessness don\'t live next to it — that gap between decision-makers and consequences is why the crisis persists.', 2);
CALL updatePhrasingCache(695);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (703, 'Micro-shelter villages are faster than waiting years for permanent housing — when people are sleeping outside, the fastest dignified option is the right one.', 2);
CALL updatePhrasingCache(703);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (710, 'Homelessness at this scale demands deliberate intervention — resources, accountability, and clear metrics, not indefinite tolerance.', 2);
CALL updatePhrasingCache(710);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (715, 'Most of Seattle\'s homeless have local roots — the magnet narrative is factually wrong and a convenient way to avoid responsibility for the crisis.', 2);
CALL updatePhrasingCache(715);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (716, 'Telling unhoused people to move somewhere cheaper ignores the family ties that anchor them — that\'s not a policy, it\'s indifference dressed up as advice.', 2);
CALL updatePhrasingCache(716);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (717, 'Many of Seattle\'s homeless are still working — gig economy, service jobs, construction — but can\'t afford housing on what the market pays them.', 2);
CALL updatePhrasingCache(717);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (718, 'If resources have been genuinely stretched and the crisis persists, additional funding is warranted — this costs more untreated than treated.', 2);
CALL updatePhrasingCache(718);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (719, 'Seattle hasn\'t run out of space — it\'s run out of zoning flexibility; the land is there, the political will to use it isn\'t.', 2);
CALL updatePhrasingCache(719);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (720, 'Seventy percent of Seattle\'s residential land is locked in single-family zoning — you cannot build out of a housing crisis with most of the city legally off-limits to additional households.', 2);
CALL updatePhrasingCache(720);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (721, 'A city that prices out nurses, teachers, and bus drivers stops being a functional city — urban density is only valuable when it\'s inclusive.', 2);
CALL updatePhrasingCache(721);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (722, 'Duplexes, triplexes, and mid-rise apartments should be the baseline everywhere, not the exception that requires a variance.', 2);
CALL updatePhrasingCache(722);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (726, 'You need an address to apply for jobs — that barrier alone makes escaping homelessness significantly harder than housed people understand.', 2);
CALL updatePhrasingCache(726);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (733, 'Heavy trucks are the main culprit for road degradation — bikes barely register, and pretending otherwise is just bad math.', 2);
CALL updatePhrasingCache(733);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (736, 'More housing units put downward pressure on rents — prices keep climbing because supply hasn\'t kept pace with demand.', 2);
CALL updatePhrasingCache(736);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (737, 'Loosen the zoning so developers have to compete, and the market eventually provides options at every price point — not quickly, but reliably.', 2);
CALL updatePhrasingCache(737);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (739, 'More units of any type add to the housing stock and soften prices over time — it works imperfectly and slowly, but that\'s how supply dynamics function.', 2);
CALL updatePhrasingCache(739);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (740, 'Luxury buildings draw high earners out of older stock, which filters down to middle-income renters — imperfect but directionally real.', 2);
CALL updatePhrasingCache(740);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (741, 'Gentrification replaces affordable units with premium ones — even if total unit count holds, the mix shifts against lower-income residents and the volume argument has to account for that.', 2);
CALL updatePhrasingCache(741);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (836, 'Home prices that exclude working people are unacceptable — a city only the wealthy can afford to stay in is failing both economically and socially.', 2);
CALL updatePhrasingCache(836);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1012, 'Seattle\'s desirability is exactly what makes its housing crisis so urgent — high demand without adequate supply produces exactly what we\'re seeing.', 2);
CALL updatePhrasingCache(1012);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1141, 'Concentrated urban living is more efficient per capita on almost every metric — smart growth policy should make cities more appealing, not less.', 2);
CALL updatePhrasingCache(1141);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1142, 'If you want to live in the city, you should be able to — that requires supply at enough price points that it isn\'t reserved for those who got there first.', 2);
CALL updatePhrasingCache(1142);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1143, 'Affordable housing is infrastructure — a city that prices out nurses, teachers, and construction workers has a serious functional problem.', 2);
CALL updatePhrasingCache(1143);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1144, 'Every unit built in dense urban areas is several acres of suburban sprawl that didn\'t have to happen — cities absorbing growth protects open land.', 2);
CALL updatePhrasingCache(1144);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1145, 'NIMBYism isn\'t stewardship — if you live in a city, change is part of the deal.', 2);
CALL updatePhrasingCache(1145);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1251, 'Denser cities function more efficiently — more people sharing infrastructure is how cities create value; sprawl undermines that logic.', 2);
CALL updatePhrasingCache(1251);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1252, 'Single-family-only zoning is the main legal instrument of the housing shortage — the answer starts on the zoning map.', 2);
CALL updatePhrasingCache(1252);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1253, 'Most of Seattle should be upzoned — not to highrises, but to gentle density: duplexes, ADUs, and small apartment buildings.', 2);
CALL updatePhrasingCache(1253);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1254, 'Parks and open plazas aren\'t luxuries — density works better when people have space to breathe, and that space belongs in the plan.', 2);
CALL updatePhrasingCache(1254);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1255, 'A triplex barely changes the streetscape but allows three households where one was allowed before — meaningful progress with minimal disruption.', 2);
CALL updatePhrasingCache(1255);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1256, 'There\'s an optimum for density — good planning finds it rather than treating maximum density as the only goal.', 2);
CALL updatePhrasingCache(1256);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1257, 'Dense cities done well have better parks, walkable streets, and local businesses — density is enjoyable when it\'s designed intentionally.', 2);
CALL updatePhrasingCache(1257);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1259, 'Growing up insulated from different people and ideas isn\'t protection — it\'s a disadvantage dressed up as one.', 2);
CALL updatePhrasingCache(1259);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1260, 'Hong Kong and Taipei show that dense urban environments can be highly livable — density isn\'t the enemy of quality of life when it\'s designed well.', 2);
CALL updatePhrasingCache(1260);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1262, 'Density should follow a gradient — denser near transit and commercial centers, stepping down outward — uniform density from edge to center is badly designed.', 2);
CALL updatePhrasingCache(1262);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1263, 'Rural students face fewer AP courses, less test prep, and less college counseling — that\'s a structural gap, not a talent gap.', 2);
CALL updatePhrasingCache(1263);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1264, 'Requiring proportional rural/urban college enrollment aligns admissions with where people actually live — a reasonable equity measure.', 2);
CALL updatePhrasingCache(1264);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1266, 'Representation programs should target groups with documented structural disadvantage — evidence-based and focused, not just categorical.', 2);
CALL updatePhrasingCache(1266);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1267, 'Pure meritocracy doesn\'t exist, but aiming for it — rewarding demonstrated performance — is still worth the effort.', 2);
CALL updatePhrasingCache(1267);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1268, 'Rural workers earn less for comparable work than urban counterparts — a structural gap driven by thinner labor markets, not productivity.', 2);
CALL updatePhrasingCache(1268);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1269, 'Poverty doesn\'t respect the rural/urban divide — treating them as opposites obscures where need actually is.', 2);
CALL updatePhrasingCache(1269);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1273, 'The government should commit to eliminating homelessness — whatever resources that takes, the cost of not doing it is higher.', 2);
CALL updatePhrasingCache(1273);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1352, 'Parking minimums force buildings to include more parking than the market wants, raising construction costs and consuming land — let the market set the amount.', 2);
CALL updatePhrasingCache(1352);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1353, 'Free parking isn\'t free — someone else pays the subsidy, and that subsidy shapes development patterns across the whole city.', 2);
CALL updatePhrasingCache(1353);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1354, 'Car ownership should be disincentivized in cities — the costs imposed on everyone else are real and rarely borne by drivers.', 2);
CALL updatePhrasingCache(1354);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1355, 'Mass transit works when ridership is there — encourage it with good service and fair fares, not by punishing people for driving.', 2);
CALL updatePhrasingCache(1355);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1545, 'Liberal cities that claim to value affordability need to prove it through zoning decisions — that\'s where the commitment shows or doesn\'t.', 2);
CALL updatePhrasingCache(1545);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1546, 'The housing crisis is a supply problem — build more housing; restricting it or regulating it into unaffordability makes the crisis worse.', 2);
CALL updatePhrasingCache(1546);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1547, '\'Neighborhood character\' as an objection to new buildings usually means not wanting more people nearby — that\'s not planning, that\'s exclusion.', 2);
CALL updatePhrasingCache(1547);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1548, 'Upzoning is a zoning map change — every city claiming it can\'t fix its housing crisis while maintaining exclusionary zoning is choosing the problem.', 2);
CALL updatePhrasingCache(1548);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1549, 'Some building code requirements add cost without proportional safety benefit and exist to protect incumbent housing values — that\'s not what codes are for.', 2);
CALL updatePhrasingCache(1549);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1550, 'A city claiming to be progressive while using zoning to price out low-income residents isn\'t being progressive — the proof is in the permits.', 2);
CALL updatePhrasingCache(1550);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1551, 'Restricting development to manage affordability produces the opposite — more supply, even market-rate, moderates prices over time.', 2);
CALL updatePhrasingCache(1551);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1552, 'Communities deserve real input on how they develop — not an unlimited veto, but genuine voice on character and pace of change.', 2);
CALL updatePhrasingCache(1552);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1553, 'The people who actually live in a community should carry more weight than developers who want to commoditize it.', 2);
CALL updatePhrasingCache(1553);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1554, 'Some modern building requirements have become excessive and contribute directly to unaffordability — acknowledging that isn\'t anti-safety, it\'s honest.', 2);
CALL updatePhrasingCache(1554);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1555, 'Manufactured homes cost less and deploy faster than site-built housing — dismissing them while claiming to address the crisis is incoherent.', 2);
CALL updatePhrasingCache(1555);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1556, 'Development decisions are made by an oligarchy of developers and wealthy landowners — residents need structural power in the process, not just public comment.', 2);
CALL updatePhrasingCache(1556);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1557, 'Low-density sprawl consumes enormous land, requires car ownership for everything, and is expensive to serve — pull growth back toward urban areas where it works.', 2);
CALL updatePhrasingCache(1557);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1558, 'Every urban resident is a person not clearing trees for a subdivision — if you want to protect open land, density is the strategy.', 2);
CALL updatePhrasingCache(1558);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1559, 'A million people in a city occupy far less land than dispersed across suburbs — concentrated settlement is one of our most effective conservation tools.', 2);
CALL updatePhrasingCache(1559);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1560, 'A homeowner on city council setting density policy has a direct financial conflict of interest — their home value goes up when scarcity persists.', 2);
CALL updatePhrasingCache(1560);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1561, 'You won\'t fix the housing crisis with decision-makers whose net worth is tied to home equity — their interest is in scarcity, not solutions.', 2);
CALL updatePhrasingCache(1561);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1570, 'Induced demand is real — build a freeway lane and traffic fills it; build more parking and more cars appear; the supply doesn\'t solve the problem, it grows it.', 2);
CALL updatePhrasingCache(1570);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1571, 'Parking minimums don\'t fix on-street shortages — they produce off-street parking that eats building footprints, raises rents, and puts more cars on the street.', 2);
CALL updatePhrasingCache(1571);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1573, 'Non-drivers subsidize car infrastructure in their rent — parking minimums require buildings to include parking people won\'t use, and that cost gets passed on.', 2);
CALL updatePhrasingCache(1573);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1574, 'Walkable commercial districts perform better economically than car-oriented ones — pedestrians make more spontaneous stops and generate more street life.', 2);
CALL updatePhrasingCache(1574);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1575, 'Roads, parking lots, and garages consume 30 to 50 percent of urban land — car infrastructure is our most expensive and most underquestioned land use.', 2);
CALL updatePhrasingCache(1575);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1576, 'Every acre of surface parking is an acre that could be housing or parks — the car\'s claim on urban land has a real cost to everything else.', 2);
CALL updatePhrasingCache(1576);
