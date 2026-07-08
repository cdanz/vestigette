#!/usr/bin/env python3
"""
Endorsement definitions for PERSONA NAME (profileID=N).

Usage:
  python3 gen_PERSONA_endorsements.py               # generate SQL file
  python3 gen_PERSONA_endorsements.py --dry-run     # validate graph only
  python3 gen_PERSONA_endorsements.py --apply       # generate + apply to DB + validate

Workflow for a new persona:
  1. Set PROFILE_ID, PROFILE_NAME, OUTPUT_FILE below.
  2. Query DB for this profile's opinions:
       SELECT argumentID, acceptance FROM OPINION WHERE profileID=N ORDER BY argumentID;
  3. Write build_CLUSTER() functions below — one per topic cluster.
     - because(targ, [(supporter, weight), ...]) for accepted args
     - rebuttal(targ, [(rebutter, weight), ...]) for rejected args
     - Weights are raw (any scale) — norm() normalizes them to 100.
     - Calling because(targ, ...) twice silently overwrites — use this to fix mistakes.
  4. Run --dry-run to catch self-references and see cross-cluster overlaps.
  5. Run --apply to generate SQL, apply to DB, and print validation report.
"""

import argparse
import sys
sys.path.insert(0, '/Users/Razzmatazz/vestigette-dev')
from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

PROFILE_ID   = 0           # ← set to actual profileID
PROFILE_NAME = "PERSONA"   # ← set to "First Last"
OUTPUT_FILE  = '/Users/Razzmatazz/vestigette-dev/PERSONA_ENDORSEMENTS_seed.sql'  # ← update


# ─── cluster definitions ──────────────────────────────────────────────────────
# Add one build_CLUSTER() per topic cluster that this persona has opinions in.
# Cross-cluster arg references are fine — the first cluster to define a
# (targArgID, endorseType) group owns it; later clusters skip that group.

def build_abort():
    g = EndorsementGraph()
    # Accept: list accepted arg IDs here
    # Reject: list rejected arg IDs here

    # Example:
    # g.because(126, [(908, 60), (127, 40)])   # arg 126 supported by 908 (60%) and 127 (40%)
    # g.rebuttal(124, [(903, 55), (908, 45)])  # rejected arg 124 countered by 903 and 908

    return g


# ... add more build_CLUSTER() functions here ...


# ─── cluster list ─────────────────────────────────────────────────────────────
# List clusters in the order they should claim cross-cluster arg groups.
# Earlier clusters take priority on any shared (targArgID, endorseType) group.

CLUSTERS = [
    ('ABORT', build_abort()),
    # ('BLM',     build_blm()),
    # ('HEALTH',  build_health()),
    # ... etc.
]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description=f'Generate endorsement SQL for {PROFILE_NAME}'
    )
    parser.add_argument('--dry-run', action='store_true', help='Validate graph; no SQL output')
    parser.add_argument('--apply',   action='store_true', help='Apply generated SQL to DB and validate')
    args = parser.parse_args()

    if args.dry_run:
        dry_run(CLUSTERS, PROFILE_ID)
    else:
        generate_sql(PROFILE_ID, PROFILE_NAME, CLUSTERS, OUTPUT_FILE)
        if args.apply:
            apply_and_validate(PROFILE_ID, OUTPUT_FILE)
