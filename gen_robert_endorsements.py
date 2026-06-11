#!/usr/bin/env python3
"""
Endorsement definitions for Robert Ramirez (profileID=18).

Robert: 50yo white male, Joplin MO, construction crew owner. +9 MAGA.
GMO reversed. Core: MAGA patriot, small business owner resentful of
government overreach, pro-2A, pro-life, law-and-order, anti-immigration.
Very similar to James but stronger on family/faith (849,1411) and
business regulations (404,405,407). Anti-woke on race and cancel culture.
Rejects climate action entirely. Anti-socialism (567,568,602).
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 18
PROFILE_NAME = "Robert Ramirez"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/robert_ramirez_ENDORSEMENTS_seed.sql'


def build_maga_gop():
    g = EndorsementGraph()
    # Accept: 80,120,121
    # Reject: 88,89,90,94,96,104

    g.because(80,  [(120,55),(400,45)])    # 400 cross-cluster from GOVTREG
    g.because(120, [(80,55),(121,45)])
    g.because(121, [(120,55),(80,45)])

    g.rebuttal(88,  [(120,55),(80,45)])
    g.rebuttal(89,  [(80,55),(120,45)])
    g.rebuttal(90,  [(80,55),(120,45)])
    g.rebuttal(94,  [(120,55),(80,45)])
    g.rebuttal(96,  [(120,55),(121,45)])
    g.rebuttal(104, [(80,55),(400,45)])
    return g


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,135,136,197(→wait, not in list),226,229,400,401,404,405,407
    # Wait - Robert's accepts: 134,135,136,226,400,401,404,405,407 (197 not listed)
    # Reject: 110,606,609

    g.because(226,  [(400,55),(134,45)])
    g.because(134,  [(135,55),(226,45)])
    g.because(135,  [(134,55),(226,45)])
    g.because(400,  [(401,55),(226,45)])
    g.because(401,  [(136,55),(400,45)])
    g.because(136,  [(401,55),(400,45)])
    g.because(404,  [(405,55),(400,45)])
    g.because(405,  [(404,55),(407,45)])
    g.because(407,  [(405,55),(400,45)])

    g.rebuttal(110, [(134,55),(400,45)])
    g.rebuttal(606, [(401,55),(136,45)])
    g.rebuttal(609, [(400,55),(134,45)])
    return g


def build_abort():
    g = EndorsementGraph()
    # Accept: 124,125,130,902,1385,1386,1387
    # Reject: (none beyond basic)

    g.because(902,  [(1385,55),(1386,45)])
    g.because(1385, [(1386,55),(902,45)])
    g.because(1386, [(1385,55),(1387,45)])
    g.because(1387, [(1386,55),(1385,45)])
    g.because(124,  [(1385,55),(902,45)])
    g.because(125,  [(124,55),(1386,45)])
    g.because(130,  [(1386,55),(1385,45)])
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 140,328,460,461
    # Reject: (none)

    g.because(140,  [(328,55),(460,45)])
    g.because(328,  [(140,55),(460,45)])
    g.because(460,  [(140,55),(328,45)])
    g.because(461,  [(460,55),(140,45)])
    return g


def build_police_law():
    g = EndorsementGraph()
    # Accept: 554,555,561,602,651,652,658,659,777,1410,1411
    # Reject: 107,145,560

    g.because(561,  [(1410,55),(651,45)])
    g.because(1410, [(561,55),(651,45)])
    g.because(1411, [(1410,55),(561,45)])
    g.because(651,  [(652,55),(561,45)])
    g.because(652,  [(651,55),(1410,45)])
    g.because(554,  [(561,55),(1410,45)])
    g.because(555,  [(554,55),(561,45)])
    g.because(777,  [(1410,55),(561,45)])
    g.because(602,  [(561,55),(651,45)])
    g.because(658,  [(659,55),(561,45)])
    g.because(659,  [(658,55),(561,45)])

    g.rebuttal(107, [(561,55),(1410,45)])
    g.rebuttal(145, [(561,55),(1410,45)])
    g.rebuttal(560, [(561,55),(1410,45)])
    return g


def build_faith_family():
    g = EndorsementGraph()
    # Accept: 428,844,849,1440
    # Reject: 141,161,315,543

    g.because(428,  [(844,55),(1440,45)])
    g.because(844,  [(428,55),(849,45)])
    g.because(849,  [(844,55),(428,45)])
    g.because(1440, [(428,55),(844,45)])

    g.rebuttal(141, [(844,55),(849,45)])
    g.rebuttal(161, [(428,100)])
    g.rebuttal(315, [(844,55),(428,45)])
    g.rebuttal(543, [(844,55),(428,45)])
    return g


def build_race_anti_woke():
    g = EndorsementGraph()
    # Accept: 288,297,326,327,349,547,548,549
    # Reject: 321,414,476,729,743,746,747

    g.because(288,  [(297,55),(349,45)])
    g.because(297,  [(288,55),(349,45)])
    g.because(349,  [(297,55),(288,45)])
    g.because(326,  [(327,55),(297,45)])
    g.because(327,  [(326,55),(297,45)])
    g.because(547,  [(548,55),(549,45)])
    g.because(548,  [(547,55),(549,45)])
    g.because(549,  [(548,55),(547,45)])

    g.rebuttal(321, [(1275,55),(1276,45)])  # cross-cluster from CLIMATE_SKEPTIC
    g.rebuttal(414, [(1275,55),(1276,45)])
    g.rebuttal(476, [(1275,55),(1276,45)])
    g.rebuttal(729, [(297,55),(288,45)])
    g.rebuttal(743, [(297,55),(288,45)])
    g.rebuttal(746, [(349,55),(297,45)])
    g.rebuttal(747, [(349,55),(297,45)])
    return g


def build_climate_skeptic():
    g = EndorsementGraph()
    # Accept: 230,1275,1276
    # Reject: 123

    g.because(1275, [(1276,55),(230,45)])
    g.because(1276, [(1275,55),(230,45)])
    g.because(230,  [(1276,55),(1275,45)])

    g.rebuttal(123, [(1275,55),(1276,45)])
    return g


def build_immig():
    g = EndorsementGraph()
    # Accept: 612,618,1027,1237
    # Reject: 611,615,616,1028

    g.because(612,  [(1237,55),(400,45)])   # 400 cross-cluster
    g.because(1237, [(612,55),(400,45)])
    g.because(618,  [(1237,55),(612,45)])
    g.because(1027, [(1237,55),(612,45)])

    g.rebuttal(611,  [(1237,55),(612,45)])
    g.rebuttal(615,  [(612,55),(1237,45)])
    g.rebuttal(616,  [(612,55),(1237,45)])
    g.rebuttal(1028, [(1027,55),(1237,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 567,568
    # No new rejects

    g.because(567,  [(568,55),(400,45)])   # 400 cross-cluster
    g.because(568,  [(567,55),(400,45)])
    return g


CLUSTERS = [
    ('MAGA_GOP',        build_maga_gop()),
    ('GOVTREG',         build_govtreg()),
    ('ABORT',           build_abort()),
    ('GUN',             build_gun()),
    ('POLICE_LAW',      build_police_law()),
    ('FAITH_FAMILY',    build_faith_family()),
    ('RACE_ANTI_WOKE',  build_race_anti_woke()),
    ('CLIMATE_SKEPTIC', build_climate_skeptic()),
    ('IMMIG',           build_immig()),
    ('MISC',            build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Robert Ramirez')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
