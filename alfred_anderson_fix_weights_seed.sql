-- Fix: normalize all Alfred Anderson (profileID=1) endorsement weights
-- Each (targArgID, profileID, endorseType) group must sum to exactly 100.
-- Weights below are proportionally scaled from the original relative preferences.

USE vestigette;

-- ============================================================
-- 107 Rebuttal: 165=80, 561=90 → total was 170
-- 165: 80/170*100 = 47,  561: 90/170*100 = 53
UPDATE ENDORSEMENT SET weight=47.0 WHERE targArgID=107 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=165;
UPDATE ENDORSEMENT SET weight=53.0 WHERE targArgID=107 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=561;

-- ============================================================
-- 123 Rebuttal: 230=80, 527=75 → total was 155
-- 230: 52,  527: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=123 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=230;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=123 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=527;

-- ============================================================
-- 140 Because: 226=90, 326=85 → total was 175
-- 226: 51,  326: 49
UPDATE ENDORSEMENT SET weight=51.0 WHERE targArgID=140 AND profileID=1 AND endorseType='Because' AND supportingArgID=226;
UPDATE ENDORSEMENT SET weight=49.0 WHERE targArgID=140 AND profileID=1 AND endorseType='Because' AND supportingArgID=326;

-- 140 Therefore: 328=90, 460=80, 461=85 → total was 255
-- 328: 35,  460: 31,  461: 34
UPDATE ENDORSEMENT SET weight=35.0 WHERE targArgID=140 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=328;
UPDATE ENDORSEMENT SET weight=31.0 WHERE targArgID=140 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=460;
UPDATE ENDORSEMENT SET weight=34.0 WHERE targArgID=140 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=461;

-- ============================================================
-- 227 Because: 201=75, 265=80 → total was 155
-- 201: 48,  265: 52
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=227 AND profileID=1 AND endorseType='Because' AND supportingArgID=201;
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=227 AND profileID=1 AND endorseType='Because' AND supportingArgID=265;

-- 227 Therefore: 228=85, 449=70 → total was 155
-- 228: 55,  449: 45
UPDATE ENDORSEMENT SET weight=55.0 WHERE targArgID=227 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=228;
UPDATE ENDORSEMENT SET weight=45.0 WHERE targArgID=227 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=449;

-- ============================================================
-- 230 Because: 1275=80, 1276=75 → total was 155
-- 1275: 52,  1276: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=230 AND profileID=1 AND endorseType='Because' AND supportingArgID=1275;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=230 AND profileID=1 AND endorseType='Because' AND supportingArgID=1276;

-- 230 Therefore: 415=70, 527=70 → total was 140
-- 415: 50,  527: 50
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=230 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=415;
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=230 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=527;

-- ============================================================
-- 288 Because: 291=85, 297=80 → total was 165
-- 291: 52,  297: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=288 AND profileID=1 AND endorseType='Because' AND supportingArgID=291;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=288 AND profileID=1 AND endorseType='Because' AND supportingArgID=297;

-- 288 Therefore: 596=85, 600=80 → total was 165
-- 596: 52,  600: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=288 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=596;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=288 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=600;

-- ============================================================
-- 293 Rebuttal: 288=80, 291=75 → total was 155
-- 288: 52,  291: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=293 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=288;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=293 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=291;

-- ============================================================
-- 328 Because: 140=90, 226=85, 325=80 → total was 255
-- 140: 35,  226: 33,  325: 32  (note: adjusted to sum exactly to 100)
UPDATE ENDORSEMENT SET weight=35.0 WHERE targArgID=328 AND profileID=1 AND endorseType='Because' AND supportingArgID=140;
UPDATE ENDORSEMENT SET weight=33.0 WHERE targArgID=328 AND profileID=1 AND endorseType='Because' AND supportingArgID=226;
UPDATE ENDORSEMENT SET weight=32.0 WHERE targArgID=328 AND profileID=1 AND endorseType='Because' AND supportingArgID=325;

-- 328 Therefore: 1172=80, 1177=75, 1178=85 → total was 240
-- 1172: 33,  1177: 31,  1178: 36
UPDATE ENDORSEMENT SET weight=33.0 WHERE targArgID=328 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1172;
UPDATE ENDORSEMENT SET weight=31.0 WHERE targArgID=328 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1177;
UPDATE ENDORSEMENT SET weight=36.0 WHERE targArgID=328 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1178;

-- ============================================================
-- 355 Rebuttal: 180=85, 183=80 → total was 165
-- 180: 52,  183: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=355 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=180;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=355 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=183;

-- ============================================================
-- 400 Because: 405=85, 406=80, 412=80 → total was 245
-- 405: 35,  406: 33,  412: 32
UPDATE ENDORSEMENT SET weight=35.0 WHERE targArgID=400 AND profileID=1 AND endorseType='Because' AND supportingArgID=405;
UPDATE ENDORSEMENT SET weight=33.0 WHERE targArgID=400 AND profileID=1 AND endorseType='Because' AND supportingArgID=406;
UPDATE ENDORSEMENT SET weight=32.0 WHERE targArgID=400 AND profileID=1 AND endorseType='Because' AND supportingArgID=412;

-- 400 Therefore: 401=85, 404=75 → total was 160
-- 401: 53,  404: 47
UPDATE ENDORSEMENT SET weight=53.0 WHERE targArgID=400 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=401;
UPDATE ENDORSEMENT SET weight=47.0 WHERE targArgID=400 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=404;

-- ============================================================
-- 407 Because: 405=85, 406=80, 412=80 → total was 245
-- 405: 35,  406: 33,  412: 32
UPDATE ENDORSEMENT SET weight=35.0 WHERE targArgID=407 AND profileID=1 AND endorseType='Because' AND supportingArgID=405;
UPDATE ENDORSEMENT SET weight=33.0 WHERE targArgID=407 AND profileID=1 AND endorseType='Because' AND supportingArgID=406;
UPDATE ENDORSEMENT SET weight=32.0 WHERE targArgID=407 AND profileID=1 AND endorseType='Because' AND supportingArgID=412;

-- 407 Therefore: 400=80, 401=75 → total was 155
-- 400: 52,  401: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=407 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=400;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=407 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=401;

-- ============================================================
-- 462 Rebuttal: 140=90, 1027=70 → total was 160
-- 140: 56,  1027: 44
UPDATE ENDORSEMENT SET weight=56.0 WHERE targArgID=462 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=140;
UPDATE ENDORSEMENT SET weight=44.0 WHERE targArgID=462 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1027;

-- ============================================================
-- 560 Rebuttal: 561=90, 777=75 → total was 165
-- 561: 55,  777: 45
UPDATE ENDORSEMENT SET weight=55.0 WHERE targArgID=560 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=561;
UPDATE ENDORSEMENT SET weight=45.0 WHERE targArgID=560 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=777;

-- ============================================================
-- 561 Because: 1410=85, 1411=90 → total was 175
-- 1410: 49,  1411: 51
UPDATE ENDORSEMENT SET weight=49.0 WHERE targArgID=561 AND profileID=1 AND endorseType='Because' AND supportingArgID=1410;
UPDATE ENDORSEMENT SET weight=51.0 WHERE targArgID=561 AND profileID=1 AND endorseType='Because' AND supportingArgID=1411;

-- 561 Therefore: 165=80 (singleton, must be 100)
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=561 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=165;

-- ============================================================
-- 604 Rebuttal: 705=80, 920=80 → total was 160
-- 705: 50,  920: 50
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=604 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=705;
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=604 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=920;

-- ============================================================
-- 609 Rebuttal: 601=80, 607=75 → total was 155
-- 601: 52,  607: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=609 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=601;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=609 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=607;

-- ============================================================
-- 611 Rebuttal: 612=85 (singleton, must be 100)
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=611 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=612;

-- ============================================================
-- 617 Rebuttal: 618=70 (singleton, must be 100)
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=617 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=618;

-- ============================================================
-- 791 Because: 142=85, 785=75 → total was 160
-- 142: 53,  785: 47
UPDATE ENDORSEMENT SET weight=53.0 WHERE targArgID=791 AND profileID=1 AND endorseType='Because' AND supportingArgID=142;
UPDATE ENDORSEMENT SET weight=47.0 WHERE targArgID=791 AND profileID=1 AND endorseType='Because' AND supportingArgID=785;

-- ============================================================
-- 797 Rebuttal: 142=80, 791=85 → total was 165
-- 142: 48,  791: 52
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=797 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=142;
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=797 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=791;

-- ============================================================
-- 901 Rebuttal: 910=85, 920=80 → total was 165
-- 910: 52,  920: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=901 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=910;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=901 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=920;

-- ============================================================
-- 913 Because: 916=90, 1411=85 → total was 175
-- 916: 51,  1411: 49
UPDATE ENDORSEMENT SET weight=51.0 WHERE targArgID=913 AND profileID=1 AND endorseType='Because' AND supportingArgID=916;
UPDATE ENDORSEMENT SET weight=49.0 WHERE targArgID=913 AND profileID=1 AND endorseType='Because' AND supportingArgID=1411;

-- 913 Therefore: 912=75 (singleton, must be 100)
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=913 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=912;

-- ============================================================
-- 1177 Because: 1002=60, 1176=80 → total was 140
-- 1002: 43,  1176: 57
UPDATE ENDORSEMENT SET weight=43.0 WHERE targArgID=1177 AND profileID=1 AND endorseType='Because' AND supportingArgID=1002;
UPDATE ENDORSEMENT SET weight=57.0 WHERE targArgID=1177 AND profileID=1 AND endorseType='Because' AND supportingArgID=1176;

-- 1177 Therefore: 1172=70, 1178=80 → total was 150
-- 1172: 47,  1178: 53
UPDATE ENDORSEMENT SET weight=47.0 WHERE targArgID=1177 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1172;
UPDATE ENDORSEMENT SET weight=53.0 WHERE targArgID=1177 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1178;

-- ============================================================
-- 1181 Rebuttal: 140=90, 1172=75, 1178=85 → total was 250
-- 140: 36,  1172: 30,  1178: 34
UPDATE ENDORSEMENT SET weight=36.0 WHERE targArgID=1181 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=140;
UPDATE ENDORSEMENT SET weight=30.0 WHERE targArgID=1181 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1172;
UPDATE ENDORSEMENT SET weight=34.0 WHERE targArgID=1181 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1178;

-- ============================================================
-- 1365 Because: 1366=80, 1367=85 → total was 165
-- 1366: 48,  1367: 52
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=1365 AND profileID=1 AND endorseType='Because' AND supportingArgID=1366;
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=1365 AND profileID=1 AND endorseType='Because' AND supportingArgID=1367;

-- ============================================================
-- 1385 Because: 1386=90, 1440=90 → total was 180
-- 1386: 50,  1440: 50
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=1385 AND profileID=1 AND endorseType='Because' AND supportingArgID=1386;
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=1385 AND profileID=1 AND endorseType='Because' AND supportingArgID=1440;

-- 1385 Therefore: 1387=80 (singleton, must be 100)
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=1385 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1387;

-- ============================================================
-- 1387 Because: 1385=80, 1440=75 → total was 155
-- 1385: 52,  1440: 48
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=1387 AND profileID=1 AND endorseType='Because' AND supportingArgID=1385;
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=1387 AND profileID=1 AND endorseType='Because' AND supportingArgID=1440;

-- ============================================================
-- 1597 Because: 1591=90, 1593=85 → total was 175
-- 1591: 51,  1593: 49
UPDATE ENDORSEMENT SET weight=51.0 WHERE targArgID=1597 AND profileID=1 AND endorseType='Because' AND supportingArgID=1591;
UPDATE ENDORSEMENT SET weight=49.0 WHERE targArgID=1597 AND profileID=1 AND endorseType='Because' AND supportingArgID=1593;

-- 1597 Therefore: 1278=75, 1602=80 → total was 155
-- 1278: 48,  1602: 52
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=1597 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1278;
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=1597 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1602;

-- ============================================================
-- 1617 Rebuttal: 1625=75, 1627=80 → total was 155
-- 1625: 48,  1627: 52
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=1617 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1625;
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=1617 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1627;

-- ============================================================
-- 1627 Because: 1625=80 (singleton, must be 100)
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=1627 AND profileID=1 AND endorseType='Because' AND supportingArgID=1625;

-- ============================================================
-- Verify: all groups for profileID=1 args > 65 should now total 100
SELECT targArgID, endorseType,
  GROUP_CONCAT(CONCAT(supportingArgID,'=',weight) ORDER BY supportingArgID SEPARATOR ', ') as weights,
  SUM(weight) as total
FROM ENDORSEMENT
WHERE profileID=1 AND active=1 AND targArgID > 65
GROUP BY targArgID, endorseType
ORDER BY targArgID, endorseType;
