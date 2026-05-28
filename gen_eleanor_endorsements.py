#!/usr/bin/env python3
"""
Endorsement definitions for Eleanor Evans (profileID=5).

Eleanor: 72yo white Republican, Cookeville TN. Retired bookkeeper.
+9/10 conservative. Abortion is her single-issue lens for all politics.
Second: LGBTQ+/children. Hawkish on immigration as cultural threat.
Trusts: pastor, church community, Fox News, Franklin Graham.
Hardcoded: abortion is murder, marriage = man+woman, Christian nation,
children must be protected from sexual ideology.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 5
PROFILE_NAME = "Eleanor Evans"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/eleanor_evans_ENDORSEMENTS_seed.sql'


def build_abort():
    g = EndorsementGraph()
    # Accept: 124,125,126,902,1385,1386,1387
    # Reject: 903

    g.because(124,  [(1385,55),(902,45)])
    g.because(125,  [(124,55),(1386,45)])
    g.because(126,  [(124,55),(125,45)])
    g.because(902,  [(1385,55),(1386,45)])
    g.because(1385, [(1386,55),(902,45)])
    g.because(1386, [(1385,55),(1387,45)])
    g.because(1387, [(1386,55),(1385,45)])

    g.rebuttal(903, [(902,55),(1385,45)])   # personhood at birth (pro-choice) ← pro-life core
    return g


def build_trans_gender():
    g = EndorsementGraph()
    # Accept: 142,143,785,791,793,844,849,1440
    # Reject: 790,795,797,801,1438

    g.because(142,  [(785,55),(791,45)])
    g.because(143,  [(142,55),(785,45)])
    g.because(785,  [(849,55),(142,45)])
    g.because(791,  [(142,55),(785,45)])
    g.because(793,  [(791,55),(142,45)])
    g.because(844,  [(785,55),(849,45)])
    g.because(849,  [(785,55),(844,45)])
    g.because(1440, [(785,55),(142,45)])

    g.rebuttal(790, [(791,55),(142,45)])
    g.rebuttal(795, [(142,55),(785,45)])
    g.rebuttal(797, [(791,55),(142,45)])
    g.rebuttal(801, [(849,55),(142,45)])   # Eleanor IS fighting this culture war
    g.rebuttal(1438,[(785,55),(1440,45)])
    return g


def build_faith():
    g = EndorsementGraph()
    # Accept: 428,821,1001
    # Reject: 161

    g.because(428,  [(821,55),(849,40)])   # 849 cross-cluster from TRANS_GENDER
    g.because(821,  [(428,55),(1001,45)])
    g.because(1001, [(821,55),(428,45)])

    g.rebuttal(161, [(428,55),(821,45)])
    return g


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 224,226,229,400,401,405,406,407,601,607,920,136
    # (No specific rejects in this cluster beyond shared ones)

    g.because(226,  [(229,55),(400,45)])
    g.because(229,  [(226,55),(400,45)])
    g.because(400,  [(226,55),(401,45)])
    g.because(401,  [(400,55),(136,45)])
    g.because(136,  [(401,55),(400,45)])
    g.because(224,  [(226,55),(229,45)])
    g.because(405,  [(406,55),(407,45)])
    g.because(406,  [(405,55),(407,45)])
    g.because(407,  [(406,55),(400,45)])
    g.because(601,  [(607,55),(400,45)])
    g.because(607,  [(601,55),(400,45)])
    g.because(920,  [(400,55),(401,45)])
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 140,328,460,1172,1177,1178
    # Reject: 462,1179,1181

    g.because(140,  [(1172,55),(328,45)])
    g.because(1172, [(140,55),(328,45)])
    g.because(328,  [(140,55),(1172,45)])
    g.because(460,  [(140,55),(1178,45)])
    g.because(1177, [(1178,55),(1172,45)])
    g.because(1178, [(460,55),(1177,45)])

    g.rebuttal(462,  [(140,55),(1178,45)])
    g.rebuttal(1179, [(1172,55),(460,45)])
    g.rebuttal(1181, [(140,55),(1172,45)])
    return g


def build_police():
    g = EndorsementGraph()
    # Accept: 165,166,561,777,1410,1411
    # Reject: 105,107,560

    g.because(561,  [(165,55),(1410,45)])
    g.because(165,  [(561,55),(1410,45)])
    g.because(166,  [(165,55),(561,45)])
    g.because(1410, [(561,55),(165,45)])
    g.because(1411, [(1410,55),(165,45)])
    g.because(777,  [(165,55),(1410,45)])

    g.rebuttal(105, [(561,55),(165,45)])
    g.rebuttal(107, [(561,55),(1410,45)])
    g.rebuttal(560, [(561,55),(165,45)])
    return g


def build_race_cancel():
    g = EndorsementGraph()
    # Accept: 100,101,108,288,291,297,298,349,350,596,600,1229,1319,1320,1562
    # Reject: 175,546,1313,1345,1346,1347

    g.because(101,  [(100,55),(349,45)])
    g.because(100,  [(349,55),(350,45)])
    g.because(108,  [(100,55),(101,45)])
    g.because(349,  [(350,55),(100,45)])
    g.because(350,  [(349,55),(101,45)])
    g.because(1229, [(1562,55),(100,45)])
    g.because(1562, [(1229,55),(297,45)])
    g.because(288,  [(291,55),(297,45)])
    g.because(291,  [(288,55),(600,45)])
    g.because(297,  [(288,55),(600,45)])
    g.because(298,  [(297,55),(288,45)])
    g.because(596,  [(600,55),(297,45)])
    g.because(600,  [(297,55),(291,45)])
    g.because(1319, [(1320,55),(100,45)])
    g.because(1320, [(1319,55),(1229,45)])

    g.rebuttal(175,  [(100,55),(349,45)])
    g.rebuttal(546,  [(1319,55),(1320,45)])
    g.rebuttal(1313, [(100,55),(101,45)])
    g.rebuttal(1345, [(1229,55),(1562,45)])
    g.rebuttal(1346, [(1229,55),(100,45)])
    g.rebuttal(1347, [(1229,55),(1562,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 230,574,1275,1276
    # Reject: 123,321,414,476

    g.because(1275, [(1276,55),(230,45)])
    g.because(1276, [(1275,55),(230,45)])
    g.because(230,  [(1276,55),(1275,45)])
    g.because(574,  [(1275,55),(1276,45)])

    g.rebuttal(123, [(1275,55),(1276,45)])
    g.rebuttal(321, [(1275,55),(230,45)])
    g.rebuttal(414, [(1276,55),(1275,45)])
    g.rebuttal(476, [(230,55),(1275,45)])
    return g


def build_immig():
    g = EndorsementGraph()
    # Accept: 612,1237
    # Reject: 611,616,617,1159,1160

    g.because(612,  [(1237,55),(322,45)])   # 322 cross-cluster from RACE_CANCEL
    g.because(1237, [(612,55),(322,45)])

    g.rebuttal(611,  [(612,55),(1237,45)])
    g.rebuttal(616,  [(612,55),(1237,45)])
    g.rebuttal(617,  [(1237,55),(612,45)])
    g.rebuttal(1159, [(1237,55),(612,45)])
    g.rebuttal(1160, [(612,55),(1237,45)])
    return g


CLUSTERS = [
    ('ABORT',       build_abort()),
    ('TRANS_GENDER',build_trans_gender()),
    ('FAITH',       build_faith()),
    ('GOVTREG',     build_govtreg()),
    ('GUN',         build_gun()),
    ('POLICE',      build_police()),
    ('RACE_CANCEL', build_race_cancel()),
    ('CLIMATE',     build_climate()),
    ('IMMIG',       build_immig()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Eleanor Evans')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
