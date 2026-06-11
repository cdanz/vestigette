#!/usr/bin/env python3
"""
Endorsement definitions for Yvonne Young (profileID=25).

Yvonne: 21yo Black female, New Orleans LA, part-time retail + SUNO student.
-8 Dem. GMO reversed. Young progressive with deep Black church roots (428,
844). Strong racial justice, police accountability (not defund/abolish —
rejects 107,560,561), climate, voting rights, economic equity. Accepts 130
(may relate to support for safe pregnancy resources, not anti-choice framing).
539, 546 = community-based safety and racial justice movement.
Hardcoded: structural racism is real; the system must change; faith and
social justice are not in contradiction.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 25
PROFILE_NAME = "Yvonne Young"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/yvonne_young_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 103,105,109,111,112,113,114,115,116,145,148,151,153,154,
    #         155,163,169,171,174,175,207,217,218,219,221,222,223,236,
    #         238,239,240,241,484,485,539,543,544,545,546,551,603,1188,
    #         1313,1314,1321,1345,1347,1351,1498
    # Reject: 101,107,108,118,170,349,350,547,560,561,1319,1320

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
    g.because(239,  [(238,55),(236,45)])
    g.because(240,  [(241,55),(236,45)])
    g.because(241,  [(240,55),(236,45)])
    # Criminal justice
    g.because(484,  [(207,55),(175,45)])
    g.because(485,  [(484,55),(175,45)])
    g.because(103,  [(207,55),(175,45)])
    g.because(109,  [(171,55),(241,45)])
    g.because(105,  [(207,55),(1188,45)])
    g.because(1188, [(207,55),(1313,45)])
    # Civil rights/voting
    g.because(111,  [(112,55),(175,45)])
    g.because(112,  [(111,55),(113,45)])
    g.because(113,  [(112,55),(111,45)])
    g.because(114,  [(113,55),(111,45)])
    g.because(115,  [(113,55),(114,45)])
    g.because(116,  [(115,55),(113,45)])
    # Education / CRT
    g.because(169,  [(175,55),(1313,45)])
    g.because(171,  [(174,55),(175,45)])
    g.because(174,  [(175,55),(171,45)])
    g.because(1345, [(1313,55),(175,45)])
    g.because(1347, [(1345,55),(175,45)])
    g.because(1351, [(1345,55),(1347,45)])
    # Police reform (accountability, not abolition)
    g.because(145,  [(148,55),(151,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(151,  [(145,55),(154,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(175,45)])
    g.because(155,  [(154,55),(145,45)])
    g.because(163,  [(145,55),(148,45)])
    g.because(539,  [(145,55),(155,45)])
    # Racial justice movement
    g.because(543,  [(544,55),(546,45)])
    g.because(544,  [(543,55),(175,45)])
    g.because(545,  [(546,55),(543,45)])
    g.because(546,  [(603,55),(1313,45)])
    g.because(551,  [(546,55),(175,45)])
    g.because(603,  [(546,55),(175,45)])
    g.because(1321, [(603,55),(546,45)])
    g.because(1498, [(175,55),(217,45)])

    g.rebuttal(101,  [(175,55),(207,45)])
    g.rebuttal(107,  [(145,55),(539,45)])
    g.rebuttal(108,  [(175,55),(207,45)])
    g.rebuttal(118,  [(175,55),(219,45)])
    g.rebuttal(170,  [(175,55),(1313,45)])
    g.rebuttal(349,  [(175,55),(1313,45)])
    g.rebuttal(350,  [(175,55),(1314,45)])
    g.rebuttal(547,  [(1345,55),(175,45)])
    g.rebuttal(560,  [(145,55),(539,45)])
    g.rebuttal(561,  [(539,55),(145,45)])
    g.rebuttal(1319, [(546,55),(603,45)])
    g.rebuttal(1320, [(546,55),(603,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 123,321,476,477,863,892,893
    # Reject: 230,527

    g.because(321,  [(863,55),(892,45)])
    g.because(863,  [(892,55),(321,45)])
    g.because(892,  [(863,55),(893,45)])
    g.because(893,  [(892,55),(863,45)])
    g.because(476,  [(477,55),(321,45)])
    g.because(477,  [(476,55),(863,45)])
    g.because(123,  [(321,55),(863,45)])

    g.rebuttal(230, [(321,55),(863,45)])
    g.rebuttal(527, [(321,55),(476,45)])
    return g


def build_econ():
    g = EndorsementGraph()
    # Accept: 110,500,598,604,606,609
    # (no specific rejects in this cluster)

    g.because(110,  [(598,55),(500,45)])
    g.because(598,  [(110,55),(604,45)])
    g.because(500,  [(110,55),(598,45)])
    g.because(604,  [(606,55),(598,45)])
    g.because(606,  [(604,55),(609,45)])
    g.because(609,  [(606,55),(604,45)])
    return g


def build_voting():
    g = EndorsementGraph()
    # Accept: 182,184,278,279,280,313,317,320,334,335,355,356,357,640,1312,1425
    # (no specific rejects)

    g.because(182,  [(184,55),(355,45)])
    g.because(184,  [(182,55),(356,45)])
    g.because(355,  [(356,55),(357,45)])
    g.because(356,  [(355,55),(357,45)])
    g.because(357,  [(356,55),(355,45)])
    g.because(640,  [(357,55),(355,45)])
    g.because(278,  [(279,55),(280,45)])
    g.because(279,  [(278,55),(280,45)])
    g.because(280,  [(279,55),(278,45)])
    g.because(313,  [(320,55),(355,45)])
    g.because(317,  [(320,55),(355,45)])
    g.because(320,  [(313,55),(317,45)])
    g.because(334,  [(335,55),(355,45)])
    g.because(335,  [(334,55),(355,45)])
    g.because(1312, [(356,55),(355,45)])
    g.because(1425, [(355,55),(356,45)])
    return g


def build_faith_misc():
    g = EndorsementGraph()
    # Accept: 130,351,352,353,428,428,682,683,684,685,692,693,844,1425(→VOTING)
    # (428 and 844 cross-cultural: faith + social justice in Black church tradition)

    g.because(428,  [(844,55),(175,45)])   # 175 cross-cluster: faith + racial awareness
    g.because(844,  [(428,55),(175,45)])
    g.because(130,  [(428,55),(844,45)])   # resource/support framing ← faith values
    g.because(351,  [(352,55),(353,45)])
    g.because(352,  [(351,55),(353,45)])
    g.because(353,  [(352,55),(351,45)])
    g.because(682,  [(683,55),(684,45)])
    g.because(683,  [(682,55),(684,45)])
    g.because(684,  [(683,55),(685,45)])
    g.because(685,  [(684,55),(683,45)])
    g.because(692,  [(693,55),(682,45)])
    g.because(693,  [(692,55),(682,45)])
    return g


CLUSTERS = [
    ('RACE_POLICE', build_race_police()),
    ('CLIMATE',     build_climate()),
    ('ECON',        build_econ()),
    ('VOTING',      build_voting()),
    ('FAITH_MISC',  build_faith_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Yvonne Young')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
