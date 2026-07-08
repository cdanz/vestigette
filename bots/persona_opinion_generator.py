#!/usr/bin/env python3
"""
persona_opinion_generator.py

Generates a seed SQL file capturing one persona's opinions on one topic cluster.

Usage:
    python3 persona_opinion_generator.py --persona 2 --cluster GUN
    python3 persona_opinion_generator.py --persona 2 --cluster GUN --dry-run
    python3 persona_opinion_generator.py --list-clusters
    python3 persona_opinion_generator.py --list-personas

Output:
    {persona_slug}_{cluster_id}_seed.sql  (gitignore matches *_seed.sql ✓)

Environment:
    ANTHROPIC_API_KEY  — required (except for --dry-run / --list-* modes)

Design notes:
    - Weights in generated SQL are RAW (proportional integers from Claude).
      Always run normalize_weights.py after all clusters for a persona are done.
    - Because/Therefore connections are reciprocal (Python derives the Therefore
      from every Because). Rebuttal connections are one-directional.
    - Large clusters are split into batches (--batch-size, default 40).
    - The script is idempotent: re-running DELETEs and re-inserts endorsements.
"""

import argparse
import json
import os
import re
import subprocess
import sys
from datetime import datetime
from pathlib import Path

# ── Config ─────────────────────────────────────────────────────────────────────
MYSQL_BIN   = '/Applications/MAMP/Library/bin/mysql'
MYSQL_ARGS  = ['-u', 'root', '-proot', '-h', 'localhost', 'vestigette',
               '--skip-column-names', '--batch']
SCRIPT_DIR  = Path(__file__).parent
PERSONAS_FILE  = SCRIPT_DIR / 'personas_all_26.json'
CLUSTERS_FILE  = SCRIPT_DIR / 'topic_clusters.json'
DEFAULT_MODEL  = 'claude-sonnet-4-6'
DEFAULT_BATCH  = 40
MAX_PHRASING   = 300
API_URL        = 'https://api.anthropic.com/v1/messages'
API_VERSION    = '2023-06-01'


# ── Database helpers ───────────────────────────────────────────────────────────

def db_query(sql):
    result = subprocess.run(
        [MYSQL_BIN] + MYSQL_ARGS + ['-e', sql],
        capture_output=True, text=True, errors='replace'
    )
    rows = []
    for line in result.stdout.strip().split('\n'):
        if line.strip():
            rows.append(line.split('\t'))
    return rows


def fetch_phrasings(arg_ids):
    """Return {argID: phrasing} for args that have a non-null currentPhrasing."""
    if not arg_ids:
        return {}
    ids = ','.join(str(i) for i in arg_ids)
    rows = db_query(
        f"SELECT argumentID, currentPhrasing FROM ARGUMENT "
        f"WHERE argumentID IN ({ids}) AND currentPhrasing IS NOT NULL"
    )
    return {int(r[0]): r[1] for r in rows if len(r) >= 2}


def fetch_existing_opinions(profile_id, arg_ids):
    """Return {argID: acceptance} where acceptance=1 or -1."""
    if not arg_ids:
        return {}
    ids = ','.join(str(i) for i in arg_ids)
    rows = db_query(
        f"SELECT argumentID, acceptance FROM OPINION "
        f"WHERE profileID={profile_id} AND argumentID IN ({ids})"
    )
    return {int(r[0]): int(r[1]) for r in rows if len(r) >= 2}


# ── Prompt construction ────────────────────────────────────────────────────────

def build_prompt(persona, args_map, cluster_label):
    """
    Return (system_prompt, user_prompt) for one batch of args.
    args_map: {argID: phrasing_text}
    """
    oe     = persona.get('opinion_engine', {})
    prefix = oe.get('sample_opinion_triggers', {}).get('prompt_prefix', '')
    name   = persona.get('_name', f"Persona {persona.get('_profileID', '?')}")

    system = f"""You are generating persona-driven opinions for a political discourse database.

PERSONA: {name}
{prefix}

TASK: Evaluate each argument below and decide what this persona would genuinely think.

RULES:
1. OPINION must be ACCEPT, REJECT, or SKIP.
   ACCEPT  — persona strongly agrees with the argument's sentiment.
   REJECT  — persona strongly disagrees.
   SKIP    — persona has no meaningful opinion, or the argument is off-topic for them.

2. PHRASING (ACCEPT only): Write the persona's own wording in their authentic voice.
   • MUST be ≤{MAX_PHRASING} characters (count carefully).
   • MUST be MORE SPECIFIC than the existing phrasing: name the policy, technology,
     event, legislation, statistic, or place — not vague generalities.
   • Do NOT start with "I" — write as the persona speaking, not as "I think".

3. BECAUSE connections (ACCEPT only): Other args in this batch that support/explain
   this one. List as {{"argID": N, "weight": W}} where W is 1–10 (higher = stronger link).
   Only use argIDs from the provided list. Omit if no strong logical connection.

4. REBUTTAL connections (REJECT only): Accepted args from this batch that rebut this
   rejected argument. Same format. Only list args the persona genuinely accepts as counters.

5. Weights are relative — they will be normalized automatically. Do not try to sum to 100.

6. Do NOT fabricate argIDs. Only use IDs from the list below.

7. Return ONLY the JSON object. No preamble, no commentary, no markdown fences.

RESPONSE FORMAT (strict):
{{
  "results": [
    {{
      "argID": 123,
      "opinion": "ACCEPT",
      "phrasing": "Specific persona-voice phrasing here...",
      "because": [{{"argID": 8, "weight": 3}}, {{"argID": 11, "weight": 2}}],
      "rebuttal": []
    }},
    {{
      "argID": 456,
      "opinion": "REJECT",
      "phrasing": null,
      "because": [],
      "rebuttal": [{{"argID": 3, "weight": 3}}]
    }},
    {{
      "argID": 789,
      "opinion": "SKIP",
      "phrasing": null,
      "because": [],
      "rebuttal": []
    }}
  ]
}}"""

    arg_lines = [
        f'argID={aid}: "{phr}"'
        for aid, phr in sorted(args_map.items())
    ]
    user = (
        f"Cluster: {cluster_label}\n"
        f"Arguments to evaluate ({len(args_map)} total):\n\n"
        + '\n'.join(arg_lines)
        + "\n\nReturn ONLY the JSON object."
    )
    return system, user


# ── API call ───────────────────────────────────────────────────────────────────

def call_claude(system_prompt, user_prompt, model, api_key):
    """Call the Anthropic Messages API and return parsed JSON dict."""
    import urllib.request
    import urllib.error

    payload = json.dumps({
        'model':      model,
        'max_tokens': 8192,
        'system':     system_prompt,
        'messages':   [{'role': 'user', 'content': user_prompt}],
    }).encode('utf-8')

    req = urllib.request.Request(
        API_URL,
        data=payload,
        headers={
            'x-api-key':         api_key,
            'anthropic-version': API_VERSION,
            'content-type':      'application/json',
        },
        method='POST',
    )
    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            body = resp.read().decode('utf-8')
    except urllib.error.HTTPError as e:
        err_body = e.read().decode('utf-8')
        raise RuntimeError(f"API HTTP {e.code}: {err_body}") from e

    api_resp = json.loads(body)
    text = api_resp['content'][0]['text'].strip()

    # Strip markdown fences if Claude wrapped the JSON
    text = re.sub(r'^```(?:json)?\s*', '', text)
    text = re.sub(r'\s*```$', '', text)

    return json.loads(text)


# ── Validation ─────────────────────────────────────────────────────────────────

def validate_results(raw_results, valid_ids):
    """
    Validate and clean Claude's output.
    Returns (cleaned_list, warnings_list).
    valid_ids: set of argIDs that were sent in this batch.
    """
    cleaned = []
    warnings = []

    for item in raw_results:
        arg_id  = item.get('argID')
        opinion = str(item.get('opinion', 'SKIP')).upper()
        phrasing = item.get('phrasing') or None
        because  = item.get('because', []) or []
        rebuttal = item.get('rebuttal', []) or []

        if arg_id not in valid_ids:
            warnings.append(f"Skipping unknown argID {arg_id} in response")
            continue

        if opinion not in ('ACCEPT', 'REJECT', 'SKIP'):
            warnings.append(f"argID {arg_id}: unknown opinion '{opinion}' → SKIP")
            opinion = 'SKIP'

        if phrasing and len(phrasing) > MAX_PHRASING:
            # Trim at word boundary
            trimmed = phrasing[:MAX_PHRASING].rsplit(' ', 1)[0]
            warnings.append(
                f"argID {arg_id}: phrasing {len(phrasing)} chars → trimmed to {len(trimmed)}"
            )
            phrasing = trimmed

        def clean_endorsements(entries, label):
            out = []
            for e in (entries or []):
                ref = e.get('argID')
                w   = int(e.get('weight', 1))
                if ref == arg_id:
                    warnings.append(f"argID {arg_id}: self-referential {label} removed")
                    continue
                if ref not in valid_ids:
                    warnings.append(
                        f"argID {arg_id}: {label} references unknown argID {ref} — removed"
                    )
                    continue
                out.append({'argID': ref, 'weight': max(1, w)})
            return out

        because  = clean_endorsements(because,  'because')
        rebuttal = clean_endorsements(rebuttal, 'rebuttal')

        cleaned.append({
            'argID':    arg_id,
            'opinion':  opinion,
            'phrasing': phrasing if opinion == 'ACCEPT' else None,
            'because':  because  if opinion == 'ACCEPT' else [],
            'rebuttal': rebuttal if opinion == 'REJECT' else [],
        })

    return cleaned, warnings


# ── SQL generation ─────────────────────────────────────────────────────────────

def escape_sql(s):
    return s.replace('\\', '\\\\').replace("'", "''")


def generate_sql(persona_name, profile_id, cluster_id, cluster_label,
                 all_results, existing_opinions):
    """
    Build the complete SQL seed file content from validated results.

    Weight normalization is NOT done here — run normalize_weights.py afterwards.
    """
    now = datetime.now().strftime('%Y-%m-%d %H:%M')

    accepted = [r for r in all_results if r['opinion'] == 'ACCEPT']
    rejected = [r for r in all_results if r['opinion'] == 'REJECT']
    skipped  = [r for r in all_results if r['opinion'] == 'SKIP']

    # Only write SQL for args where the persona has a real opinion
    opinionated = sorted([r['argID'] for r in all_results if r['opinion'] != 'SKIP'])

    lines = [
        f"-- Persona: {persona_name} (profileID={profile_id})",
        f"-- Cluster: {cluster_id} — {cluster_label}",
        f"-- Generated: {now}",
        f"-- Decisions: {len(accepted)} ACCEPT, {len(rejected)} REJECT, {len(skipped)} SKIP",
        f"-- NOTE: Weights are raw proportional values. Run normalize_weights.py after all clusters.",
        "",
    ]

    if not opinionated:
        lines.append("-- No opinions for this persona/cluster combination.")
        return '\n'.join(lines)

    ids_csv = ', '.join(str(i) for i in opinionated)

    # ── Section 1: Delete existing endorsements ─────────────────────────────
    lines += [
        "-- ── Section 1: Clear existing endorsements ──────────────────────────────",
        f"DELETE FROM ENDORSEMENT WHERE profileID={profile_id} AND targArgID IN ({ids_csv});",
        "",
    ]

    # ── Section 2: Opinion assertions (new or changed) ──────────────────────
    opinion_calls = []
    for r in sorted(all_results, key=lambda x: x['argID']):
        if r['opinion'] == 'SKIP':
            continue
        target = 1 if r['opinion'] == 'ACCEPT' else -1
        if existing_opinions.get(r['argID']) != target:
            opinion_calls.append((r['argID'], target))

    if opinion_calls:
        lines.append("-- ── Section 2: Opinion assertions (new or changed) ──────────────────────")
        for arg_id, acc in sorted(opinion_calls):
            label = "ACCEPT" if acc == 1 else "REJECT"
            lines.append(f"CALL assertOpinion({acc}, {arg_id}, {profile_id});  -- {label}")
        lines.append("")

    # ── Section 3: Phrasings for accepted args ───────────────────────────────
    phrasings_to_add = [(r['argID'], r['phrasing']) for r in accepted if r['phrasing']]
    if phrasings_to_add:
        lines.append("-- ── Section 3: Persona phrasings ────────────────────────────────────────")
        for arg_id, phr in sorted(phrasings_to_add):
            lines.append(f"CALL newPutForth({arg_id}, {profile_id}, '{escape_sql(phr)}');")
        lines.append("")

    # ── Section 4: Because/Therefore reciprocal pairs ────────────────────────
    # Collect unique (targ, type, supporting, weight) rows.
    # Each Because(A→B) creates a paired Therefore(B→A) at the same weight.
    # Use dict to merge duplicates (take max weight).
    endorsement_rows = {}  # (targ, etype, sup) -> weight

    for r in sorted(accepted, key=lambda x: x['argID']):
        a = r['argID']
        for bc in r['because']:
            b, w = bc['argID'], bc['weight']
            for key in [(a, 'Because', b), (b, 'Therefore', a)]:
                endorsement_rows[key] = max(endorsement_rows.get(key, 0), w)

    if endorsement_rows:
        lines.append("-- ── Section 4: Because/Therefore pairs (reciprocal, raw weights) ────────")
        lines.append(
            "INSERT IGNORE INTO ENDORSEMENT "
            "(targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES"
        )
        value_lines = []
        for (targ, etype, sup), w in sorted(endorsement_rows.items()):
            value_lines.append(f"  ({targ}, {profile_id}, '{etype}', {sup}, {w}, 1)")
        lines.append(',\n'.join(value_lines) + ';')
        lines.append("")

    # ── Section 5: Rebuttal connections (one-directional) ───────────────────
    rebuttal_rows = {}
    for r in sorted(rejected, key=lambda x: x['argID']):
        a = r['argID']
        for rb in r['rebuttal']:
            b, w = rb['argID'], rb['weight']
            key = (a, 'Rebuttal', b)
            rebuttal_rows[key] = max(rebuttal_rows.get(key, 0), w)

    if rebuttal_rows:
        lines.append("-- ── Section 5: Rebuttal connections (one-directional, raw weights) ──────")
        lines.append(
            "INSERT IGNORE INTO ENDORSEMENT "
            "(targArgID, profileID, endorseType, supportingArgID, weight, active) VALUES"
        )
        value_lines = []
        for (targ, etype, sup), w in sorted(rebuttal_rows.items()):
            value_lines.append(f"  ({targ}, {profile_id}, '{etype}', {sup}, {w}, 1)")
        lines.append(',\n'.join(value_lines) + ';')
        lines.append("")

    # ── Section 6: Sync PHRASE_ENDORSE active flags ──────────────────────────
    lines += [
        "-- ── Section 6: Sync PHRASE_ENDORSE active flags ────────────────────────",
        "UPDATE PHRASE_ENDORSE pe",
        "INNER JOIN OPINION o ON pe.argumentID=o.argumentID AND pe.profileID=o.profileID",
        "SET pe.active = o.acceptance",
        f"WHERE pe.profileID={profile_id}",
        f"AND pe.argumentID IN ({ids_csv});",
        "",
    ]

    return '\n'.join(lines)


# ── Normalization utility (run after all clusters) ────────────────────────────

def generate_normalization_sql(profile_id, persona_slug):
    """
    Query DB for all active endorsement groups for this persona and emit
    UPDATE statements normalizing each (targArgID, endorseType) group to 100.
    Returns SQL string.
    """
    rows = db_query(
        f"SELECT targArgID, endorseType, supportingArgID, weight "
        f"FROM ENDORSEMENT WHERE profileID={profile_id} AND active=1 "
        f"ORDER BY targArgID, endorseType, supportingArgID"
    )
    if not rows:
        return f"-- No active endorsements found for profileID={profile_id}\n"

    from collections import defaultdict
    groups = defaultdict(list)
    for r in rows:
        tid, etype, sid, w = int(r[0]), r[1], int(r[2]), float(r[3])
        groups[(tid, etype)].append((sid, w))

    lines = [
        f"-- normalize_{persona_slug}_seed.sql",
        f"-- Normalizes all ENDORSEMENT weights for profileID={profile_id}",
        f"-- so each (targArgID, endorseType) group sums to exactly 100.",
        f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M')}",
        "",
    ]

    for (tid, etype), entries in sorted(groups.items()):
        total = sum(w for _, w in entries)
        if abs(total - 100.0) < 0.001:
            continue  # already correct
        lines.append(f"-- arg {tid} {etype}: {len(entries)} entries, old sum={total:.1f}")
        running = 0.0
        for i, (sid, w) in enumerate(entries):
            if i == len(entries) - 1:
                nw = round(100.0 - running, 4)
            else:
                nw = round((w / total) * 100, 4)
            lines.append(
                f"UPDATE ENDORSEMENT SET weight={nw} WHERE "
                f"targArgID={tid} AND profileID={profile_id} AND "
                f"endorseType='{etype}' AND supportingArgID={sid} AND active=1;"
            )
            running += nw
        lines.append("")

    return '\n'.join(lines)


# ── CLI ────────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description='Generate persona opinion seed SQL for a topic cluster.',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument('--persona',    type=int,  help='profileID (1–26)')
    parser.add_argument('--cluster',               help='Cluster ID (e.g. GUN, CLIMATE)')
    parser.add_argument('--batch-size', type=int,  default=DEFAULT_BATCH,
                        help=f'Args per API call (default {DEFAULT_BATCH})')
    parser.add_argument('--model',                 default=DEFAULT_MODEL,
                        help=f'Claude model (default {DEFAULT_MODEL})')
    parser.add_argument('--output-dir',            default='.',
                        help='Directory for output SQL file')
    parser.add_argument('--dry-run',  action='store_true',
                        help='Print prompt stats but skip API calls')
    parser.add_argument('--normalize', action='store_true',
                        help='After processing, generate normalization SQL for entire persona')
    parser.add_argument('--list-clusters', action='store_true',
                        help='List all available cluster IDs and exit')
    parser.add_argument('--list-personas', action='store_true',
                        help='List all personas and exit')
    args = parser.parse_args()

    # Load reference files
    clusters = json.loads(CLUSTERS_FILE.read_text())
    raw_personas = json.loads(PERSONAS_FILE.read_text())
    # personas_all_26.json wraps the list under a 'personas' key
    persona_list = raw_personas.get('personas', raw_personas) if isinstance(raw_personas, dict) else raw_personas

    # Build profileID → persona dict (id='A'→1, 'B'→2, ...)
    persona_map = {}
    for p in persona_list:
        pid_char = p.get('id', '')
        if pid_char and pid_char.isalpha():
            profile_num = ord(pid_char.upper()) - ord('A') + 1
            # Attach resolved profileID and flat name for convenience
            p['_profileID'] = profile_num
            p['_name'] = p.get('identity', {}).get('name', f"Persona {profile_num}")
            persona_map[profile_num] = p

    if args.list_clusters:
        print(f"{'ID':<20} {'Count':>5}  Label")
        print('-' * 70)
        for cid, c in sorted(clusters.items()):
            if cid != 'SKIP':
                print(f"{cid:<20} {len(c['args']):>5}  {c['label']}")
        return

    if args.list_personas:
        print(f"{'profileID':>10}  Name")
        print('-' * 40)
        for pid, p in sorted(persona_map.items()):
            print(f"{pid:>10}  {p['_name']}")
        return

    if not args.persona or not args.cluster:
        parser.error("--persona and --cluster are required (or use --list-clusters / --list-personas)")

    # Resolve persona and cluster
    if args.persona not in persona_map:
        sys.exit(f"ERROR: profileID={args.persona} not found in {PERSONAS_FILE.name}")

    cluster_id = args.cluster.upper()
    if cluster_id not in clusters or cluster_id == 'SKIP':
        sys.exit(f"ERROR: cluster '{args.cluster}' not found. Use --list-clusters to see options.")

    persona        = persona_map[args.persona]
    persona_name   = persona['_name']
    persona_slug   = persona_name.lower().replace(' ', '_')
    profile_id     = args.persona
    cluster        = clusters[cluster_id]
    cluster_label  = cluster['label']
    cluster_args   = cluster['args']

    print(f"Persona : {persona_name} (profileID={profile_id})")
    print(f"Cluster : {cluster_id} — {cluster_label}")
    print(f"Args    : {len(cluster_args)} in cluster")

    # Fetch data from DB
    print("Fetching phrasings …", end=' ', flush=True)
    phrasings = fetch_phrasings(cluster_args)
    print(f"{len(phrasings)} args have phrasings")

    print("Fetching existing opinions …", end=' ', flush=True)
    existing = fetch_existing_opinions(profile_id, cluster_args)
    print(f"{len(existing)} existing")

    arg_ids_with_phrasing = sorted(phrasings.keys())
    batches = [
        arg_ids_with_phrasing[i:i + args.batch_size]
        for i in range(0, len(arg_ids_with_phrasing), args.batch_size)
    ]

    if args.dry_run:
        sys_p, usr_p = build_prompt(persona, phrasings, cluster_label)
        print(f"\n-- DRY RUN --")
        print(f"Batches      : {len(batches)} × up to {args.batch_size} args")
        print(f"System prompt: {len(sys_p):,} chars")
        print(f"User prompt  : {len(usr_p):,} chars  (full batch, for illustration)")
        print("\n-- System prompt preview (first 600 chars) --")
        print(sys_p[:600])
        return

    api_key = os.environ.get('ANTHROPIC_API_KEY')
    if not api_key:
        sys.exit("ERROR: ANTHROPIC_API_KEY environment variable not set")

    # Process batches
    all_results = []
    for i, batch_ids in enumerate(batches, 1):
        batch_map = {aid: phrasings[aid] for aid in batch_ids}
        print(f"Batch {i}/{len(batches)}: args {batch_ids[0]}–{batch_ids[-1]} …", end=' ', flush=True)

        sys_p, usr_p = build_prompt(persona, batch_map, cluster_label)
        try:
            resp = call_claude(sys_p, usr_p, args.model, api_key)
        except (RuntimeError, json.JSONDecodeError) as e:
            sys.exit(f"\nERROR on batch {i}: {e}")

        raw = resp.get('results', [])
        valid_ids = set(batch_ids)
        cleaned, warns = validate_results(raw, valid_ids)

        if warns:
            print()
            for w in warns:
                print(f"  WARN: {w}")

        ac = sum(1 for r in cleaned if r['opinion'] == 'ACCEPT')
        rj = sum(1 for r in cleaned if r['opinion'] == 'REJECT')
        sk = sum(1 for r in cleaned if r['opinion'] == 'SKIP')
        print(f"ACCEPT={ac} REJECT={rj} SKIP={sk}")

        all_results.extend(cleaned)

    # Generate SQL
    sql = generate_sql(
        persona_name, profile_id, cluster_id, cluster_label,
        all_results, existing
    )

    out_name = f"{persona_slug}_{cluster_id}_seed.sql"
    out_path = Path(args.output_dir) / out_name
    out_path.write_text(sql)

    ac_total = sum(1 for r in all_results if r['opinion'] == 'ACCEPT')
    rj_total = sum(1 for r in all_results if r['opinion'] == 'REJECT')
    sk_total = sum(1 for r in all_results if r['opinion'] == 'SKIP')

    print(f"\nResults : ACCEPT={ac_total}  REJECT={rj_total}  SKIP={sk_total}")
    print(f"Output  : {out_path}")
    print(f"\nNext steps:")
    print(f"  1. Review: cat {out_path}")
    print(f"  2. Apply:  {MYSQL_BIN} -u root -proot vestigette < {out_path}")
    print(f"  3. After ALL clusters: python3 persona_opinion_generator.py \\")
    print(f"       --persona {profile_id} --normalize-only")

    if args.normalize:
        print("\nGenerating normalization SQL …", end=' ', flush=True)
        norm_sql  = generate_normalization_sql(profile_id, persona_slug)
        norm_path = Path(args.output_dir) / f"normalize_{persona_slug}_seed.sql"
        norm_path.write_text(norm_sql)
        print(f"written to {norm_path}")


if __name__ == '__main__':
    main()
