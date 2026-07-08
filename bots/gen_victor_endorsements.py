#!/usr/bin/env python3
"""
Endorsement definitions for Victor Vasquez (profileID=22).

Victor: 30yo Black male, Atlanta GA, financial analyst. -2 Independent
non-voter. GMO reversed. Cross-cutting: accepts structural racism AND
free-market capitalism. Rejects both police extremes (defund/abolish AND
back-the-blue). Rejects racism tropes (101,108,118) and colorblindness
(349,350). Economic pragmatist: capitalism can coexist with racial equity.
Non-partisan: rejects Dem partisanship (90,94,104).
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 22
PROFILE_NAME = "Victor Vasquez"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/victor_vasquez_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 103,145,148,169,175,217,218,219,484,486,539,546,603
    # Reject: 101,107,108,118,349,350,485,547,548,560,561,1197,1319,1320

    g.because(175,  [(217,55),(218,45)])
    g.because(217,  [(175,55),(219,45)])
    g.because(218,  [(217,55),(219,45)])
    g.because(219,  [(175,55),(217,45)])
    g.because(484,  [(175,55),(218,45)])
    g.because(486,  [(484,55),(175,45)])
    g.because(103,  [(175,55),(218,45)])
    g.because(169,  [(175,55),(217,45)])
    g.because(145,  [(148,55),(539,45)])
    g.because(148,  [(145,55),(539,45)])
    g.because(539,  [(145,55),(148,45)])
    g.because(546,  [(603,55),(175,45)])
    g.because(603,  [(546,55),(175,45)])

    g.rebuttal(101,  [(175,55),(217,45)])
    g.rebuttal(107,  [(145,55),(539,45)])
    g.rebuttal(108,  [(175,55),(218,45)])
    g.rebuttal(118,  [(175,55),(217,45)])
    g.rebuttal(349,  [(175,55),(217,45)])
    g.rebuttal(350,  [(175,55),(219,45)])
    g.rebuttal(485,  [(175,55),(484,45)])   # Victor doesn't accept 485
    g.rebuttal(547,  [(539,55),(145,45)])
    g.rebuttal(548,  [(539,55),(145,45)])
    g.rebuttal(560,  [(145,55),(539,45)])
    g.rebuttal(561,  [(539,55),(145,45)])
    g.rebuttal(1197, [(175,55),(217,45)])
    g.rebuttal(1319, [(546,55),(603,45)])
    g.rebuttal(1320, [(546,55),(603,45)])
    return g


def build_econ():
    g = EndorsementGraph()
    # Accept: 110,136,322,323,367,400,401,481,482,483,498,499,500,501,502,590
    # Reject: 574

    # Free market (Victor accepts capitalism as financial analyst)
    g.because(136,  [(401,55),(400,45)])
    g.because(400,  [(401,55),(136,45)])
    g.because(401,  [(136,55),(400,45)])
    # Gov skepticism
    g.because(322,  [(400,55),(136,45)])
    g.because(323,  [(322,55),(400,45)])
    # Economic equity (coexists with market view)
    g.because(110,  [(500,55),(499,45)])
    g.because(500,  [(501,55),(110,45)])
    g.because(501,  [(500,55),(502,45)])
    g.because(502,  [(501,55),(500,45)])
    g.because(498,  [(499,55),(500,45)])
    g.because(499,  [(498,55),(500,45)])
    g.because(590,  [(500,55),(110,45)])
    # Housing / community
    g.because(481,  [(482,55),(483,45)])
    g.because(482,  [(481,55),(483,45)])
    g.because(483,  [(482,55),(481,45)])
    # Racial equity args
    g.because(367,  [(175,55),(217,45)])   # cross-cluster

    g.rebuttal(574, [(136,55),(400,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Reject: 90,94,104 (partisanship)

    g.rebuttal(90,  [(322,55),(136,45)])   # cross-cluster
    g.rebuttal(94,  [(322,55),(401,45)])
    g.rebuttal(104, [(322,55),(136,45)])
    return g


CLUSTERS = [
    ('RACE_POLICE', build_race_police()),
    ('ECON',        build_econ()),
    ('MISC',        build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Victor Vasquez')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
