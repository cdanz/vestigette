#!/usr/bin/env python3
"""
Vestigette Argument Seeder

Given a new argument ID, picks N random personas and runs the persona bot
on each one sequentially. This is the production entry point — call it
whenever a new argument is created.

Usage:
  python3 seed_argument.py --arg 123                  # 10 random personas
  python3 seed_argument.py --arg 123 --count 5        # 5 random personas
  python3 seed_argument.py --arg 123 --dry-run        # preview, no submissions
  python3 seed_argument.py --arg 123 --personas A,B,C # specific personas

Setup: see persona_bot.py header.
"""

import argparse
import json
import random
import sys
import time
from pathlib import Path

# Reuse all helpers from persona_bot
sys.path.insert(0, str(Path(__file__).parent))
import persona_bot as bot

ALL_LETTERS = list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
DELAY_BETWEEN_PERSONAS = 2.0  # seconds


def main():
    parser = argparse.ArgumentParser(description='Seed a new argument with N random personas')
    parser.add_argument('--arg',      required=True, type=int, metavar='ID',
                        help='Argument ID to seed')
    parser.add_argument('--count',    type=int, default=10, metavar='N',
                        help='Number of random personas to run (default: 10)')
    parser.add_argument('--personas', metavar='A,B,C',
                        help='Comma-separated persona letters to use instead of random')
    parser.add_argument('--dry-run',  action='store_true',
                        help='Show Claude responses but submit nothing')
    parser.add_argument('--skip-associations', action='store_true',
                        help='Skip association submission for every persona')
    args = parser.parse_args()

    arg_id = args.arg

    # ── Choose personas ────────────────────────────────────────────────────────
    if args.personas:
        chosen = [l.strip().upper() for l in args.personas.split(',')]
        invalid = [l for l in chosen if l not in ALL_LETTERS]
        if invalid:
            sys.exit(f'Unknown persona letters: {invalid}')
    else:
        pool = list(ALL_LETTERS)
        random.shuffle(pool)
        chosen = pool[:args.count]

    print(f'Argument : {arg_id}')
    print(f'Personas : {", ".join(chosen)} ({len(chosen)} total)')
    if args.dry_run:
        print('[DRY RUN — nothing will be submitted]\n')
    else:
        print()

    # ── Load shared data once ──────────────────────────────────────────────────
    personas_data = bot.load_personas()
    clusters      = bot.load_clusters()
    credentials   = bot.load_credentials()

    import anthropic, os
    api_key = os.environ.get('ANTHROPIC_API_KEY')
    if not api_key:
        sys.exit('Error: ANTHROPIC_API_KEY not set')
    client = anthropic.Anthropic(api_key=api_key)

    # ── Run each persona ───────────────────────────────────────────────────────
    total_cost   = 0.0
    results      = []  # [{letter, name, verdict, cost, skipped, error}]

    for i, letter in enumerate(chosen):
        persona = next((p for p in personas_data['personas'] if p['id'] == letter), None)
        if not persona:
            print(f'[{letter}] Persona not found — skipping')
            continue

        persona_name = persona['identity']['name']
        creds = credentials.get(letter)
        if not creds:
            print(f'[{letter}] No credentials — skipping')
            continue

        print(f'── {letter}: {persona_name} ──────────────────────────')

        try:
            import requests as req_lib
            import warnings
            warnings.filterwarnings('ignore')

            session = req_lib.Session()
            session.headers['User-Agent'] = 'VestigettePersonaBot/1.0'

            if not bot.login(session, creds['email'], creds['password']):
                print(f'  Login failed — skipping')
                results.append({'letter': letter, 'name': persona_name,
                                'verdict': None, 'cost': 0, 'error': 'login failed'})
                continue

            arg_phrasing, csrf_token, current_opinion = bot.get_arg_page(session, arg_id)

            if i == 0:
                # Print argument text once at the top
                print(f'\nArgument: "{arg_phrasing}"\n')
                print(f'── {letter}: {persona_name} ──────────────────────────')

            if current_opinion in (1, -1):
                print(f'  Already has opinion ({current_opinion}) — skipping')
                results.append({'letter': letter, 'name': persona_name,
                                'verdict': current_opinion, 'cost': 0, 'skipped': True})
                continue

            sibling_ids, _ = bot.find_cluster_siblings(arg_id, clusters)
            cluster_context = []  # Phase 1: no phrasing lookup

            # Claude call
            response, call_cost = bot.ask_claude(client, persona, arg_phrasing, cluster_context)
            total_cost += call_cost

            verdict       = response.get('verdict', 'skip')
            phrasing_text = response.get('phrasing') if verdict == 'accept' else None
            rebuttals     = response.get('rebuttals', []) if verdict == 'reject' else []

            # Display
            print(f'  {persona_name} — {verdict.upper()}', end='')
            if verdict == 'accept':
                print(f'\n    "{phrasing_text}"')
            elif verdict == 'reject' and rebuttals:
                print()
                for j, r in enumerate(rebuttals, 1):
                    print(f'    rebuttal {j}: "{r}"')
            else:
                print()

            # Warn on "but" constructions
            for w in bot.validate_response(response):
                print(f'    ⚠ {w}')

            print(f'  cost: ${call_cost:.4f}')

            results.append({'letter': letter, 'name': persona_name,
                            'verdict': verdict, 'cost': call_cost})

            if verdict == 'skip' or args.dry_run:
                pass
            else:
                import json as _json

                # Submit vote
                bot.submit_vote(session, arg_id, csrf_token, verdict)
                time.sleep(0.4)

                # Submit phrasing + explication (accept only)
                if phrasing_text:
                    _, fresh_csrf, _ = bot.get_arg_page(session, arg_id)
                    time.sleep(0.3)
                    bot.submit_phrasing(session, arg_id, fresh_csrf, phrasing_text)
                    time.sleep(0.4)

                    expl_url = bot.search_for_url(phrasing_text)
                    if expl_url:
                        time.sleep(0.3)
                        action, _ = bot.submit_explication_deduped(session, arg_id, expl_url)
                        if action == 'endorsed':
                            print(f'  explication: {expl_url} (endorsed existing)')
                        elif action == 'created':
                            print(f'  explication: {expl_url} (new)')
                        time.sleep(0.4)

                # Submit rebuttals as new argument nodes (reject only)
                if rebuttals:
                    flesh_csrf = bot.get_flesh_out_csrf(session, arg_id, 'Rebuttal')
                    time.sleep(0.3)
                    pinned = [
                        {'type': 'new', 'text': r, 'weight': 1, 'reciprocate': False}
                        for r in rebuttals
                    ]
                    session.post(
                        f'{bot.BASE_URL}/flesh_out.php?arg={arg_id}&type=Rebuttal',
                        data={
                            'csrfToken': flesh_csrf,
                            'type': 'Rebuttal',
                            'argID': arg_id,
                            'pinnedData': _json.dumps(pinned),
                        },
                        allow_redirects=True, timeout=15,
                    )
                    time.sleep(0.4)

                # Associations
                if not args.skip_associations:
                    associations = response.get('associations', [])
                    by_type = {}
                    for assoc in associations:
                        rel = assoc.get('relationship', '').capitalize()
                        by_type.setdefault(rel, []).append(assoc)
                    for rel_type, group in by_type.items():
                        if rel_type not in ('Because', 'Therefore', 'Rebuttal'):
                            continue
                        if rel_type in ('Because', 'Therefore') and verdict == 'reject':
                            continue
                        if rel_type == 'Rebuttal' and verdict in ('accept', 'ambivalent'):
                            continue
                        flesh_csrf = bot.get_flesh_out_csrf(session, arg_id, rel_type)
                        time.sleep(0.3)
                        bot.submit_associations(session, arg_id, rel_type, flesh_csrf, group)
                        time.sleep(0.4)

                print(f'  submitted OK')

        except Exception as exc:
            print(f'  ERROR: {exc}')
            results.append({'letter': letter, 'name': persona_name,
                            'verdict': None, 'cost': 0, 'error': str(exc)})

        if i < len(chosen) - 1:
            time.sleep(DELAY_BETWEEN_PERSONAS)

    # ── Summary ────────────────────────────────────────────────────────────────
    print(f'\n{"─" * 50}')
    print(f'SUMMARY — arg {arg_id}')
    print(f'{"─" * 50}')
    accepts  = sum(1 for r in results if r.get('verdict') == 'accept')
    rejects  = sum(1 for r in results if r.get('verdict') == 'reject')
    skipped  = sum(1 for r in results if r.get('verdict') == 'skip' or r.get('skipped'))
    errors   = sum(1 for r in results if r.get('error'))
    print(f'accept: {accepts}  reject: {rejects}  skip: {skipped}  errors: {errors}')
    print(f'total cost: ${total_cost:.4f}')
    print(f'est. cost for all 26 personas on this arg: ${total_cost / max(len([r for r in results if not r.get("skipped") and not r.get("error")]), 1) * 26:.4f}')
    print(f'est. cost for 10 personas on 100 new args: ${total_cost / max(len([r for r in results if not r.get("skipped") and not r.get("error")]), 1) * 10 * 100:.2f}')


if __name__ == '__main__':
    main()
