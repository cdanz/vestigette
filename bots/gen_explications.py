#!/usr/bin/env python3
"""
gen_explications.py  —  two-source explication seeder

MODES
-----
  wikipedia  (default)
    For every argument that has NO active explication, searches Wikipedia and
    inserts a link attributed to the first (lowest-ID) acceptor. Run once.

  google
    For every argument that has EXACTLY ONE active explication (the Wikipedia
    one), searches Google Custom Search and inserts a second link attributed
    to the SECOND-lowest acceptor. Google's free tier allows 100 queries/day,
    so this mode caps at 100 and is safe to run daily until complete.

USAGE
-----
  # Phase 1 — Wikipedia (run once, ~11 minutes)
  python3 gen_explications.py wikipedia 2>wiki.log > wiki_seed.sql
  /Applications/MAMP/Library/bin/mysql -u root -proot vestigette < wiki_seed.sql

  # Phase 2 — Google (run daily, ~1 min/day for a few weeks)
  # First: set GOOGLE_API_KEY and GOOGLE_CX in the Config section below, or
  # export them as environment variables.
  python3 gen_explications.py google 2>>google.log >> google_seed.sql
  /Applications/MAMP/Library/bin/mysql -u root -proot vestigette < google_seed.sql

  # (append >> each day so you accumulate one loadable file, or load daily)

GOOGLE SETUP (free, 100 queries/day)
-------------------------------------
  1. Go to https://programmablesearchengine.google.com/
     Create an engine → turn on "Search the entire web" → copy the CX id.
  2. Go to https://console.cloud.google.com/ → APIs & Services →
     Enable "Custom Search API" → Credentials → Create API Key.
  3. Paste both below (or export as env vars).

RESUMABLE
---------
  Both modes skip arguments that already have the target number of explications,
  so re-running after an interruption is safe.
"""

import os
import sys
import re
import time
import json
import urllib.request
import urllib.parse

import mysql.connector

# ── Config ────────────────────────────────────────────────────────────────────

DB_CONFIG = {
    'host': 'localhost',
    'port': 3306,
    'user': 'root',
    'password': 'root',
    'database': 'vestigette',
}

# Google Custom Search — only needed for `google` mode
GOOGLE_API_KEY = os.environ.get('GOOGLE_API_KEY', '')
GOOGLE_CX      = os.environ.get('GOOGLE_CX',      '')

GOOGLE_DAILY_LIMIT = 100   # free-tier cap per day

WIKI_DELAY   = 1.5   # seconds between Wikipedia requests (was 0.5; 429s forced increase)
GOOGLE_DELAY = 1.2   # seconds between Google requests

MAX_TITLE_LEN = 100
WEIGHT        = 50.0

# ── Stop-words for keyword extraction ─────────────────────────────────────────

_STOPWORDS = {
    'a','an','the','is','are','was','were','be','been','being','have','has',
    'had','do','does','did','will','would','could','should','may','might',
    'must','shall','can','need','to','of','in','for','on','with','at','by',
    'from','up','about','into','through','during','before','after','between',
    'this','that','these','those','it','its','if','as','or','and','but','nor',
    'so','yet','not','no','any','all','both','than','very','just','also',
    'only','even','more','most','other','some','such','too','there','their',
    'they','them','we','our','you','your','my','his','her','who','which',
    'what','when','where','how','why',
}

def phrasing_to_keywords(phrasing, max_words=6):
    tokens = re.findall(r"[a-zA-Z''\-]{3,}", phrasing)
    kw = [t for t in tokens if t.lower() not in _STOPWORDS]
    return ' '.join(kw[:max_words]) if kw else phrasing[:50]

# ── Wikipedia search ──────────────────────────────────────────────────────────

def wiki_url_from_title(title):
    encoded = urllib.parse.quote(title.replace(' ', '_'), safe='/:')
    return f'https://en.wikipedia.org/wiki/{encoded}'

def wiki_search(phrasing, retries=4):
    query = phrasing_to_keywords(phrasing)
    params = urllib.parse.urlencode({
        'action': 'query', 'list': 'search', 'srsearch': query,
        'srlimit': 5, 'srinfo': '', 'srprop': 'snippet',
        'format': 'json', 'origin': '*',
    })
    req = urllib.request.Request(
        f'https://en.wikipedia.org/w/api.php?{params}',
        headers={
            'User-Agent': 'VestigetteBot/1.0 (discourse-mapping; agitate.org)',
            'Accept': 'application/json',
        }
    )
    for attempt in range(retries):
        try:
            with urllib.request.urlopen(req, timeout=10) as resp:
                data = json.loads(resp.read().decode('utf-8'))
            for r in data.get('query', {}).get('search', []):
                title = r.get('title', '')
                if 'disambiguation' not in title.lower():
                    return wiki_url_from_title(title), title
            return None, None   # got a response, just no usable results
        except urllib.error.HTTPError as exc:
            if exc.code == 429:
                wait = 30 * (attempt + 1)   # 30s, 60s, 90s, 120s
                print(f"-- Wikipedia 429; backing off {wait}s", file=sys.stderr, flush=True)
                time.sleep(wait)
            else:
                print(f"-- Wikipedia HTTP {exc.code}", file=sys.stderr)
                return None, None
        except Exception as exc:
            print(f"-- Wikipedia error: {exc}", file=sys.stderr)
            return None, None
    return None, None   # exhausted retries

# ── Google Custom Search ──────────────────────────────────────────────────────

_GOOGLE_BLOCKED = {
    'quora.com','facebook.com','twitter.com','x.com','instagram.com',
    'tiktok.com','pinterest.com','linkedin.com','tumblr.com','reddit.com',
    'youtube.com','youtu.be','snapchat.com','threads.net',
}

def _strip_www(host):
    return host[4:] if host.startswith('www.') else host

def _is_blocked(url):
    try:
        host = _strip_www(urllib.parse.urlparse(url).netloc.lower())
        return any(host == d or host.endswith('.' + d) for d in _GOOGLE_BLOCKED)
    except Exception:
        return True

def google_search(phrasing):
    if not GOOGLE_API_KEY or not GOOGLE_CX:
        print("-- Google: GOOGLE_API_KEY / GOOGLE_CX not set", file=sys.stderr)
        return None, None

    params = urllib.parse.urlencode({
        'key': GOOGLE_API_KEY,
        'cx':  GOOGLE_CX,
        'q':   phrasing,
        'num': '5',
    })
    req = urllib.request.Request(
        f'https://www.googleapis.com/customsearch/v1?{params}',
        headers={'Accept': 'application/json'}
    )
    try:
        with urllib.request.urlopen(req, timeout=12) as resp:
            data = json.loads(resp.read().decode('utf-8'))
    except urllib.error.HTTPError as exc:
        if exc.code == 429:
            print("-- Google daily quota exhausted — stopping.", file=sys.stderr)
            sys.exit(0)
        print(f"-- Google HTTP {exc.code}", file=sys.stderr)
        return None, None
    except Exception as exc:
        print(f"-- Google error: {exc}", file=sys.stderr)
        return None, None

    for item in data.get('items', []):
        url   = item.get('link', '')
        title = item.get('title', '')
        if url and not _is_blocked(url):
            return url, title
    return None, None

# ── SQL helpers ───────────────────────────────────────────────────────────────

def escape(s):
    if s is None:
        return 'NULL'
    return "'" + str(s).replace('\\', '\\\\').replace("'", "\\'") + "'"

def emit_sql(arg_id, profile_id, url, title):
    safe_title = (title or '')[:MAX_TITLE_LEN]
    print(f"-- URL: {url}")
    print(
        "INSERT IGNORE INTO EXPLICATION"
        " (argumentID, profileID, hyperlink, publisher, authorFName,"
        "  authorLName, title, metaPub, metaName, metaWildcard,"
        "  firstVisit, lastVisit, active)"
    )
    print(
        f"  VALUES ({arg_id}, {profile_id}, {escape(url)}, '', '', '',"
        f" {escape(safe_title)}, '', '', '',"
        f" CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);"
    )
    print(
        f"SET @eid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(),"
        f" (SELECT explicationID FROM EXPLICATION"
        f"  WHERE argumentID = {arg_id} AND profileID = {profile_id}));"
    )
    print(
        "INSERT IGNORE INTO EXPLICATION_ENDORSE"
        " (explicationID, argumentID, profileID, weight, active)"
        f" VALUES (@eid, {arg_id}, {profile_id}, {WEIGHT}, 1);"
    )

# ── DB queries ────────────────────────────────────────────────────────────────

def fetch_wiki_args(conn):
    """Arguments with NO active explication + their first (min) acceptor."""
    cur = conn.cursor()
    cur.execute("""
        SELECT a.argumentID,
               a.currentPhrasing,
               MIN(o.profileID) AS acceptor_1
        FROM   ARGUMENT a
        LEFT   JOIN EXPLICATION e
               ON e.argumentID = a.argumentID AND e.active = 1
        JOIN   OPINION o
               ON o.argumentID = a.argumentID AND o.acceptance = 1
        WHERE  e.explicationID IS NULL
          AND  a.currentPhrasing IS NOT NULL
          AND  a.currentPhrasing != ''
        GROUP  BY a.argumentID, a.currentPhrasing
        ORDER  BY a.argumentID
    """)
    rows = cur.fetchall()
    cur.close()
    return rows

def fetch_google_args(conn, limit):
    """
    Returns up to `limit` arguments that still need a Google explication,
    in two priority tiers processed together:

    Tier 1 — zero explications (56 args): needs its FIRST link.
      Uses the lowest acceptor profileID (same logic as Wikipedia mode).

    Tier 2 — one explication / Wikipedia only (798 args): needs a SECOND link.
      Uses the second-lowest acceptor profileID so the unique key isn't hit.

    Each row: (argumentID, currentPhrasing, google_profile_id)
    """
    cur = conn.cursor()
    cur.execute("""
        -- Tier 1: no explication yet, use first acceptor
        SELECT  a.argumentID,
                a.currentPhrasing,
                MIN(o.profileID) AS google_profile
        FROM    ARGUMENT a
        LEFT    JOIN EXPLICATION e
                ON e.argumentID = a.argumentID AND e.active = 1
        JOIN    OPINION o
                ON  o.argumentID = a.argumentID
                AND o.acceptance = 1
        WHERE   e.explicationID IS NULL
          AND   a.currentPhrasing IS NOT NULL
          AND   a.currentPhrasing != ''
        GROUP   BY a.argumentID, a.currentPhrasing

        UNION ALL

        -- Tier 2: one Wikipedia explication, add a second via different profile
        SELECT  a.argumentID,
                a.currentPhrasing,
                MIN(o.profileID) AS google_profile
        FROM    ARGUMENT a
        JOIN    EXPLICATION e
                ON e.argumentID = a.argumentID AND e.active = 1
        JOIN    OPINION o
                ON  o.argumentID = a.argumentID
                AND o.acceptance = 1
                AND o.profileID != e.profileID
        WHERE   a.currentPhrasing IS NOT NULL
          AND   a.currentPhrasing != ''
          AND   (SELECT COUNT(*) FROM EXPLICATION e2
                 WHERE e2.argumentID = a.argumentID AND e2.active = 1) = 1
        GROUP   BY a.argumentID, a.currentPhrasing

        ORDER   BY argumentID
        LIMIT   %s
    """, (limit,))
    rows = cur.fetchall()
    cur.close()
    return rows

# ── Modes ─────────────────────────────────────────────────────────────────────

def run_wikipedia(conn):
    args  = fetch_wiki_args(conn)
    total = len(args)

    print("-- Wikipedia explication seed")
    print(f"-- {total} arguments to process")
    print("USE vestigette;")
    print()

    inserted = 0
    skipped  = 0

    for i, (arg_id, phrasing, profile_id) in enumerate(args, 1):
        preview = phrasing[:70].replace('--', '-')
        print(f"-- [{i}/{total}] argID={arg_id}: {preview}", file=sys.stderr, flush=True)

        url, title = wiki_search(phrasing)

        if not url:
            print(f"-- SKIPPED [{i}/{total}] argID={arg_id}: no Wikipedia result")
            print()
            skipped += 1
            time.sleep(WIKI_DELAY)
            continue

        print(f"-- [{i}/{total}] argID={arg_id} → profileID={profile_id}")
        emit_sql(arg_id, profile_id, url, title)
        print()

        inserted += 1
        time.sleep(WIKI_DELAY)

    msg = f"-- Wikipedia done: {inserted} inserted, {skipped} skipped (total {total})"
    print(msg)
    print(msg, file=sys.stderr)


def run_google(conn):
    args  = fetch_google_args(conn, GOOGLE_DAILY_LIMIT)
    total = len(args)

    if total == 0:
        print("-- Google: nothing left to process (all args have 2 explications)")
        return

    if not GOOGLE_API_KEY or not GOOGLE_CX:
        print(
            "ERROR: Set GOOGLE_API_KEY and GOOGLE_CX (env vars or in script).\n"
            "Setup: https://programmablesearchengine.google.com/ + "
            "https://console.cloud.google.com/",
            file=sys.stderr
        )
        sys.exit(1)

    print(f"-- Google explication seed ({total} args in today's batch, {GOOGLE_DAILY_LIMIT}/day limit)")
    print("USE vestigette;")
    print()

    inserted = 0
    skipped  = 0

    for i, (arg_id, phrasing, wiki_profile, google_profile) in enumerate(args, 1):
        preview = phrasing[:70].replace('--', '-')
        print(
            f"-- [{i}/{total}] argID={arg_id}: {preview}",
            file=sys.stderr, flush=True
        )

        url, title = google_search(phrasing)

        if not url:
            print(f"-- SKIPPED [{i}/{total}] argID={arg_id}: no Google result")
            print()
            skipped += 1
            time.sleep(GOOGLE_DELAY)
            continue

        print(f"-- [{i}/{total}] argID={arg_id} → profileID={google_profile}")
        emit_sql(arg_id, google_profile, url, title)
        print()

        inserted += 1
        time.sleep(GOOGLE_DELAY)

    msg = f"-- Google done: {inserted} inserted, {skipped} skipped (today's batch: {total})"
    print(msg)
    print(msg, file=sys.stderr)

# ── Entry point ───────────────────────────────────────────────────────────────

def main():
    mode = sys.argv[1].lower() if len(sys.argv) > 1 else 'wikipedia'
    if mode not in ('wikipedia', 'google'):
        print(f"Usage: {sys.argv[0]} [wikipedia|google]", file=sys.stderr)
        sys.exit(1)

    conn = mysql.connector.connect(**DB_CONFIG)
    try:
        if mode == 'wikipedia':
            run_wikipedia(conn)
        else:
            run_google(conn)
    finally:
        conn.close()


if __name__ == '__main__':
    main()
