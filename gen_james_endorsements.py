#!/usr/bin/env python3
"""
Endorsement definitions for James Jennings (profileID=10).

James: 55yo white male, WV, disabled former coal miner. +9 MAGA. GMO
opinions reversed (rejects pro-GMO 1-23, accepts anti-GMO 24-47).
Core: government ruined his industry; elites don't care about working
class; immigration is cultural threat; faith and guns are non-negotiable.
Strong law-and-order, anti-woke, anti-establishment Dem.
Hardcoded: coal industry was sacrificed; deep state is real; 2A is
sacred; faith is the anchor; illegal immigration is lawlessness.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 10
PROFILE_NAME = "James Jennings"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/james_jennings_ENDORSEMENTS_seed.sql'


def build_maga_gop():
    g = EndorsementGraph()
    # Accept: 80,120
    # Reject: 88,89,90,94,104

    g.because(80,  [(120,55),(229,45)])    # 229 cross-cluster from GOVTREG
    g.because(120, [(80,55),(412,45)])     # 412 cross-cluster from GOVTREG

    g.rebuttal(88,  [(120,55),(80,45)])
    g.rebuttal(89,  [(80,55),(120,45)])
    g.rebuttal(90,  [(80,55),(120,45)])
    g.rebuttal(94,  [(120,55),(80,45)])
    g.rebuttal(104, [(80,55),(229,45)])
    return g


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,226,229,266,267,400,412
    # Reject: 609

    g.because(226, [(229,55),(400,45)])
    g.because(229, [(226,55),(400,45)])
    g.because(134, [(226,55),(266,45)])
    g.because(400, [(412,55),(226,45)])
    g.because(412, [(400,55),(226,45)])
    g.because(266, [(267,55),(134,45)])
    g.because(267, [(266,55),(400,45)])

    g.rebuttal(609, [(266,55),(267,45)])
    return g


def build_climate_skeptic():
    g = EndorsementGraph()
    # Accept: 230,1275,1276
    # Reject: 123,414,476

    g.because(1275, [(1276,55),(230,45)])
    g.because(1276, [(1275,55),(230,45)])
    g.because(230,  [(1276,55),(1275,45)])

    g.rebuttal(123, [(1275,55),(1276,45)])
    g.rebuttal(414, [(1276,55),(1275,45)])
    g.rebuttal(476, [(230,55),(1275,45)])
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 140,328,460,461,1172,1177,1178
    # Reject: 462,1179,1181

    g.because(140,  [(1172,55),(328,45)])
    g.because(1172, [(140,55),(328,45)])
    g.because(328,  [(140,55),(1172,45)])
    g.because(460,  [(140,55),(1178,45)])
    g.because(461,  [(460,55),(140,45)])
    g.because(1177, [(1178,55),(1172,45)])
    g.because(1178, [(460,55),(1177,45)])

    g.rebuttal(462,  [(140,55),(1178,45)])
    g.rebuttal(1179, [(1172,55),(460,45)])
    g.rebuttal(1181, [(140,55),(1172,45)])
    return g


def build_police_law():
    g = EndorsementGraph()
    # Accept: 554,555,561,651,652,777,1197,1410
    # Reject: 107,145,560

    g.because(561,  [(1410,55),(651,45)])
    g.because(1410, [(561,55),(651,45)])
    g.because(651,  [(652,55),(561,45)])
    g.because(652,  [(651,55),(1410,45)])
    g.because(554,  [(561,55),(1410,45)])
    g.because(555,  [(554,55),(561,45)])
    g.because(777,  [(1410,55),(561,45)])
    g.because(1197, [(561,55),(1410,45)])

    g.rebuttal(107, [(561,55),(1410,45)])
    g.rebuttal(145, [(561,55),(1410,45)])
    g.rebuttal(560, [(561,55),(1410,45)])
    return g


def build_race_anti_woke():
    g = EndorsementGraph()
    # Accept: 288,291,297,349,350,600,1229
    # Reject: 175,484,485,546,1202,1345,1347

    g.because(288,  [(291,55),(297,45)])
    g.because(291,  [(288,55),(297,45)])
    g.because(297,  [(291,55),(288,45)])
    g.because(349,  [(350,55),(1229,45)])
    g.because(350,  [(349,55),(1229,45)])
    g.because(1229, [(349,55),(297,45)])
    g.because(600,  [(297,55),(291,45)])

    g.rebuttal(175,  [(349,55),(1229,45)])
    g.rebuttal(484,  [(1229,55),(349,45)])
    g.rebuttal(485,  [(1229,55),(350,45)])
    g.rebuttal(546,  [(1229,55),(297,45)])
    g.rebuttal(1202, [(1229,55),(291,45)])
    g.rebuttal(1345, [(1229,55),(297,45)])
    g.rebuttal(1347, [(1229,55),(291,45)])
    return g


def build_immig():
    g = EndorsementGraph()
    # Accept: 618,1237
    # Reject: 611,615,616,617,972,1159,1160

    g.because(618,  [(1237,55),(400,45)])   # 400 cross-cluster from GOVTREG
    g.because(1237, [(618,55),(400,45)])

    g.rebuttal(611,  [(1237,55),(618,45)])
    g.rebuttal(615,  [(1237,55),(618,45)])
    g.rebuttal(616,  [(618,55),(1237,45)])
    g.rebuttal(617,  [(1237,55),(618,45)])
    g.rebuttal(972,  [(1237,55),(618,45)])
    g.rebuttal(1159, [(618,55),(1237,45)])
    g.rebuttal(1160, [(618,55),(1237,45)])
    return g


def build_faith():
    g = EndorsementGraph()
    # Accept: 428,844,1440

    g.because(428,  [(844,55),(1440,45)])
    g.because(844,  [(428,55),(1440,45)])
    g.because(1440, [(428,55),(844,45)])
    return g


def build_abort():
    g = EndorsementGraph()
    # Accept: 130,1385,1386

    g.because(1385, [(1386,55),(844,45)])   # 844 cross-cluster from FAITH
    g.because(1386, [(1385,55),(844,45)])
    g.because(130,  [(1386,55),(1385,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 324,326,327,547,548,549,658,659
    # Reject: 329,331,333,383

    g.because(324,  [(326,55),(327,45)])
    g.because(326,  [(324,55),(327,45)])
    g.because(327,  [(326,55),(324,45)])
    g.because(547,  [(548,55),(549,45)])
    g.because(548,  [(547,55),(549,45)])
    g.because(549,  [(548,55),(547,45)])
    g.because(658,  [(659,55),(561,45)])   # 561 cross-cluster from POLICE
    g.because(659,  [(658,55),(561,45)])

    g.rebuttal(329, [(326,55),(327,45)])
    g.rebuttal(331, [(324,55),(326,45)])
    g.rebuttal(333, [(327,55),(326,45)])
    g.rebuttal(383, [(324,55),(327,45)])
    return g


CLUSTERS = [
    ('MAGA_GOP',       build_maga_gop()),
    ('GOVTREG',        build_govtreg()),
    ('CLIMATE_SKEPTIC',build_climate_skeptic()),
    ('GUN',            build_gun()),
    ('POLICE_LAW',     build_police_law()),
    ('RACE_ANTI_WOKE', build_race_anti_woke()),
    ('IMMIG',          build_immig()),
    ('FAITH',          build_faith()),
    ('ABORT',          build_abort()),
    ('MISC',           build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for James Jennings')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
