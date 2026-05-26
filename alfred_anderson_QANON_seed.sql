-- alfred_anderson_QANON_seed.sql
-- Alfred Anderson (profileID=1) — QANON: 6 acc, 5 rej

START TRANSACTION;

DELETE FROM ENDORSEMENT WHERE profileID=1 AND targArgID IN (60,247,248,1417,1419,1420,1421,1422,1423,1424,1714);

CALL assertOpinion(-1, 60, 1);
CALL assertOpinion(-1, 247, 1);
CALL assertOpinion(1, 248, 1);
CALL assertOpinion(1, 1417, 1);
CALL assertOpinion(-1, 1419, 1);
CALL assertOpinion(-1, 1420, 1);
CALL assertOpinion(1, 1421, 1);
CALL assertOpinion(1, 1422, 1);
CALL assertOpinion(1, 1423, 1);
CALL assertOpinion(-1, 1424, 1);
CALL assertOpinion(1, 1714, 1);

CALL newPutForth(248, 1, 'Child sexual abuse — especially by the powerful against the defenseless — is a line that no amount of money, influence, or political cover can make acceptable. When Epstein\'s network is fully mapped, heads should roll regardless of party.');
CALL newPutForth(1421, 1, 'Extraordinary claims require extraordinary evidence. That\'s not cynicism — it\'s the minimum standard for believing anything important. The moment you abandon it, you\'re capable of believing anything.');
CALL newPutForth(1714, 1, 'Missing prison surveillance footage from the most high-profile prison death in America, involving a convicted child sex trafficker connected to powerful people on both sides — that\'s not a nothing burger. At some point \'security malfunction\' strains credibility.');

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (248,1,'Because',1421,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (248,1,'Because',1714,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (248,1,'Because',1422,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1417,1,'Because',248,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1417,1,'Because',1714,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1417,1,'Because',1421,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1421,1,'Because',1422,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1421,1,'Because',1423,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1422,1,'Because',1421,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1422,1,'Because',1423,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1423,1,'Because',1422,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1423,1,'Because',1421,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1714,1,'Because',248,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1714,1,'Because',1421,40.0,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (248,1,'Therefore',1417,45.45455,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (248,1,'Therefore',1714,54.54545,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1421,1,'Therefore',248,23.80952,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1421,1,'Therefore',1417,9.52381,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1421,1,'Therefore',1422,28.57143,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1421,1,'Therefore',1423,19.04762,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1421,1,'Therefore',1714,19.04762,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1422,1,'Therefore',248,14.28571,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1422,1,'Therefore',1421,42.85714,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1422,1,'Therefore',1423,42.85715,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1423,1,'Therefore',1421,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1423,1,'Therefore',1422,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1714,1,'Therefore',248,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1714,1,'Therefore',1417,50.0,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (60,1,'Rebuttal',1421,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (60,1,'Rebuttal',1422,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (60,1,'Rebuttal',1423,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (247,1,'Rebuttal',1421,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (247,1,'Rebuttal',1422,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (247,1,'Rebuttal',248,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1419,1,'Rebuttal',1421,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1419,1,'Rebuttal',1422,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1419,1,'Rebuttal',1423,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1420,1,'Rebuttal',1421,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1420,1,'Rebuttal',1422,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1420,1,'Rebuttal',1423,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1424,1,'Rebuttal',1421,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1424,1,'Rebuttal',1422,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1424,1,'Rebuttal',248,25.0,1);

UPDATE PHRASE_ENDORSE SET active=1 WHERE profileID=1 AND argumentID IN (248,1417,1421,1422,1423,1714);
UPDATE PHRASE_ENDORSE SET active=0 WHERE profileID=1 AND argumentID IN (60,247,1419,1420,1424);

COMMIT;