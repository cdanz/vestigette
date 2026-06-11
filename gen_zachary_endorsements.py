#!/usr/bin/env python3
"""
Endorsement definitions for Zachary Zeller (profileID=26).

Zachary: 18yo Lakota Sioux male, Standing Rock ND/SD, odd jobs. 0 Apolitical.
GMO reversed. Indigenous perspective is the lens for everything: climate is
land and water rights; racism is settler colonialism; government is inherently
suspicious (rejects 400,412 — unlike libertarians, because of specific
Indigenous history with federal government). Accepts climate action (321,414).
Accepts some civil rights framing (226 = natural rights, 103). Indigenous
identity cluster (781-789, 806, 825-843).
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 26
PROFILE_NAME = "Zachary Zeller"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/zachary_zeller_ENDORSEMENTS_seed.sql'


def build_race_history():
    g = EndorsementGraph()
    # Accept: 103,175,221,237,238,242,244,245,313,320
    # Reject: 101,527,528

    g.because(175,  [(221,55),(237,45)])
    g.because(221,  [(175,55),(242,45)])
    g.because(237,  [(244,55),(245,45)])
    g.because(242,  [(244,55),(237,45)])
    g.because(244,  [(245,55),(237,45)])
    g.because(245,  [(237,55),(244,45)])
    g.because(238,  [(237,55),(244,45)])
    g.because(103,  [(175,55),(221,45)])
    g.because(313,  [(320,55),(175,45)])
    g.because(320,  [(313,55),(237,45)])

    g.rebuttal(101, [(175,55),(237,45)])
    g.rebuttal(527, [(321,55),(477,45)])  # 321/477 cross-cluster
    g.rebuttal(528, [(321,55),(477,45)])
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 123,278,279,280,281,282,283,285,317,318,319,321,414,416,
    #         476,477,530,598,863,892,893
    # Reject: 230,560,561

    g.because(321,  [(863,55),(892,45)])
    g.because(863,  [(892,55),(893,45)])
    g.because(892,  [(863,55),(893,45)])
    g.because(893,  [(892,55),(863,45)])
    g.because(476,  [(477,55),(321,45)])
    g.because(477,  [(476,55),(863,45)])
    g.because(414,  [(321,55),(477,45)])
    g.because(123,  [(321,55),(863,45)])
    g.because(530,  [(321,55),(414,45)])
    # Indigenous environmental rights
    g.because(278,  [(279,55),(280,45)])
    g.because(279,  [(278,55),(281,45)])
    g.because(280,  [(279,55),(282,45)])
    g.because(281,  [(280,55),(278,45)])
    g.because(282,  [(281,55),(283,45)])
    g.because(283,  [(282,55),(285,45)])
    g.because(285,  [(283,55),(282,45)])
    g.because(317,  [(318,55),(321,45)])
    g.because(318,  [(317,55),(319,45)])
    g.because(319,  [(318,55),(317,45)])
    g.because(416,  [(321,55),(414,45)])
    g.because(598,  [(278,55),(321,45)])

    g.rebuttal(230, [(321,55),(892,45)])
    g.rebuttal(560, [(278,55),(282,45)])   # police abolition framing not Indigenous view
    g.rebuttal(561, [(278,55),(282,45)])   # back the blue not Indigenous view
    return g


def build_indigenous():
    g = EndorsementGraph()
    # Accept: 226,322,323,405,406,682,685,692,704,706,757,762,774,
    #         781,782,783,784,786,787,788,789,806,825,827,842,843
    # Reject: 400,412,772,773,776,780,839,840,841

    # Civil rights/sovereignty framing
    g.because(226,  [(322,55),(782,45)])
    g.because(322,  [(226,55),(781,45)])
    g.because(323,  [(322,55),(226,45)])
    # Economic
    g.because(405,  [(406,55),(322,45)])
    g.because(406,  [(405,55),(322,45)])
    # Community/cultural args
    g.because(682,  [(685,55),(692,45)])
    g.because(685,  [(682,55),(692,45)])
    g.because(692,  [(682,55),(685,45)])
    # Indigenous sovereignty cluster
    g.because(781,  [(782,55),(783,45)])
    g.because(782,  [(781,55),(784,45)])
    g.because(783,  [(782,55),(784,45)])
    g.because(784,  [(783,55),(782,45)])
    g.because(786,  [(787,55),(781,45)])
    g.because(787,  [(786,55),(788,45)])
    g.because(788,  [(787,55),(789,45)])
    g.because(789,  [(788,55),(787,45)])
    g.because(704,  [(706,55),(781,45)])
    g.because(706,  [(704,55),(782,45)])
    g.because(757,  [(762,55),(781,45)])
    g.because(762,  [(757,55),(783,45)])
    g.because(774,  [(781,55),(784,45)])
    g.because(806,  [(781,55),(786,45)])
    g.because(825,  [(827,55),(781,45)])
    g.because(827,  [(825,55),(783,45)])
    g.because(842,  [(843,55),(781,45)])
    g.because(843,  [(842,55),(783,45)])

    g.rebuttal(400, [(226,55),(322,45)])   # gov failure framing ← sovereignty + rights
    g.rebuttal(412, [(226,55),(781,45)])
    g.rebuttal(772, [(781,55),(782,45)])
    g.rebuttal(773, [(781,55),(783,45)])
    g.rebuttal(776, [(782,55),(781,45)])
    g.rebuttal(780, [(781,55),(784,45)])
    g.rebuttal(839, [(782,55),(784,45)])
    g.rebuttal(840, [(783,55),(782,45)])
    g.rebuttal(841, [(784,55),(781,45)])
    return g


CLUSTERS = [
    ('RACE_HISTORY', build_race_history()),
    ('CLIMATE',      build_climate()),
    ('INDIGENOUS',   build_indigenous()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Zachary Zeller')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
