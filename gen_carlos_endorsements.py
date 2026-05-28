#!/usr/bin/env python3
"""
Endorsement definitions for Carlos Castillo (profileID=3).

Carlos: 41yo Mexican-American, San Antonio TX. Owner of small HVAC business.
Catholic, married w/ 3 kids. Voted Obama→Trump. Strong 2A, pro-police,
climate skeptic, anti-regulatory, anti-union. Experienced discrimination
personally — rejects blatant racism while also rejecting DEI curriculum.
Responds to practical business framing and perceived strength. Joe Rogan
listener. Distrusts media, government, unions.
"""

import argparse
import sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 3
PROFILE_NAME = "Carlos Castillo"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/carlos_castillo_ENDORSEMENTS_seed.sql'


# ─── cluster definitions ──────────────────────────────────────────────────────

def build_govtreg():
    g = EndorsementGraph()
    # Accept: 52,134,135,136,201,226,227,228,229,265,266,267,275,
    #         322,400,401,404,412,449,601,607,727,920,1045,1278,1591,1597,1602
    # Reject: 54,203,494,495,609,745

    # Rights + taxation core (226,135,134,265)
    g.because(226, [(229, 55), (227, 45)])   # born w/ rights → gov out, lower taxes work
    g.because(229, [(226, 55), (404, 45)])   # gov out of business ← rights + over-regulation
    g.because(135, [(134, 55), (226, 45)])   # threshold of taking ← don't punish success + natural rights
    g.because(134, [(135, 55), (265, 45)])   # don't punish success ← threshold + tax cut returns yours
    g.because(265, [(134, 55), (52, 45)])    # tax cut = return earned money ← don't punish + your money
    g.because(52,  [(265, 55), (135, 45)])   # tax cut is yours ← same reasoning
    g.because(449, [(134, 50), (265, 50)])   # flat tax honest ← don't punish success + return earned

    # Lower taxes → investment (227,228)
    g.because(227, [(228, 55), (401, 45)])   # lower taxes = investment ← private works + free market lifted poor
    g.because(228, [(227, 55), (400, 45)])   # private money works better ← lower taxes + gov ruins it

    # Gov failure pattern (275,400,412,920)
    g.because(275, [(400, 50), (412, 50)])   # no competition in gov ← gov ruins + can't be fired
    g.because(400, [(275, 50), (412, 50)])   # gov ruins it ← no competition + can't be fired
    g.because(412, [(275, 55), (400, 45)])   # gov can't be fired ← no competition + ruins it
    g.because(920, [(412, 55), (400, 45)])   # failed programs persist ← can't be fired + ruins it

    # Regulation burden (404,1045)
    g.because(404, [(1045, 55), (920, 45)])  # 180k pages of regs ← cost-benefit ignored + programs persist
    g.because(1045, [(404, 55), (412, 45)]) # cost-benefit on regs ← over-reg + gov can't be fired

    # Free market / capitalism (401,136,201,1278)
    g.because(401, [(136, 55), (400, 45)])   # free market lifted poor ← capitalism best + gov ruins it
    g.because(136, [(401, 55), (1278, 45)])  # capitalism best ← lifted poor + capitalism ideal
    g.because(1278, [(136, 55), (401, 45)]) # capitalism ideal ← capitalism best + lifted poor
    g.because(201, [(136, 55), (401, 45)])   # innovation shouldn't be encumbered ← capitalism + free market

    # Anti-socialism (1591,1597,1602)
    g.because(1591, [(1597, 55), (1602, 45)]) # socialism always fails ← coercion + private ownership efficient
    g.because(1597, [(1591, 55), (1602, 45)]) # socialism = coercion ← always fails + private efficient
    g.because(1602, [(136, 55), (401, 45)])   # private ownership efficient ← capitalism + free market

    # Welfare / means-testing (266,267,601,607)
    g.because(266, [(267, 55), (265, 45)])   # gov check is unearned ← means-testing + tax cut returns yours
    g.because(267, [(266, 55), (601, 45)])   # means-testing ← unearned + work requirements
    g.because(601, [(267, 55), (607, 45)])   # work requirements for welfare ← means-testing + it works
    g.because(607, [(601, 55), (267, 45)])   # welfare with requirements works ← work req + means-testing

    # Anti-union (727)
    g.because(727, [(275, 55), (400, 45)])   # union work rules kill adaptability ← no competition in gov + ruins what it touches (parallels private market logic)

    # Gov skepticism (322)
    g.because(322, [(400, 55), (412, 45)])   # distrust gov ← ruins it + can't be fired

    # Rebuttals
    g.rebuttal(54,  [(134, 55), (135, 45)])  # wealth tax ← don't punish success + threshold is taking
    g.rebuttal(203, [(401, 55), (136, 45)])  # equality = happiness ← free market lifted poor + capitalism
    g.rebuttal(494, [(727, 55), (275, 45)])  # unionize ← union rules hurt + no gov-like competition
    g.rebuttal(495, [(727, 55), (400, 45)])  # collective bargaining ← union rules + gov ruins
    g.rebuttal(609, [(266, 55), (267, 45)])  # UBI ← gov check unearned + means-test instead
    g.rebuttal(745, [(134, 55), (449, 45)])  # wealthy pay more ← don't punish success + flat tax honest
    return g


def build_police():
    g = EndorsementGraph()
    # Accept: 165,554,561,777,1410
    # Reject: 107,145,151,560

    g.because(561,  [(165, 55), (1410, 45)])  # back the blue ← unions not racist + officer safety first
    g.because(165,  [(561, 55), (1410, 45)])  # fund w/ training ← back the blue + officer safety
    g.because(1410, [(561, 55), (165, 45)])   # officer safety first ← back the blue + training focus
    g.because(554,  [(561, 55), (165, 45)])   # enforce against Antifa ← back the blue + fund properly
    g.because(777,  [(165, 55), (1410, 45)])  # lose vote while incarcerated = fair consequence ← proper policing + safety

    # Rebuttals
    g.rebuttal(107, [(561, 55), (165, 45)])   # defund ← back the blue + fund with training
    g.rebuttal(145, [(165, 55), (1410, 45)])  # policing must be reformed (radical reading) ← training approach is reform
    g.rebuttal(151, [(165, 55), (561, 45)])   # police unions racist ← unions not racist + back the blue
    g.rebuttal(560, [(561, 55), (1410, 45)])  # abolish police ← back the blue + officer safety first
    return g


def build_race_cancel():
    g = EndorsementGraph()
    # Accept: 100,288,291,296,297,600,1229,1562
    # Reject: 101,108,118,293,1345,1346,1347

    # No system perfectly fair (100) — Carlos accepts this from lived experience of profiling
    g.because(100,  [(297, 55), (1229, 45)])  # no system fair ← cancel culture pushes conformism + OK to be white
    g.because(1229, [(1562, 55), (100, 45)])  # OK to be white ← woke ruins institutions + no system fair
    g.because(1562, [(297, 55), (1229, 45)])  # woke ideology ruins institutions ← conformist norms + OK to be white

    # Cancel culture cluster (288,291,296,297,600)
    g.because(288, [(291, 55), (297, 45)])    # cancel culture = intimidation ← jobs for beliefs + conformist norms
    g.because(291, [(288, 55), (600, 45)])    # political beliefs shouldn't cost jobs ← intimidation + left's selective free speech
    g.because(296, [(297, 55), (288, 45)])    # opposition to cancel culture can legitimize bad views ← conformist norms + intimidation
    g.because(297, [(288, 55), (600, 45)])    # cancel culture = conformist liberal norms ← intimidation + left's free speech
    g.because(600, [(297, 55), (291, 45)])    # left only free speech for their ideas ← conformist norms + political beliefs cost jobs

    # Rebuttals
    g.rebuttal(101,  [(100, 100)])             # racism made up ← no system is fair (Carlos has experienced profiling)
    g.rebuttal(108,  [(100, 100)])             # black people commit more crime — racist ← no system fair
    g.rebuttal(118,  [(100, 100)])             # black people inherently less civil ← no system fair
    g.rebuttal(293,  [(288, 55), (291, 45)])  # cancel culture is just criticism ← intimidation + jobs at stake
    g.rebuttal(1345, [(1229, 55), (1562, 45)]) # curriculum to combat white supremacy ← OK to be white + woke ruins
    g.rebuttal(1346, [(1229, 55), (1562, 45)]) # teach kids white people racist ← OK to be white + woke ruins
    g.rebuttal(1347, [(1229, 55), (1562, 45)]) # teach kids white supremacy blocks BIPOC ← OK to be white + woke ruins
    return g


def build_gun():
    g = EndorsementGraph()
    # Accept: 140,328,460,1172,1177,1178
    # Reject: 462,1179,1181

    g.because(140,  [(1172, 55), (328, 45)])  # 2A right to own ← background checks OK/2A not optional + stop compromising
    g.because(1172, [(140, 55), (328, 45)])   # 2A not optional ← right to own + stop giving ground
    g.because(328,  [(140, 55), (1172, 45)])  # stop compromising on 2A ← right to own + 2A not optional
    g.because(460,  [(140, 55), (1178, 45)])  # law-abiding owners punished ← right to own + don't own = no opinion
    g.because(1177, [(1178, 55), (1172, 45)]) # AR-15 for hunting/defense ← purpose determines tool + 2A not optional
    g.because(1178, [(460, 55), (1177, 45)])  # don't own = no opinion ← law-abiding punished + AR-15 legitimate use

    # Rebuttals
    g.rebuttal(462,  [(140, 55), (1178, 45)])  # society better without guns ← 2A right + don't own = no opinion
    g.rebuttal(1179, [(1172, 55), (460, 45)])  # gun reform needed now ← 2A not optional + law-abiding punished
    g.rebuttal(1181, [(140, 55), (1172, 45)])  # strictly limit gun ownership ← right to own + 2A not optional
    return g


def build_trans():
    g = EndorsementGraph()
    # Accept: 142,785,791,801,849
    # Reject: 795,797

    g.because(142, [(785, 55), (791, 45)])    # only two genders ← traditional roles = real differences + women's sports premise
    g.because(785, [(849, 55), (142, 45)])    # traditional gender roles = complementarity ← father protects + two genders
    g.because(791, [(142, 55), (785, 45)])    # women's sports for biological females ← two genders + traditional roles
    g.because(849, [(785, 55), (142, 45)])    # father's first job = protection ← traditional roles + two genders
    g.because(801, [(849, 55), (142, 45)])    # leave trans kids out of culture war ← protect kids (father's role) + two genders is settled

    # Rebuttals
    g.rebuttal(795, [(142, 55), (785, 45)])   # support trans women as women ← two genders + traditional roles
    g.rebuttal(797, [(142, 55), (791, 45)])   # trans girls in women's sports ← two genders + women's sports premise
    return g


def build_immig():
    g = EndorsementGraph()
    # Accept: 612,1159,1160
    # Reject: 611,616,617,972,1237

    g.because(612,  [(1159, 50), (1160, 50)])  # legal/controlled/merit-based ← immigrants not dangerous + boost economy
    g.because(1159, [(1160, 55), (612, 45)])   # immigrants not dangerous ← boost economy + legal process works
    g.because(1160, [(612, 55), (1159, 45)])   # immigrants boost economy ← controlled process + not dangerous

    # Rebuttals
    g.rebuttal(611,  [(612, 55), (1160, 45)])  # open borders ← legal process + boost economy (controlled)
    g.rebuttal(616,  [(612, 100)])             # asylum for all ← legal/merit-based is right approach
    g.rebuttal(617,  [(612, 55), (1159, 45)])  # family separation atrocity ← legal process prevents this + immigrants not dangerous
    g.rebuttal(972,  [(612, 55), (1159, 45)])  # GOP anti-immigrant ← supports legal immigration + immigrants not dangerous
    g.rebuttal(1237, [(612, 55), (1160, 45)])  # this framing of border crisis ← legal process is the answer + economic integration
    return g


def build_climate():
    g = EndorsementGraph()
    # Accept: 1275,1276
    # Reject: 123,414

    g.because(1275, [(1276, 60), (322, 40)])   # climate has always changed ← not uniquely our fault + distrust gov (cross-cluster)
    g.because(1276, [(1275, 60), (322, 40)])   # not uniquely our fault ← always changed + distrust gov claims

    # Rebuttals
    g.rebuttal(123, [(1275, 55), (1276, 45)])  # must act on climate quickly ← always changed + not our fault
    g.rebuttal(414, [(1276, 55), (1275, 45)])  # ramp up renewables ← not uniquely our fault + always changed
    return g


def build_faith():
    g = EndorsementGraph()
    # Accept: 428
    # Reject: 161

    # Faith informs his protector/provider identity and traditional values
    g.because(428, [(849, 60), (785, 40)])     # 30 years walking with God ← father's role (cross-cluster) + traditional values (cross-cluster)

    # Rebuttal
    g.rebuttal(161, [(428, 100)])              # no god exists ← personal faith experience is real
    return g


def build_gop():
    g = EndorsementGraph()
    # Accept: 120
    # Reject: 90,94,104

    g.because(120, [(229, 55), (401, 45)])     # Trump put America first ← gov out of business + free market (cross-cluster GOVTREG)

    # Rebuttals
    g.rebuttal(90,  [(120, 55), (229, 45)])    # GOP bad for America ← Trump put America first + gov out of business
    g.rebuttal(94,  [(120, 55), (136, 45)])    # don't vote Republican ← Trump America first + capitalism best
    g.rebuttal(104, [(229, 55), (136, 45)])    # vote Dems ← gov out of business + capitalism best
    return g


# ─── cluster list ─────────────────────────────────────────────────────────────

CLUSTERS = [
    ('GOVTREG',     build_govtreg()),
    ('POLICE',      build_police()),
    ('RACE_CANCEL', build_race_cancel()),
    ('GUN',         build_gun()),
    ('TRANS',       build_trans()),
    ('IMMIG',       build_immig()),
    ('CLIMATE',     build_climate()),
    ('FAITH',       build_faith()),
    ('GOP',         build_gop()),
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate endorsement SQL for Carlos Castillo')
    parser.add_argument('--dry-run', action='store_true', help='Validate graph; no SQL output')
    parser.add_argument('--apply',   action='store_true', help='Apply generated SQL to DB and validate')
    args = parser.parse_args()

    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
