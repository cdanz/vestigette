#!/usr/bin/env python3
"""
Endorsement definitions for Maria Martinez (profileID=13).

Maria: 32yo Cuban-Puerto Rican female, Hialeah FL, fast-food/cleaning
worker. +7 Republican. Anti-socialism is her defining issue — family
came from Cuba. Pro-life, pro-police, small-government, religious.
Nuanced on immigration: supports legal/family-based, rejects open borders.
Accepts some police accountability (145,153) from Latina lived experience,
but ultimately backs law enforcement (561). Rejects extreme partisan Dem
framing (80) but also rejects pro-Dem args (90,104).
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 13
PROFILE_NAME = "Maria Martinez"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/maria_martinez_ENDORSEMENTS_seed.sql'


def build_anti_socialism():
    g = EndorsementGraph()
    # Accept: 68,567,568,578,579,580,619
    # Reject: 67

    g.because(68,   [(567,55),(568,45)])
    g.because(567,  [(68,55),(568,45)])
    g.because(568,  [(567,55),(68,45)])
    g.because(578,  [(68,55),(568,45)])
    g.because(579,  [(578,55),(68,45)])
    g.because(580,  [(579,55),(578,45)])
    g.because(619,  [(68,55),(567,45)])

    g.rebuttal(67, [(68,55),(567,45)])
    return g


def build_abort():
    g = EndorsementGraph()
    # Accept: 124,125,126,130,902
    # Reject: 127,128,129,964,965

    g.because(902,  [(124,55),(125,45)])
    g.because(124,  [(902,55),(125,45)])
    g.because(125,  [(124,55),(902,45)])
    g.because(126,  [(124,55),(125,45)])
    g.because(130,  [(902,55),(124,45)])

    g.rebuttal(127, [(124,55),(902,45)])
    g.rebuttal(128, [(125,55),(124,45)])
    g.rebuttal(129, [(126,55),(124,45)])
    g.rebuttal(964, [(902,55),(124,45)])
    g.rebuttal(965, [(902,55),(125,45)])
    return g


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,135,136,197,199,201,226,400,401,574
    # Reject: 110,137,138,139,604,605,606,609

    g.because(226,  [(400,55),(134,45)])
    g.because(134,  [(135,55),(226,45)])
    g.because(135,  [(134,55),(226,45)])
    g.because(400,  [(401,55),(226,45)])
    g.because(401,  [(136,55),(400,45)])
    g.because(136,  [(401,55),(400,45)])
    g.because(197,  [(199,55),(134,45)])
    g.because(199,  [(197,55),(201,45)])
    g.because(201,  [(136,55),(401,45)])
    g.because(574,  [(400,55),(136,45)])

    g.rebuttal(110,  [(134,55),(400,45)])
    g.rebuttal(137,  [(136,55),(401,45)])
    g.rebuttal(138,  [(136,55),(401,45)])
    g.rebuttal(139,  [(136,55),(401,45)])
    g.rebuttal(604,  [(400,55),(134,45)])
    g.rebuttal(605,  [(401,55),(136,45)])
    g.rebuttal(606,  [(401,55),(136,45)])
    g.rebuttal(609,  [(400,55),(134,45)])
    return g


def build_trans_faith():
    g = EndorsementGraph()
    # Accept: 142,428,785,844
    # Reject: 161

    g.because(142,  [(785,55),(844,45)])
    g.because(785,  [(142,55),(844,45)])
    g.because(844,  [(428,55),(142,45)])
    g.because(428,  [(844,55),(785,45)])

    g.rebuttal(161, [(428,55),(844,45)])
    return g


def build_police_immig():
    g = EndorsementGraph()
    # Accept: 145,153,561,607,612,615,617
    # Reject: 107,155,560,611,616

    # Police: supports police but accepts moderate accountability
    g.because(561,  [(145,55),(607,45)])
    g.because(145,  [(153,55),(561,45)])
    g.because(153,  [(145,55),(561,45)])
    g.because(607,  [(561,55),(145,45)])
    # Immigration: legal + family-based, rejects open borders
    g.because(612,  [(615,55),(617,45)])
    g.because(615,  [(612,55),(617,45)])
    g.because(617,  [(615,55),(612,45)])  # family sep is wrong ← legal process + merit-based

    g.rebuttal(107, [(561,55),(145,45)])
    g.rebuttal(155, [(561,55),(145,45)])
    g.rebuttal(560, [(561,55),(145,45)])
    g.rebuttal(611, [(612,55),(615,45)])
    g.rebuttal(616, [(612,55),(615,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 217,405,416,504
    # Reject: 80,90,104

    g.because(217,  [(134,55),(400,45)])   # racial disparities ← economic/systemic awareness
    g.because(405,  [(400,55),(134,45)])
    g.because(416,  [(405,55),(400,45)])
    g.because(504,  [(405,55),(416,45)])

    g.rebuttal(80,  [(68,55),(136,45)])    # extreme partisan framing ← anti-socialism + capitalism
    g.rebuttal(90,  [(401,55),(68,45)])    # Dems are good ← free market + anti-socialism
    g.rebuttal(104, [(401,55),(136,45)])   # vote Dem ← free market + capitalism
    return g


CLUSTERS = [
    ('ANTI_SOCIALISM', build_anti_socialism()),
    ('ABORT',          build_abort()),
    ('GOVTREG',        build_govtreg()),
    ('TRANS_FAITH',    build_trans_faith()),
    ('POLICE_IMMIG',   build_police_immig()),
    ('MISC',           build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Maria Martinez')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
