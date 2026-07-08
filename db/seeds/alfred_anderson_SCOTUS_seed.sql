-- alfred_anderson_SCOTUS_seed.sql
-- Alfred Anderson (profileID=1) — SCOTUS: 8 acc, 5 rej

START TRANSACTION;

DELETE FROM ENDORSEMENT WHERE profileID=1 AND targArgID IN (1443,1444,1445,1446,1447,1448,1449,1450,1451,1452,1453,1454,1455);

CALL assertOpinion(1, 1443, 1);
CALL assertOpinion(1, 1444, 1);
CALL assertOpinion(1, 1445, 1);
CALL assertOpinion(1, 1446, 1);
CALL assertOpinion(-1, 1447, 1);
CALL assertOpinion(-1, 1448, 1);
CALL assertOpinion(1, 1449, 1);
CALL assertOpinion(1, 1450, 1);
CALL assertOpinion(1, 1451, 1);
CALL assertOpinion(-1, 1452, 1);
CALL assertOpinion(-1, 1453, 1);
CALL assertOpinion(1, 1454, 1);
CALL assertOpinion(-1, 1455, 1);

CALL newPutForth(1443, 1, 'Justice should be blind — the same law applied the same way to everyone, regardless of who\'s in power. A court that departs from that principle isn\'t a court anymore. It\'s an enforcement arm for whoever controls it.');
CALL newPutForth(1444, 1, 'When people stop trusting that courts can reach impartial decisions, they stop using the courts — and start using other means. Judicial legitimacy is the load-bearing wall of civic order. You weaken it at everyone\'s peril.');
CALL newPutForth(1449, 1, 'I know the Garland-Ginsburg episodes look bad. They are bad — both sides played politics with seats that shouldn\'t be political. The answer to that isn\'t packing the court and making it explicitly political. The answer is less of this.');
CALL newPutForth(1450, 1, 'Expanding the Supreme Court through partisan legislation would politicize it beyond repair. If you can add four seats when you have the Senate, your opponents can add eight when they do. Every term becomes a new battle to reshape the bench. That\'s not a court — that\'s a legislature.');
CALL newPutForth(1454, 1, 'Term limits for Supreme Court justices — 18 years, staggered — is the reform that deserves serious discussion. It reduces the stakes of each appointment, depoliticizes the confirmation process a little, and keeps fresh perspectives on the bench. Better than packing.');

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1443,1,'Because',1444,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1443,1,'Because',1445,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1444,1,'Because',1443,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1444,1,'Because',1450,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1445,1,'Because',1443,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1445,1,'Because',1444,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1445,1,'Because',1449,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1446,1,'Because',1449,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1446,1,'Because',1450,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1446,1,'Because',1451,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1449,1,'Because',1450,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1449,1,'Because',1445,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1449,1,'Because',1454,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Because',1444,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Because',1449,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Because',1451,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1451,1,'Because',1450,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1451,1,'Because',1446,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1454,1,'Because',1449,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1454,1,'Because',1450,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1454,1,'Because',1443,20.0,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1443,1,'Therefore',1444,46.15385,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1443,1,'Therefore',1445,38.46154,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1443,1,'Therefore',1454,15.38461,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1444,1,'Therefore',1443,42.85714,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1444,1,'Therefore',1445,21.42857,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1444,1,'Therefore',1450,35.71429,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1445,1,'Therefore',1443,57.14286,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1445,1,'Therefore',1449,42.85714,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1446,1,'Therefore',1451,100.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1449,1,'Therefore',1445,13.33333,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1449,1,'Therefore',1446,33.33333,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1449,1,'Therefore',1450,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1449,1,'Therefore',1454,33.33334,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Therefore',1444,19.04762,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Therefore',1446,14.28571,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Therefore',1449,23.80952,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Therefore',1451,28.57143,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1450,1,'Therefore',1454,14.28572,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1451,1,'Therefore',1446,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1451,1,'Therefore',1450,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1454,1,'Therefore',1449,100.0,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1447,1,'Rebuttal',1443,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1447,1,'Rebuttal',1444,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1447,1,'Rebuttal',1445,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1448,1,'Rebuttal',1450,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1448,1,'Rebuttal',1449,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1448,1,'Rebuttal',1454,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1452,1,'Rebuttal',1449,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1452,1,'Rebuttal',1443,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1452,1,'Rebuttal',1450,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1453,1,'Rebuttal',1449,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1453,1,'Rebuttal',1443,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1453,1,'Rebuttal',1450,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1455,1,'Rebuttal',1450,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1455,1,'Rebuttal',1449,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1455,1,'Rebuttal',1454,25.0,1);

UPDATE PHRASE_ENDORSE SET active=1 WHERE profileID=1 AND argumentID IN (1443,1444,1445,1446,1449,1450,1451,1454);
UPDATE PHRASE_ENDORSE SET active=0 WHERE profileID=1 AND argumentID IN (1447,1448,1452,1453,1455);

COMMIT;