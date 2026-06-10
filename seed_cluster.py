#!/usr/bin/env python3
"""
Vestigette Cluster Association Seeder

A deliberate, occasional reconstruction task (NOT the event-driven production
queue). Given a curated cluster of existing arguments and a set of "focal hubs"
within it, personas:
  1. Form an opinion on each hub (accept gates Because/Therefore; reject gates Rebuttal)
  2. Link existing cluster members as Because / Therefore / Rebuttal of the hub
  3. Propose up to 2 genuinely new arguments (as a curious new user would), each
     attached to the hub via a relationship — capped and deduped to avoid sprawl.

Runs on the droplet (needs local DB for reads). Writes via the live form handlers.

Usage:
  python3 seed_cluster.py --dry-run      # preview every proposal, submit nothing
  python3 seed_cluster.py                # live: write associations + new args
  python3 seed_cluster.py --hubs 631,632 # restrict to specific focal hubs
  python3 seed_cluster.py --personas 6   # personas per hub (default 8)
"""

import argparse
import json
import os
import random
import re
import sys
import time
import warnings
from pathlib import Path

warnings.filterwarnings('ignore')
SCRIPT_DIR = Path(__file__).parent
sys.path.insert(0, str(SCRIPT_DIR))

import persona_bot as bot
import process_seed_queue as psq   # reuse get_db() + fetch_existing()
import requests

try:
    import anthropic
except ImportError:
    sys.exit('Error: anthropic not installed. pip install anthropic')

# ── Cluster definition ────────────────────────────────────────────────────────

CLUSTER = [
    72, 73, 74, 75, 76, 77, 85, 86, 366, 379, 380, 393, 394, 398,
    629, 630, 631, 632, 638, 1136, 1137, 1149, 1150, 1151, 1152,
    371, 1769, 1770, 1772, 1773, 1775,
]

DEFAULT_HUBS = [75, 631, 632, 630, 366, 379, 393, 394, 1149, 1150, 1151, 1152]

PERSONAS_PER_HUB    = 8
MAX_NEW_PER_PERSONA = 2
DELAY               = 1.5   # seconds between persona calls
ALL_LETTERS         = list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

# ── Prompt ────────────────────────────────────────────────────────────────────

_CLUSTER_SUFFIX = """

You are exploring Vestigette (a.k.a. Agitate), a structured discourse graph, as a
NEW USER. You're shown a FOCAL ARGUMENT and a list of RELATED ARGUMENTS already in
the system. Your job is to map how they connect and, sparingly, suggest a missing one.

Return ONLY valid JSON — no markdown fences, no commentary:
{
  "verdict": "accept" | "reject" | "skip",
  "reasoning": "1-2 sentences, your authentic gut reaction (internal log)",
  "because":   [<related-argument ids that support/explain the focal>],
  "therefore": [<related-argument ids that follow as a consequence of the focal>],
  "rebuttal":  [<related-argument ids that refute the focal>],
  "new_arguments": [ {"text": "...", "relationship": "because"|"therefore"|"rebuttal"} ]
}

RULES:
- First decide verdict. Strong bias toward accept/reject over skip.
- The platform only lets you add BECAUSE/THEREFORE links if you ACCEPT, and REBUTTAL
  links if you REJECT. So:
    * If you ACCEPT: fill "because" and/or "therefore". Leave "rebuttal" = [].
    * If you REJECT: fill "rebuttal". Leave "because"/"therefore" = [].
    * If you SKIP: leave all three = [] and new_arguments = [].
- BECAUSE = the related argument explains WHY the focal is true (sits under it).
  THEREFORE = the related argument FOLLOWS as a consequence of the focal (sits after it).
  REBUTTAL = the related argument argues AGAINST the focal.
- For because/therefore/rebuttal, use ONLY ids from the provided related-arguments list.
  Pick the ones that genuinely fit — it's fine to pick several, one, or none.
- NEW_ARGUMENTS (0 to 2 max): only a point a curious new user would naturally raise
  that is NOT already represented in the related list. Each must:
    * attach via a relationship consistent with your verdict (accept -> because/therefore,
      reject -> rebuttal),
    * stay on-topic to learning/using/trusting the platform (do not wander),
    * be atomic: one idea, no "but"/"however"/"although", under 150 characters.
  If the related list already covers your point, DO NOT create a new one — that's the
  common mistake. Prefer linking an existing argument over inventing a duplicate."""


def ask_cluster(client, persona, hub_phrasing, candidates):
    """
    candidates: list of {'id': int, 'text': str}.
    Returns (response_dict, cost).
    """
    system_prompt = (
        persona['opinion_engine']['sample_opinion_triggers']['prompt_prefix']
        + _CLUSTER_SUFFIX
    )
    cand_block = '\n'.join(f'  id={c["id"]}: "{c["text"]}"' for c in candidates)
    user_prompt = (
        f'FOCAL ARGUMENT:\n"{hub_phrasing}"\n\n'
        f'RELATED ARGUMENTS (the cluster you can link to):\n{cand_block}\n\n'
        f'Respond with JSON only.'
    )
    msg = client.messages.create(
        model=bot.MODEL, max_tokens=900,
        system=system_prompt,
        messages=[{'role': 'user', 'content': user_prompt}],
    )
    in_tok, out_tok = msg.usage.input_tokens, msg.usage.output_tokens
    cost = (in_tok * 3 + out_tok * 15) / 1_000_000
    raw = msg.content[0].text.strip()
    raw = re.sub(r'^```(?:json)?\s*', '', raw)
    raw = re.sub(r'\s*```$', '', raw)
    # Recover a common model slip: bare "id=394" tokens inside id arrays
    raw = re.sub(r'\bid=(\d+)', r'\1', raw)
    try:
        return json.loads(raw), cost
    except json.JSONDecodeError as exc:
        raise ValueError(f'Bad JSON: {exc}\n{raw}') from exc

# ── Data helpers ──────────────────────────────────────────────────────────────

def fetch_cluster_phrasings(db, ids):
    """Return {argID: phrasing} for the cluster members."""
    idlist = ','.join(str(int(i)) for i in ids)
    out = {}
    with db.cursor() as cur:
        cur.execute(
            f"SELECT a.argumentID AS id, "
            f"       COALESCE(a.currentPhrasing, '') AS text "
            f"FROM ARGUMENT a WHERE a.argumentID IN ({idlist})"
        )
        for r in cur.fetchall():
            if r['text'].strip():
                out[r['id']] = r['text']
    return out


def hub_candidate_pool(db, hub_id, cluster_phrasings):
    """
    Candidate pool for a hub = cluster members (minus the hub) PLUS any arguments
    already linked to the hub as Because/Therefore/Rebuttal (which includes new
    args created earlier in this run, giving free dedup).
    """
    pool = {aid: txt for aid, txt in cluster_phrasings.items() if aid != hub_id}
    for rel in ('Because', 'Therefore', 'Rebuttal'):
        for item in psq.fetch_existing(db, hub_id, rel):
            pool[item['id']] = item['text']
    return [{'id': aid, 'text': txt} for aid, txt in pool.items()]

# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    ap = argparse.ArgumentParser(description='Seed associations within a cluster')
    ap.add_argument('--dry-run', action='store_true')
    ap.add_argument('--hubs', help='comma-separated focal hub argIDs (default: built-in)')
    ap.add_argument('--personas', type=int, default=PERSONAS_PER_HUB)
    ap.add_argument('--max-new', type=int, default=MAX_NEW_PER_PERSONA,
                    help='max new args per persona (0 = associations only)')
    args = ap.parse_args()

    hubs = ([int(x) for x in args.hubs.split(',')] if args.hubs else DEFAULT_HUBS)

    api_key = os.environ.get('ANTHROPIC_API_KEY')
    if not api_key:
        sys.exit('ANTHROPIC_API_KEY not set')

    personas_data = bot.load_personas()
    credentials   = bot.load_credentials()
    client        = anthropic.Anthropic(api_key=api_key)
    db            = psq.get_db()

    cluster_phrasings = fetch_cluster_phrasings(db, CLUSTER)
    print(f'Cluster: {len(cluster_phrasings)} args | Hubs: {hubs}')
    if args.dry_run:
        print('[DRY RUN — nothing will be submitted]\n')

    grand_cost = 0.0
    new_arg_count = 0
    assoc_count = 0

    for hub in hubs:
        hub_phrasing = cluster_phrasings.get(hub)
        if not hub_phrasing:
            print(f'\n== Hub {hub}: phrasing not found, skipping ==')
            continue
        print(f'\n══ Hub {hub}: "{hub_phrasing[:70]}" ══')

        chosen = random.sample(ALL_LETTERS, min(args.personas, 26))
        # Dry-run dedup preview: synthetic ids for proposed-but-not-created new args
        dry_extra = []
        synth = 90000

        for letter in chosen:
            persona = next((p for p in personas_data['personas'] if p['id'] == letter), None)
            creds   = credentials.get(letter)
            if not persona or not creds:
                continue
            name = persona['identity']['name']

            # Build candidate pool fresh each persona (captures prior new args, live mode)
            candidates = hub_candidate_pool(db, hub, cluster_phrasings)
            if args.dry_run:
                candidates = candidates + dry_extra
            valid_ids = {c['id'] for c in candidates}

            session = requests.Session()
            session.headers['User-Agent'] = 'VestigetteClusterSeeder/1.0'
            if not bot.login(session, creds['email'], creds['password']):
                print(f'  [{letter}] login failed'); continue

            try:
                resp, cost = ask_cluster(client, persona, hub_phrasing, candidates)
            except Exception as exc:
                print(f'  [{letter}] error: {exc}'); continue
            grand_cost += cost

            verdict = resp.get('verdict', 'skip')

            def pick(key):
                return [int(i) for i in (resp.get(key, []) or []) if int(i) in valid_ids]

            because   = pick('because')   if verdict == 'accept' else []
            therefore = pick('therefore') if verdict == 'accept' else []
            rebuttal  = pick('rebuttal')  if verdict == 'reject' else []

            new_args = (resp.get('new_arguments', []) or [])[:args.max_new]
            new_by_rel = {'because': [], 'therefore': [], 'rebuttal': []}
            for na in new_args:
                rel = (na.get('relationship') or '').lower()
                txt = (na.get('text') or '').strip()
                if not txt or rel not in new_by_rel:
                    continue
                if verdict == 'accept' and rel == 'rebuttal':   continue
                if verdict == 'reject' and rel in ('because', 'therefore'): continue
                new_by_rel[rel].append(txt)

            # Report
            print(f'  [{letter}] {name} — {verdict}')
            if because:   print(f'        because  → {because}')
            if therefore: print(f'        therefore→ {therefore}')
            if rebuttal:  print(f'        rebuttal → {rebuttal}')
            for rel, texts in new_by_rel.items():
                for t in texts:
                    print(f'        +NEW {rel}: "{t}"')
            for w in bot.validate_response(
                {'verdict': verdict, 'phrasing': None,
                 'rebuttals': new_by_rel['rebuttal'],
                 'becauses': new_by_rel['because'],
                 'therefores': new_by_rel['therefore']}
            ):
                print(f'        ⚠ {w}')

            assoc_count += len(because) + len(therefore) + len(rebuttal)
            new_arg_count += sum(len(v) for v in new_by_rel.values())

            if args.dry_run:
                # Track proposed new args so later personas can "see" them
                for rel, texts in new_by_rel.items():
                    for t in texts:
                        dry_extra.append({'id': synth, 'text': t}); synth += 1
                continue

            if verdict not in ('accept', 'reject'):
                continue

            # Submission is wrapped so a transient network timeout skips this
            # persona rather than aborting the whole run.
            try:
                # Submit vote
                _, csrf, _ = bot.get_arg_page(session, hub)
                bot.submit_vote(session, hub, csrf, verdict)
                time.sleep(0.4)

                # Submit each relationship type (existing links + new nodes together)
                submit_plan = (
                    [('Because', new_by_rel['because'], because),
                     ('Therefore', new_by_rel['therefore'], therefore)]
                    if verdict == 'accept'
                    else [('Rebuttal', new_by_rel['rebuttal'], rebuttal)]
                )
                for rel_type, new_texts, existing_ids in submit_plan:
                    if not new_texts and not existing_ids:
                        continue
                    fcsrf = bot.get_flesh_out_csrf(session, hub, rel_type)
                    time.sleep(0.3)
                    bot.submit_mixed(session, hub, fcsrf, rel_type, new_texts, existing_ids)
                    time.sleep(0.4)
            except requests.RequestException as exc:
                print(f'        ⚠ submit failed ({type(exc).__name__}) — skipping persona')
                continue

            time.sleep(DELAY)

    db.close()
    print(f'\n{"─"*55}')
    print(f'SUMMARY  associations: {assoc_count}  new args: {new_arg_count}  '
          f'cost: ${grand_cost:.4f}')
    if args.dry_run:
        print('[dry-run] nothing was written.')


if __name__ == '__main__':
    main()
