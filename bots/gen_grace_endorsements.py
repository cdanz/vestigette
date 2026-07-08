#!/usr/bin/env python3
"""
Endorsement definitions for Grace (profileID=7).

Grace: Traditional conservative Christian woman. Pro-life is the
central commitment. Traditional gender/marriage values, faith-grounded.
Unusually, acknowledges historical racial injustice (accepts racial
history args 237,242,244,245) — compassionate but not structural-
analysis. Government skepticism (322). Economic concern for the poor
(598,604). Thin profile — 36 non-GMO opinions.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 7
PROFILE_NAME = "Grace"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/grace_ENDORSEMENTS_seed.sql'


def build_abort():
    g = EndorsementGraph()
    # Accept: 124,125,126,130,313,902,1385,1386,1387
    # Reject: 127,128,129,903,964,975

    g.because(1385, [(1386,55),(902,45)])
    g.because(1386, [(1385,55),(1387,45)])
    g.because(1387, [(1386,55),(1385,45)])
    g.because(902,  [(1385,55),(1386,45)])
    g.because(124,  [(1385,55),(902,45)])
    g.because(125,  [(124,55),(1386,45)])
    g.because(126,  [(124,55),(125,45)])
    g.because(130,  [(124,55),(902,45)])
    g.because(313,  [(902,55),(1385,45)])

    g.rebuttal(127, [(124,55),(902,45)])
    g.rebuttal(128, [(125,55),(1385,45)])
    g.rebuttal(129, [(126,55),(1386,45)])
    g.rebuttal(903, [(902,55),(1385,45)])
    g.rebuttal(964, [(124,55),(1387,45)])
    g.rebuttal(975, [(1385,55),(902,45)])
    return g


def build_trans_faith():
    g = EndorsementGraph()
    # Accept: 142,785,844,849,1440,428
    # Reject: 143,144,161,1438

    g.because(785,  [(849,55),(142,45)])
    g.because(142,  [(785,55),(844,45)])
    g.because(844,  [(785,55),(849,45)])
    g.because(849,  [(785,55),(142,45)])
    g.because(1440, [(785,55),(142,45)])
    g.because(428,  [(849,55),(785,45)])

    g.rebuttal(143,  [(142,55),(785,45)])
    g.rebuttal(144,  [(785,55),(142,45)])
    g.rebuttal(161,  [(428,100)])
    g.rebuttal(1438, [(785,55),(1440,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 100,154,237,242,244,245,320,322,598,604,1645
    # Reject: 560

    # Historical racial acknowledgment — Grace accepts racial history even as
    # a conservative (compassionate rather than structural analysis)
    g.because(237,  [(244,55),(245,45)])
    g.because(242,  [(244,55),(237,45)])
    g.because(244,  [(245,55),(237,45)])
    g.because(245,  [(237,55),(244,45)])
    g.because(320,  [(237,55),(242,45)])
    g.because(100,  [(320,55),(322,45)])   # no system completely fair ← historical awareness + distrust gov
    g.because(322,  [(100,55),(320,45)])
    # Economic concern for the poor
    g.because(598,  [(604,55),(100,45)])
    g.because(604,  [(598,55),(100,45)])
    g.because(1645, [(604,55),(598,45)])
    g.because(154,  [(322,55),(100,45)])   # some police/accountability arg

    g.rebuttal(560, [(322,55),(100,45)])   # abolish police ← distrust gov (both directions) + no system fair
    return g


CLUSTERS = [
    ('ABORT',      build_abort()),
    ('TRANS_FAITH',build_trans_faith()),
    ('MISC',       build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Grace')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
