-- alfred_anderson_CATHOLIC_ABUSE_seed.sql
-- Alfred Anderson (profileID=1) — CATHOLIC_ABUSE: 7 acc, 4 rej

START TRANSACTION;

DELETE FROM ENDORSEMENT WHERE profileID=1 AND targArgID IN (967,978,979,980,981,982,983,984,1099,1100,1102);

CALL assertOpinion(-1, 967, 1);
CALL assertOpinion(1, 978, 1);
CALL assertOpinion(-1, 979, 1);
CALL assertOpinion(1, 980, 1);
CALL assertOpinion(1, 981, 1);
CALL assertOpinion(1, 982, 1);
CALL assertOpinion(1, 983, 1);
CALL assertOpinion(-1, 984, 1);
CALL assertOpinion(-1, 1099, 1);
CALL assertOpinion(1, 1100, 1);
CALL assertOpinion(1, 1102, 1);

CALL newPutForth(978, 1, 'The abuse scandal has permanently damaged the institutional credibility of the Catholic Church\'s leadership. That doesn\'t change the faith — Christ didn\'t abuse anyone. But the men who ran this institution, and the men who covered for the men who abused — they have a hell of a lot to answer for.');
CALL newPutForth(983, 1, 'Sheltering priests with documented decades-long patterns of abuse isn\'t a failure of judgment — it\'s a moral catastrophe. These weren\'t rumors. There were records. And the response was to move the predators somewhere else. That\'s not protecting the flock. That\'s feeding it to the wolves.');
CALL newPutForth(1100, 1, 'Whatever social norms may have existed around other behaviors, the rape of a child has never been socially acceptable. At any point in history, in any culture we would want to claim as civilized. Anyone who touches a child that way knew exactly what they were doing.');
CALL newPutForth(1102, 1, 'Using money and lawyers to attack a child accuser\'s family isn\'t defending yourself — it\'s weaponizing resources against the vulnerable. It\'s the kind of behavior that makes you want rich people to face consequences they currently don\'t.');

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (978,1,'Because',983,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (978,1,'Because',980,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (978,1,'Because',981,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (980,1,'Because',978,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (980,1,'Because',981,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (980,1,'Because',983,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (981,1,'Because',980,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (981,1,'Because',978,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (981,1,'Because',982,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (982,1,'Because',981,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (982,1,'Because',980,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (983,1,'Because',978,50.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (983,1,'Because',980,30.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (983,1,'Because',981,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1100,1,'Because',1102,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1100,1,'Because',983,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1102,1,'Because',1100,60.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1102,1,'Because',983,40.0,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (978,1,'Therefore',980,38.46154,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (978,1,'Therefore',981,23.07692,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (978,1,'Therefore',983,38.46154,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (980,1,'Therefore',978,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (980,1,'Therefore',981,33.33333,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (980,1,'Therefore',982,26.66667,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (980,1,'Therefore',983,20.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (981,1,'Therefore',978,15.38462,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (981,1,'Therefore',980,23.07692,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (981,1,'Therefore',982,46.15385,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (981,1,'Therefore',983,15.38461,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (982,1,'Therefore',981,100.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (983,1,'Therefore',978,33.33333,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (983,1,'Therefore',980,13.33333,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (983,1,'Therefore',1100,26.66667,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (983,1,'Therefore',1102,26.66667,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1100,1,'Therefore',1102,100.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1102,1,'Therefore',1100,100.0,1);

INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (967,1,'Rebuttal',978,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (967,1,'Rebuttal',983,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (967,1,'Rebuttal',1100,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (979,1,'Rebuttal',978,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (979,1,'Rebuttal',983,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (979,1,'Rebuttal',980,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (984,1,'Rebuttal',983,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (984,1,'Rebuttal',978,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (984,1,'Rebuttal',980,25.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1099,1,'Rebuttal',978,40.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1099,1,'Rebuttal',983,35.0,1);
INSERT INTO ENDORSEMENT (targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES (1099,1,'Rebuttal',1100,25.0,1);

UPDATE PHRASE_ENDORSE SET active=1 WHERE profileID=1 AND argumentID IN (978,980,981,982,983,1100,1102);
UPDATE PHRASE_ENDORSE SET active=0 WHERE profileID=1 AND argumentID IN (967,979,984,1099);

COMMIT;