#!/usr/bin/env python3
"""
Candidate rejection seeding — spec JSON -> SQL.

Turns a per-candidate rejection spec into a SQL script built on the same
stored procedures the web UI fires (foldAndReciprocate / assertOpinion),
so every insert carries full bookkeeping: PHRASING + PHRASE_ENDORSE,
implied-acceptance OPINION + SCOPE_OPINION (impliedAssertion trigger),
reciprocal Therefore edges on Because children, phrasing cache, and the
100% weight invariant.

Usage:
    python3 gen_rejections.py spec.json > out.sql
    ssh root@178.128.74.45 'MYSQL_PWD=$(cat /root/.digitalocean_password) \
        mysql --default-character-set=utf8mb4 -u root vestigette' < out.sql

Spec schema (see aoc_rejections.json for a worked example):
{
  "candidate": "AOC",                  # label only
  "candidacyArgID": 1968,
  "personas": [
    {
      "personaID": 5,
      "slot": "thoughtful_conservative",   # label only
      "setOpinion": -1,                    # emit assertOpinion(-1, cand, pid); omit if opinion already correct
      "rebuttals": [
        { "text": "New heading arg.", "weight": 25,
          "because": [ {"text": "New child arg."}, {"argID": 1591} ] },
        { "argID": 2429, "weight": 15 },   # reuse an existing arg as a rebuttal
        { "argID": 2411, "weight": 10, "already": true }  # persona ALREADY endorses this: reweight only, no insert
      ]
    }
  ]
}

Rules enforced:
- rebuttal weights per persona must sum to 100 (or all omitted -> equal split).
- Because children get an equal split within their heading.
- Reused (argID) children get a plain endorsement, no reciprocal edge —
  matching web-UI behavior for endorsing an existing argument.

PRECHECK before applying (accept->reject flips deactivate a persona's
accept-side weights; the script will not protect you from that):
  SELECT profileID, acceptance FROM OPINION
  WHERE argumentID = <candidacyArgID> AND profileID IN (<personaIDs>);
"""
import json, sys

def esc(s):
    return s.replace("\\", "\\\\").replace("'", "\\'")

def main(path):
    spec = json.load(open(path))
    cand = spec["candidacyArgID"]
    out = []
    w = out.append
    w("SET NAMES utf8mb4;")
    w("SET @active_aff_id = 12;")
    w("START TRANSACTION;")
    w(f"-- Candidate: {spec.get('candidate','?')} (arg {cand})")
    var_n = 0

    for p in spec["personas"]:
        pid = p["personaID"]
        rebs = p["rebuttals"]
        # weight validation
        weights = [r.get("weight") for r in rebs]
        if any(x is None for x in weights):
            if not all(x is None for x in weights):
                sys.exit(f"persona {pid}: give weights to all rebuttals or none")
            weights = [round(100.0 / len(rebs), 5)] * len(rebs)
        if abs(sum(weights) - 100) > 0.01:
            sys.exit(f"persona {pid}: rebuttal weights sum to {sum(weights)}, not 100")

        w(f"\n-- ===== persona {pid} ({p.get('slot','?')}) =====")
        if "setOpinion" in p:
            w(f"CALL assertOpinion({p['setOpinion']}, {cand}, {pid});")
        w(f"INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES ({pid}, {cand}, 12);")

        norm = []  # (supporting_expr, weight) for the rebuttal-level normalization
        for r, wt in zip(rebs, weights):
            if "argID" in r:
                if r.get("already"):
                    w(f"-- persona already endorses arg {r['argID']}: reweight only")
                else:
                    w(f"-- reuse existing arg {r['argID']} as rebuttal")
                    w(f"INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)"
                      f" VALUES ({cand}, {pid}, 'Rebuttal', {r['argID']}, 1, 1);")
                norm.append((str(r["argID"]), wt))
                continue
            var_n += 1
            hv = f"@h{var_n}"
            w(f"-- new rebuttal heading: {r['text'][:70]}")
            w(f"CALL foldAndReciprocate('{esc(r['text'])}', 'Rebuttal', {cand}, {pid});")
            w(f"SET {hv} = (SELECT MAX(argumentID) FROM ARGUMENT WHERE createdBy = {pid});")
            norm.append((hv, wt))
            kids = r.get("because", [])
            for k in kids:
                if "argID" in k:
                    w(f"INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)"
                      f" VALUES ({hv}, {pid}, 'Because', {k['argID']}, 1, 1);")
                else:
                    w(f"CALL foldAndReciprocate('{esc(k['text'])}', 'Because', {hv}, {pid});")
            if kids:
                share = round(100.0 / len(kids), 5)
                w(f"UPDATE ENDORSEMENT SET weight = {share} WHERE targArgID = {hv}"
                  f" AND profileID = {pid} AND endorseType = 'Because' AND active = 1;")
                w(f"INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES ({pid}, {hv}, 12);")

        w(f"-- normalize persona {pid}'s rebuttal weights on {cand}")
        for expr, wt in norm:
            w(f"UPDATE ENDORSEMENT SET weight = {wt} WHERE targArgID = {cand} AND profileID = {pid}"
              f" AND endorseType = 'Rebuttal' AND supportingArgID = {expr} AND active = 1;")

    w("\nCOMMIT;")
    w("-- ===== verification =====")
    w(f"SELECT a.argumentID, a.createdBy, LEFT(a.currentPhrasing, 80) FROM ARGUMENT a"
      f" WHERE a.createdDate >= CURDATE() ORDER BY a.argumentID;")
    w(f"SELECT targArgID, profileID, endorseType, SUM(weight) s FROM ENDORSEMENT WHERE active = 1"
      f" GROUP BY targArgID, profileID, endorseType HAVING ABS(s - 100) > 0.01;")
    print("\n".join(out))

if __name__ == "__main__":
    main(sys.argv[1])
