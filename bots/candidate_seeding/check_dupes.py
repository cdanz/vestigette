#!/usr/bin/env python3
"""
Duplicate check for a candidate spec — run BEFORE gen_rejections.py.

Extracts every NEW text (rebuttals, because chains, putForths) from the spec
and emits SQL that ranks the top 3 full-text matches for each against every
existing phrasing (same FULLTEXT index find_similar.php uses). Review every
hit: a strong match means adopt the existing node (argID + optional putForth
alternative phrasing) instead of coining.

LIMITATION: full-text is lexical. It would NOT have caught "AOC has never run
anything" vs "AOC has no executive experience" — semantically identical, zero
shared content words. The lexical pass is the backstop; the primary defense is
the drafting rule in PLAYBOOK.md: every draft claim carries a "nearest existing
arg" annotation produced by reading the candidate's full existing neighborhood.

Usage:
    python3 check_dupes.py spec.json > dupecheck.sql
    ssh root@178.128.74.45 'MYSQL_PWD=$(cat /root/.digitalocean_password) \
        mysql --default-character-set=utf8mb4 -u root vestigette -t' < dupecheck.sql
"""
import json, sys

def esc(s):
    return s.replace("\\", "\\\\").replace("'", "\\'")

def texts_of(node):
    if "text" in node:
        yield node["text"]
    if "putForth" in node:
        yield node["putForth"]
    for k in node.get("because", []):
        yield from texts_of(k)

spec = json.load(open(sys.argv[1]))
blocks = spec["blocks"] if "blocks" in spec else [{"personas": spec["personas"]}]
seen = []
for b in blocks:
    for p in b["personas"]:
        for r in p["rebuttals"]:
            seen.extend(texts_of(r))

print("SET NAMES utf8mb4;")
for t in seen:
    e = esc(t)
    print(f"SELECT '>>> {e}' AS draft_claim;")
    print(f"SELECT p.argumentID, LEFT(p.phrasing, 90) AS existing,"
          f" ROUND(MATCH(p.phrasing) AGAINST ('{e}' IN NATURAL LANGUAGE MODE), 2) AS score"
          f" FROM PHRASING p WHERE MATCH(p.phrasing) AGAINST ('{e}' IN NATURAL LANGUAGE MODE)"
          f" ORDER BY score DESC LIMIT 3;")
