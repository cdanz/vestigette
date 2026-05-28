#!/usr/bin/env python3
"""
Endorsement definitions for Frank Fletcher (profileID=6).

Frank: 52yo white Republican, Cary NC. Regional Sales Manager.
+6/10 conservative. Strongly fiscal conservative — taxes/regulation/
free markets are his issues. Culturally moderate: accepts climate
science (just opposes aggressive action), finds overt racism
embarrassing (rejects 'racism is made up'), doesn't care much about
abortion or LGBTQ+. Anti-union. Trusts WSJ, Chamber of Commerce.
Hardcoded: lower taxes = better outcomes, gov less efficient than
markets, hard work explains outcomes, deficit is real problem.
"""

import argparse, sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 6
PROFILE_NAME = "Frank Fletcher"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/frank_fletcher_ENDORSEMENTS_seed.sql'


def build_govtreg():
    g = EndorsementGraph()
    # Accept: 134,135,197,199,201,226,227,228,229,264,265,266,267,275,
    #         400,401,404,412,601,607,727,895,910,911,920,1045,1278,1591,1597,1602
    # Reject: 192,450,494,495,609,745

    # Rights + taxation core
    g.because(226,  [(229,55),(227,45)])
    g.because(229,  [(226,55),(404,45)])
    g.because(134,  [(135,55),(265,45)])
    g.because(135,  [(134,55),(226,45)])
    g.because(265,  [(134,55),(227,45)])
    g.because(264,  [(265,55),(267,45)])
    g.because(266,  [(267,55),(265,45)])
    g.because(267,  [(266,55),(601,45)])
    # Lower taxes → growth
    g.because(227,  [(228,55),(401,45)])
    g.because(228,  [(227,55),(400,45)])
    # Gov failure
    g.because(275,  [(400,55),(412,45)])
    g.because(400,  [(275,55),(412,45)])
    g.because(412,  [(275,55),(400,45)])
    g.because(920,  [(412,55),(400,45)])
    g.because(404,  [(1045,55),(920,45)])
    g.because(1045, [(404,55),(412,45)])
    # Free market / capitalism
    g.because(401,  [(136,55),(400,45)])
    g.because(136,  [(401,55),(1278,45)])
    g.because(1278, [(136,55),(401,45)])
    g.because(1591, [(1597,55),(136,45)])
    g.because(1597, [(1591,55),(1602,45)])
    g.because(1602, [(136,55),(401,45)])
    g.because(201,  [(136,55),(401,45)])
    g.because(197,  [(199,55),(134,45)])
    g.because(199,  [(197,55),(201,45)])
    # Welfare / work requirements
    g.because(601,  [(267,55),(607,45)])
    g.because(607,  [(601,55),(267,45)])
    # Anti-union
    g.because(727,  [(275,55),(400,45)])
    # Healthcare (pro-market)
    g.because(895,  [(910,55),(920,45)])
    g.because(910,  [(895,55),(911,45)])
    g.because(911,  [(910,55),(895,45)])

    # Rebuttals
    g.rebuttal(192, [(134,55),(265,45)])   # wealth tax
    g.rebuttal(450, [(227,55),(401,45)])   # Keynesian stimulus
    g.rebuttal(494, [(727,55),(275,45)])   # unionize
    g.rebuttal(495, [(727,55),(400,45)])   # collective bargaining
    g.rebuttal(609, [(266,55),(267,45)])   # UBI
    g.rebuttal(745, [(134,55),(265,45)])   # wealthy pay more
    return g


def build_police_immig():
    g = EndorsementGraph()
    # Accept: 165,561,1159,1160,1410,612
    # Reject: 107,155,560,611,616

    g.because(561,  [(165,55),(1410,45)])
    g.because(165,  [(561,55),(1410,45)])
    g.because(1410, [(561,55),(165,45)])
    g.because(612,  [(1159,55),(1160,45)])
    g.because(1159, [(1160,55),(612,45)])
    g.because(1160, [(612,55),(1159,45)])

    g.rebuttal(107, [(561,55),(165,45)])
    g.rebuttal(155, [(1410,55),(165,45)])   # some police opposition arg
    g.rebuttal(560, [(561,55),(1410,45)])
    g.rebuttal(611, [(612,55),(1159,45)])
    g.rebuttal(616, [(612,100)])
    return g


def build_climate_mod():
    g = EndorsementGraph()
    # Frank: accepts science, nuclear, waste mgmt; rejects aggressive mandates
    # Accept: 321,527,528,529,530
    # Reject: 123,414,476

    g.because(321,  [(530,55),(527,45)])   # climate science ← nuclear option + recycling
    g.because(530,  [(321,55),(527,45)])   # nuclear energy ← climate real + recycling infrastructure
    g.because(527,  [(528,55),(529,45)])
    g.because(528,  [(527,55),(530,45)])
    g.because(529,  [(528,55),(527,45)])

    g.rebuttal(123, [(321,55),(530,45)])   # must act "quickly and forcefully" — Frank accepts science but rejects panic
    g.rebuttal(414, [(530,55),(321,45)])   # ramp up renewables aggressively
    g.rebuttal(476, [(530,55),(321,45)])   # fossil fuels critique
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 140,328,460,1172
    # Reject: 1179,1181

    g.because(140,  [(1172,55),(328,45)])
    g.because(1172, [(140,55),(328,45)])
    g.because(328,  [(140,55),(1172,45)])
    g.because(460,  [(140,55),(1172,45)])

    g.rebuttal(1179, [(1172,55),(460,45)])
    g.rebuttal(1181, [(140,55),(1172,45)])
    return g


def build_race_cancel():
    g = EndorsementGraph()
    # Frank: accepts climate science, rejects overt racism, nuanced on cancel culture
    # Accept: 100,288,291,1229,321(dup-handled),322,1095,1096
    # Reject: 101,108,118,297,1345,1346,1589

    g.because(100,  [(1229,55),(322,45)])
    g.because(1229, [(100,55),(322,45)])
    g.because(322,  [(100,55),(1229,45)])
    g.because(288,  [(291,55),(100,45)])
    g.because(291,  [(288,55),(100,45)])
    g.because(1095, [(1096,55),(1278,45)])   # 1278 from GOVTREG
    g.because(1096, [(1095,55),(1278,45)])

    g.rebuttal(101,  [(100,55),(1229,45)])   # racism made up — Frank rejects crude racism
    g.rebuttal(108,  [(100,55),(1229,45)])   # black people commit more crime
    g.rebuttal(118,  [(100,55),(1229,45)])   # inherently less civil
    g.rebuttal(297,  [(291,55),(288,45)])    # cancel culture = liberal norms — too partisan for Frank
    g.rebuttal(1345, [(100,55),(322,45)])    # curriculum for white supremacy
    g.rebuttal(1346, [(100,55),(1229,45)])   # teach kids white people racist
    g.rebuttal(1589, [(1591,55),(1597,45)])  # some socialism arg — 1591,1597 from GOVTREG
    return g


CLUSTERS = [
    ('GOVTREG',     build_govtreg()),
    ('POLICE_IMMIG',build_police_immig()),
    ('CLIMATE_MOD', build_climate_mod()),
    ('GUN',         build_gun()),
    ('RACE_CANCEL', build_race_cancel()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Frank Fletcher')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--apply',   action='store_true')
    args = parser.parse_args()
    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
