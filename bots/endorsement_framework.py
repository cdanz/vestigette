#!/usr/bin/env python3
"""
Shared framework for generating persona endorsement SQL.

Usage from a per-persona script:
    from endorsement_framework import EndorsementGraph, generate_sql, dry_run, apply_and_validate

Per-persona script only needs:
  - PROFILE_ID, PROFILE_NAME, OUTPUT_FILE constants
  - 17 build_CLUSTER() functions returning EndorsementGraph objects
  - CLUSTERS list
  - argparse main block

Endorsement semantics:
  Because[A]   includes B  → "I believe A because of B"
  Therefore[A] includes B  → "A implies B" (derived automatically from Because edges)
  Rebuttal[R]  includes A  → "I rebut R with my accepted argument A"

Weight rule: every (targArgID, profileID, endorseType) group must sum to exactly 100.
Cross-cluster: if the same (targArgID, endorseType) group is defined in multiple clusters,
the FIRST cluster wins — later definitions are silently skipped.
"""

import re
import subprocess
from collections import defaultdict

MYSQL = '/Applications/MAMP/Library/bin/mysql -u root -proot -h localhost vestigette'


# ── weight normalizer ────────────────────────────────────────────────────────

def norm(pairs):
    """Normalize raw weights to sum to exactly 100.  pairs = [(argID, raw_weight), ...]"""
    total = sum(w for _, w in pairs)
    result = [(a, round(w / total * 100, 5)) for a, w in pairs]
    diff = 100.0 - sum(w for _, w in result)
    # last element absorbs floating-point remainder
    result[-1] = (result[-1][0], round(result[-1][1] + diff, 5))
    return result


# ── graph builder ────────────────────────────────────────────────────────────

class EndorsementGraph:
    def __init__(self):
        self.because_edges  = {}   # targArgID -> [(supporting, weight), ...]
        self.rebuttal_edges = {}   # rejectedArgID -> [(accepted, weight), ...]

    def because(self, targ, supporters):
        """Declare: arg `targ` is supported by `supporters`.
        Calling twice for the same targ silently overwrites — useful for corrections."""
        self.because_edges[targ] = supporters

    def rebuttal(self, targ, rebuters):
        """Declare: rejected arg `targ` is countered by accepted args `rebuters`."""
        self.rebuttal_edges[targ] = rebuters

    def _compute_therefore(self):
        """Derive Therefore edges from Because edges (reversed direction).
        For each A supported by B: Therefore[B] includes A."""
        therefore = {}
        for targ, supporters in self.because_edges.items():
            for sup, w in supporters:
                therefore.setdefault(sup, []).append((targ, w))
        return therefore

    def _make_rows(self, profile_id):
        """Return list of SQL value tuples for all endorsement types."""
        out = []
        for targ, supporters in self.because_edges.items():
            for sup, w in norm(supporters):
                out.append(f"({targ},{profile_id},'Because',{sup},{w},1)")
        for targ, implies_list in self._compute_therefore().items():
            for sup, w in norm(implies_list):
                out.append(f"({targ},{profile_id},'Therefore',{sup},{w},1)")
        for targ, rebuters in self.rebuttal_edges.items():
            for sup, w in norm(rebuters):
                out.append(f"({targ},{profile_id},'Rebuttal',{sup},{w},1)")
        return out


# ── pre-flight checks ────────────────────────────────────────────────────────

def dry_run(clusters, profile_id):
    """Validate cluster graph structure before generating SQL.
    Returns True if no blocking errors found."""
    errors   = []
    warnings = []

    for cname, g in clusters:
        # Self-references in Because
        for targ, supporters in g.because_edges.items():
            for sup, _w in supporters:
                if sup == targ:
                    errors.append(f"[{cname}] Self-reference in because({targ}): ({sup}, ...)")
        # Self-references in Rebuttal
        for targ, rebuters in g.rebuttal_edges.items():
            for sup, _w in rebuters:
                if sup == targ:
                    errors.append(f"[{cname}] Self-reference in rebuttal({targ}): ({sup}, ...)")
        # Non-positive weights
        for targ, supporters in g.because_edges.items():
            for sup, w in supporters:
                if w <= 0:
                    errors.append(f"[{cname}] Non-positive weight in because({targ}): ({sup}, {w})")
        for targ, rebuters in g.rebuttal_edges.items():
            for sup, w in rebuters:
                if w <= 0:
                    errors.append(f"[{cname}] Non-positive weight in rebuttal({targ}): ({sup}, {w})")

    # Cross-cluster duplicate (targArgID, endorseType) groups
    seen_groups = {}
    for cname, g in clusters:
        cluster_rows = g._make_rows(profile_id)
        cg = defaultdict(list)
        for row in cluster_rows:
            m = re.match(r'\((\d+),\d+,\'(\w+)\',', row)
            if m:
                gk = (m.group(1), m.group(2))
                cg[gk].append(row)
        for gk in cg:
            if gk in seen_groups:
                warnings.append(
                    f"Dup group (arg={gk[0]}, {gk[1]}): "
                    f"claimed by {seen_groups[gk]}, skipped in {cname}"
                )
            else:
                seen_groups[gk] = cname

    if errors:
        print("ERRORS (must fix before generating SQL):")
        for e in errors:
            print(f"  ✗ {e}")
    if warnings:
        print(f"WARNINGS — cross-cluster overlaps ({len(warnings)} groups, first-cluster wins):")
        for w in warnings:
            print(f"  ⚠  {w}")
    if not errors and not warnings:
        print("✓ All checks passed — no errors, no cross-cluster overlaps.")
    elif not errors:
        print(f"✓ No blocking errors. {len(warnings)} cross-cluster overlap(s) handled by dedup.")

    return len(errors) == 0


# ── SQL generator ────────────────────────────────────────────────────────────

def generate_sql(profile_id, profile_name, clusters, outfile):
    """Generate complete endorsement SQL for a profile and write to outfile."""
    lines = [
        f"-- {profile_name} (profileID={profile_id}) — ENDORSEMENTS",
        f"-- Generated by endorsement_framework.py",
        "",
        f"-- STEP 1: PHRASE_ENDORSE rows for all {profile_name} phrasings",
        "",
        f"INSERT IGNORE INTO PHRASE_ENDORSE (argumentID, phrasingID, profileID, weight, active)",
        f"SELECT p.argumentID, p.phrasingID, {profile_id}, 100, 1",
        f"FROM PHRASING p",
        f"WHERE p.coinedBy = {profile_id}",
        f"  AND NOT EXISTS (",
        f"    SELECT 1 FROM PHRASE_ENDORSE pe",
        f"    WHERE pe.profileID = {profile_id} AND pe.argumentID = p.argumentID",
        f"  );",
        "",
        "-- STEP 2: Endorsement chains (Because / Therefore / Rebuttal)",
        "",
    ]

    # Collect all target arg IDs across clusters
    all_targets = set()
    for _cname, g in clusters:
        all_targets.update(g.because_edges.keys())
        all_targets.update(g.rebuttal_edges.keys())
        all_targets.update(g._compute_therefore().keys())

    targ_list = ','.join(str(t) for t in sorted(all_targets))
    lines.append(
        f"DELETE FROM ENDORSEMENT WHERE profileID={profile_id} "
        f"AND targArgID IN ({targ_list});"
    )
    lines.append("")

    # Cross-cluster dedup: first cluster to define a (targArgID, endorseType) group wins
    seen_groups = set()
    unique_rows = []
    for _cname, g in clusters:
        cluster_rows = g._make_rows(profile_id)
        cg_rows = defaultdict(list)
        for row in cluster_rows:
            m = re.match(r'\((\d+),\d+,\'(\w+)\',', row)
            if m:
                gk = (m.group(1), m.group(2))
                cg_rows[gk].append(row)
        for gk, rows_list in cg_rows.items():
            if gk not in seen_groups:
                seen_groups.add(gk)
                unique_rows.extend(rows_list)

    if unique_rows:
        lines.append(
            "INSERT INTO ENDORSEMENT "
            "(targArgID,profileID,endorseType,supportingArgID,weight,active) VALUES"
        )
        lines.append(",\n".join(unique_rows) + ";")

    lines += [
        "",
        "-- STEP 3: Sync PHRASE_ENDORSE active flag with opinion acceptance",
        "",
        "UPDATE PHRASE_ENDORSE pe",
        f"JOIN OPINION o ON pe.argumentID = o.argumentID AND o.profileID = {profile_id}",
        "SET pe.active = o.acceptance",
        f"WHERE pe.profileID = {profile_id};",
        "",
        f"SELECT 'Done: endorsements for profileID={profile_id}' AS status;",
    ]

    sql = '\n'.join(lines)
    with open(outfile, 'w') as f:
        f.write(sql)
    print(f"Written {len(unique_rows)} endorsement rows → {outfile}")
    return outfile


# ── apply + validate ─────────────────────────────────────────────────────────

def apply_and_validate(profile_id, sql_file):
    """Pipe sql_file into MySQL, then print a combined validation report."""
    print(f"Applying {sql_file} to DB...")
    result = subprocess.run(
        f'{MYSQL} < {sql_file}',
        shell=True, capture_output=True, text=True
    )
    if result.returncode != 0:
        print(f"ERROR applying SQL:\n{result.stderr}")
        return False
    if result.stderr and 'Warning' not in result.stderr:
        print(f"STDERR: {result.stderr}")

    print("Validating...")
    query = f"""
SELECT 'phrasings'      AS metric, COUNT(*) AS val FROM PHRASING       WHERE coinedBy  = {profile_id}
UNION ALL
SELECT 'phrase_endorse',            COUNT(*)        FROM PHRASE_ENDORSE WHERE profileID = {profile_id}
UNION ALL
SELECT 'endorsements',              COUNT(*)        FROM ENDORSEMENT    WHERE profileID = {profile_id}
UNION ALL
SELECT 'opinions',                  COUNT(*)        FROM OPINION        WHERE profileID = {profile_id}
UNION ALL
SELECT 'accepted',                  SUM(acceptance) FROM OPINION        WHERE profileID = {profile_id}
UNION ALL
SELECT 'bad_groups', COUNT(*) FROM (
    SELECT targArgID, endorseType
    FROM ENDORSEMENT WHERE profileID = {profile_id}
    GROUP BY targArgID, endorseType
    HAVING ABS(SUM(weight) - 100) > 0.001
) _bad;

SELECT endorseType, COUNT(*) AS cnt
FROM ENDORSEMENT WHERE profileID = {profile_id}
GROUP BY endorseType;

SELECT
    SUM(pe.active = 1 AND o.acceptance = 1) AS both_active,
    SUM(pe.active = 0 AND o.acceptance = 0) AS both_inactive,
    SUM(pe.active != o.acceptance)          AS mismatched
FROM PHRASE_ENDORSE pe
JOIN OPINION o ON pe.argumentID = o.argumentID AND o.profileID = pe.profileID
WHERE pe.profileID = {profile_id};
"""
    result = subprocess.run(
        f'{MYSQL} -t',
        input=query, shell=True, capture_output=True, text=True
    )
    print(result.stdout)
    if result.stderr and 'Warning' not in result.stderr:
        print("STDERR:", result.stderr)
    return True
