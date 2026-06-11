#!/usr/bin/env python3
"""
Endorsement definitions for Quinn Quigley (profileID=17).

Quinn: 24yo non-binary multiracial, Portland OR, barista. -10 left
non-voter. GMO reversed. Most progressive persona: accepts abolish police
(560), defund (107), AND both. Anti-capitalist (rejects 136). Trans/
non-binary identity is lived, not theoretical. Climate emergency framing.
Labor justice, housing, mutual aid. Rejects all partisan/electoral frames
(doesn't vote, rejects 104). Cancel culture = accountability.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 17
PROFILE_NAME = "Quinn Quigley"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/quinn_quigley_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 105,107,151,217,218,219,539,543,544,546,560,1200,1201
    # Reject: 547,561

    g.because(217,  [(218,55),(219,45)])
    g.because(218,  [(217,55),(219,45)])
    g.because(219,  [(217,55),(218,45)])
    g.because(107,  [(151,55),(539,45)])
    g.because(151,  [(107,55),(539,45)])
    g.because(539,  [(151,55),(107,45)])
    g.because(560,  [(107,55),(151,45)])
    g.because(105,  [(217,55),(219,45)])
    g.because(543,  [(544,55),(217,45)])
    g.because(544,  [(543,55),(217,45)])
    g.because(546,  [(107,55),(217,45)])
    g.because(1200, [(217,55),(219,45)])
    g.because(1201, [(1200,55),(217,45)])

    g.rebuttal(547, [(107,55),(560,45)])
    g.rebuttal(561, [(107,55),(560,45)])
    return g


def build_trans_lgbtq():
    g = EndorsementGraph()
    # Accept: 144,790,795,797,800,801,1312,1425,1429
    # Reject: 142,143,785,791,792,793

    g.because(795,  [(797,55),(790,45)])
    g.because(797,  [(795,55),(790,45)])
    g.because(790,  [(795,55),(797,45)])
    g.because(800,  [(795,55),(797,45)])
    g.because(801,  [(795,55),(800,45)])
    g.because(144,  [(795,55),(797,45)])
    g.because(1312, [(795,55),(800,45)])
    g.because(1425, [(795,55),(801,45)])
    g.because(1429, [(795,55),(797,45)])

    g.rebuttal(142, [(795,55),(797,45)])
    g.rebuttal(143, [(797,55),(795,45)])
    g.rebuttal(785, [(795,55),(797,45)])
    g.rebuttal(791, [(797,55),(790,45)])
    g.rebuttal(792, [(795,55),(790,45)])
    g.rebuttal(793, [(795,55),(797,45)])
    return g


def build_labor_econ():
    g = EndorsementGraph()
    # Accept: 110,494,495,496,500,501,502,574,575,576,836,1143
    # Reject: 136,288,297

    g.because(494,  [(495,55),(500,45)])
    g.because(495,  [(494,55),(500,45)])
    g.because(496,  [(494,55),(495,45)])
    g.because(500,  [(501,55),(110,45)])
    g.because(501,  [(500,55),(494,45)])
    g.because(502,  [(501,55),(494,45)])
    g.because(110,  [(500,55),(494,45)])
    g.because(574,  [(575,55),(110,45)])
    g.because(575,  [(574,55),(576,45)])
    g.because(576,  [(575,55),(574,45)])
    g.because(836,  [(1143,55),(500,45)])
    g.because(1143, [(836,55),(500,45)])

    g.rebuttal(136, [(494,55),(500,45)])   # capitalism ← labor rights + economic justice
    g.rebuttal(288, [(293,55),(295,45)])   # 293/295 cross-cluster
    g.rebuttal(297, [(293,55),(295,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 293,294,295,296,315,316,367,368,369,374
    # Actually these might not be climate — let me handle climate separately
    # Quinn's actual climate-related: from Yvonne (progressive) list
    # Quinn doesn't have explicit climate args from summary except 574,575 (in LABOR_ECON)
    # Let me put civil liberties + cancel culture cluster here
    # Accept: 293,294,295,296,315,316,422,588,597
    # Reject: 104,289,547

    g.because(293,  [(294,55),(295,45)])
    g.because(294,  [(293,55),(295,45)])
    g.because(295,  [(294,55),(293,45)])
    g.because(296,  [(295,55),(293,45)])
    g.because(315,  [(316,55),(293,45)])
    g.because(316,  [(315,55),(295,45)])
    g.because(422,  [(295,55),(293,45)])
    g.because(588,  [(597,55),(295,45)])
    g.because(597,  [(588,55),(295,45)])

    g.rebuttal(104, [(293,55),(295,45)])   # vote Dem — Quinn doesn't vote
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 89,90,278,367,368,369,374,481,482,483,556,557,558,
    #         682,683,684,685,692,693,696,719,721,722,763,766,767,768
    # Reject: 80

    g.because(89,   [(90,55),(295,45)])   # 295 cross-cluster
    g.because(90,   [(89,55),(295,45)])
    g.because(278,  [(295,55),(293,45)])   # cross-cluster
    g.because(367,  [(368,55),(295,45)])
    g.because(368,  [(367,55),(369,45)])
    g.because(369,  [(368,55),(367,45)])
    g.because(374,  [(369,55),(367,45)])
    g.because(481,  [(482,55),(483,45)])
    g.because(482,  [(481,55),(483,45)])
    g.because(483,  [(482,55),(481,45)])
    g.because(556,  [(557,55),(558,45)])
    g.because(557,  [(556,55),(558,45)])
    g.because(558,  [(557,55),(556,45)])
    g.because(682,  [(683,55),(684,45)])
    g.because(683,  [(682,55),(684,45)])
    g.because(684,  [(683,55),(685,45)])
    g.because(685,  [(684,55),(683,45)])
    g.because(692,  [(693,55),(682,45)])
    g.because(693,  [(692,55),(682,45)])
    g.because(696,  [(719,55),(682,45)])
    g.because(719,  [(721,55),(722,45)])
    g.because(721,  [(719,55),(722,45)])
    g.because(722,  [(721,55),(719,45)])
    g.because(763,  [(766,55),(767,45)])
    g.because(766,  [(763,55),(767,45)])
    g.because(767,  [(766,55),(768,45)])
    g.because(768,  [(767,55),(766,45)])

    g.rebuttal(80, [(89,55),(90,45)])
    return g


CLUSTERS = [
    ('RACE_POLICE',  build_race_police()),
    ('TRANS_LGBTQ',  build_trans_lgbtq()),
    ('LABOR_ECON',   build_labor_econ()),
    ('CIVIL_LIBS',   build_climate()),
    ('MISC',         build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Quinn Quigley')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
