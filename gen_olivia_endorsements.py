#!/usr/bin/env python3
"""
Endorsement definitions for Olivia O'Brien (profileID=15).

Olivia: 48yo white female, Waukesha WI, assistant principal. -3 soft Dem
(regrets 2016 Trump vote). GMO reversed. Education policy is her lens.
Believes in racial equity without being strident about it. Cares about
healthcare, voting rights. Accepts moderate police reform, not defunding.
Accepts 68 (anti-socialism economic arg) as a pragmatic educator, not
an ideologue. Skeptical of both partisan camps.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 15
PROFILE_NAME = "Olivia O'Brien"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/olivia_obrien_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 100,103,145,148,153,154,175,217,219,242,484,485,539,546,603
    # Reject: 101,107,193,560

    g.because(175,  [(217,55),(219,45)])
    g.because(217,  [(175,55),(219,45)])
    g.because(219,  [(175,55),(217,45)])
    g.because(242,  [(175,55),(219,45)])
    g.because(484,  [(485,55),(175,45)])
    g.because(485,  [(484,55),(175,45)])
    g.because(103,  [(175,55),(484,45)])
    g.because(100,  [(175,55),(217,45)])
    g.because(145,  [(148,55),(153,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(175,45)])
    g.because(539,  [(145,55),(154,45)])
    g.because(546,  [(603,55),(175,45)])
    g.because(603,  [(546,55),(175,45)])

    g.rebuttal(101, [(175,55),(217,45)])
    g.rebuttal(107, [(145,55),(539,45)])
    g.rebuttal(193, [(175,55),(217,45)])
    g.rebuttal(560, [(145,55),(539,45)])
    return g


def build_education():
    g = EndorsementGraph()
    # Accept: 359,360,362,363,364,365,748,756
    # Reject: 361,547

    g.because(359,  [(360,55),(362,45)])
    g.because(360,  [(359,55),(362,45)])
    g.because(362,  [(360,55),(363,45)])
    g.because(363,  [(362,55),(364,45)])
    g.because(364,  [(363,55),(365,45)])
    g.because(365,  [(364,55),(363,45)])
    g.because(748,  [(365,55),(363,45)])
    g.because(756,  [(748,55),(365,45)])

    g.rebuttal(361, [(360,55),(362,45)])
    g.rebuttal(547, [(365,55),(364,45)])
    return g


def build_voting():
    g = EndorsementGraph()
    # Accept: 182,184,320,355,356
    # Reject: 80

    g.because(182,  [(184,55),(355,45)])
    g.because(184,  [(182,55),(356,45)])
    g.because(355,  [(356,55),(182,45)])
    g.because(356,  [(355,55),(182,45)])
    g.because(320,  [(355,55),(356,45)])

    g.rebuttal(80, [(182,55),(355,45)])
    return g


def build_healthcare():
    g = EndorsementGraph()
    # Accept: 894,895,896,897,898,909
    # Reject: 910

    g.because(895,  [(896,55),(897,45)])
    g.because(896,  [(895,55),(898,45)])
    g.because(897,  [(896,55),(895,45)])
    g.because(898,  [(897,55),(896,45)])
    g.because(894,  [(895,55),(896,45)])
    g.because(909,  [(895,55),(898,45)])

    g.rebuttal(910, [(895,55),(897,45)])
    return g


def build_econ():
    g = EndorsementGraph()
    # Accept: 68,110,200,500,504,590,636,654,745
    # Reject: 67,106,288

    g.because(110,  [(745,55),(500,45)])
    g.because(745,  [(110,55),(500,45)])
    g.because(500,  [(110,55),(745,45)])
    g.because(200,  [(110,55),(500,45)])
    g.because(68,   [(500,55),(110,45)])   # anti-socialism ← labor rights + econ concern
    g.because(504,  [(500,55),(200,45)])
    g.because(590,  [(500,55),(110,45)])
    g.because(636,  [(500,55),(745,45)])
    g.because(654,  [(590,55),(500,45)])

    g.rebuttal(67,  [(68,55),(110,45)])
    g.rebuttal(106, [(110,55),(500,45)])
    g.rebuttal(288, [(293,55),(100,45)])   # 293/100 cross-cluster
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 293,295,367,368,374,378,413,416,463,578,579,580,
    #         696,697,698,745(→ECON),958
    # Reject: (none new)

    g.because(293,  [(295,55),(100,45)])   # 100 cross-cluster
    g.because(295,  [(293,55),(100,45)])
    g.because(367,  [(368,55),(295,45)])
    g.because(368,  [(367,55),(295,45)])
    g.because(374,  [(367,55),(368,45)])
    g.because(378,  [(374,55),(367,45)])
    g.because(413,  [(416,55),(295,45)])
    g.because(416,  [(295,55),(367,45)])
    g.because(463,  [(416,55),(367,45)])
    g.because(578,  [(579,55),(580,45)])
    g.because(579,  [(578,55),(580,45)])
    g.because(580,  [(579,55),(578,45)])
    g.because(696,  [(697,55),(698,45)])
    g.because(697,  [(696,55),(698,45)])
    g.because(698,  [(697,55),(696,45)])
    g.because(958,  [(698,55),(696,45)])
    return g


CLUSTERS = [
    ('RACE_POLICE', build_race_police()),
    ('EDUCATION',   build_education()),
    ('VOTING',      build_voting()),
    ('HEALTHCARE',  build_healthcare()),
    ('ECON',        build_econ()),
    ('MISC',        build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Generate endorsement SQL for Olivia O'Brien")
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
