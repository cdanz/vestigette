#!/usr/bin/env python3
"""
Endorsement definitions for Karen Kim (profileID=11).

Karen: 44yo Korean-American female, Bellevue WA, senior SWE. -6 Dem.
Meritocratic progressive: worked hard to get here, believes in fairness
and equity, but wants practical solutions over ideological purity.
Core issues: racial equity, climate, voting rights, healthcare, tech
policy. Accepts police reform not abolition/defunding. Accepts 134
(don't over-punish success) because she's earned her salary — but still
wants billionaires to pay more (745). Rejects crude racism but avoids
excessive wokeness that alienates centrists.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 11
PROFILE_NAME = "Karen Kim"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/karen_kim_ENDORSEMENTS_seed.sql'


def build_race_police():
    g = EndorsementGraph()
    # Accept: 100,103,145,148,153,154,155,169,175,207,217,218,219,240,
    #         484,485,539,546,603
    # Reject: 107,108,118,349,560

    # Structural racism
    g.because(175,  [(207,55),(217,45)])
    g.because(207,  [(175,55),(218,45)])
    g.because(217,  [(207,55),(175,45)])
    g.because(218,  [(207,55),(219,45)])
    g.because(219,  [(175,55),(207,45)])
    # Historical
    g.because(240,  [(175,55),(207,45)])
    # Criminal justice
    g.because(484,  [(485,55),(175,45)])
    g.because(485,  [(484,55),(207,45)])
    g.because(103,  [(175,55),(484,45)])
    # Education
    g.because(169,  [(175,55),(207,45)])
    # No system perfectly fair (Karen accepts this from systemic awareness)
    g.because(100,  [(175,55),(207,45)])
    # Police reform (moderate)
    g.because(145,  [(148,55),(153,45)])
    g.because(148,  [(153,55),(145,45)])
    g.because(153,  [(148,55),(154,45)])
    g.because(154,  [(153,55),(175,45)])
    g.because(155,  [(154,55),(145,45)])
    g.because(539,  [(145,55),(155,45)])
    # Racial justice movement
    g.because(546,  [(603,55),(175,45)])
    g.because(603,  [(546,55),(175,45)])

    g.rebuttal(107, [(145,55),(539,45)])   # defund — Karen wants reform not defunding
    g.rebuttal(108, [(175,55),(207,45)])   # racist trope
    g.rebuttal(118, [(175,55),(207,45)])   # racist trope
    g.rebuttal(349, [(175,55),(207,45)])   # colorblindness
    g.rebuttal(560, [(145,55),(539,45)])   # abolish
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 123,321,414,476,477,863,892
    # Reject: 230

    g.because(321,  [(863,55),(892,45)])
    g.because(863,  [(892,55),(321,45)])
    g.because(892,  [(863,55),(321,45)])
    g.because(476,  [(477,55),(321,45)])
    g.because(477,  [(476,55),(863,45)])
    g.because(414,  [(321,55),(477,45)])
    g.because(123,  [(321,55),(863,45)])

    g.rebuttal(230, [(321,55),(892,45)])
    return g


def build_voting():
    g = EndorsementGraph()
    # Accept: 182,184,279,331,333,355,356,357
    # (no specific rejects in this cluster)

    g.because(182,  [(184,55),(355,45)])
    g.because(184,  [(182,55),(356,45)])
    g.because(355,  [(356,55),(357,45)])
    g.because(356,  [(355,55),(357,45)])
    g.because(357,  [(356,55),(355,45)])
    g.because(279,  [(355,55),(356,45)])
    g.because(331,  [(355,55),(182,45)])
    g.because(333,  [(331,55),(355,45)])
    return g


def build_healthcare():
    g = EndorsementGraph()
    # Accept: 894,895,896,897,898,899,909
    # Reject: 910

    g.because(895,  [(896,55),(897,45)])
    g.because(896,  [(895,55),(898,45)])
    g.because(897,  [(896,55),(895,45)])
    g.because(898,  [(897,55),(896,45)])
    g.because(894,  [(895,55),(898,45)])
    g.because(899,  [(898,55),(895,45)])
    g.because(909,  [(895,55),(896,45)])

    g.rebuttal(910, [(895,55),(897,45)])
    return g


def build_econ():
    g = EndorsementGraph()
    # Accept: 110,134,203,494,495,500,501,745
    # Reject: 193

    g.because(110,  [(203,55),(745,45)])
    g.because(203,  [(110,55),(745,45)])
    g.because(745,  [(110,55),(203,45)])
    # Karen (meritocratic progressive): accepts "don't over-tax hard work"
    # supported by her belief in fairness + systems awareness
    g.because(134,  [(203,55),(100,45)])   # 100 cross-cluster from RACE_POLICE
    g.because(494,  [(495,55),(500,45)])
    g.because(495,  [(494,55),(501,45)])
    g.because(500,  [(501,55),(110,45)])
    g.because(501,  [(500,55),(494,45)])

    g.rebuttal(193, [(110,55),(203,45)])
    return g


def build_lgbtq():
    g = EndorsementGraph()
    # Accept: 141,544,696,697,698,699,701,702,954,958
    # Reject: 142,700

    g.because(696,  [(698,55),(699,45)])
    g.because(698,  [(696,55),(699,45)])
    g.because(699,  [(698,55),(701,45)])
    g.because(697,  [(696,55),(698,45)])
    g.because(701,  [(699,55),(702,45)])
    g.because(702,  [(701,55),(699,45)])
    g.because(141,  [(699,55),(698,45)])
    g.because(544,  [(699,55),(698,45)])
    g.because(954,  [(698,55),(699,45)])
    g.because(958,  [(699,55),(701,45)])

    g.rebuttal(142, [(699,55),(701,45)])
    g.rebuttal(700, [(699,55),(701,45)])
    return g


def build_misc():
    g = EndorsementGraph()
    # Accept: 89,90,293,295,315,316,317,318,320,367,368,369,374,378,
    #         416,463,464,476(→CLIMATE),478,479,480,486,496,498,499,
    #         504,505,588,591,615,636,654,655,946,972
    # Reject: 80,611,612

    # Dem party (reluctant but present)
    g.because(89,   [(90,55),(100,45)])    # 100 cross-cluster
    g.because(90,   [(89,55),(100,45)])
    # Cancel culture = accountability
    g.because(293,  [(295,55),(203,45)])   # 203 cross-cluster
    g.because(295,  [(293,55),(203,45)])
    # Tech / net neutrality
    g.because(315,  [(316,55),(295,45)])
    g.because(316,  [(315,55),(293,45)])
    # Democratic norms / governance
    g.because(317,  [(318,55),(315,45)])
    g.because(318,  [(317,55),(316,45)])
    g.because(320,  [(317,55),(318,45)])
    # Policy / equity
    g.because(367,  [(368,55),(369,45)])
    g.because(368,  [(367,55),(369,45)])
    g.because(369,  [(368,55),(367,45)])
    g.because(374,  [(369,55),(368,45)])
    g.because(378,  [(374,55),(369,45)])
    g.because(416,  [(369,55),(374,45)])
    # Research/data
    g.because(463,  [(464,55),(369,45)])
    g.because(464,  [(463,55),(369,45)])
    g.because(478,  [(479,55),(480,45)])
    g.because(479,  [(478,55),(480,45)])
    g.because(480,  [(479,55),(478,45)])
    g.because(486,  [(480,55),(479,45)])
    g.because(496,  [(494,55),(495,45)])   # 494/495 cross-cluster
    g.because(498,  [(499,55),(496,45)])
    g.because(499,  [(498,55),(496,45)])
    # Other progressive args
    g.because(504,  [(505,55),(496,45)])
    g.because(505,  [(504,55),(499,45)])
    g.because(588,  [(591,55),(500,45)])   # 500 cross-cluster
    g.because(591,  [(588,55),(500,45)])
    g.because(615,  [(972,55),(495,45)])
    g.because(636,  [(499,55),(498,45)])
    g.because(654,  [(655,55),(499,45)])
    g.because(655,  [(654,55),(499,45)])
    g.because(946,  [(954,55),(499,45)])   # 954 cross-cluster
    g.because(972,  [(615,55),(495,45)])

    g.rebuttal(80,  [(89,55),(90,45)])
    g.rebuttal(611, [(615,55),(972,45)])
    g.rebuttal(612, [(615,55),(972,45)])
    return g


CLUSTERS = [
    ('RACE_POLICE', build_race_police()),
    ('CLIMATE',     build_climate()),
    ('VOTING',      build_voting()),
    ('HEALTHCARE',  build_healthcare()),
    ('ECON',        build_econ()),
    ('LGBTQ',       build_lgbtq()),
    ('MISC',        build_misc()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Karen Kim')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
