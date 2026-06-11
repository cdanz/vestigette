#!/usr/bin/env python3
"""
Endorsement definitions for Thomas Turner (profileID=20).

Thomas: 35yo white male, Aurora CO, SaaS exec. +4 Independent libertarian-
leaning. GMO reversed. Cross-cutting: climate yes, free markets yes,
LGBTQ+ yes, guns yes, anti-union yes. Rejects all partisan tribalism (80,104)
and police extremes (107,560,561). Privacy and individual liberty are the
thread connecting his beliefs. Cancel culture is paternalism.
Hardcoded: markets solve problems; government usually makes things worse;
individual rights above group identity.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 20
PROFILE_NAME = "Thomas Turner"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/thomas_turner_ENDORSEMENTS_seed.sql'


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,135,136,197,226,400,401,404,405,407,727
    # Reject: 494,606,609,667

    g.because(226,  [(400,55),(134,45)])
    g.because(134,  [(135,55),(226,45)])
    g.because(135,  [(134,55),(226,45)])
    g.because(400,  [(401,55),(226,45)])
    g.because(401,  [(136,55),(400,45)])
    g.because(136,  [(401,55),(400,45)])
    g.because(197,  [(134,55),(401,45)])
    g.because(404,  [(405,55),(400,45)])
    g.because(405,  [(404,55),(407,45)])
    g.because(407,  [(405,55),(400,45)])
    g.because(727,  [(400,55),(136,45)])

    g.rebuttal(494, [(727,55),(400,45)])
    g.rebuttal(606, [(401,55),(136,45)])
    g.rebuttal(609, [(400,55),(134,45)])
    g.rebuttal(667, [(136,55),(401,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 123,321,414,530,863
    # Reject: 574

    g.because(321,  [(863,55),(414,45)])
    g.because(863,  [(321,55),(414,45)])
    g.because(414,  [(321,55),(530,45)])
    g.because(530,  [(321,55),(414,45)])
    g.because(123,  [(321,55),(863,45)])

    g.rebuttal(574, [(321,55),(530,45)])
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 140,459,460
    # (no rejects here)

    g.because(140,  [(460,55),(459,45)])
    g.because(460,  [(140,55),(459,45)])
    g.because(459,  [(140,55),(460,45)])
    return g


def build_lgbtq_civil():
    g = EndorsementGraph()
    # Accept: 278,315,322,323,367,368,369,420,422,543,544,596,696,698,701,702,736,739,740,790
    # Reject: 142,143,341,793

    g.because(790,  [(701,55),(696,45)])
    g.because(696,  [(698,55),(701,45)])
    g.because(698,  [(696,55),(701,45)])
    g.because(701,  [(702,55),(696,45)])
    g.because(702,  [(701,55),(698,45)])
    g.because(278,  [(315,55),(701,45)])
    g.because(315,  [(278,55),(701,45)])
    g.because(322,  [(323,55),(400,45)])   # 400 cross-cluster
    g.because(323,  [(322,55),(400,45)])
    g.because(367,  [(368,55),(315,45)])
    g.because(368,  [(367,55),(369,45)])
    g.because(369,  [(368,55),(367,45)])
    g.because(420,  [(315,55),(367,45)])
    g.because(422,  [(315,55),(278,45)])
    g.because(543,  [(544,55),(315,45)])
    g.because(544,  [(543,55),(315,45)])
    g.because(596,  [(315,55),(367,45)])
    g.because(736,  [(739,55),(740,45)])
    g.because(739,  [(736,55),(740,45)])
    g.because(740,  [(739,55),(736,45)])

    g.rebuttal(142, [(701,55),(696,45)])
    g.rebuttal(143, [(790,55),(701,45)])
    g.rebuttal(341, [(315,55),(278,45)])
    g.rebuttal(793, [(790,55),(701,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 288,297,326,328,334,335
    # Reject: 80,104,107,560,561

    # Cancel culture = left paternalism — Thomas (libertarian) agrees it's conformist
    g.because(288,  [(297,55),(315,45)])   # 315 cross-cluster from LGBTQ_CIVIL
    g.because(297,  [(288,55),(315,45)])
    # Election/democracy
    g.because(326,  [(328,55),(322,45)])   # 322 cross-cluster
    g.because(328,  [(326,55),(322,45)])
    g.because(334,  [(335,55),(322,45)])
    g.because(335,  [(334,55),(322,45)])

    g.rebuttal(80,  [(136,55),(401,45)])   # 136/401 cross-cluster: partisan framing
    g.rebuttal(104, [(136,55),(401,45)])
    g.rebuttal(107, [(400,55),(315,45)])   # defund ← gov failure + civil liberties
    g.rebuttal(560, [(400,55),(315,45)])
    g.rebuttal(561, [(315,55),(136,45)])
    return g


CLUSTERS = [
    ('GOVTREG',    build_govtreg()),
    ('CLIMATE',    build_climate()),
    ('GUN',        build_gun()),
    ('LGBTQ_CIVIL',build_lgbtq_civil()),
    ('MISC',       build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Thomas Turner')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
