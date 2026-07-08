-- Brianna Barnes (profileID=2) — ABORT cluster
-- 23 args: 16 accept / 7 reject

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (124,  2, 0),
  (125,  2, 0),
  (126,  2, 1),
  (127,  2, 1),
  (128,  2, 1),
  (129,  2, 1),
  (313,  2, 0),
  (314,  2, 0),
  (902,  2, 0),
  (903,  2, 1),
  (908,  2, 1),
  (964,  2, 1),
  (965,  2, 1),
  (966,  2, 1),
  (973,  2, 1),
  (974,  2, 1),
  (975,  2, 1),
  (976,  2, 0),
  (977,  2, 1),
  (997,  2, 1),
  (998,  2, 1),
  (999,  2, 1),
  (1387, 2, 0);

-- PHRASINGS (16 accepts)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (126, 'Some limits on late-term abortion are reasonable — but restrictions before viability are government overreach into the most personal medical decisions.', 2);
CALL updatePhrasingCache(126);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (127, 'You can\'t fully protect a fetus without controlling the woman carrying it — that\'s the tradeoff the pro-life movement refuses to name.', 2);
CALL updatePhrasingCache(127);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (128, 'Restricting abortion access is cruel — and Black women, who already die in childbirth at three times the rate of white women, bear that cruelty the hardest.', 2);
CALL updatePhrasingCache(128);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (129, 'A pregnancy isn\'t a punishment — and treating it as one is no way to build a society that actually values children.', 2);
CALL updatePhrasingCache(129);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (903, 'Legal personhood begins at live birth — that\'s been the recognized standard, and it\'s the right one.', 2);
CALL updatePhrasingCache(903);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (908, 'Viability is the most defensible legal standard — before that point, the woman\'s bodily autonomy governs.', 2);
CALL updatePhrasingCache(908);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (964, 'Contraception and abortion are not optional features of modern life — they are the infrastructure of women\'s equality.', 2);
CALL updatePhrasingCache(964);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (965, 'Abstinence as a birth control strategy doesn\'t work — and insisting on it anyway isn\'t moral guidance, it\'s willful ignorance.', 2);
CALL updatePhrasingCache(965);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (966, 'Abstinence-only sex ed fails children — especially girls — and keeping them ignorant doesn\'t protect them, it endangers them.', 2);
CALL updatePhrasingCache(966);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (973, 'Abortion bans don\'t end pregnancies — they end legal, safe ones, while adding more children to families already in poverty.', 2);
CALL updatePhrasingCache(973);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (974, 'Restrictions on abortion access don\'t just control bodies — they compound poverty, and the data on that is consistent.', 2);
CALL updatePhrasingCache(974);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (975, 'The movement spent decades pursuing criminal penalties for women and ignored support for mothers and children — that tells you what it\'s actually about.', 2);
CALL updatePhrasingCache(975);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (977, '\'Pro-life\' ends at birth — cut the maternal healthcare, the childcare, the food assistance, and then call it pro-life.', 2);
CALL updatePhrasingCache(977);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (997, 'Women don\'t need shame from politicians — they need healthcare, support, and the right to make their own decisions.', 2);
CALL updatePhrasingCache(997);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (998, 'A movement that controls women\'s bodies, judges their choices, and offers no support after birth is not pro-life — it\'s misogyny with religious dressing.', 2);
CALL updatePhrasingCache(998);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (999, 'Abortion restrictions target women and ignore men — if the goal were reducing unwanted pregnancies, the law would go after both.', 2);
CALL updatePhrasingCache(999);
