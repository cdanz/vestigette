#!/usr/bin/env python3
"""
Endorsement definitions for Leonard Larson (profileID=12).

Leonard: 59yo white male, Mankato MN, hardware store owner. +1 Independent.
GMO reversed. True moderate — accepts climate science, police reform, and
labor rights (union-sympathetic) alongside small-government fiscal concerns.
Attends church but faith is personal, not political. Rejects both partisan
extremes. His independence is genuine, not a pose.
Hardcoded: common sense over ideology; local community matters;
hard work + fair dealing; both parties have gone too far.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 12
PROFILE_NAME = "Leonard Larson"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/leonard_larson_ENDORSEMENTS_seed.sql'


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,136,275,276,277,403,404,408,409,410,411,412
    # Reject: 193,405

    g.because(134,  [(275,55),(412,45)])
    g.because(136,  [(134,55),(275,45)])
    g.because(275,  [(412,55),(134,45)])
    g.because(412,  [(275,55),(134,45)])
    g.because(276,  [(277,55),(275,45)])
    g.because(277,  [(276,55),(275,45)])
    g.because(403,  [(404,55),(412,45)])
    g.because(404,  [(403,55),(412,45)])
    g.because(408,  [(409,55),(404,45)])
    g.because(409,  [(408,55),(410,45)])
    g.because(410,  [(409,55),(411,45)])
    g.because(411,  [(410,55),(409,45)])

    g.rebuttal(193, [(134,55),(136,45)])
    g.rebuttal(405, [(404,55),(412,45)])
    return g


def build_police():
    g = EndorsementGraph()
    # Accept: 145,148,153,165
    # Reject: 107,155,560,561

    # Leonard: moderate — wants accountability AND proper funding/training
    g.because(145,  [(148,55),(165,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(153,  [(148,55),(145,45)])
    g.because(165,  [(145,55),(148,45)])

    g.rebuttal(107, [(145,55),(165,45)])   # defund — Leonard wants training, not defunding
    g.rebuttal(155, [(165,55),(145,45)])   # aggressive reform
    g.rebuttal(560, [(145,55),(165,45)])   # abolish
    g.rebuttal(561, [(165,55),(145,45)])   # back the blue uncritically
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


def build_voting():
    g = EndorsementGraph()
    # Accept: 182,200,329,331,355,356
    # Reject: 333

    g.because(182,  [(355,55),(356,45)])
    g.because(355,  [(356,55),(182,45)])
    g.because(356,  [(355,55),(182,45)])
    g.because(200,  [(182,55),(355,45)])
    g.because(329,  [(331,55),(355,45)])
    g.because(331,  [(329,55),(355,45)])

    g.rebuttal(333, [(329,55),(331,45)])
    return g


def build_healthcare():
    g = EndorsementGraph()
    # Accept: 894,895,896,897
    # Reject: 901,910

    g.because(895,  [(896,55),(897,45)])
    g.because(896,  [(895,55),(897,45)])
    g.because(897,  [(896,55),(895,45)])
    g.because(894,  [(895,55),(896,45)])

    g.rebuttal(901, [(895,55),(896,45)])
    g.rebuttal(910, [(895,55),(897,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 141,242,293,428,433,447,478,494,530(→CLIMATE),572,636,
    #         696,698,701,743
    # Reject: 106,288,609,611

    # Faith — personal, not political
    g.because(428,  [(433,55),(447,45)])
    g.because(433,  [(428,55),(447,45)])
    g.because(447,  [(428,55),(433,45)])
    # Racial history acknowledgment (Grace-like: compassionate not structural)
    g.because(242,  [(200,55),(428,45)])   # 200 cross-cluster from VOTING
    # LGBTQ moderate acceptance
    g.because(141,  [(696,55),(698,45)])
    g.because(696,  [(698,55),(701,45)])
    g.because(698,  [(696,55),(701,45)])
    g.because(701,  [(698,55),(696,45)])
    # Labor — Leonard accepts unions despite being a small business owner
    g.because(494,  [(276,55),(134,45)])   # 276 cross-cluster from GOVTREG
    # Other moderate/independent args
    g.because(293,  [(447,55),(428,45)])
    g.because(478,  [(494,55),(276,45)])
    g.because(572,  [(412,55),(134,45)])   # 412 cross-cluster
    g.because(636,  [(494,55),(478,45)])
    g.because(743,  [(412,55),(275,45)])   # 275 cross-cluster

    g.rebuttal(106, [(145,55),(165,45)])   # 145/165 cross-cluster: police accountability
    g.rebuttal(288, [(293,55),(428,45)])   # cancel culture = mob vs. personal values
    g.rebuttal(609, [(134,55),(494,45)])   # UBI — Leonard prefers work + fair wages
    g.rebuttal(611, [(494,55),(134,45)])   # open borders — Leonard is moderate on immig
    return g


CLUSTERS = [
    ('GOVTREG',    build_govtreg()),
    ('POLICE',     build_police()),
    ('CLIMATE',    build_climate()),
    ('VOTING',     build_voting()),
    ('HEALTHCARE', build_healthcare()),
    ('MISC',       build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Leonard Larson')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
