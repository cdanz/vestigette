#!/usr/bin/env python3
"""
Endorsement definitions for Harold Hughes (profileID=8).

Harold: 45yo Black male, Detroit MI, logistics coordinator. -5 Dem
(reluctant). Core issues: racial justice, police accountability,
working-class economics. Pro-reform policing — rejects both defund/
abolish AND uncritical back-the-blue. Votes Dem but not enthusiastically.
Hardcoded: structural racism is real; police need accountability;
working-class people deserve economic dignity.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 8
PROFILE_NAME = "Harold Hughes"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/harold_hughes_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 103,105,109,145,148,153,154,155,169,171,174,175,207,
    #         217,218,219,221,222,223,236,240,241,484,539,546,603,
    #         1188,1202,1313,1314,1321
    # Reject: 107,118,166,349,350,560,561,1319

    # Structural racism thesis
    g.because(175,  [(1313,55),(207,45)])
    g.because(1313, [(1314,55),(175,45)])
    g.because(1314, [(1313,55),(207,45)])
    g.because(207,  [(175,55),(218,45)])
    g.because(218,  [(207,55),(219,45)])
    g.because(219,  [(175,55),(207,45)])
    g.because(217,  [(207,55),(175,45)])
    # Racial disparities
    g.because(221,  [(175,55),(241,45)])
    g.because(222,  [(221,55),(175,45)])
    g.because(223,  [(221,55),(222,45)])
    # Historical foundation
    g.because(236,  [(241,55),(175,45)])
    g.because(240,  [(241,55),(236,45)])
    g.because(241,  [(240,55),(236,45)])
    # Criminal justice
    g.because(484,  [(207,55),(175,45)])
    g.because(103,  [(207,55),(175,45)])
    g.because(109,  [(171,55),(241,45)])
    # Education / racial awareness
    g.because(169,  [(175,55),(1313,45)])
    g.because(171,  [(174,55),(175,45)])
    g.because(174,  [(175,55),(171,45)])
    # Policing disparities
    g.because(1188, [(207,55),(1313,45)])
    g.because(105,  [(207,55),(1188,45)])
    # Police reform — moderate position (not defund, not abolish)
    g.because(145,  [(148,55),(153,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(175,45)])
    g.because(155,  [(154,55),(145,45)])
    g.because(539,  [(145,55),(155,45)])
    # BLM / racial justice movement
    g.because(546,  [(603,55),(1202,45)])
    g.because(603,  [(546,55),(175,45)])
    g.because(1202, [(546,55),(1313,45)])
    g.because(1321, [(603,55),(546,45)])

    g.rebuttal(107,  [(145,55),(539,45)])   # defund — Harold wants reform, not defunding
    g.rebuttal(118,  [(175,55),(207,45)])   # racist trope
    g.rebuttal(166,  [(539,55),(145,45)])   # "police unions aren't racist" uncritical defense
    g.rebuttal(349,  [(175,55),(1313,45)])  # colorblindness ignores structural reality
    g.rebuttal(350,  [(175,55),(1314,45)])  # reverse racism
    g.rebuttal(560,  [(145,55),(539,45)])   # abolish — Harold is not there
    g.rebuttal(561,  [(539,55),(145,45)])   # back the blue uncritically
    g.rebuttal(1319, [(546,55),(603,45)])   # all-lives-matter dismissal
    return g


def build_econ():
    g = EndorsementGraph()
    # Accept: 110,187,200,500,501,574,575,598,986,1498
    # Reject: 266,607

    g.because(598,  [(110,55),(500,45)])
    g.because(110,  [(598,55),(500,45)])
    g.because(500,  [(501,55),(110,45)])
    g.because(501,  [(500,55),(598,45)])
    g.because(574,  [(110,55),(598,45)])
    g.because(575,  [(574,55),(598,45)])
    g.because(187,  [(200,55),(110,45)])
    g.because(200,  [(187,55),(110,45)])
    g.because(986,  [(598,55),(500,45)])
    g.because(1498, [(598,55),(110,45)])

    g.rebuttal(266, [(598,55),(110,45)])   # "gov check is unearned" — Harold disagrees
    g.rebuttal(607, [(598,55),(500,45)])   # work requirements for welfare
    return g


def build_dem():
    g = EndorsementGraph()
    # Accept: 89,90,104,111,112,113,115,116
    # Reject: 80

    g.because(89,  [(90,55),(104,45)])
    g.because(90,  [(89,55),(104,45)])
    g.because(104, [(89,55),(90,45)])
    g.because(111, [(89,55),(90,45)])
    g.because(112, [(111,55),(89,45)])
    g.because(113, [(112,55),(111,45)])
    g.because(115, [(113,55),(111,45)])
    g.because(116, [(115,55),(113,45)])

    g.rebuttal(80, [(89,55),(90,45)])   # anti-Democrat argument
    return g


CLUSTERS = [
    ('RACE_POLICE', build_race_police()),
    ('ECON',        build_econ()),
    ('DEM',         build_dem()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Harold Hughes')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
