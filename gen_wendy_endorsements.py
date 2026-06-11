#!/usr/bin/env python3
"""
Endorsement definitions for Wendy Walsh (profileID=23).

Wendy: 77yo white female, Scranton PA, retired bank teller. +7 Republican
(recent Dem→Rep convert). GMO reversed. Former Dem who switched, partly
from cultural resentment. Accepts 101 (racism is made up) — further right
than moderate conservatives. Strong law-and-order, pro-life, faith.
Accepts some moderate healthcare (897,898) as a senior. Rejects criminal
justice reform, police accountability, open immigration.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 23
PROFILE_NAME = "Wendy Walsh"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/wendy_walsh_ENDORSEMENTS_seed.sql'


def build_race_cancel():
    g = EndorsementGraph()
    # Accept: 101,288,297,322
    # Reject: 103,105,349,546

    g.because(101,  [(288,55),(297,45)])
    g.because(288,  [(297,55),(101,45)])
    g.because(297,  [(288,55),(101,45)])
    g.because(322,  [(288,55),(101,45)])

    g.rebuttal(103, [(101,55),(288,45)])
    g.rebuttal(105, [(101,55),(297,45)])
    g.rebuttal(349, [(101,55),(288,45)])   # colorblindness is Wendy's view ← racism made up
    g.rebuttal(546, [(101,55),(297,45)])
    return g


def build_abort():
    g = EndorsementGraph()
    # Accept: 902,1385,1387
    # Reject: 901

    g.because(902,  [(1385,55),(1387,45)])
    g.because(1385, [(902,55),(1387,45)])
    g.because(1387, [(1385,55),(902,45)])

    g.rebuttal(901, [(902,55),(1385,45)])
    return g


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,400,412,910,920
    # Reject: 192,615,616,617

    g.because(134,  [(400,55),(412,45)])
    g.because(400,  [(412,55),(134,45)])
    g.because(412,  [(400,55),(134,45)])
    g.because(910,  [(920,55),(400,45)])
    g.because(920,  [(412,55),(400,45)])

    g.rebuttal(192, [(134,55),(400,45)])
    g.rebuttal(615, [(612,55),(1237,45)])  # cross-cluster from IMMIG
    g.rebuttal(616, [(612,55),(1237,45)])
    g.rebuttal(617, [(1237,55),(612,45)])
    return g


def build_police_law():
    g = EndorsementGraph()
    # Accept: 165,561,651,652,777,1410
    # Reject: 107,123,145,560

    g.because(561,  [(1410,55),(651,45)])
    g.because(165,  [(561,55),(1410,45)])
    g.because(1410, [(561,55),(651,45)])
    g.because(651,  [(652,55),(561,45)])
    g.because(652,  [(651,55),(1410,45)])
    g.because(777,  [(1410,55),(561,45)])

    g.rebuttal(107, [(561,55),(1410,45)])
    g.rebuttal(123, [(1275,55),(412,45)])  # 1275 cross-cluster from FAITH_IMMIG
    g.rebuttal(145, [(561,55),(165,45)])
    g.rebuttal(560, [(561,55),(1410,45)])
    return g


def build_faith_immig():
    g = EndorsementGraph()
    # Accept: 428,612,844,897,898,1237,1275,1440
    # Reject: 161,230,611

    g.because(428,  [(844,55),(1440,45)])
    g.because(844,  [(428,55),(1440,45)])
    g.because(1440, [(428,55),(844,45)])
    # Immigration restriction
    g.because(612,  [(1237,55),(412,45)])   # 412 cross-cluster
    g.because(1237, [(612,55),(412,45)])
    # Climate skepticism
    g.because(1275, [(412,55),(400,45)])    # 400/412 cross-cluster
    # Healthcare (senior perspective — moderate)
    g.because(897,  [(898,55),(412,45)])
    g.because(898,  [(897,55),(412,45)])

    g.rebuttal(161, [(428,100)])
    g.rebuttal(230, [(1275,55),(412,45)])   # climate change framing
    g.rebuttal(611, [(612,55),(1237,45)])
    return g


CLUSTERS = [
    ('RACE_CANCEL', build_race_cancel()),
    ('ABORT',       build_abort()),
    ('GOVTREG',     build_govtreg()),
    ('POLICE_LAW',  build_police_law()),
    ('FAITH_IMMIG', build_faith_immig()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Wendy Walsh')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
