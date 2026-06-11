#!/usr/bin/env python3
"""
Vestigette Bot Seed Queue Processor

Reads pending entries from BOT_SEED_QUEUE and runs seed_argument.py
for arguments that pass all guard-rail conditions.

Designed to run as a cron job every 5 minutes on the droplet:
  */5 * * * * cd /var/www/bot && python3 process_seed_queue.py >> /var/log/vestigette-bot.log 2>&1

Condition checks (in order, cheapest first):
  1. Delay window     — queuedAt must be at least 10 minutes ago
  2. Real user        — createdBy > 26 (not a bot persona)
  3. Not admin        — isAdmin = 0 on that profile
  4. Not yet seeded   — no existing bot opinions on this argument
  5. Weight floor     — parentWeight >= 10.0 (flesh_out entries only)
  6. Phrasing length  — argument phrasing >= 20 characters
  7. Parent engaged   — parent argument has >= 2 distinct real-user opinions
"""

import json
import os
import random
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

try:
    import pymysql
except ImportError:
    sys.exit('Error: pymysql not installed. Run: pip install pymysql')

# ── Config ────────────────────────────────────────────────────────────────────

SCRIPT_DIR   = Path(__file__).parent
DELAY_MINUTES = 10
MIN_PHRASING_LENGTH = 20
MIN_PARENT_OPINIONS = 2   # distinct real humans needed on parent arg
WEIGHT_FLOOR        = 10.0  # % floor for flesh_out-created arguments
BOT_PERSONA_MAX     = 26    # profileIDs 1-26 are bot personas
PERSONAS_PER_ARG    = 10    # how many random personas to run per argument
PENDING_MAX_DAYS    = 30    # entries waiting on parent engagement expire after this

# A check returns one of these outcomes:
PASS  = 'pass'    # all conditions met — seed it
SKIP  = 'skip'    # terminal — never revisit
RETRY = 'retry'   # not yet — leave pending, re-check on a future run

# Load .env if present
_env_file = SCRIPT_DIR / '.env'
if _env_file.exists():
    for _line in _env_file.read_text().splitlines():
        _line = _line.strip()
        if _line and not _line.startswith('#') and '=' in _line:
            _k, _v = _line.split('=', 1)
            _k = _k.strip()
            if not os.environ.get(_k):
                os.environ[_k] = _v.strip()

# ── DB connection ─────────────────────────────────────────────────────────────

def get_db():
    """Open a MySQL connection using the same credentials as the PHP app."""
    # On the droplet, MySQL is local — connect via socket or localhost
    return pymysql.connect(
        host='localhost',
        user='root',
        password='',          # root on droplet typically uses unix socket auth
        database='vestigette',
        charset='utf8mb4',
        unix_socket='/var/run/mysqld/mysqld.sock',
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True,
    )


# ── Condition checks ──────────────────────────────────────────────────────────

def check_entry(db, entry) -> tuple:
    """
    Run all guard-rail checks against a queue entry.
    Returns (outcome, reason) where outcome is PASS, SKIP, or RETRY.
      PASS  — all conditions met, seed it
      SKIP  — terminal failure, never revisit (mark 'skipped')
      RETRY — not yet eligible, leave 'pending' for a future run
    Terminal checks come first; the only RETRY condition is parent engagement,
    which can change over time as more humans interact with the parent.
    """
    arg_id        = entry['argumentID']
    created_by    = entry['createdBy']
    parent_arg_id = entry['parentArgID']
    parent_weight = entry['parentWeight']

    # Note: the delay-window check is enforced in the main SELECT query using
    # MySQL's own clock (queuedAt <= NOW() - INTERVAL N MINUTE), so entries still
    # in the window are simply not selected and remain 'pending' for a later run.

    # ── Terminal checks (SKIP) ────────────────────────────────────────────────

    # Real user check
    if created_by <= BOT_PERSONA_MAX:
        return SKIP, f'bot persona (profileID={created_by})'

    # Admin check
    with db.cursor() as cur:
        cur.execute("SELECT isAdmin FROM USER_PROFILE WHERE profileID = %s", (created_by,))
        row = cur.fetchone()
        if not row:
            return SKIP, f'creator profile not found (profileID={created_by})'
        if row['isAdmin']:
            return SKIP, f'admin user (profileID={created_by})'

    # Not already seeded
    with db.cursor() as cur:
        cur.execute(
            "SELECT COUNT(*) AS cnt FROM OPINION "
            "WHERE argumentID = %s AND profileID <= %s",
            (arg_id, BOT_PERSONA_MAX)
        )
        if cur.fetchone()['cnt'] > 0:
            return SKIP, 'already has bot opinions'

    # Weight floor (flesh_out entries only)
    if parent_weight is not None and parent_weight < WEIGHT_FLOOR:
        return SKIP, f'low endorsement weight ({parent_weight:.1f}% < {WEIGHT_FLOOR}%)'

    # Phrasing length
    with db.cursor() as cur:
        cur.execute(
            "SELECT COALESCE(currentPhrasing, '') AS phrasing "
            "FROM ARGUMENT WHERE argumentID = %s",
            (arg_id,)
        )
        row = cur.fetchone()
        if not row or len(row['phrasing'].strip()) < MIN_PHRASING_LENGTH:
            return SKIP, f'phrasing too short (< {MIN_PHRASING_LENGTH} chars)'

    # ── Retryable check (RETRY) ───────────────────────────────────────────────
    # Parent engagement can grow over time, so this stays 'pending' rather than
    # being marked terminally skipped. A second human on the parent unblocks it.
    if parent_arg_id:
        with db.cursor() as cur:
            # Count distinct genuine external humans: profileID > 26 (not a bot
            # persona) AND not an admin. Admin engagement is internal and should
            # not satisfy the "real users care about this branch" threshold.
            cur.execute(
                "SELECT COUNT(DISTINCT o.profileID) AS cnt "
                "FROM OPINION o "
                "JOIN USER_PROFILE u ON u.profileID = o.profileID "
                "WHERE o.argumentID = %s AND o.profileID > %s AND u.isAdmin = 0",
                (parent_arg_id, BOT_PERSONA_MAX)
            )
            cnt = cur.fetchone()['cnt']
            if cnt < MIN_PARENT_OPINIONS:
                return RETRY, (
                    f'parent arg {parent_arg_id} has only {cnt} real-user '
                    f'opinion(s) (need {MIN_PARENT_OPINIONS}) — waiting'
                )

    return PASS, ''


# ── Queue processing ──────────────────────────────────────────────────────────

def fetch_existing(db, arg_id: int, rel_type: str) -> list:
    """
    Return current arguments of a given relationship type (Because / Therefore /
    Rebuttal) on an argument as [{'id': argID, 'text': phrasing}]. Lets later
    personas endorse an existing node instead of duplicating it.
    """
    with db.cursor() as cur:
        cur.execute(
            "SELECT DISTINCT e.supportingArgID AS id, "
            "       COALESCE(a.currentPhrasing, '') AS text "
            "FROM ENDORSEMENT e "
            "JOIN ARGUMENT a ON a.argumentID = e.supportingArgID "
            "WHERE e.targArgID = %s AND e.endorseType = %s AND e.active = TRUE",
            (arg_id, rel_type)
        )
        return [r for r in cur.fetchall() if r['text'].strip()]


def mark(db, queue_id: int, status: str, **kwargs):
    fields = ['status = %s', 'processedAt = NOW()']
    values = [status]
    for col, val in kwargs.items():
        fields.append(f'{col} = %s')
        values.append(val)
    values.append(queue_id)
    with db.cursor() as cur:
        cur.execute(
            f"UPDATE BOT_SEED_QUEUE SET {', '.join(fields)} WHERE queueID = %s",
            values
        )


def process_queue():
    now_str = datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S UTC')
    print(f'\n[{now_str}] process_seed_queue starting')

    try:
        db = get_db()
    except Exception as exc:
        print(f'DB connection failed: {exc}')
        return

    # Expire stale pending entries (e.g. 2nd-hop args whose parent never gained
    # a second human). Keeps the queue bounded.
    with db.cursor() as cur:
        cur.execute(
            "UPDATE BOT_SEED_QUEUE "
            "SET status='skipped', processedAt=NOW(), "
            "    skipReason=CONCAT('expired after ', %s, ' days waiting') "
            "WHERE status='pending' "
            "  AND queuedAt < (NOW() - INTERVAL %s DAY)",
            (PENDING_MAX_DAYS, PENDING_MAX_DAYS)
        )
        expired = cur.rowcount
    if expired:
        print(f'  Expired {expired} stale pending entr{"y" if expired == 1 else "ies"}')

    # Fetch pending entries whose delay window has elapsed. The window is
    # enforced here with MySQL's clock so entries still waiting stay 'pending'
    # and get picked up on a later run.
    with db.cursor() as cur:
        cur.execute(
            "SELECT * FROM BOT_SEED_QUEUE "
            "WHERE status = 'pending' "
            "  AND queuedAt <= (NOW() - INTERVAL %s MINUTE) "
            "ORDER BY queuedAt ASC "
            "LIMIT 50",
            (DELAY_MINUTES,)
        )
        entries = cur.fetchall()

    if not entries:
        print('  No pending entries.')
        db.close()
        return

    print(f'  {len(entries)} pending entries found')

    # Import seed_argument logic directly
    sys.path.insert(0, str(SCRIPT_DIR))
    import seed_argument as sa
    import persona_bot as bot
    import anthropic

    api_key = os.environ.get('ANTHROPIC_API_KEY')
    if not api_key:
        print('ERROR: ANTHROPIC_API_KEY not set — aborting')
        db.close()
        return

    personas_data = bot.load_personas()
    clusters      = bot.load_clusters()
    credentials   = bot.load_credentials()
    client        = anthropic.Anthropic(api_key=api_key)
    all_letters   = list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

    for entry in entries:
        qid    = entry['queueID']
        arg_id = entry['argumentID']
        print(f'\n  Queue #{qid} — arg {arg_id}')

        # Mark as processing to prevent double-runs if cron overlaps
        mark(db, qid, 'processing')

        outcome, reason = check_entry(db, entry)
        if outcome == SKIP:
            print(f'    SKIP: {reason}')
            mark(db, qid, 'skipped', skipReason=reason[:200])
            continue
        if outcome == RETRY:
            print(f'    RETRY: {reason}')
            # Return to pending so a future run re-checks; log the reason but
            # do NOT set processedAt (it isn't finished).
            with db.cursor() as cur:
                cur.execute(
                    "UPDATE BOT_SEED_QUEUE SET status='pending', skipReason=%s "
                    "WHERE queueID=%s",
                    (reason[:200], qid)
                )
            continue

        # Choose random personas
        random.shuffle(all_letters)
        chosen = all_letters[:PERSONAS_PER_ARG]
        print(f'    Seeding with personas: {", ".join(chosen)}')

        ran       = []
        total_cost = 0.0

        for letter in chosen:
            persona = next((p for p in personas_data['personas'] if p['id'] == letter), None)
            creds   = credentials.get(letter)
            if not persona or not creds:
                continue

            import requests as req_lib
            import warnings
            warnings.filterwarnings('ignore')

            session = req_lib.Session()
            session.headers['User-Agent'] = 'VestigettePersonaBot/1.0'

            if not bot.login(session, creds['email'], creds['password']):
                print(f'    [{letter}] login failed — skipping')
                continue

            arg_phrasing, csrf_token, current_opinion = bot.get_arg_page(session, arg_id)

            if current_opinion in (1, -1):
                print(f'    [{letter}] already has opinion — skipping')
                continue

            sibling_ids, cluster_label = bot.find_cluster_siblings(arg_id, clusters)
            cluster_context = []  # Phase 1: no phrasing lookup

            # Fetch existing nodes of each type so the persona can endorse rather
            # than duplicate. Includes prior bots in this run + any earlier.
            existing_rebuttals  = fetch_existing(db, arg_id, 'Rebuttal')
            existing_becauses   = fetch_existing(db, arg_id, 'Because')
            existing_therefores = fetch_existing(db, arg_id, 'Therefore')

            try:
                response, call_cost = bot.ask_claude(
                    client, persona, arg_phrasing, cluster_context,
                    existing_rebuttals=existing_rebuttals,
                    existing_becauses=existing_becauses,
                    existing_therefores=existing_therefores,
                )
            except Exception as exc:
                print(f'    [{letter}] Claude error: {exc}')
                continue

            total_cost += call_cost
            verdict = response.get('verdict', 'skip')

            def _clean(new_key, endorse_key, existing):
                """Return (new_texts, valid_endorse_ids) filtered to the shown set."""
                new_texts = response.get(new_key, []) or []
                valid = {r['id'] for r in existing}
                endorse = [int(i) for i in (response.get(endorse_key, []) or [])
                           if int(i) in valid]
                return new_texts, endorse

            if verdict == 'accept':
                phrasing_text = response.get('phrasing')
                new_bec, end_bec = _clean('becauses', 'endorse_becauses', existing_becauses)
                new_thr, end_thr = _clean('therefores', 'endorse_therefores', existing_therefores)
                # Enforce the one-new-each cap for accept-side scaffolding
                new_bec = new_bec[:1]
                new_thr = new_thr[:1]
                rebuttals, endorse_ids = [], []
            elif verdict == 'reject':
                phrasing_text = None
                rebuttals, endorse_ids = _clean('rebuttals', 'endorse_rebuttals', existing_rebuttals)
                new_bec = new_thr = end_bec = end_thr = []
            else:  # skip
                phrasing_text = None
                rebuttals = endorse_ids = new_bec = new_thr = end_bec = end_thr = []

            print(f'    [{letter}] {verdict}', end='')
            if verdict == 'accept':
                print(f' — "{phrasing_text}"  [+{len(new_bec)}/{len(end_bec)} because, '
                      f'+{len(new_thr)}/{len(end_thr)} therefore]')
            elif verdict == 'reject':
                print(f' — {len(rebuttals)} new + {len(endorse_ids)} endorsed rebuttal(s)')
            else:
                print()

            for w in bot.validate_response(response):
                print(f'      ⚠ {w}')

            if verdict == 'skip':
                continue

            # Submit vote
            bot.submit_vote(session, arg_id, csrf_token, verdict)
            time.sleep(0.4)

            if phrasing_text:
                _, fresh_csrf, _ = bot.get_arg_page(session, arg_id)
                time.sleep(0.3)
                bot.submit_phrasing(session, arg_id, fresh_csrf, phrasing_text)
                time.sleep(0.4)

                expl_url = bot.search_for_url(phrasing_text)
                if expl_url:
                    time.sleep(0.3)
                    action, _ = bot.submit_explication_deduped(session, arg_id, expl_url)
                    print(f'      explication ({action}): {expl_url}')
                    time.sleep(0.4)

            # Accept-side scaffolding: because + therefore
            if new_bec or end_bec:
                csrf_b = bot.get_flesh_out_csrf(session, arg_id, 'Because')
                time.sleep(0.3)
                bot.submit_mixed(session, arg_id, csrf_b, 'Because', new_bec, end_bec)
                time.sleep(0.4)
            if new_thr or end_thr:
                csrf_t = bot.get_flesh_out_csrf(session, arg_id, 'Therefore')
                time.sleep(0.3)
                bot.submit_mixed(session, arg_id, csrf_t, 'Therefore', new_thr, end_thr)
                time.sleep(0.4)

            # Reject-side scaffolding: rebuttals
            if rebuttals or endorse_ids:
                flesh_csrf = bot.get_flesh_out_csrf(session, arg_id, 'Rebuttal')
                time.sleep(0.3)
                bot.submit_mixed(session, arg_id, flesh_csrf, 'Rebuttal', rebuttals, endorse_ids)
                time.sleep(0.4)

            ran.append(letter)
            time.sleep(sa.DELAY_BETWEEN_PERSONAS)

        personas_run_str = ','.join(ran)
        print(f'    Done. Ran: {personas_run_str} | cost: ${total_cost:.4f}')
        mark(db, qid, 'done', personasRun=personas_run_str)

    db.close()
    print('\nQueue processing complete.')


if __name__ == '__main__':
    process_queue()
