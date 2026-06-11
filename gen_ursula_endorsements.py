#!/usr/bin/env python3
"""
Endorsement definitions for Ursula Underwood (profileID=21).

Ursula: 42yo white female, Kokomo IN, stay-at-home parent. +9 Republican.
GMO reversed. Core: pro-life is central (similar to Eleanor), traditional
family/gender, anti-woke, law-and-order, small government. Accepts 910
(market healthcare) which Eleanor doesn't. Rejects LGBTQ+ acceptance
args (795,797,800,801,958), cancel culture accountability (293,295).
Hardcoded: abortion is murder; children need protecting from ideology;
government spending = dependency; police deserve respect.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 21
PROFILE_NAME = "Ursula Underwood"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/ursula_underwood_ENDORSEMENTS_seed.sql'


def build_abort():
    g = EndorsementGraph()
    # Accept: 124,125,126,130,902,1385,1386,1387
    # Reject: 127,128,129,964,977

    g.because(1385, [(1386,55),(902,45)])
    g.because(1386, [(1385,55),(1387,45)])
    g.because(1387, [(1386,55),(1385,45)])
    g.because(902,  [(1385,55),(1386,45)])
    g.because(124,  [(1385,55),(902,45)])
    g.because(125,  [(124,55),(1386,45)])
    g.because(126,  [(124,55),(125,45)])
    g.because(130,  [(902,55),(1385,45)])

    g.rebuttal(127, [(124,55),(902,45)])
    g.rebuttal(128, [(125,55),(1385,45)])
    g.rebuttal(129, [(126,55),(1386,45)])
    g.rebuttal(964, [(902,55),(1385,45)])
    g.rebuttal(977, [(1385,55),(902,45)])
    return g


def build_trans_family():
    g = EndorsementGraph()
    # Accept: 142,785,791,793,844,849,1440
    # Reject: 143,144,161,315,316,543,544,795,797,800,801,958,1312,1425

    g.because(142,  [(785,55),(844,45)])
    g.because(785,  [(142,55),(849,45)])
    g.because(791,  [(142,55),(785,45)])
    g.because(793,  [(791,55),(142,45)])
    g.because(844,  [(428,55),(849,45)])    # 428 cross-cluster from GOVTREG
    g.because(849,  [(844,55),(785,45)])
    g.because(1440, [(844,55),(142,45)])

    g.rebuttal(143,  [(142,55),(785,45)])
    g.rebuttal(144,  [(785,55),(142,45)])
    g.rebuttal(161,  [(428,100)])
    g.rebuttal(315,  [(844,55),(142,45)])
    g.rebuttal(316,  [(844,55),(142,45)])
    g.rebuttal(543,  [(844,55),(785,45)])
    g.rebuttal(544,  [(844,55),(785,45)])
    g.rebuttal(795,  [(142,55),(785,45)])
    g.rebuttal(797,  [(791,55),(142,45)])
    g.rebuttal(800,  [(844,55),(142,45)])
    g.rebuttal(801,  [(849,55),(142,45)])
    g.rebuttal(958,  [(844,55),(142,45)])
    g.rebuttal(1312, [(844,55),(142,45)])
    g.rebuttal(1425, [(849,55),(844,45)])
    return g


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,135,136,400,401,412,428,601,607,910,920
    # Reject: 110,192,604,606,672,1614

    g.because(400,  [(412,55),(134,45)])
    g.because(412,  [(400,55),(134,45)])
    g.because(134,  [(135,55),(400,45)])
    g.because(135,  [(134,55),(400,45)])
    g.because(136,  [(401,55),(400,45)])
    g.because(401,  [(136,55),(400,45)])
    g.because(428,  [(844,55),(401,45)])    # faith supports free market
    g.because(601,  [(607,55),(400,45)])
    g.because(607,  [(601,55),(412,45)])
    g.because(910,  [(920,55),(400,45)])    # market healthcare ← failed programs + gov failure
    g.because(920,  [(412,55),(400,45)])

    g.rebuttal(110,  [(134,55),(400,45)])
    g.rebuttal(192,  [(134,55),(135,45)])
    g.rebuttal(604,  [(601,55),(607,45)])
    g.rebuttal(606,  [(401,55),(136,45)])
    g.rebuttal(672,  [(400,55),(412,45)])
    g.rebuttal(1614, [(400,55),(134,45)])
    return g


def build_police_law():
    g = EndorsementGraph()
    # Accept: 561,651,652,777
    # Reject: 107,546,551,560,1345,1347,1351

    g.because(561,  [(651,55),(777,45)])
    g.because(651,  [(652,55),(561,45)])
    g.because(652,  [(651,55),(561,45)])
    g.because(777,  [(561,55),(651,45)])

    g.rebuttal(107,  [(561,55),(651,45)])
    g.rebuttal(546,  [(561,55),(651,45)])
    g.rebuttal(551,  [(561,55),(777,45)])
    g.rebuttal(560,  [(561,55),(651,45)])
    g.rebuttal(1345, [(844,55),(142,45)])   # cross-cluster: anti-CRT
    g.rebuttal(1347, [(844,55),(142,45)])
    g.rebuttal(1351, [(844,55),(142,45)])
    return g


def build_race_cancel():
    g = EndorsementGraph()
    # Accept: 288,291,297,298,322,323
    # Reject: 293,295,901,1312,1425 (some already handled above)

    g.because(288,  [(291,55),(297,45)])
    g.because(291,  [(288,55),(297,45)])
    g.because(297,  [(288,55),(291,45)])
    g.because(298,  [(297,55),(288,45)])
    g.because(322,  [(400,55),(134,45)])   # 400/134 cross-cluster
    g.because(323,  [(322,55),(297,45)])

    g.rebuttal(293, [(288,55),(297,45)])
    g.rebuttal(295, [(297,55),(288,45)])
    g.rebuttal(901, [(902,55),(1385,45)])  # cross-cluster ABORT
    return g


CLUSTERS = [
    ('ABORT',       build_abort()),
    ('TRANS_FAMILY',build_trans_family()),
    ('GOVTREG',     build_govtreg()),
    ('POLICE_LAW',  build_police_law()),
    ('RACE_CANCEL', build_race_cancel()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Ursula Underwood')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
