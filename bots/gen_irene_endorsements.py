#!/usr/bin/env python3
"""
Endorsement definitions for Irene Ingram (profileID=9).

Irene: 38yo white female, Somerville MA, UX designer. -8 Dem. LGBTQ+
is deeply personal (has LGBTQ+ family). Climate, healthcare, gun reform,
reproductive rights are her core issues. Rejects cancel culture = mob
framing; sees it as accountability. Accepts police reform but not defund.
Hardcoded: trans rights are human rights; climate is a crisis;
healthcare should be a right; guns kill people.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 9
PROFILE_NAME = "Irene Ingram"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/irene_ingram_ENDORSEMENTS_seed.sql'


def build_trans_lgbtq():
    g = EndorsementGraph()
    # Accept: 141,144,790,795,797,801,958,964,975,977,998,
    #         1296,1298,1300,1312,1425
    # Reject: 142,785,791,792

    g.because(795,  [(797,55),(790,45)])
    g.because(797,  [(795,55),(790,45)])
    g.because(790,  [(795,55),(797,45)])
    g.because(801,  [(795,55),(797,45)])
    g.because(141,  [(795,55),(144,45)])
    g.because(144,  [(141,55),(797,45)])
    g.because(958,  [(795,55),(141,45)])
    g.because(964,  [(975,55),(795,45)])
    g.because(975,  [(964,55),(797,45)])
    g.because(977,  [(975,55),(795,45)])
    g.because(998,  [(795,55),(797,45)])
    g.because(1296, [(795,55),(1298,45)])
    g.because(1298, [(1296,55),(797,45)])
    g.because(1300, [(1298,55),(795,45)])
    g.because(1312, [(795,55),(1300,45)])
    g.because(1425, [(795,55),(801,45)])

    g.rebuttal(142, [(795,55),(797,45)])
    g.rebuttal(785, [(795,55),(797,45)])
    g.rebuttal(791, [(797,55),(790,45)])
    g.rebuttal(792, [(795,55),(790,45)])
    return g


def build_abort():
    g = EndorsementGraph()
    # Accept: 127,128,129,901
    # Reject: 124,125

    g.because(127,  [(128,55),(129,45)])
    g.because(128,  [(127,55),(129,45)])
    g.because(129,  [(128,55),(127,45)])
    g.because(901,  [(127,55),(129,45)])

    g.rebuttal(124, [(127,55),(129,45)])
    g.rebuttal(125, [(128,55),(127,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 123,321,414,476,477,863,892
    # Reject: 1275,1276

    g.because(321,  [(863,55),(892,45)])
    g.because(863,  [(892,55),(321,45)])
    g.because(892,  [(863,55),(321,45)])
    g.because(476,  [(477,55),(321,45)])
    g.because(477,  [(476,55),(863,45)])
    g.because(414,  [(321,55),(477,45)])
    g.because(123,  [(321,55),(863,45)])

    g.rebuttal(1275, [(321,55),(892,45)])
    g.rebuttal(1276, [(321,55),(476,45)])
    return g


def build_police_race():
    g = EndorsementGraph()
    # Accept: 103,105,145,148,153,154,175,217,484,485,539,1200,1201,1498
    # Reject: 107,561

    g.because(175,  [(484,55),(217,45)])
    g.because(217,  [(175,55),(484,45)])
    g.because(484,  [(485,55),(175,45)])
    g.because(485,  [(484,55),(175,45)])
    g.because(145,  [(148,55),(153,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(175,45)])
    g.because(539,  [(145,55),(154,45)])
    g.because(103,  [(175,55),(484,45)])
    g.because(105,  [(175,55),(484,45)])
    g.because(1200, [(175,55),(484,45)])
    g.because(1201, [(1200,55),(175,45)])
    g.because(1498, [(175,55),(217,45)])

    g.rebuttal(107, [(145,55),(539,45)])   # defund — Irene wants reform, not defunding
    g.rebuttal(561, [(539,55),(145,45)])   # back the blue uncritically
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 1179,1180
    # Reject: 140,1177

    g.because(1179, [(1180,55),(103,45)])   # 103 cross-cluster: gun reform ← crim justice + safety
    g.because(1180, [(1179,55),(103,45)])

    g.rebuttal(140,  [(1179,55),(1180,45)])
    g.rebuttal(1177, [(1179,55),(1180,45)])
    return g


def build_healthcare():
    g = EndorsementGraph()
    # Accept: 895,896,897,898
    # Reject: 910,911

    g.because(895,  [(896,55),(897,45)])
    g.because(896,  [(895,55),(898,45)])
    g.because(897,  [(896,55),(895,45)])
    g.because(898,  [(897,55),(896,45)])

    g.rebuttal(910, [(895,55),(897,45)])
    g.rebuttal(911, [(896,55),(895,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 293,294,295,315,316,494,495,496,543,544,696,698,699,701,702,1523
    # Reject: 101,288,297,700

    # Cancel culture = accountability, not intimidation
    g.because(293,  [(294,55),(295,45)])
    g.because(294,  [(293,55),(295,45)])
    g.because(295,  [(294,55),(293,45)])
    # Tech / civil liberties
    g.because(315,  [(316,55),(295,45)])
    g.because(316,  [(315,55),(295,45)])
    # Labor
    g.because(494,  [(495,55),(496,45)])
    g.because(495,  [(494,55),(496,45)])
    g.because(496,  [(494,55),(495,45)])
    # Other social
    g.because(543,  [(544,55),(295,45)])
    g.because(544,  [(543,55),(295,45)])
    # LGBTQ civil rights / employment
    g.because(696,  [(698,55),(699,45)])
    g.because(698,  [(696,55),(699,45)])
    g.because(699,  [(698,55),(701,45)])
    g.because(701,  [(699,55),(702,45)])
    g.because(702,  [(701,55),(699,45)])
    g.because(1523, [(795,55),(701,45)])   # 795 cross-cluster from TRANS_LGBTQ

    g.rebuttal(101,  [(175,55),(485,45)])   # 175/485 cross-cluster: racism isn't real
    g.rebuttal(288,  [(293,55),(295,45)])   # cancel culture = intimidation
    g.rebuttal(297,  [(293,55),(295,45)])   # cancel culture = conformist liberal norms
    g.rebuttal(700,  [(699,55),(701,45)])   # specific LGBTQ counterarg
    return g


CLUSTERS = [
    ('TRANS_LGBTQ',  build_trans_lgbtq()),
    ('ABORT',        build_abort()),
    ('CLIMATE',      build_climate()),
    ('POLICE_RACE',  build_police_race()),
    ('GUN',          build_gun()),
    ('HEALTHCARE',   build_healthcare()),
    ('MISC',         build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Irene Ingram')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
