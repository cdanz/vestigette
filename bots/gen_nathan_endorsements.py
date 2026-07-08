#!/usr/bin/env python3
"""
Endorsement definitions for Nathan Nguyen (profileID=14).

Nathan: 26yo Vietnamese-American male, Houston TX, data analyst. +2
Independent non-voter. GMO opinions reversed. Cross-cutting views: accepts
climate science, racial justice, police reform (moderate), and ALSO accepts
government inefficiency / market arguments. Data-driven pragmatist who sees
partisan tribalism as the problem. Rejects all police extremes (defund,
abolish, AND back-the-blue). Rejects colorblindness and "OK to be white"
as data-blind.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 14
PROFILE_NAME = "Nathan Nguyen"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/nathan_nguyen_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 100,103,145,148,175,217,219,539
    # Reject: 107,349,350,560,561,1229

    g.because(175,  [(217,55),(219,45)])
    g.because(217,  [(175,55),(219,45)])
    g.because(219,  [(175,55),(217,45)])
    g.because(100,  [(175,55),(217,45)])
    g.because(103,  [(175,55),(219,45)])
    g.because(145,  [(148,55),(539,45)])
    g.because(148,  [(145,55),(539,45)])
    g.because(539,  [(145,55),(148,45)])

    g.rebuttal(107,  [(145,55),(539,45)])
    g.rebuttal(349,  [(175,55),(217,45)])
    g.rebuttal(350,  [(175,55),(219,45)])
    g.rebuttal(560,  [(145,55),(539,45)])
    g.rebuttal(561,  [(539,55),(145,45)])
    g.rebuttal(1229, [(175,55),(100,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 321,414,530
    # Reject: 230,527

    g.because(321,  [(530,55),(414,45)])
    g.because(530,  [(321,55),(414,45)])
    g.because(414,  [(321,55),(530,45)])

    g.rebuttal(230, [(321,55),(414,45)])
    g.rebuttal(527, [(530,55),(321,45)])
    return g


def build_econ():
    g = EndorsementGraph()
    # Accept: 110,200,203,275,276,277,400,401,412,500
    # Reject: 267,289

    # Gov inefficiency — Nathan accepts this as data-driven (not ideological)
    g.because(400,  [(412,55),(275,45)])
    g.because(412,  [(400,55),(275,45)])
    g.because(275,  [(400,55),(412,45)])
    g.because(401,  [(400,55),(275,45)])
    g.because(276,  [(277,55),(275,45)])
    g.because(277,  [(276,55),(275,45)])
    g.because(200,  [(276,55),(275,45)])
    # Economic inequality — Nathan also accepts this
    g.because(110,  [(203,55),(500,45)])
    g.because(203,  [(110,55),(500,45)])
    g.because(500,  [(110,55),(203,45)])

    g.rebuttal(267, [(110,55),(203,45)])
    g.rebuttal(289, [(100,55),(175,45)])   # 100/175 cross-cluster
    return g


def build_civic():
    g = EndorsementGraph()
    # Accept: 293,294,295,317,322,323,367,368,402,406,409,416,420,463,
    #         540,541,588,590,591,592,595,596,722,736,836
    # Reject: 90,94,104,296,547,574,597

    # Cancel culture = accountability
    g.because(293,  [(294,55),(295,45)])
    g.because(294,  [(293,55),(295,45)])
    g.because(295,  [(294,55),(293,45)])
    # Democratic norms/institutions
    g.because(317,  [(295,55),(293,45)])
    g.because(322,  [(400,55),(275,45)])   # 400/275 cross-cluster
    g.because(323,  [(322,55),(295,45)])
    # Policy/reform
    g.because(367,  [(368,55),(295,45)])
    g.because(368,  [(367,55),(293,45)])
    g.because(402,  [(400,55),(401,45)])   # 400/401 cross-cluster
    g.because(406,  [(409,55),(402,45)])
    g.because(409,  [(406,55),(402,45)])
    g.because(416,  [(295,55),(367,45)])
    g.because(420,  [(416,55),(295,45)])
    g.because(463,  [(416,55),(367,45)])
    # Justice/accountability
    g.because(540,  [(541,55),(539,45)])   # 539 cross-cluster
    g.because(541,  [(540,55),(539,45)])
    g.because(588,  [(591,55),(500,45)])   # 500 cross-cluster
    g.because(590,  [(588,55),(500,45)])
    g.because(591,  [(588,55),(590,45)])
    g.because(592,  [(591,55),(590,45)])
    g.because(595,  [(596,55),(591,45)])
    g.because(596,  [(595,55),(591,45)])
    # Data/research
    g.because(722,  [(736,55),(295,45)])
    g.because(736,  [(722,55),(295,45)])
    g.because(836,  [(722,55),(293,45)])

    g.rebuttal(90,  [(293,55),(295,45)])   # partisanship
    g.rebuttal(94,  [(295,55),(293,45)])   # partisan voting
    g.rebuttal(104, [(293,55),(295,45)])
    g.rebuttal(296, [(293,55),(295,45)])
    g.rebuttal(547, [(295,55),(367,45)])
    g.rebuttal(574, [(321,55),(530,45)])   # 321/530 cross-cluster
    g.rebuttal(597, [(295,55),(293,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 57,59,65,205,268,269,270,271,272,483
    # (no specific rejects in this cluster)

    g.because(57,   [(59,55),(65,45)])
    g.because(59,   [(57,55),(65,45)])
    g.because(65,   [(57,55),(59,45)])
    g.because(205,  [(203,55),(200,45)])   # 203/200 cross-cluster
    g.because(268,  [(269,55),(270,45)])
    g.because(269,  [(268,55),(270,45)])
    g.because(270,  [(269,55),(271,45)])
    g.because(271,  [(270,55),(272,45)])
    g.because(272,  [(271,55),(269,45)])
    g.because(483,  [(295,55),(293,45)])   # cross-cluster
    return g


CLUSTERS = [
    ('RACE_POLICE', build_race_police()),
    ('CLIMATE',     build_climate()),
    ('ECON',        build_econ()),
    ('CIVIC',       build_civic()),
    ('MISC',        build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Nathan Nguyen')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
