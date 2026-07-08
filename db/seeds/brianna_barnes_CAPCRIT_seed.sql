-- Brianna Barnes (profileID=2) — CAPCRIT cluster
-- 54 args: 40 accept / 14 reject
-- Overlaps from GOVTREG: 275(0✓),276(1✓),277(1✓),400(0✓),401(0✓),402(1✓),870(0✓)
-- Overlaps from WEALTH: 136(1✓),1279(1✓),1280(0✓),1281(1✓)
-- Phrasings already written for: 136,276,277,402,1279,1281 — no new phrasings for those

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (136,  2, 1),
  (224,  2, 0),
  (275,  2, 0),
  (276,  2, 1),
  (277,  2, 1),
  (400,  2, 0),
  (401,  2, 0),
  (402,  2, 1),
  (862,  2, 1),
  (870,  2, 0),
  (871,  2, 1),
  (872,  2, 1),
  (873,  2, 1),
  (874,  2, 1),
  (875,  2, 1),
  (876,  2, 1),
  (877,  2, 1),
  (878,  2, 1),
  (879,  2, 1),
  (880,  2, 1),
  (923,  2, 1),
  (924,  2, 1),
  (963,  2, 0),
  (1095, 2, 1),
  (1096, 2, 1),
  (1101, 2, 1),
  (1103, 2, 1),
  (1106, 2, 1),
  (1107, 2, 1),
  (1108, 2, 1),
  (1109, 2, 1),
  (1112, 2, 1),
  (1274, 2, 1),
  (1278, 2, 0),
  (1279, 2, 1),
  (1280, 2, 0),
  (1281, 2, 1),
  (1282, 2, 1),
  (1283, 2, 1),
  (1589, 2, 1),
  (1590, 2, 1),
  (1591, 2, 0),
  (1592, 2, 0),
  (1593, 2, 0),
  (1594, 2, 1),
  (1595, 2, 1),
  (1596, 2, 0),
  (1597, 2, 0),
  (1601, 2, 1),
  (1602, 2, 0),
  (1603, 2, 1),
  (1604, 2, 1),
  (1605, 2, 1),
  (1606, 2, 1);

-- PHRASINGS (34 new accepts; 136,276,277,402,1279,1281 already phrased)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (862, 'Every structural reform is threatening to someone who benefits from the status quo — that\'s the engine of elite resistance.', 2);
CALL updatePhrasingCache(862);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (871, 'Markets excel at providing goods people want and can pay for — that\'s genuinely impressive, and different from providing what people need.', 2);
CALL updatePhrasingCache(871);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (872, 'When the law requires corporations to maximize shareholder returns, expecting them to voluntarily serve broader social goals is wishful thinking.', 2);
CALL updatePhrasingCache(872);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (873, 'Businesses serve their owners\' goals — which is fine when those goals overlap with the public interest, and a problem when they don\'t.', 2);
CALL updatePhrasingCache(873);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (874, 'Cooperatives, nonprofits, and mission-driven enterprises prove that viable organizations don\'t have to run on profit.', 2);
CALL updatePhrasingCache(874);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (875, 'Treating corporations as purely profit-maximizing misses how much corporate activity is actually about political and social power.', 2);
CALL updatePhrasingCache(875);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (876, 'Quarterly earnings pressure drives decisions that are good for shareholders and bad for workers, communities, and the environment — that\'s structural, not moral failure.', 2);
CALL updatePhrasingCache(876);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (877, 'Many mergers are driven by managerial empire-building, not productive efficiency — and they concentrate market power while often destroying value.', 2);
CALL updatePhrasingCache(877);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (878, 'Stock-based compensation ties executive wealth to the next quarter\'s share price — that\'s why long-term thinking is structurally punished in public companies.', 2);
CALL updatePhrasingCache(878);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (879, 'Stock option compensation gives executives a personal financial stake in the short-term share price, which is often in direct conflict with the company\'s long-term health.', 2);
CALL updatePhrasingCache(879);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (880, 'A 10-year trading lockup for executive stock would align their incentives with long-term outcomes — exactly the kind of structural fix that would actually work.', 2);
CALL updatePhrasingCache(880);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (923, 'On universal healthcare, gun violence, incarceration rates, and maternal mortality — Canada is measurably doing better. That\'s not anti-American, that\'s the scorecard.', 2);
CALL updatePhrasingCache(923);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (924, 'Universal healthcare, paid parental leave, lower inequality — Canada figured out things Americans tell themselves are impossible.', 2);
CALL updatePhrasingCache(924);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1095, 'If "capitalism" means everything from predatory monopolies to worker cooperatives, it means nothing — the definition shapes the whole argument.', 2);
CALL updatePhrasingCache(1095);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1096, 'Antitrust enforcement isn\'t anti-capitalist — it\'s the maintenance required to keep capitalism from eating itself.', 2);
CALL updatePhrasingCache(1096);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1101, 'You can\'t have capitalism without competitive markets — once you have monopolies and regulatory capture, you have something else entirely.', 2);
CALL updatePhrasingCache(1101);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1103, 'Defining what "free market" actually means exposes how far most markets are from the textbook version — that\'s where the real policy conversation starts.', 2);
CALL updatePhrasingCache(1103);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1106, 'Information asymmetry is a core market failure — when one side knows something the other doesn\'t, the "free market" isn\'t actually working.', 2);
CALL updatePhrasingCache(1106);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1107, 'Universal market access is a prerequisite for market legitimacy — a market that structurally excludes whole groups of people is not a free market.', 2);
CALL updatePhrasingCache(1107);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1108, 'Freedom of exchange includes the right not to transact — that\'s one of the principles the market rests on.', 2);
CALL updatePhrasingCache(1108);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1109, 'What we call "capitalism" in the US is increasingly crony capitalism — and that corruption belongs to the system, not to capitalism\'s idealized form.', 2);
CALL updatePhrasingCache(1109);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1112, 'Conservatives who claim to support free markets should lead the charge against monopolies and lobbying — that\'s the system distorting what they say they value.', 2);
CALL updatePhrasingCache(1112);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1274, 'We can\'t reform an economic system we won\'t honestly describe — defining the ideal is where every useful economic argument has to start.', 2);
CALL updatePhrasingCache(1274);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1282, 'Corporate charters are public grants of limited liability — the public that grants them should have a meaningful stake and oversight in how they\'re used.', 2);
CALL updatePhrasingCache(1282);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1283, 'Economic risk is real and the consequences of failure are unequal — a well-designed system distributes the downside as well as the upside.', 2);
CALL updatePhrasingCache(1283);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1589, 'The direction of travel should be toward more collective ownership, more shared prosperity, and less of the economy controlled by a few private hands.', 2);
CALL updatePhrasingCache(1589);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1590, 'Collective ownership of the means of production is the defining feature of socialism — everything else labeled "socialist" is a welfare state, which is different.', 2);
CALL updatePhrasingCache(1590);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1594, 'The Scandinavian countries combine robust market economies with strong labor rights, universal services, and far less inequality — whatever you call it, it works.', 2);
CALL updatePhrasingCache(1594);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1595, 'Scandinavians describe their systems as social democratic market economies — appropriating them as "socialist" misrepresents both their system and the term.', 2);
CALL updatePhrasingCache(1595);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1601, 'In American political shorthand, "socialism" means robust social programs funded through progressive taxation — which is just what most developed democracies do.', 2);
CALL updatePhrasingCache(1601);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1603, 'Genuine competition among producers drives innovation and lower prices — the argument is for maintaining it, not removing the rules that keep it fair.', 2);
CALL updatePhrasingCache(1603);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1604, 'Price signals coordinate economic activity across millions of actors without central direction — that\'s capitalism\'s genuine technical achievement.', 2);
CALL updatePhrasingCache(1604);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1605, 'Hayek was right that distributed price information can\'t be replicated by central planning — that\'s a strong argument for markets, not an argument against regulation.', 2);
CALL updatePhrasingCache(1605);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1606, 'Capitalism created real prosperity and caused genuine destruction — both are true, and ignoring either one produces bad analysis.', 2);
CALL updatePhrasingCache(1606);
