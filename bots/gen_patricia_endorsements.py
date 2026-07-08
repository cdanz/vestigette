#!/usr/bin/env python3
"""
Endorsement definitions for Patricia Powell (profileID=16).

Patricia: 63yo Black female, Greenville MS, church secretary. -8 Dem.
GMO reversed. Deeply embedded in Black church tradition that merges
faith, civil rights, and Democratic politics. Core: racial justice,
voting rights, community uplift. Unique tension: accepts 1385 (pro-life)
and 844 (traditional values) from faith, despite being a strong Dem.
Rejects both police extremes (560, 561) — supports accountability (145).
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 16
PROFILE_NAME = "Patricia Powell"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/patricia_powell_ENDORSEMENTS_seed.sql'


def build_race_civil_rights():
    g = EndorsementGraph()
    # Accept: 100,103,105,111,112,113,115,116,144,145,148,151,153,154,
    #         155,169,171,174,175,207,217,218,219,221,222,223,236,238,
    #         240,241,484,485,500,539,543,546,551,603,1188,1202,1313,1314,1321,1345,1347,1351
    # Reject: 349,350,547,549,560,561,1197,1229,1346

    # Structural racism
    g.because(175,  [(1313,55),(207,45)])
    g.because(1313, [(1314,55),(175,45)])
    g.because(1314, [(1313,55),(207,45)])
    g.because(207,  [(175,55),(218,45)])
    g.because(218,  [(207,55),(219,45)])
    g.because(219,  [(175,55),(207,45)])
    g.because(217,  [(207,55),(175,45)])
    g.because(221,  [(175,55),(241,45)])
    g.because(222,  [(221,55),(175,45)])
    g.because(223,  [(221,55),(222,45)])
    # Historical
    g.because(236,  [(241,55),(175,45)])
    g.because(238,  [(236,55),(241,45)])
    g.because(240,  [(241,55),(236,45)])
    g.because(241,  [(240,55),(236,45)])
    # Criminal justice
    g.because(484,  [(207,55),(175,45)])
    g.because(485,  [(484,55),(175,45)])
    g.because(103,  [(207,55),(175,45)])
    g.because(105,  [(207,55),(1188,45)])
    g.because(1188, [(207,55),(1313,45)])
    # Education / CRT
    g.because(169,  [(175,55),(1313,45)])
    g.because(171,  [(174,55),(175,45)])
    g.because(174,  [(175,55),(171,45)])
    # Civil rights laws
    g.because(100,  [(175,55),(207,45)])
    g.because(111,  [(112,55),(175,45)])
    g.because(112,  [(111,55),(113,45)])
    g.because(113,  [(112,55),(111,45)])
    g.because(115,  [(113,55),(111,45)])
    g.because(116,  [(115,55),(113,45)])
    # Police reform (Patricia supports accountability)
    g.because(145,  [(148,55),(151,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(151,  [(145,55),(154,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(175,45)])
    g.because(155,  [(154,55),(145,45)])
    g.because(539,  [(145,55),(155,45)])
    # BLM / racial justice
    g.because(144,  [(175,55),(207,45)])
    g.because(543,  [(546,55),(603,45)])
    g.because(546,  [(603,55),(1202,45)])
    g.because(551,  [(546,55),(175,45)])
    g.because(603,  [(546,55),(175,45)])
    g.because(1202, [(546,55),(1313,45)])
    g.because(1321, [(603,55),(546,45)])
    # CRT / education curriculum
    g.because(1345, [(1313,55),(175,45)])
    g.because(1347, [(1345,55),(175,45)])
    g.because(1351, [(1345,55),(1347,45)])
    # Economic
    g.because(500,  [(175,55),(207,45)])

    g.rebuttal(349,  [(175,55),(1313,45)])
    g.rebuttal(350,  [(175,55),(1314,45)])
    g.rebuttal(547,  [(1345,55),(175,45)])
    g.rebuttal(549,  [(546,55),(603,45)])
    g.rebuttal(560,  [(145,55),(539,45)])   # abolish — Patricia wants accountability
    g.rebuttal(561,  [(539,55),(145,45)])   # back the blue uncritically
    g.rebuttal(1197, [(1188,55),(539,45)])
    g.rebuttal(1229, [(175,55),(1313,45)])
    g.rebuttal(1346, [(1345,55),(1313,45)])
    return g


def build_faith_church():
    g = EndorsementGraph()
    # Accept: 130,428,615,617,844,972,1005,1385,1440
    # Patricia: faith-based Dem — pro-life from faith, but Democrat on everything else

    g.because(428,  [(844,55),(1440,45)])
    g.because(844,  [(428,55),(1440,45)])
    g.because(1440, [(428,55),(844,45)])
    g.because(1005, [(428,55),(844,45)])
    # Pro-life from faith (unusual for -8 Dem, but Black church tradition)
    g.because(1385, [(428,55),(844,45)])
    g.because(130,  [(1385,55),(428,45)])
    # Immigration (compassion from faith)
    g.because(615,  [(428,55),(617,45)])
    g.because(617,  [(615,55),(428,45)])
    g.because(972,  [(617,55),(428,45)])
    return g


def build_voting():
    g = EndorsementGraph()
    # Accept: 88,89,90,94,96,104,182,184,346,347,355,356,357,640,
    #         770,775,1357,1380
    # Reject: 80,1365

    # Democratic party support
    g.because(88,   [(89,55),(96,45)])
    g.because(89,   [(88,55),(90,45)])
    g.because(90,   [(89,55),(96,45)])
    g.because(94,   [(90,55),(89,45)])
    g.because(96,   [(94,55),(90,45)])
    g.because(104,  [(89,55),(90,45)])
    # Voting rights
    g.because(182,  [(184,55),(355,45)])
    g.because(184,  [(182,55),(356,45)])
    g.because(355,  [(356,55),(357,45)])
    g.because(356,  [(355,55),(357,45)])
    g.because(357,  [(356,55),(355,45)])
    g.because(640,  [(357,55),(355,45)])
    g.because(346,  [(347,55),(355,45)])
    g.because(347,  [(346,55),(357,45)])
    g.because(770,  [(355,55),(356,45)])
    g.because(775,  [(770,55),(355,45)])
    g.because(1357, [(355,55),(356,45)])
    g.because(1380, [(1357,55),(182,45)])

    g.rebuttal(80,   [(88,55),(90,45)])
    g.rebuttal(1365, [(355,55),(1357,45)])
    return g


CLUSTERS = [
    ('RACE_CIVIL_RIGHTS', build_race_civil_rights()),
    ('FAITH_CHURCH',      build_faith_church()),
    ('VOTING',            build_voting()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Patricia Powell')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
