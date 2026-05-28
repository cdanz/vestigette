-- Brianna Barnes (profileID=2) — CANCEL cluster
-- 113 args: 80 accept / 33 reject
-- Overlap: 759,760,761,763,764,765,766,767,768,771 already in DB from BLM (all match)
-- Note: 763,766,767,768 phrasings already written in BLM — no new phrasings here

INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (65,   2, 1),
  (278,  2, 1),
  (279,  2, 1),
  (280,  2, 1),
  (281,  2, 1),
  (282,  2, 1),
  (283,  2, 1),
  (284,  2, 1),
  (285,  2, 1),
  (286,  2, 1),
  (287,  2, 1),
  (288,  2, 0),
  (289,  2, 0),
  (290,  2, 0),
  (291,  2, 0),
  (292,  2, 0),
  (293,  2, 1),
  (294,  2, 1),
  (295,  2, 1),
  (296,  2, 1),
  (297,  2, 0),
  (298,  2, 1),
  (299,  2, 1),
  (300,  2, 1),
  (301,  2, 1),
  (302,  2, 1),
  (303,  2, 1),
  (304,  2, 1),
  (305,  2, 1),
  (306,  2, 1),
  (307,  2, 1),
  (308,  2, 1),
  (309,  2, 1),
  (310,  2, 1),
  (311,  2, 1),
  (312,  2, 1),
  (420,  2, 1),
  (421,  2, 1),
  (422,  2, 1),
  (540,  2, 1),
  (541,  2, 1),
  (587,  2, 1),
  (588,  2, 1),
  (589,  2, 0),
  (590,  2, 1),
  (591,  2, 1),
  (592,  2, 1),
  (593,  2, 1),
  (595,  2, 0),
  (596,  2, 0),
  (597,  2, 1),
  (599,  2, 0),
  (600,  2, 0),
  (635,  2, 1),
  (636,  2, 1),
  (637,  2, 1),
  (642,  2, 0),
  (643,  2, 0),
  (645,  2, 1),
  (646,  2, 0),
  (647,  2, 1),
  (648,  2, 1),
  (649,  2, 1),
  (650,  2, 1),
  (651,  2, 0),
  (652,  2, 0),
  (653,  2, 1),
  (654,  2, 1),
  (655,  2, 1),
  (656,  2, 1),
  (657,  2, 0),
  (658,  2, 0),
  (659,  2, 0),
  (660,  2, 1),
  (661,  2, 1),
  (662,  2, 1),
  (663,  2, 0),
  (664,  2, 1),
  (665,  2, 0),
  (673,  2, 1),
  (749,  2, 1),
  (750,  2, 1),
  (751,  2, 1),
  (752,  2, 1),
  (753,  2, 0),
  (754,  2, 1),
  (755,  2, 1),
  (756,  2, 1),
  (759,  2, 0),
  (760,  2, 0),
  (761,  2, 0),
  (763,  2, 1),
  (764,  2, 0),
  (765,  2, 0),
  (766,  2, 1),
  (767,  2, 1),
  (768,  2, 1),
  (771,  2, 0),
  (1430, 2, 1),
  (1431, 2, 0),
  (1432, 2, 1),
  (1562, 2, 0),
  (1563, 2, 1),
  (1564, 2, 1),
  (1565, 2, 1),
  (1566, 2, 1),
  (1567, 2, 1),
  (1577, 2, 1),
  (1578, 2, 1),
  (1579, 2, 1),
  (1580, 2, 0),
  (1581, 2, 0),
  (1582, 2, 0);

-- PHRASINGS (76 new accepts; 763,766,767,768 already phrased in BLM)

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (65, 'Argue against what someone actually said — not a caricature of it, not what it implies about their character.', 2);
CALL updatePhrasingCache(65);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (278, 'Harassment based on who you love is not a political position — it is just cruelty.', 2);
CALL updatePhrasingCache(278);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (279, 'Targeting someone for harassment because of their race is bigotry, period.', 2);
CALL updatePhrasingCache(279);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (280, 'No one\'s gender makes them a valid target for harassment or attack.', 2);
CALL updatePhrasingCache(280);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (281, 'Where you were born does not make you a legitimate target for harassment.', 2);
CALL updatePhrasingCache(281);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (282, 'Criticizing religious ideas is fair; attacking people for having faith is not.', 2);
CALL updatePhrasingCache(282);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (283, 'Putting God\'s name on a position doesn\'t put it beyond question.', 2);
CALL updatePhrasingCache(283);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (284, 'Political views deserve debate, not harassment or threats.', 2);
CALL updatePhrasingCache(284);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (285, 'Criticism of an idea is legitimate — targeting a person for harassment is not.', 2);
CALL updatePhrasingCache(285);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (286, 'The more power a belief system claims over others, the more scrutiny it deserves.', 2);
CALL updatePhrasingCache(286);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (287, 'Everything is political — the people who say it isn\'t usually benefit from you believing that.', 2);
CALL updatePhrasingCache(287);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (293, 'If "cancel culture" means facing consequences for what you say — that\'s just speech working.', 2);
CALL updatePhrasingCache(293);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (294, 'A term that means everything means nothing — "cancel culture" has been stretched past any useful definition.', 2);
CALL updatePhrasingCache(294);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (295, 'Calling every accountability moment "cancel culture" is how you shut down legitimate criticism.', 2);
CALL updatePhrasingCache(295);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (296, 'Rallying to defend every "canceled" person launders some genuinely indefensible positions.', 2);
CALL updatePhrasingCache(296);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (298, 'Cancel culture is social ostracism with a Twitter account — old behavior, new name.', 2);
CALL updatePhrasingCache(298);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (299, 'Some people have said harmful things for years without consequence — accountability is not a crisis.', 2);
CALL updatePhrasingCache(299);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (300, 'If your standing falls because people won\'t accept your views, that\'s social consequence, not censorship.', 2);
CALL updatePhrasingCache(300);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (301, 'A reduced platform is not the same as silencing — you can still speak, just to fewer people.', 2);
CALL updatePhrasingCache(301);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (302, 'Calling it "cancel culture" is often just a way to avoid engaging with the actual criticism.', 2);
CALL updatePhrasingCache(302);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (303, 'Shared definitions aren\'t constraints — they\'re the minimum required for actual conversation.', 2);
CALL updatePhrasingCache(303);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (304, 'Language is living — meaning shifts with context and who\'s using it.', 2);
CALL updatePhrasingCache(304);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (305, 'Shock value is not a reason to amplify something — provocation without substance doesn\'t earn a megaphone.', 2);
CALL updatePhrasingCache(305);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (306, 'Inflammatory speech grabs attention — that\'s not an argument for its value, it\'s an argument for skepticism of what\'s trending.', 2);
CALL updatePhrasingCache(306);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (307, 'Engagement-maximizing algorithms reward outrage because outrage is addictive — that\'s a design choice, not a natural law.', 2);
CALL updatePhrasingCache(307);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (308, 'Having a large platform does not make your cruelty protected — some voices deserve to be smaller.', 2);
CALL updatePhrasingCache(308);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (309, 'How many people clicked does not tell you whether something was worth saying.', 2);
CALL updatePhrasingCache(309);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (310, 'The most viral content is often the most harmful — engagement metrics are doing real damage.', 2);
CALL updatePhrasingCache(310);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (311, 'If you misrepresent someone and they push back, that\'s not harassment — that\'s accountability.', 2);
CALL updatePhrasingCache(311);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (312, 'Being argued against accurately is the minimum anyone owes anyone in a debate.', 2);
CALL updatePhrasingCache(312);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (420, 'The First Amendment is not a license for deliberate psychological manipulation — expression and coercion are different things.', 2);
CALL updatePhrasingCache(420);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (421, 'Monetizing a false claim crosses from expression to fraud — commercial speech has never been fully protected.', 2);
CALL updatePhrasingCache(421);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (422, 'Free speech was never absolute — the line has always been direct harm to others.', 2);
CALL updatePhrasingCache(422);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (540, 'The answer to bad information is better information, not a lock on the vault.', 2);
CALL updatePhrasingCache(540);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (541, 'Banning a book doesn\'t destroy the idea — it just guarantees you never have to argue against it.', 2);
CALL updatePhrasingCache(541);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (587, 'Social media turns collective judgment into a mob mechanism — the excesses aren\'t a glitch, they\'re a feature.', 2);
CALL updatePhrasingCache(587);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (588, 'Social media puts public accountability in more hands than ever — that\'s not entirely a bad thing.', 2);
CALL updatePhrasingCache(588);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (590, 'Your Twitter feed is not public opinion — it\'s your own beliefs in a mirror.', 2);
CALL updatePhrasingCache(590);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (591, 'Before concluding that the critics are out of step, ask whether you might be.', 2);
CALL updatePhrasingCache(591);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (592, 'Common sense isn\'t common — everyone assumes they have it and half of them are wrong.', 2);
CALL updatePhrasingCache(592);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (593, 'Confident hot takes on situations you don\'t understand are still wrong — just louder.', 2);
CALL updatePhrasingCache(593);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (597, 'Speech that directly causes panic or harm has always had limits — the absolutists pretend otherwise.', 2);
CALL updatePhrasingCache(597);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (635, 'Until we define what actually constitutes "canceling," the term will keep being weaponized against legitimate criticism.', 2);
CALL updatePhrasingCache(635);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (636, 'Yes, some people have lost jobs over things that didn\'t warrant it — worth taking seriously without pretending it\'s an epidemic.', 2);
CALL updatePhrasingCache(636);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (637, 'Losing Twitter followers is not being canceled — the bar should be actual professional destruction.', 2);
CALL updatePhrasingCache(637);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (645, 'A work is canceled when consuming it becomes culturally radioactive — not when someone on Twitter criticizes it.', 2);
CALL updatePhrasingCache(645);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (647, 'The Seuss estate chose to stop publishing six books it judged offensive — a private business decision, not censorship.', 2);
CALL updatePhrasingCache(647);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (648, 'The imagery in those six books — caricatured Asians, stereotyped Africans — was racist. That\'s not a close call.', 2);
CALL updatePhrasingCache(648);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (649, 'Golliwog imagery doesn\'t belong in new editions — it belongs in a museum exhibit about what not to do.', 2);
CALL updatePhrasingCache(649);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (650, 'A children\'s rhyme caricaturing Asian eyes is offensive — that\'s not a difficult assessment.', 2);
CALL updatePhrasingCache(650);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (653, 'Burning books is an attempt to erase — that\'s why it\'s historically associated with authoritarian regimes.', 2);
CALL updatePhrasingCache(653);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (654, 'A business choosing not to sell something is not censorship — no one has a right to a publisher.', 2);
CALL updatePhrasingCache(654);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (655, 'Seuss has 60 books still in print and outsold every other children\'s author in 2021 — he was not canceled.', 2);
CALL updatePhrasingCache(655);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (656, 'The Dr. Seuss discourse was a right-wing distraction from actual policy debates — and it worked on most of the media.', 2);
CALL updatePhrasingCache(656);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (660, 'Organizing for a more just society is not pathological — it\'s one of the better uses of a person\'s time.', 2);
CALL updatePhrasingCache(660);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (661, 'Progress toward a kinder world requires believing one is possible — that\'s not naivety, it\'s necessary.', 2);
CALL updatePhrasingCache(661);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (662, 'Updating a legacy to remove imagery that demeans children is responsible stewardship, not censorship.', 2);
CALL updatePhrasingCache(662);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (664, 'Nobody was reading "The Cat\'s Quizzer" — the books removed were not beloved classics.', 2);
CALL updatePhrasingCache(664);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (673, 'Seuss still has 60 books in print — treating the removal of six as a cultural catastrophe is theater.', 2);
CALL updatePhrasingCache(673);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (749, 'Country radio blacklisted the Chicks for criticizing the Iraq War — that was the establishment canceling dissent, not the left.', 2);
CALL updatePhrasingCache(749);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (750, 'The NFL boycott was a conservative response to Kaepernick\'s protest — that\'s cancel culture from the right, which the moral panic conveniently ignores.', 2);
CALL updatePhrasingCache(750);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (751, 'NASCAR fans threatened boycotts over banning the Confederate flag — cancellation goes both ways, but only one direction gets the moral panic.', 2);
CALL updatePhrasingCache(751);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (752, 'Confederate flag fans calling a NASCAR ban "oppression" were practicing their own version of cancel culture.', 2);
CALL updatePhrasingCache(752);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (754, 'FAIR drapes anti-woke politics in civil-liberties language — the tolerance branding is cover for protecting the status quo.', 2);
CALL updatePhrasingCache(754);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (755, 'The most-booked speakers on the right are still selling out auditoriums — nobody is silencing them.', 2);
CALL updatePhrasingCache(755);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (756, 'Crying "cancel culture" is often just lobbying to be insulated from criticism — working the refs, not defending free speech.', 2);
CALL updatePhrasingCache(756);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1430, 'Using your platform to mock people with less power than you isn\'t edgy — it\'s just mean.', 2);
CALL updatePhrasingCache(1430);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1432, 'Punching down isn\'t comedy — it\'s bullying with a punchline.', 2);
CALL updatePhrasingCache(1432);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1563, 'Being "woke" means being aware of how systems of oppression work — there is nothing wrong with that.', 2);
CALL updatePhrasingCache(1563);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1564, '"Woke" has been stretched so far by bad-faith critics that it now means whatever they want to attack.', 2);
CALL updatePhrasingCache(1564);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1565, '"Stay woke" came out of Black communities trying to survive — its appropriation by critics erases that history.', 2);
CALL updatePhrasingCache(1565);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1566, 'The words Black communities use to describe our reality weren\'t created for white people to dilute and mock.', 2);
CALL updatePhrasingCache(1566);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1567, 'You can borrow "woke" but you can\'t borrow what it means to need that awareness to stay alive.', 2);
CALL updatePhrasingCache(1567);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1577, 'Bad tactics don\'t invalidate a righteous cause, but they do give ammunition to people looking for an excuse to oppose it.', 2);
CALL updatePhrasingCache(1577);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1578, 'Real cancellation — career destruction disproportionate to offense — happens, but it\'s rarer than the panic suggests.', 2);
CALL updatePhrasingCache(1578);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES (1579, 'If you want to protect workers from being fired over speech, fight for just-cause employment reform — that\'s the actual fix.', 2);
CALL updatePhrasingCache(1579);
