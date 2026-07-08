#!/usr/bin/env python3
"""
Endorsement definitions for Diana Delgado (profileID=4).

Diana: 28yo Puerto Rican-American, LA public school teacher (K-3).
-9/10 progressive. Core issues: housing, education equity, climate,
immigration (personal), police brutality. Skeptical of Democratic
establishment as well as Republicans. Trusts teachers' union, community
organizers, Latina activists. Hardcoded: children deserve equal
opportunity; climate is existential; rent crisis is not an accident;
police cause more harm than good; Puerto Rico deserves statehood.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 4
PROFILE_NAME = "Diana Delgado"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/diana_delgado_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 103,105,107,109,145,148,151,153,154,155,163,169,171,174,175,207,
    #         217,218,219,221,236,240,241,484,485,539,546,560,603,1188,1202,
    #         1207,1313,1314,1321,1345,1347,1351
    # Reject: 100,101,108,118,165,166,349,350,561,1197,1229,1319,1320,1410

    # Structural racism thesis (175,1313,1314,207)
    g.because(175,  [(1313,55),(207,45)])
    g.because(1313, [(1314,55),(175,45)])
    g.because(1314, [(1313,55),(207,45)])
    g.because(207,  [(175,55),(218,45)])
    g.because(218,  [(207,55),(219,45)])
    g.because(219,  [(539,55),(207,45)])
    g.because(217,  [(207,55),(175,45)])
    g.because(221,  [(175,55),(241,45)])
    # Historical foundation (236,240,241)
    g.because(236,  [(241,55),(175,45)])
    g.because(240,  [(241,55),(236,45)])
    g.because(241,  [(240,55),(236,45)])
    # CRT / education (1207,1345,1347,1351,169,171,174)
    g.because(1207, [(1345,55),(1313,45)])
    g.because(1345, [(1207,55),(175,45)])
    g.because(1347, [(1345,55),(175,45)])
    g.because(1351, [(1345,55),(1347,45)])
    g.because(169,  [(175,55),(1345,45)])
    g.because(171,  [(174,55),(175,45)])
    g.because(174,  [(175,55),(171,45)])
    # Criminal justice disparity (103,109,484,485)
    g.because(103,  [(207,55),(175,45)])
    g.because(109,  [(171,55),(241,45)])
    g.because(484,  [(485,55),(175,45)])
    g.because(485,  [(484,55),(207,45)])
    # Police reform cluster (107,145,148,151,153,154,155,163,539,560)
    g.because(145,  [(107,50),(155,50)])
    g.because(107,  [(145,55),(151,45)])
    g.because(151,  [(107,55),(539,45)])
    g.because(539,  [(219,55),(151,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(155,45)])
    g.because(155,  [(154,55),(145,45)])
    g.because(163,  [(107,50),(145,50)])
    g.because(560,  [(107,55),(145,45)])
    g.because(105,  [(207,55),(1188,45)])
    # BLM / racial justice movement (546,603,1202,1321)
    g.because(546,  [(603,55),(1202,45)])
    g.because(603,  [(546,55),(175,45)])
    g.because(1202, [(546,55),(1313,45)])
    g.because(1321, [(603,55),(546,45)])
    # Racial disparities in policing (1188)
    g.because(1188, [(207,55),(1313,45)])

    # Rebuttals
    g.rebuttal(100,  [(175,55),(1313,45)])   # no system fair — Diana believes systems CAN be fixed
    g.rebuttal(101,  [(175,55),(207,45)])    # racism made up
    g.rebuttal(108,  [(207,55),(175,45)])    # black people commit more crime
    g.rebuttal(118,  [(175,55),(207,45)])    # inherently less civil
    g.rebuttal(165,  [(151,55),(107,45)])    # police unions not racist
    g.rebuttal(166,  [(539,55),(219,45)])    # some police defense arg
    g.rebuttal(349,  [(175,55),(1313,45)])   # colorblindness
    g.rebuttal(350,  [(175,55),(1314,45)])   # reverse racism
    g.rebuttal(561,  [(107,55),(145,45)])    # back the blue
    g.rebuttal(1197, [(1188,55),(207,45)])   # colorblind policing
    g.rebuttal(1229, [(175,55),(1313,45)])   # OK to be white
    g.rebuttal(1319, [(546,55),(603,45)])    # all lives matter type
    g.rebuttal(1320, [(546,55),(603,45)])    # BLM is violent
    g.rebuttal(1410, [(145,55),(560,45)])    # officer safety first above all
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 123,321,414,476,477,863,892
    # Reject: 230,1275,1276

    g.because(321,  [(863,55),(892,45)])
    g.because(863,  [(892,55),(321,45)])
    g.because(892,  [(863,55),(321,45)])
    g.because(476,  [(477,55),(321,45)])
    g.because(477,  [(476,55),(863,45)])
    g.because(414,  [(321,55),(477,45)])
    g.because(123,  [(321,55),(863,45)])

    g.rebuttal(230,  [(321,55),(863,45)])
    g.rebuttal(1275, [(321,55),(892,45)])
    g.rebuttal(1276, [(321,55),(476,45)])
    return g


def build_wealth_labor():
    g = EndorsementGraph()
    # Accept: 54,110,185,192,203,204,494,495,604,606,609,666,745,836,1143
    # Reject: 134,135,193,727

    g.because(54,   [(185,55),(745,45)])
    g.because(185,  [(54,50),(192,50)])
    g.because(192,  [(185,55),(110,45)])
    g.because(110,  [(203,55),(192,45)])
    g.because(203,  [(204,55),(110,45)])
    g.because(204,  [(203,55),(110,45)])
    g.because(745,  [(54,55),(185,45)])
    g.because(494,  [(495,55),(609,45)])
    g.because(495,  [(494,55),(604,45)])
    g.because(604,  [(606,55),(495,45)])
    g.because(606,  [(604,55),(609,45)])
    g.because(609,  [(606,55),(495,45)])
    g.because(666,  [(54,55),(604,45)])
    g.because(836,  [(1143,55),(604,45)])
    g.because(1143, [(836,55),(604,45)])

    g.rebuttal(134, [(110,55),(203,45)])
    g.rebuttal(135, [(54,55),(192,45)])
    g.rebuttal(193, [(192,55),(185,45)])
    g.rebuttal(727, [(494,55),(495,45)])
    return g


def build_vote():
    g = EndorsementGraph()
    # Accept: 182,184,355,356,357,640,1357,1380
    # Reject: 1365

    g.because(182,  [(184,55),(355,45)])
    g.because(184,  [(182,55),(356,45)])
    g.because(355,  [(356,55),(357,45)])
    g.because(356,  [(355,55),(357,45)])
    g.because(357,  [(356,55),(640,45)])
    g.because(640,  [(357,55),(355,45)])
    g.because(1357, [(355,55),(356,45)])
    g.because(1380, [(1357,55),(182,45)])

    g.rebuttal(1365, [(355,55),(1357,45)])
    return g


def build_trans():
    g = EndorsementGraph()
    # Accept: 790,795,797,801
    # Reject: 142,785,791

    g.because(790,  [(795,55),(797,45)])
    g.because(795,  [(790,55),(797,45)])
    g.because(797,  [(795,55),(790,45)])
    g.because(801,  [(795,55),(790,45)])

    g.rebuttal(142, [(795,55),(797,45)])
    g.rebuttal(785, [(795,55),(797,45)])
    g.rebuttal(791, [(797,55),(790,45)])
    return g


def build_immig():
    g = EndorsementGraph()
    # Accept: 616,617,972,1159,1160
    # Reject: 611,612,1237

    g.because(616,  [(1159,55),(617,45)])
    g.because(617,  [(616,55),(1159,45)])
    g.because(1159, [(1160,55),(616,45)])
    g.because(1160, [(1159,55),(617,45)])
    g.because(972,  [(1159,55),(1160,45)])

    g.rebuttal(611,  [(1159,55),(616,45)])
    g.rebuttal(612,  [(616,55),(1159,45)])
    g.rebuttal(1237, [(1159,55),(616,45)])
    return g


def build_gop():
    g = EndorsementGraph()
    # Accept: 88,89,90,94,96,104
    # Reject: 80,120

    g.because(88,  [(89,50),(90,50)])
    g.because(89,  [(88,55),(96,45)])
    g.because(90,  [(89,55),(88,45)])
    g.because(94,  [(90,55),(96,45)])
    g.because(96,  [(94,55),(90,45)])
    g.because(104, [(94,55),(90,45)])

    g.rebuttal(80,  [(88,55),(90,45)])
    g.rebuttal(120, [(88,55),(89,45)])
    return g


CLUSTERS = [
    ('RACE_POLICE',  build_race_police()),
    ('CLIMATE',      build_climate()),
    ('WEALTH_LABOR', build_wealth_labor()),
    ('VOTE',         build_vote()),
    ('TRANS',        build_trans()),
    ('IMMIG',        build_immig()),
    ('GOP',          build_gop()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Diana Delgado')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
