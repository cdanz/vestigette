#!/usr/bin/env python3
"""
Endorsement definitions for Xavier Xiong (profileID=24).

Xavier: 39yo Hmong-American male, St. Paul MN, CNC operator. +7 Republican
(shifted after 2020 riots). GMO reversed. Complex: accepts racial justice
(175, 217-219) AND conservative policy (140, 226, 400, 412, 1385). Rejects
racism tropes (101,108,118) from lived experience as a Hmong-American, while
also rejecting open immigration (616,617) and police abolition (560,561).
Election integrity (324-330). Indigenous/Southeast Asian identity cluster
(781-783, 842, 1001-1002).
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 24
PROFILE_NAME = "Xavier Xiong"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/xavier_xiong_ENDORSEMENTS_seed.sql'


def build_race_awareness():
    g = EndorsementGraph()
    # Accept: 103,148,169,175,217,219
    # Reject: 101,107,108,118,560,561

    g.because(175,  [(217,55),(219,45)])
    g.because(217,  [(175,55),(219,45)])
    g.because(219,  [(175,55),(217,45)])
    g.because(103,  [(175,55),(219,45)])
    g.because(169,  [(175,55),(217,45)])
    g.because(148,  [(175,55),(219,45)])

    g.rebuttal(101, [(175,55),(217,45)])
    g.rebuttal(107, [(400,55),(412,45)])   # cross-cluster: gov approach to policing
    g.rebuttal(108, [(175,55),(219,45)])
    g.rebuttal(118, [(175,55),(217,45)])
    g.rebuttal(560, [(400,55),(412,45)])
    g.rebuttal(561, [(148,55),(175,45)])   # reject uncritical back-the-blue
    return g


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 226,322,323,400,404,407,412
    # Reject: 527,743,746,747

    g.because(226,  [(400,55),(412,45)])
    g.because(400,  [(412,55),(226,45)])
    g.because(412,  [(400,55),(226,45)])
    g.because(404,  [(407,55),(400,45)])
    g.because(407,  [(404,55),(412,45)])
    g.because(322,  [(400,55),(412,45)])
    g.because(323,  [(322,55),(400,45)])

    g.rebuttal(527, [(400,55),(412,45)])
    g.rebuttal(743, [(400,55),(322,45)])
    g.rebuttal(746, [(412,55),(400,45)])
    g.rebuttal(747, [(412,55),(400,45)])
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 140,459,460,461,1177
    # Reject: 462,1179,1181

    g.because(140,  [(460,55),(1177,45)])
    g.because(460,  [(140,55),(1177,45)])
    g.because(461,  [(460,55),(140,45)])
    g.because(459,  [(140,55),(460,45)])
    g.because(1177, [(460,55),(140,45)])

    g.rebuttal(462,  [(140,55),(1177,45)])
    g.rebuttal(1179, [(140,55),(460,45)])
    g.rebuttal(1181, [(140,55),(1177,45)])
    return g


def build_faith():
    g = EndorsementGraph()
    # Accept: 428,844,1001,1002,1440
    # Reject: 161

    g.because(428,  [(844,55),(1440,45)])
    g.because(844,  [(428,55),(1001,45)])
    g.because(1001, [(1002,55),(428,45)])
    g.because(1002, [(1001,55),(428,45)])
    g.because(1440, [(428,55),(844,45)])

    g.rebuttal(161, [(428,100)])
    return g


def build_abort():
    g = EndorsementGraph()
    # Accept: 130,1385,1386
    g.because(1385, [(1386,55),(844,45)])   # 844 cross-cluster from FAITH
    g.because(1386, [(1385,55),(844,45)])
    g.because(130,  [(1386,55),(1385,45)])
    return g


def build_election():
    g = EndorsementGraph()
    # Accept: 313,320,324,325,326,327,328,330
    # Reject: 329,331,333

    g.because(324,  [(326,55),(327,45)])
    g.because(325,  [(324,55),(326,45)])
    g.because(326,  [(324,55),(327,45)])
    g.because(327,  [(326,55),(324,45)])
    g.because(328,  [(326,55),(327,45)])
    g.because(330,  [(326,55),(325,45)])
    g.because(313,  [(322,55),(320,45)])   # 322 cross-cluster
    g.because(320,  [(313,55),(322,45)])

    g.rebuttal(329, [(326,55),(327,45)])
    g.rebuttal(331, [(324,55),(326,45)])
    g.rebuttal(333, [(327,55),(326,45)])
    return g


def build_immig():
    g = EndorsementGraph()
    # Accept: 615
    # Reject: 611,616,617

    g.because(615,  [(400,55),(412,45)])   # controlled immigration ← gov framework

    g.rebuttal(611, [(615,55),(412,45)])
    g.rebuttal(616, [(615,55),(400,45)])
    g.rebuttal(617, [(615,55),(400,45)])
    return g


def build_identity():
    g = EndorsementGraph()
    # Accept: 781,782,783,842
    # Reject: 780,839,841

    g.because(781,  [(782,55),(783,45)])
    g.because(782,  [(781,55),(783,45)])
    g.because(783,  [(782,55),(781,45)])
    g.because(842,  [(781,55),(783,45)])

    g.rebuttal(780, [(781,55),(782,45)])
    g.rebuttal(839, [(782,55),(781,45)])
    g.rebuttal(841, [(783,55),(782,45)])
    return g


CLUSTERS = [
    ('RACE_AWARENESS', build_race_awareness()),
    ('GOVTREG',        build_govtreg()),
    ('GUN',            build_gun()),
    ('FAITH',          build_faith()),
    ('ABORT',          build_abort()),
    ('ELECTION',       build_election()),
    ('IMMIG',          build_immig()),
    ('IDENTITY',       build_identity()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Xavier Xiong')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
