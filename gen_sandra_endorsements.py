#!/usr/bin/env python3
"""
Endorsement definitions for Sandra Sullivan (profileID=19).

Sandra: 57yo white Jewish female, Scarsdale NY, law partner. -7 Dem.
GMO reversed. Lawyer lens: civil rights, rule of law, democratic norms,
anti-authoritarianism. Strongly progressive on race, climate, healthcare,
LGBTQ+. Nuanced on Israel/anti-semitism (383-389 cluster). Police reform
yes, abolition no. Faith community (1005) as Jewish identity, not
evangelical. Rejects conspiracy framing (120, anti-MAGA).
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 19
PROFILE_NAME = "Sandra Sullivan"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/sandra_sullivan_ENDORSEMENTS_seed.sql'


def build_dem_party():
    g = EndorsementGraph()
    # Accept: 88,89,90,91,92,93,94,96,97,104
    # Reject: 80,120

    g.because(88,  [(89,55),(94,45)])
    g.because(89,  [(88,55),(90,45)])
    g.because(90,  [(89,55),(96,45)])
    g.because(91,  [(90,55),(88,45)])
    g.because(92,  [(91,55),(90,45)])
    g.because(93,  [(92,55),(91,45)])
    g.because(94,  [(90,55),(89,45)])
    g.because(96,  [(94,55),(90,45)])
    g.because(97,  [(96,55),(94,45)])
    g.because(104, [(89,55),(90,45)])

    g.rebuttal(80,  [(88,55),(90,45)])
    g.rebuttal(120, [(88,55),(94,45)])
    return g


def build_race_police():
    g = EndorsementGraph()
    # Accept: 103,105,145,148,151,153,154,155,169,175,217,219,221,539,546,1200,1201,1202,1313
    # Reject: 349,547,561

    g.because(175,  [(1313,55),(217,45)])
    g.because(1313, [(175,55),(217,45)])
    g.because(217,  [(175,55),(219,45)])
    g.because(219,  [(175,55),(217,45)])
    g.because(221,  [(175,55),(219,45)])
    g.because(103,  [(175,55),(219,45)])
    g.because(105,  [(175,55),(1313,45)])
    g.because(169,  [(175,55),(1313,45)])
    g.because(145,  [(148,55),(151,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(151,  [(145,55),(154,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(175,45)])
    g.because(155,  [(154,55),(145,45)])
    g.because(539,  [(145,55),(155,45)])
    g.because(546,  [(1202,55),(175,45)])
    g.because(1200, [(175,55),(219,45)])
    g.because(1201, [(1200,55),(175,45)])
    g.because(1202, [(546,55),(1313,45)])

    g.rebuttal(349, [(175,55),(1313,45)])
    g.rebuttal(547, [(1313,55),(175,45)])
    g.rebuttal(561, [(539,55),(145,45)])
    return g


def build_legal_civil():
    g = EndorsementGraph()
    # Accept: 346,347,383,384,386,387,389,422,434,435,441,456,457,469,470,640,756,770,1005
    # (No specific rejects — Sandra as a lawyer accepts the rule-of-law framework)

    g.because(346,  [(347,55),(383,45)])
    g.because(347,  [(346,55),(384,45)])
    g.because(383,  [(384,55),(386,45)])
    g.because(384,  [(383,55),(387,45)])
    g.because(386,  [(383,55),(389,45)])
    g.because(387,  [(384,55),(389,45)])
    g.because(389,  [(386,55),(387,45)])
    g.because(422,  [(383,55),(384,45)])
    g.because(434,  [(435,55),(441,45)])
    g.because(435,  [(434,55),(441,45)])
    g.because(441,  [(435,55),(434,45)])
    g.because(456,  [(457,55),(441,45)])
    g.because(457,  [(456,55),(435,45)])
    g.because(469,  [(470,55),(457,45)])
    g.because(470,  [(469,55),(456,45)])
    g.because(640,  [(456,55),(470,45)])
    g.because(756,  [(470,55),(456,45)])
    g.because(770,  [(640,55),(356,45)])   # 356 cross-cluster from VOTING
    g.because(1005, [(383,55),(346,45)])
    return g


def build_voting():
    g = EndorsementGraph()
    # Accept: 182,184,355,356,357,597
    # Reject: (none new)

    g.because(182,  [(184,55),(355,45)])
    g.because(184,  [(182,55),(356,45)])
    g.because(355,  [(356,55),(357,45)])
    g.because(356,  [(355,55),(357,45)])
    g.because(357,  [(356,55),(355,45)])
    g.because(597,  [(355,55),(356,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 123,321,414,476,863
    # Reject: 230,574,1275

    g.because(321,  [(863,55),(414,45)])
    g.because(863,  [(321,55),(414,45)])
    g.because(414,  [(321,55),(863,45)])
    g.because(476,  [(321,55),(414,45)])
    g.because(123,  [(321,55),(863,45)])

    g.rebuttal(230,  [(321,55),(863,45)])
    g.rebuttal(574,  [(321,55),(414,45)])
    g.rebuttal(1275, [(321,55),(863,45)])
    return g


def build_healthcare():
    g = EndorsementGraph()
    # Accept: 864,866,894,895,896,897,898,909
    # (no specific rejects here)

    g.because(895,  [(896,55),(897,45)])
    g.because(896,  [(895,55),(898,45)])
    g.because(897,  [(896,55),(895,45)])
    g.because(898,  [(897,55),(896,45)])
    g.because(894,  [(895,55),(898,45)])
    g.because(864,  [(895,55),(866,45)])
    g.because(866,  [(864,55),(895,45)])
    g.because(909,  [(895,55),(896,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 110,137,193(→wait: REJECT),494,495,496,745,958,696,698
    # Wait - 193 is in Sandra's REJECTS. Let me only use accepts.
    # Accept: 110,137,494,495,496,745,958,696,698
    # Reject: 193,230(→CLIMATE),288

    g.because(110,  [(745,55),(494,45)])
    g.because(745,  [(110,55),(494,45)])
    g.because(494,  [(495,55),(496,45)])
    g.because(495,  [(494,55),(496,45)])
    g.because(496,  [(494,55),(495,45)])
    g.because(137,  [(110,55),(745,45)])
    g.because(696,  [(698,55),(958,45)])
    g.because(698,  [(696,55),(958,45)])
    g.because(958,  [(698,55),(696,45)])

    g.rebuttal(193, [(110,55),(745,45)])
    g.rebuttal(288, [(383,55),(175,45)])   # cancel culture = mob ← civil rights framework + structural racism
    return g


CLUSTERS = [
    ('DEM_PARTY',    build_dem_party()),
    ('RACE_POLICE',  build_race_police()),
    ('LEGAL_CIVIL',  build_legal_civil()),
    ('VOTING',       build_voting()),
    ('CLIMATE',      build_climate()),
    ('HEALTHCARE',   build_healthcare()),
    ('MISC',         build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Sandra Sullivan')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
