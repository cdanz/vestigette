#!/usr/bin/env python3
"""
Preflight for a candidate spec — run BEFORE gen_rejections.py, alongside check_dupes.py.

Emits SQL that must return ZERO data rows. Catches the two footguns that were
previously manual:

1. OPINION CONFLICT — a cast persona holds the OPPOSITE opinion on the
   candidacy arg (flipping deactivates their other-side weights; recast instead).
2. UNLISTED EXISTING EDGE — the persona already has active edges in the
   (candidacy, edgeType) pool that the spec doesn't list with "already": true.
   Normalization only updates listed edges, so an unlisted one silently breaks
   the 100% sum.

Usage:
    python3 preflight.py spec.json > preflight.sql
    ssh root@178.128.74.45 '...mysql -N -B...' < preflight.sql   # any output = STOP
"""
import json, sys

spec = json.load(open(sys.argv[1]))
cand = spec["candidacyArgID"]
etype = spec.get("edgeType", "Rebuttal")
want = 0 if etype == "Rebuttal" else 1  # required opinion direction on the candidacy arg

print("SET NAMES utf8mb4;")
for p in spec["personas"]:
    pid = p["personaID"]
    print(f"SELECT 'OPINION CONFLICT persona {pid}' AS problem, acceptance FROM OPINION"
          f" WHERE argumentID={cand} AND profileID={pid} AND acceptance={1 - want};")
    listed = [str(r["argID"]) for r in p["rebuttals"] if r.get("already")]
    listed_sql = ",".join(listed) if listed else "0"
    print(f"SELECT 'UNLISTED EDGE persona {pid}' AS problem, supportingArgID, weight FROM ENDORSEMENT"
          f" WHERE targArgID={cand} AND profileID={pid} AND endorseType='{etype}' AND active=1"
          f" AND supportingArgID NOT IN ({listed_sql});")
