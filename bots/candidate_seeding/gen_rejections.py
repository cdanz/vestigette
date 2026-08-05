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
  "personas": [   # acceptor specs: add top-level "edgeType": "Because"; "rebuttals" then means "headings"
    {
      "personaID": 5,
      "slot": "thoughtful_conservative",   # label only
      "setOpinion": -1,                    # emit assertOpinion(-1, cand, pid); omit if opinion already correct
      "rebuttals": [
        { "text": "New heading arg.", "weight": 25,
          "because": [ {"text": "New child arg.",
                        "because": [ {"text": "Chains nest: evidence under mechanism under outcome."} ]},
                       {"argID": 1591} ] },
        { "argID": 2429, "weight": 15,     # adopt an existing arg (any persona's) as your heading...
          "putForth": "Optional: persona's own alternative phrasing of the adopted arg.",
          "because": [ {"text": "...and hang your own reasoning beneath it."} ] },
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

def emit_expl(w, expr, pid, node):
    """If a node carries an "explication": {"url": ...} key, attach that link
    to the node for this persona via the app-native promoteExplication proc
    (creates EXPLICATION + the creator's EXPLICATION_ENDORSE @100 +
    SCOPE_EXPLICATION_ENDORSE off @active_aff_id). Idempotent-ish: the proc
    UPDATEs if the (arg, profile) explication already exists."""
    ex = node.get("explication")
    if ex:
        w(f"CALL promoteExplication({expr}, {pid}, '{esc(ex['url'])}');")

def main(path):
    spec = json.load(open(path))
    out = []
    w = out.append
    w("SET NAMES utf8mb4;")
    w("SET @active_aff_id = 12;")
    w("START TRANSACTION;")
    var_n = 0
    refs = {}  # "id" label -> @var of a node coined earlier in this run

    # Multi-target cluster spec: {"blocks": [{"targetArgID"|"targetRef", "edgeType", "personas": [...]}]}
    # Classic single-target spec (candidacyArgID at top level) is wrapped into one block.
    if "blocks" in spec:
        blocks = spec["blocks"]
        w(f"-- Cluster: {spec.get('cluster', spec.get('candidate','?'))}")
    else:
        blocks = [{"targetArgID": spec["candidacyArgID"],
                   "edgeType": spec.get("edgeType", "Rebuttal"),
                   "personas": spec["personas"]}]
        w(f"-- Candidate: {spec.get('candidate','?')} (arg {spec['candidacyArgID']})")

    for block in blocks:
        cand = refs[block["targetRef"]] if "targetRef" in block else block["targetArgID"]
        etype = block.get("edgeType", "Rebuttal")
        w(f"\n-- ===== target {cand} ({etype}) =====")
        vb = [var_n]
        process_block(block, cand, etype, out, w, refs, vb)
        var_n = vb[0]
    finish(out, w)

def process_block(spec_block, cand, etype, out, w, refs, var_box):
    var_n = var_box[0]

    for p in spec_block["personas"]:
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

        def emit_because(parent_expr, kids):
            """Recursively wire Because children (and their children) under parent_expr."""
            nonlocal var_n
            for k in kids:
                if "ref" in k:
                    rv = refs[k["ref"]]
                    w(f"INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)"
                      f" VALUES ({parent_expr}, {pid}, 'Because', {rv}, 1, 1);")
                    emit_expl(w, rv, pid, k)
                    continue
                if "argID" in k:
                    w(f"INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)"
                      f" VALUES ({parent_expr}, {pid}, 'Because', {k['argID']}, 1, 1);")
                    if k.get("putForth"):
                        w(f"CALL newPutForth({k['argID']}, {pid}, '{esc(k['putForth'])}');")
                    emit_expl(w, k["argID"], pid, k)
                    if k.get("because"):
                        emit_because(str(k["argID"]), k["because"])
                else:
                    w(f"CALL foldAndReciprocate('{esc(k['text'])}', 'Because', {parent_expr}, {pid});")
                    if k.get("because") or k.get("id") or k.get("explication"):
                        var_n += 1
                        cv = f"@c{var_n}"
                        w(f"SET {cv} = (SELECT MAX(argumentID) FROM ARGUMENT WHERE createdBy = {pid});")
                        if k.get("id"):
                            refs[k["id"]] = cv
                        emit_expl(w, cv, pid, k)
                        if k.get("because"):
                            emit_because(cv, k["because"])
            share = round(100.0 / len(kids), 5)
            w(f"UPDATE ENDORSEMENT SET weight = {share} WHERE targArgID = {parent_expr}"
              f" AND profileID = {pid} AND endorseType = 'Because' AND active = 1;")
            w(f"INSERT IGNORE INTO SCOPE_ENDORSEMENT (profileID, targArgID, affiliationID) VALUES ({pid}, {parent_expr}, 12);")

        norm = []  # (supporting_expr, weight) for the rebuttal-level normalization
        for r, wt in zip(rebs, weights):
            if "ref" in r:
                rv = refs[r["ref"]]
                w(f"INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)"
                  f" VALUES ({cand}, {pid}, '{etype}', {rv}, 1, 1);")
                emit_expl(w, rv, pid, r)
                norm.append((rv, wt))
                continue
            if "argID" in r:
                if r.get("already"):
                    w(f"-- persona already endorses arg {r['argID']}: reweight only")
                else:
                    w(f"-- adopt existing arg {r['argID']} as rebuttal heading")
                    w(f"INSERT INTO ENDORSEMENT (targArgID, profileID, endorseType, supportingArgID, weight, active)"
                      f" VALUES ({cand}, {pid}, '{etype}', {r['argID']}, 1, 1);")
                norm.append((str(r["argID"]), wt))
                if r.get("putForth"):
                    w(f"CALL newPutForth({r['argID']}, {pid}, '{esc(r['putForth'])}');")
                emit_expl(w, r["argID"], pid, r)
                if r.get("because"):
                    emit_because(str(r["argID"]), r["because"])
                continue
            var_n += 1
            hv = f"@h{var_n}"
            w(f"-- new rebuttal heading: {r['text'][:70]}")
            w(f"CALL foldAndReciprocate('{esc(r['text'])}', '{etype}', {cand}, {pid});")
            w(f"SET {hv} = (SELECT MAX(argumentID) FROM ARGUMENT WHERE createdBy = {pid});")
            if r.get("id"):
                refs[r["id"]] = hv
            emit_expl(w, hv, pid, r)
            norm.append((hv, wt))
            if r.get("because"):
                emit_because(hv, r["because"])

        w(f"-- normalize persona {pid}'s rebuttal weights on {cand}")
        for expr, wt in norm:
            w(f"UPDATE ENDORSEMENT SET weight = {wt} WHERE targArgID = {cand} AND profileID = {pid}"
              f" AND endorseType = '{etype}' AND supportingArgID = {expr} AND active = 1;")

    var_box[0] = var_n

def finish(out, w):
    w("\nCOMMIT;")
    w("-- ===== verification =====")
    w(f"SELECT a.argumentID, a.createdBy, LEFT(a.currentPhrasing, 80) FROM ARGUMENT a"
      f" WHERE a.createdDate >= CURDATE() ORDER BY a.argumentID;")
    w(f"SELECT targArgID, profileID, endorseType, SUM(weight) s FROM ENDORSEMENT WHERE active = 1"
      f" GROUP BY targArgID, profileID, endorseType HAVING ABS(s - 100) > 0.01;")
    print("\n".join(out))

if __name__ == "__main__":
    main(sys.argv[1])
