#!/usr/bin/env python3
"""
Vestigette Persona Bot — Phase 1 (Form POST scraping)

Logs in as a persona user, fetches an argument, calls the Anthropic API to
generate an in-character opinion, then POSTs the verdict, phrasing,
explication URL (searched from the phrasing), and associations back to
the live app via its existing form handlers.

Usage:
  python3 persona_bot.py --persona A --arg 123
  python3 persona_bot.py --persona B --arg 456 --dry-run
  python3 persona_bot.py --persona C --arg 789 --skip-associations

Setup:
  pip install anthropic requests
  export ANTHROPIC_API_KEY=sk-ant-...
"""

import argparse
import json
import os
import re
import sys
import time
import urllib.parse
from pathlib import Path

# Load .env if present (before any os.environ.get calls)
_env_file = Path(__file__).parent / '.env'
if _env_file.exists():
    for _line in _env_file.read_text().splitlines():
        _line = _line.strip()
        if _line and not _line.startswith('#') and '=' in _line:
            _k, _v = _line.split('=', 1)
            _k = _k.strip()
            if not os.environ.get(_k):  # set if missing or empty
                os.environ[_k] = _v.strip()

try:
    import anthropic
except ImportError:
    sys.exit('Error: anthropic package not installed. Run: pip install anthropic')

try:
    import requests
except ImportError:
    sys.exit('Error: requests package not installed. Run: pip install requests')

# ── Config ────────────────────────────────────────────────────────────────────

BASE_URL  = 'https://agitate-discourse.org'
MODEL     = 'claude-sonnet-4-6'
SCRIPT_DIR = Path(__file__).parent

# Sources excluded from explication search (low quality / paywalled / social)
_EXCLUDED_DOMAINS = {
    # Social media
    'quora.com', 'facebook.com', 'instagram.com', 'twitter.com', 'x.com',
    'tiktok.com', 'youtube.com', 'reddit.com', 'pinterest.com', 'linkedin.com',
    'threads.net', 'snapchat.com', 'tumblr.com',
    # Content farms and SEO aggregators
    'ehow.com', 'answers.com', 'reference.com', 'wikihow.com',
    'thoughtco.com', 'livestrong.com', 'leaf.tv', 'hunker.com',
    # Entertainment and gaming wikis
    'fandom.com', 'wikia.com', 'ign.com', 'gamespot.com', 'lcpdfr.com',
    'gamefaqs.com', 'steampowered.com', 'nexusmods.com',
    # Satire (good sites, wrong purpose)
    'theonion.com', 'babylonbee.com', 'clickhole.com',
    # Free website builders (no original editorial content)
    'blogspot.com', 'wordpress.com', 'wixsite.com', 'weebly.com',
    # E-commerce
    'amazon.com', 'ebay.com', 'etsy.com', 'walmart.com',
    # Pure aggregators
    'allsides.com',
}

# URL path patterns that indicate index/forum/discussion pages rather than articles
_EXCLUDED_PATH_PATTERNS = [
    '/forum/', '/forums/', '/community/', '/thread/', '/threads/',
    '/discuss/', '/discussion/', '/boards/', '/topic/', '/topics/',
    '/tag/', '/tags/', '/category/', '/categories/', '/archive/',
    '/search/', '/search?', '?s=', '?q=', '?search=',
    '/page/', '/page?', '?page=',
    '/comment', '#comment',
]

# Top-level domains strongly associated with spam/low-quality content
_EXCLUDED_TLDS = {'.xyz', '.info', '.biz', '.click', '.download', '.loan', '.win'}

# ── Data loading ──────────────────────────────────────────────────────────────

def load_personas() -> dict:
    path = SCRIPT_DIR / 'personas_all_26.json'
    if not path.exists():
        sys.exit('Error: personas_all_26.json not found in project root')
    return json.loads(path.read_text(encoding='utf-8'))


def load_clusters() -> dict:
    path = SCRIPT_DIR / 'topic_clusters.json'
    return json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}


def load_credentials() -> dict:
    path = SCRIPT_DIR / 'persona_credentials.json'
    if not path.exists():
        sys.exit(
            'Error: persona_credentials.json not found.\n'
            'Copy persona_credentials.json.example and confirm credentials.'
        )
    return json.loads(path.read_text(encoding='utf-8'))

# ── HTTP helpers ──────────────────────────────────────────────────────────────

def login(session: requests.Session, email: str, password: str) -> bool:
    """POST to login.php. Returns True if redirected to the app (login succeeded)."""
    resp = session.post(
        f'{BASE_URL}/login.php',
        data={'email': email, 'password': password},
        allow_redirects=True,
        timeout=30,
    )
    return '/?arg=' in resp.url or resp.url.rstrip('/') == BASE_URL


def extract_csrf(html: str) -> str:
    match = re.search(r'name="csrfToken"\s+value="([^"]+)"', html)
    if not match:
        raise ValueError('CSRF token not found — are we still logged in?')
    return match.group(1)


def decode_html_entities(text: str) -> str:
    return (
        text.replace('&amp;', '&')
            .replace('&lt;', '<')
            .replace('&gt;', '>')
            .replace('&quot;', '"')
            .replace('&#039;', "'")
            .replace('&nbsp;', ' ')
    )


def get_arg_page(session: requests.Session, arg_id: int) -> tuple:
    """
    GET the main argument page.
    Returns (phrasing: str, csrf: str, current_opinion: int|None).
    current_opinion: 1=accept, -1=reject, 0=none, None=not logged in.
    """
    resp = session.get(f'{BASE_URL}/?arg={arg_id}', timeout=30)
    resp.raise_for_status()
    html = resp.text

    phrasing_match = re.search(
        r'class="rate_phrase".*?<p>(.*?)</p>', html, re.DOTALL
    )
    if not phrasing_match:
        raise ValueError(f'Could not extract phrasing for arg {arg_id}')
    phrasing = decode_html_entities(phrasing_match.group(1).strip())

    opinion_match = re.search(r'\bopinion\s*=\s*(-?\d+|null)\b', html)
    current_opinion = None
    if opinion_match:
        val = opinion_match.group(1)
        current_opinion = None if val == 'null' else int(val)

    return phrasing, extract_csrf(html), current_opinion


def submit_vote(session: requests.Session, arg_id: int, csrf: str, verdict: str) -> bool:
    """POST accept or reject. Ambivalent → accept."""
    button = 'accept' if verdict in ('accept', 'ambivalent') else 'reject'
    resp = session.post(
        f'{BASE_URL}/?arg={arg_id}',
        data={'buttonClicked': button, 'csrfToken': csrf},
        allow_redirects=True,
        timeout=30,
    )
    return resp.status_code == 200


def submit_phrasing(session: requests.Session, arg_id: int, csrf: str, text: str) -> bool:
    """POST a new alternative phrasing."""
    resp = session.post(
        f'{BASE_URL}/?arg={arg_id}',
        data={'buttonClicked': 'newPutForth', 'newPutForth': text, 'csrfToken': csrf},
        allow_redirects=True,
        timeout=30,
    )
    return resp.status_code == 200


def submit_explication(session: requests.Session, arg_id: int, csrf: str, url: str) -> bool:
    """POST a URL as a new explication link."""
    resp = session.post(
        f'{BASE_URL}/?arg={arg_id}',
        data={'buttonClicked': 'promoteExplication', 'promoteExplication': url, 'csrfToken': csrf},
        allow_redirects=True,
        timeout=30,
    )
    return resp.status_code == 200


def endorse_explication(session: requests.Session, arg_id: int, csrf: str, explication_id: int) -> bool:
    """Endorse an existing explication row (weighExplication action at 100% weight)."""
    resp = session.post(
        f'{BASE_URL}/?arg={arg_id}',
        data={
            'buttonClicked': 'weighExplication',
            'explicWeighInWith': f'{explication_id},100.00000,',
            'csrfToken': csrf,
        },
        allow_redirects=True,
        timeout=30,
    )
    return resp.status_code == 200


def get_existing_explications(html: str) -> dict:
    """
    Parse an already-fetched argument page HTML and return {normalized_url: explication_id}
    for all explication links currently on the argument.
    """
    items = re.findall(
        r'data-explication-id="(\d+)".*?href="([^"]+)"',
        html, re.DOTALL
    )
    result = {}
    for expl_id, url in items:
        normalized = url.strip().rstrip('/')
        result[normalized] = int(expl_id)
    return result


def submit_explication_deduped(
    session: requests.Session, arg_id: int, url: str
) -> tuple:
    """
    Submit an explication URL for arg_id, deduplicating against what already exists.
    Fetches a fresh page (for CSRF + current explication list), then either:
      - endorses the existing explication if the URL is already there, or
      - creates a new explication row if not.
    Returns (action: 'endorsed'|'created'|'failed', explication_id_or_none).
    """
    phrasing, csrf, _ = get_arg_page(session, arg_id)  # also gives us the HTML
    # Re-fetch to get HTML (get_arg_page doesn't return raw HTML — do a second GET)
    resp = session.get(f'{BASE_URL}/?arg={arg_id}', timeout=30)
    existing = get_existing_explications(resp.text)
    csrf = extract_csrf(resp.text)

    normalized = url.strip().rstrip('/')
    if normalized in existing:
        expl_id = existing[normalized]
        ok = endorse_explication(session, arg_id, csrf, expl_id)
        return ('endorsed', expl_id) if ok else ('failed', None)
    else:
        ok = submit_explication(session, arg_id, csrf, url)
        if not ok:
            return ('failed', None)
        # promoteExplication now creates the EXPLICATION_ENDORSE row for the
        # creator automatically — no extra step needed.
        return ('created', None)


def get_flesh_out_csrf(session: requests.Session, arg_id: int, rel_type: str) -> str:
    """GET flesh_out.php to obtain a fresh CSRF for association submission."""
    resp = session.get(
        f'{BASE_URL}/flesh_out.php?arg={arg_id}&type={rel_type}', timeout=30
    )
    resp.raise_for_status()
    return extract_csrf(resp.text)


def submit_associations(
    session: requests.Session,
    arg_id: int,
    rel_type: str,
    csrf: str,
    assocs: list,
) -> bool:
    """
    POST associations via flesh_out.php.
    rel_type: 'Because', 'Therefore', or 'Rebuttal'.
    Equal weights; server normalises to sum 100.
    """
    if not assocs:
        return True
    pinned = [
        {'type': 'existing', 'argID': a['argumentId'], 'weight': 1, 'reciprocate': False}
        for a in assocs
    ]
    resp = session.post(
        f'{BASE_URL}/flesh_out.php?arg={arg_id}&type={rel_type}',
        data={
            'csrfToken': csrf,
            'type': rel_type,
            'argID': arg_id,
            'pinnedData': json.dumps(pinned),
        },
        allow_redirects=True,
        timeout=30,
    )
    return resp.status_code == 200


def submit_mixed(
    session: requests.Session,
    arg_id: int,
    csrf: str,
    rel_type: str,
    new_texts: list,
    existing_ids: list,
) -> bool:
    """
    Submit a single flesh_out POST for one relationship type (Because / Therefore /
    Rebuttal), mixing newly-created argument nodes (new_texts) with endorsements of
    existing nodes (existing_ids). New texts create nodes; existing IDs add this
    persona's endorsement to the already-existing node (accumulating its weight).
    """
    pinned = []
    for text in new_texts:
        pinned.append({'type': 'new', 'text': text, 'weight': 1, 'reciprocate': False})
    for aid in existing_ids:
        pinned.append({'type': 'existing', 'argID': int(aid), 'weight': 1, 'reciprocate': False})
    if not pinned:
        return True
    resp = session.post(
        f'{BASE_URL}/flesh_out.php?arg={arg_id}&type={rel_type}',
        data={
            'csrfToken': csrf,
            'type': rel_type,
            'argID': arg_id,
            'pinnedData': json.dumps(pinned),
        },
        allow_redirects=True,
        timeout=30,
    )
    return resp.status_code == 200

# ── Explication search ────────────────────────────────────────────────────────

def search_for_url(query: str, max_candidates: int = 15):
    """
    Search DuckDuckGo for the query and return the first URL from a
    substantive source. Applies domain blacklist, path pattern checks,
    and TLD filtering. Appends 'analysis' to bias DDG toward editorial
    and research content over informal discussion.
    Returns None if nothing suitable is found.
    """
    try:
        resp = requests.get(
            'https://html.duckduckgo.com/html/',
            params={'q': query + ' analysis'},
            headers={
                'User-Agent': (
                    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '
                    'AppleWebKit/537.36 (KHTML, like Gecko) '
                    'Chrome/120.0.0.0 Safari/537.36'
                ),
                'Accept-Language': 'en-US,en;q=0.9',
            },
            timeout=12,
        )
    except requests.RequestException as exc:
        print(f'  Search request failed: {exc}')
        return None

    # DDG result hrefs look like: //duckduckgo.com/l/?uddg=https%3A%2F%2F...
    hrefs = re.findall(r'class="result__a"[^>]*href="([^"]+)"', resp.text)
    for href in hrefs[:max_candidates]:
        if 'uddg=' not in href:
            continue
        m = re.search(r'uddg=([^&]+)', href)
        if not m:
            continue
        url = urllib.parse.unquote(m.group(1))
        if not url.startswith('http'):
            continue

        parsed = urllib.parse.urlparse(url)
        domain = re.sub(r'^www\.', '', parsed.netloc.lower())
        path = parsed.path.lower()

        # Domain blacklist
        if any(domain == ex or domain.endswith('.' + ex) for ex in _EXCLUDED_DOMAINS):
            continue

        # TLD filter
        tld = '.' + domain.rsplit('.', 1)[-1] if '.' in domain else ''
        if tld in _EXCLUDED_TLDS:
            continue

        # Path pattern filter — skip forum threads, tag pages, search results
        full_url_lower = url.lower()
        if any(pat in full_url_lower for pat in _EXCLUDED_PATH_PATTERNS):
            continue

        # Must have a meaningful path (not just a homepage)
        if not path or path == '/':
            continue

        return url
    return None

# ── Cluster context ───────────────────────────────────────────────────────────

def find_cluster_siblings(arg_id: int, clusters: dict, max_args: int = 20) -> tuple:
    """Return (sibling_id_list, cluster_label) for the cluster containing arg_id."""
    for key, cluster in clusters.items():
        if arg_id in cluster.get('args', []):
            siblings = [a for a in cluster['args'] if a != arg_id]
            return siblings[:max_args], cluster.get('label', key)
    return [], None

# ── Claude API ────────────────────────────────────────────────────────────────

_SYSTEM_SUFFIX = """

You are participating in Agitate, a structured political discourse graph where every \
argument is a single, atomic point. You will be shown an argument and must respond \
with a JSON object representing your honest in-character reaction.

Return ONLY valid JSON — no markdown fences, no commentary:
{
  "verdict": "accept" | "reject" | "skip",
  "reasoning": "2-3 sentences of gut reaction in your authentic voice (internal log, never published — be honest here even if contradictory, concessions welcome)",
  "phrasing": "string or null",
  "becauses": ["string"],
  "endorse_becauses": [<existing because id>, ...],
  "therefores": ["string"],
  "endorse_therefores": [<existing therefore id>, ...],
  "rebuttals": ["string", ...],
  "endorse_rebuttals": [<existing rebuttal id>, ...]
}

VERDICT — choose one, with a strong bias toward having an opinion:
- Before deciding, identify the core underlying claim in plain language, stripped of \
any loaded or strong vocabulary. Respond to that claim. If the argument uses a strong \
word like "exalted" where "recognized" or "credited" would convey the same basic idea, \
treat it as the plain-language version for the purpose of your verdict.
- "accept": you agree with this argument, even if only as a gut reaction or weak lean
- "reject": you disagree, even if only as a gut reaction or weak lean
- "skip": ONLY for arguments so completely outside your knowledge or life experience \
that you have zero reaction. This should be rare.

PHRASING — required when verdict is "accept", null otherwise:
- Restate the argument in your own authentic voice
- ONE idea only. One. No compound thoughts.
- FORBIDDEN words that split one phrasing into two arguments: \
"but", "however", "although", "yet", "while", "even if", "except", "though"
- If you feel two things at once, identify which is your PRIMARY reaction and express ONLY that
- 1-2 sentences, under 200 characters strongly preferred (hard limit: 300)
- No "I think" / "I believe" / "As a..." openers
- Must stand alone as a point another person could accept or reject

BECAUSE / THEREFORE — only when verdict is "accept" (empty arrays otherwise):
These build out the reasoning around an argument you agree with. The direction matters:
- BECAUSE = a reason the argument is TRUE. It answers "why?" — the main argument is
  true BECAUSE of this supporting point. It sits logically UNDER the main argument.
- THEREFORE = a consequence that FOLLOWS from the argument. The main argument is true,
  THEREFORE this follows. It sits logically ABOVE / downstream of the main argument.

  Example — main argument: "Public schools deserve full funding."
    BECAUSE:   "An educated population is the foundation of a functioning democracy."
               (a reason it's true)
    THEREFORE: "Cutting school budgets should require extraordinary justification."
               (what follows if it's true)

  Getting the direction backwards creates a broken edge, so check: does my point
  EXPLAIN the argument (because) or does it FOLLOW FROM the argument (therefore)?

- Provide AT MOST ONE new "because" and AT MOST ONE new "therefore" — your single
  strongest one of each. It is fine to provide none if nothing strong comes to mind.
- Each is atomic: one idea, no conjunctions, under 150 characters, stands alone.
- Same dedup rule as rebuttals: if EXISTING BECAUSES or EXISTING THEREFORES are
  provided and your point matches one, endorse its id instead of writing a duplicate.
  Put matched ids in "endorse_becauses" / "endorse_therefores" and leave that slot
  out of the new array.

REBUTTALS — required when verdict is "reject", empty array otherwise:
- For each rebuttal: identify the KERNEL of your disagreement — the specific claim
  you reject — and state that kernel directly as a standalone assertion.
- The most common failure is the run-up concession: "X is true, but my real point
  is Y." Drop the "X is true" part entirely. That belongs in reasoning. The rebuttal
  is just Y, stated as if X were never mentioned.

  WRONG: "Tesla did accelerate EV adoption, but that's a market win, not climate heroism."
  RIGHT: "Commercializing a product category is a market achievement, not climate heroism."
  WRONG: "He built great companies, but his motives were profit, not the planet."
  RIGHT: "Profit-driven innovation is not the same as climate leadership."

- Each rebuttal must challenge the underlying CLAIM, not the vocabulary used to state
  it. Rebuttals about word choice ("that word is too strong", "that's loaded language")
  are weak graph nodes — they become meaningless if the argument is rephrased. Ask
  yourself: would this rebuttal still apply if the argument were stated in plainer
  language? If not, find a different angle.
- Each rebuttal must be able to stand alone as an argument someone could accept or
  reject on its own merits, with no knowledge of what prompted it
- Atomic: one idea, no conjunctions splitting two thoughts, under 150 characters

ENDORSE_REBUTTALS — avoid creating duplicates:
- If a list of EXISTING REBUTTALS is provided, check each of your intended rebuttals
  against it FIRST. If an existing rebuttal already makes substantially the same point
  you would make, do NOT write a new one — instead put that existing rebuttal's id in
  "endorse_rebuttals". You are agreeing with a point someone already raised.
- Only put genuinely NEW points (not already covered by any existing rebuttal) in
  "rebuttals". It is good and normal to endorse 2 existing rebuttals and write only 1
  new one, or to endorse all and write none.
- "endorse_rebuttals" is a list of integer ids from the provided existing list only.
  Leave it as [] if no existing rebuttals are provided or none match.

ASSOCIATIONS — include only if cluster context is provided:
- 0-3 items from the provided list only
- "because": the linked arg supports/explains the main arg
- "therefore": the main arg leads to/implies the linked arg
- "rebuttal": the linked arg opposes the main arg"""


def _existing_block(label: str, items: list, verb: str) -> str:
    """Format an existing-arguments section for the prompt, or '' if none."""
    if not items:
        return ''
    block = '\n'.join(f'  id={it["id"]}: "{it["text"]}"' for it in items)
    return (
        f'\n\nEXISTING {label} already submitted for this argument — if you {verb} '
        f'and your point matches one of these, endorse its id instead of writing a '
        f'duplicate:\n{block}'
    )


def ask_claude(client, persona: dict, arg_phrasing: str, cluster_context: list,
               existing_rebuttals: list = None,
               existing_becauses: list = None,
               existing_therefores: list = None) -> dict:
    """
    Call the Anthropic API and return the persona's structured response.
    existing_* : optional lists of {'id': int, 'text': str} for already-submitted
    rebuttals / becauses / therefores, so the persona can endorse rather than duplicate.
    """
    system_prompt = (
        persona['opinion_engine']['sample_opinion_triggers']['prompt_prefix']
        + _SYSTEM_SUFFIX
    )

    if cluster_context:
        context_block = '\n'.join(
            f'  [{i + 1}] (argID={item["id"]}) "{item["phrasing"]}"'
            for i, item in enumerate(cluster_context)
        )
        context_section = (
            f'\n\nRelated arguments in this cluster — pick up to 3 for associations:\n'
            f'{context_block}'
        )
    else:
        context_section = '\n\n(No related arguments provided. Set associations to [])'

    existing_section = (
        _existing_block('BECAUSES',   existing_becauses,   'accept')
        + _existing_block('THEREFORES', existing_therefores, 'accept')
        + _existing_block('REBUTTALS',  existing_rebuttals,  'reject')
    )

    user_prompt = (
        f'Argument to evaluate:\n"{arg_phrasing}"'
        f'{context_section}'
        f'{existing_section}'
        f'\n\nRespond with JSON only.'
    )

    msg = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        system=system_prompt,
        messages=[{'role': 'user', 'content': user_prompt}],
    )

    # Cost — Sonnet 4: $3/M input, $15/M output
    in_tok  = msg.usage.input_tokens
    out_tok = msg.usage.output_tokens
    cost    = (in_tok * 3 + out_tok * 15) / 1_000_000
    print(f'  tokens: {in_tok} in / {out_tok} out  |  cost: ${cost:.4f}')

    raw = msg.content[0].text.strip()
    raw = re.sub(r'^```(?:json)?\s*', '', raw)
    raw = re.sub(r'\s*```$', '', raw)

    try:
        return json.loads(raw), cost
    except json.JSONDecodeError as exc:
        raise ValueError(
            f'Claude returned invalid JSON: {exc}\n--- Raw ---\n{raw}'
        ) from exc

# ── Validation ────────────────────────────────────────────────────────────────

_BUT_WORDS = re.compile(
    r'\b(but|however|although|yet|while|even if|except|though)\b', re.IGNORECASE
)

def validate_response(response: dict) -> list:
    warnings = []
    verdict = response.get('verdict', '')
    if verdict not in ('accept', 'reject', 'skip'):
        warnings.append(f'Unknown verdict: {verdict!r}')
    phrasing = response.get('phrasing')
    if verdict != 'accept' and phrasing:
        warnings.append('Phrasing should be null for non-accept verdict — will be ignored')
    if phrasing:
        if len(phrasing) > 300:
            warnings.append(f'Phrasing is {len(phrasing)} chars (max 300) — server will reject it')
        m = _BUT_WORDS.search(phrasing)
        if m:
            warnings.append(f'Phrasing contains "{m.group()}" — compound argument, needs splitting')
    for label, key in (('Rebuttal', 'rebuttals'),
                       ('Because', 'becauses'),
                       ('Therefore', 'therefores')):
        for i, r in enumerate(response.get(key, []) or []):
            m = _BUT_WORDS.search(r)
            if m:
                warnings.append(f'{label} {i+1} contains "{m.group()}" — compound argument')
    return warnings

# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description='Vestigette Persona Bot — Phase 1',
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument('--persona', required=True, metavar='LETTER', help='Persona A-Z')
    parser.add_argument('--arg',     required=True, type=int, metavar='ID', help='Argument ID')
    parser.add_argument('--dry-run', action='store_true',
                        help='Show Claude response but submit nothing')
    parser.add_argument('--skip-associations', action='store_true',
                        help='Skip association submission')
    parser.add_argument('--force', action='store_true',
                        help='Submit even if persona already has an opinion on this arg')
    args = parser.parse_args()

    persona_letter = args.persona.upper()
    arg_id = args.arg

    # ── Load data ─────────────────────────────────────────────────────────────
    personas_data = load_personas()
    clusters      = load_clusters()
    credentials   = load_credentials()

    persona = next((p for p in personas_data['personas'] if p['id'] == persona_letter), None)
    if not persona:
        sys.exit(f'Error: persona {persona_letter!r} not found in personas_all_26.json')
    if persona_letter not in credentials:
        sys.exit(f'Error: no credentials for persona {persona_letter}')

    api_key = os.environ.get('ANTHROPIC_API_KEY')
    if not api_key:
        sys.exit('Error: ANTHROPIC_API_KEY environment variable is not set')

    persona_name = persona['identity']['name']
    creds = credentials[persona_letter]

    print(f'Persona : {persona_name} ({persona_letter})')
    print(f'Argument: {arg_id}')
    if args.dry_run:
        print('[DRY RUN — nothing will be submitted]\n')

    # ── Login ─────────────────────────────────────────────────────────────────
    print('Logging in...')
    session = requests.Session()
    session.headers['User-Agent'] = 'VestigettePersonaBot/1.0'

    if not login(session, creds['email'], creds['password']):
        sys.exit('Login failed — check persona_credentials.json')
    print('Login OK\n')

    # ── Fetch argument ─────────────────────────────────────────────────────────
    print(f'Fetching argument {arg_id}...')
    arg_phrasing, csrf_token, current_opinion = get_arg_page(session, arg_id)
    print(f'Phrasing        : "{arg_phrasing}"')
    print(f'Current opinion : {current_opinion}')

    if current_opinion in (1, -1) and not args.force:
        print(
            f'\nPersona already has opinion ({current_opinion}) on arg {arg_id}. '
            'Use --force to overwrite.'
        )
        sys.exit(0)

    # ── Cluster context ────────────────────────────────────────────────────────
    sibling_ids, cluster_label = find_cluster_siblings(arg_id, clusters)
    cluster_context = []  # Phase 1: no phrasing lookup — associations will be empty
    if sibling_ids:
        print(f'Cluster         : {cluster_label} ({len(sibling_ids)} siblings — context skipped in Phase 1)')
    else:
        print('Cluster         : not found')

    # ── Ask Claude ─────────────────────────────────────────────────────────────
    print(f'\nAsking Claude ({persona_name})...')
    client = anthropic.Anthropic(api_key=api_key)
    bot_response, _ = ask_claude(client, persona, arg_phrasing, cluster_context)

    verdict      = bot_response.get('verdict', 'skip')
    phrasing_text = bot_response.get('phrasing') if verdict == 'accept' else None
    reasoning    = bot_response.get('reasoning', '')
    rebuttals    = bot_response.get('rebuttals', []) if verdict == 'reject' else []
    associations = bot_response.get('associations', [])

    # ── Display ────────────────────────────────────────────────────────────────
    print(f'\n{persona_name} — {verdict.upper()}', end='')
    if verdict == 'accept':
        print(f'\n  phrasing : "{phrasing_text}"')
    elif verdict == 'reject' and rebuttals:
        print()
        for i, r in enumerate(rebuttals, 1):
            print(f'  rebuttal {i}: "{r}"')
    else:
        print()
    if reasoning:
        print(f'  reasoning: {reasoning}')

    for w in validate_response(bot_response):
        print(f'  ⚠ {w}')

    if verdict == 'skip':
        print('\nSkipping — no submission.')
        return

    # ── Search for explication URL (accept only) ───────────────────────────────
    explication_url = None
    if phrasing_text:
        print(f'\nSearching for explication URL...')
        explication_url = search_for_url(phrasing_text)
        print(f'Found: {explication_url}' if explication_url else 'No suitable URL found')

    if args.dry_run:
        print('\n[dry-run] Stopping before submission.')
        return

    # ── Submit vote ────────────────────────────────────────────────────────────
    print(f'\nSubmitting {verdict}...')
    if not submit_vote(session, arg_id, csrf_token, verdict):
        sys.exit('Vote submission failed')
    print('Vote OK')
    time.sleep(0.5)

    # ── Submit phrasing ────────────────────────────────────────────────────────
    if phrasing_text:
        _, fresh_csrf, _ = get_arg_page(session, arg_id)
        time.sleep(0.3)
        if submit_phrasing(session, arg_id, fresh_csrf, phrasing_text):
            print('Phrasing OK')
        else:
            print('Warning: phrasing submission failed')
        time.sleep(0.5)

    # ── Submit explication URL (deduplicated) ──────────────────────────────────
    if explication_url:
        time.sleep(0.3)
        action, _ = submit_explication_deduped(session, arg_id, explication_url)
        if action == 'endorsed':
            print(f'Explication OK (endorsed existing)')
        elif action == 'created':
            print(f'Explication OK (new)')
        else:
            print('Warning: explication submission failed')
        time.sleep(0.5)

    # ── Submit rebuttals as new argument nodes ─────────────────────────────────
    if rebuttals:
        print(f'\nSubmitting {len(rebuttals)} rebuttal(s) as new argument nodes...')
        flesh_csrf = get_flesh_out_csrf(session, arg_id, 'Rebuttal')
        time.sleep(0.3)
        pinned = [
            {'type': 'new', 'text': r, 'weight': 1, 'reciprocate': False}
            for r in rebuttals
        ]
        resp = session.post(
            f'{BASE_URL}/flesh_out.php?arg={arg_id}&type=Rebuttal',
            data={
                'csrfToken': flesh_csrf,
                'type': 'Rebuttal',
                'argID': arg_id,
                'pinnedData': json.dumps(pinned),
            },
            allow_redirects=True, timeout=30,
        )
        if resp.status_code == 200:
            print('Rebuttals OK')
        else:
            print('Warning: rebuttal submission failed')
        time.sleep(0.5)

    # ── Submit associations (existing args only) ───────────────────────────────
    if not args.skip_associations and associations:
        by_type: dict = {}
        for assoc in associations:
            rel = assoc.get('relationship', '').capitalize()
            by_type.setdefault(rel, []).append(assoc)

        for rel_type, group in by_type.items():
            if rel_type not in ('Because', 'Therefore', 'Rebuttal'):
                continue
            if rel_type in ('Because', 'Therefore') and verdict == 'reject':
                continue
            if rel_type == 'Rebuttal' and verdict == 'accept':
                continue
            flesh_csrf = get_flesh_out_csrf(session, arg_id, rel_type)
            time.sleep(0.3)
            if submit_associations(session, arg_id, rel_type, flesh_csrf, group):
                print(f'{rel_type} associations OK')
            else:
                print(f'Warning: {rel_type} association submission failed')
            time.sleep(0.5)

    print('\nDone.')


if __name__ == '__main__':
    main()
