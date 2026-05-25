-- alfred_anderson_LABOR_seed.sql
-- Alfred Anderson (profileID=1) — LABOR: 9 acc, 4 rej

START TRANSACTION;

DELETE FROM ENDORSEMENT WHERE profileID=1 AND targArgID IN (494,495,496,497,727,734,1200,1201,1607,1608,1609,1610,1611);

CALL assertOpinion(-1, 494, 1);
CALL assertOpinion(1, 495, 1);
CALL assertOpinion(-1, 496, 1);
CALL assertOpinion(1, 497, 1);
CALL assertOpinion(1, 727, 1);
CALL assertOpinion(1, 734, 1);
CALL assertOpinion(1, 1200, 1);
CALL assertOpinion(1, 1201, 1);
CALL assertOpinion(1, 1607, 1);
CALL assertOpinion(-1, 1608, 1);
CALL assertOpinion(-1, 1609, 1);
CALL assertOpinion(1, 1610, 1);
CALL assertOpinion(1, 1611, 1);

CALL newPutForth(727, 1, 'Union work rules — seniority over performance, narrow job classifications, restrictions on who can do what task — make it nearly impossible for a business to adapt to changing conditions. You end up with a system optimized for the protection of incumbents, not productivity.');
CALL newPutForth(734, 1, 'When union leadership and management are at war, both sides lose — workers most of all. The model that works is one where union reps and management are in the room together, aligned on keeping the enterprise healthy enough to meet its obligations. That\'s labor relations done right.');
CALL newPutForth(1200, 1, 'Workers have legitimate interests separate from management\'s. When labor markets are tight, workers have leverage. When they\'re not, they need some other form. That\'s not a political position — it\'s an observation about power.');
CALL newPutForth(1607, 1, 'Working yourself to death is not a virtue. Rest, family time, and recovery are part of a complete human life. Nobody on their deathbed wishes they\'d put in more overtime. That\'s worth saying.');
CALL newPutForth(1611, 1, 'There\'s solid evidence that overworked employees make more mistakes, get sick more often, and produce lower quality output. Shorter hours with focused effort often beats long hours with diminishing returns. Good management knows this.');

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (495,1,'Because',1200,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (495,1,'Because',1201,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (497,1,'Because',495,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (497,1,'Because',734,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (727,1,'Because',734,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (727,1,'Because',1200,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (734,1,'Because',727,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (734,1,'Because',1200,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1200,1,'Because',1201,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1200,1,'Because',727,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1201,1,'Because',1200,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1201,1,'Because',727,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1607,1,'Because',1611,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1607,1,'Because',1610,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1610,1,'Because',1611,70.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1610,1,'Because',1607,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1611,1,'Because',1607,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1611,1,'Because',1610,40.0,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (495,1,'Therefore',497,100.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (727,1,'Therefore',734,42.85714,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (727,1,'Therefore',1200,28.57143,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (727,1,'Therefore',1201,28.57143,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (734,1,'Therefore',497,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (734,1,'Therefore',727,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1200,1,'Therefore',495,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1200,1,'Therefore',727,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1200,1,'Therefore',734,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1200,1,'Therefore',1201,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1201,1,'Therefore',495,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1201,1,'Therefore',1200,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1607,1,'Therefore',1610,33.33333,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1607,1,'Therefore',1611,66.66667,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1610,1,'Therefore',1607,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1610,1,'Therefore',1611,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1611,1,'Therefore',1607,46.15385,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1611,1,'Therefore',1610,53.84615,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (494,1,'Rebuttal',727,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (494,1,'Rebuttal',734,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (494,1,'Rebuttal',1200,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (496,1,'Rebuttal',727,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (496,1,'Rebuttal',734,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (496,1,'Rebuttal',1200,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1608,1,'Rebuttal',1611,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1608,1,'Rebuttal',1607,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1608,1,'Rebuttal',1610,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1609,1,'Rebuttal',1610,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1609,1,'Rebuttal',1611,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1609,1,'Rebuttal',1607,25.0,1);

UPDATE PHRASE_ENDORSE SET active=1 WHERE profileID=1 AND argumentID IN (495,497,727,734,1200,1201,1607,1610,1611);
UPDATE PHRASE_ENDORSE SET active=0 WHERE profileID=1 AND argumentID IN (494,496,1608,1609);

COMMIT;