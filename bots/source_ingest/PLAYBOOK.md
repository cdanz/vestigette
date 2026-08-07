# Source → Agitate — Playbook

Repeatable (not automatic) process for taking a debate expressed in some **other
format** — a long-form article, a Bluesky thread, your own blog post — and
representing its arguments faithfully in the Agitate graph, with test personas
voicing every side and the source cited wherever it fairly applies.

First run: **The Atlantic, "The Wingman" (Mark Kelly), 2026-08-05** →
`mark_kelly_atlantic.json`, args **3015–3044** off candidacy arg 2993. Read that
spec next to this file for a worked example of every rule below.

This is a generalization of `bots/candidate_seeding/PLAYBOOK.md` (candidate
rejection/acceptance seeding) and **reuses its tooling verbatim** —
`gen_rejections.py`, `preflight.py`, `check_dupes.py`, `personas_all_26.json`.
The difference: we start from an *external source* pushed *into* the graph,
rather than harvesting the graph for a latent debate.

---

## 0. Model & session start

- **Model:** strongest Opus available (Opus 5, or 4.8). The leverage is in
  judgment — tiering, dedup, casting, persona voice — not throughput. A lighter
  model makes plausible-but-naive choices this process exists to avoid. Keep
  each run to **one source** to stay bounded and within included usage.
- **Cold-start incantation:** Craig says *"Run the source-ingest playbook,"*
  points here, and pastes the source (intake below). Claude reads this file +
  PROJECT.md, surveys the graph neighborhood (§7), then returns the tiered
  **redline** for markup before writing anything.

---

## 1. Intake — what Craig brings

The reliable channel is **pasted text.** (Learned the hard way: WebFetch and the
in-app browser were both blocked on The Atlantic, and the live page never idled
— the cut-and-paste worked instantly.) Bring three things:

1. **The full source text, pasted.** Bluesky: posts in order. Long article: the
   whole thing, or the one section to treat.
2. **Canonical URL(s)** for the explication links — article URL **with any gift
   token stripped**; the specific Bluesky post URLs; or the blog post's URL.
3. **One line of intent + scope** — what it should improve ("we're thin on X"),
   whole-piece vs. section, any personas to feature or avoid.

---

## 2. The pipeline

1. **Ingest** — read the source for *argumentative moves*, not prose.
2. **Atomize** — one terse single claim per node; bundled reasons drop to
   second-jump Because children (no em-dash lists, no "X, not Y" contrast
   smuggling). See `feedback_argument_phrasing_granularity`.
3. **Sloganize + generalize** — lift each atom from the source's specific,
   time-bound wording to the **generalized reusable claim** (registry-grade).
   Where the source's own wording is vivid, keep it as a competing **phrasing**
   on the node (`putForth`), not as the node itself. Generalize the node;
   preserve the voice as a phrasing.
   - **Every node asserts a claim — even the most specific one.** State the claim
     the node makes, in your own words; never transcribe an article excerpt as a
     node. If you have a vivid anecdote, name the claim it proves ("success hasn't
     made Kelly self-important") and put the anecdote one rung down as evidence
     (or a phrasing) — never leave the point implicit. Cut color that doesn't
     serve the claim. **Miss from run 1:** arg 3018 "a former shuttle commander,
     Kelly deflects his status, joking he carries his own makeup" — reads as an
     excerpt with an unstated point; the claim ("status hasn't made him
     self-important") was never asserted.
   - **Every node must STAND ALONE — self-containment (Craig, 2026-08-05).**
     Atomizing is not just deconstructing to the smallest defensible claim; the
     claim must also be legible to a reader who lands on it cold, with none of its
     neighbors in view. **Name the subject in the node itself** — the specific
     merger, person, bill, ruling, study — even when the parent already names it.
     Resolve every context-borrowed reference to its referent: no bare "the deal,"
     "the merger," "the report," "those studies," "that speech," "the proposed
     punishment," nor dangling "this / it / the two / these traits / his" whose
     antecedent lives only in an adjacent node. Test each draft node by imagining
     it surfaced alone in search: would a stranger know what's being discussed?
     **Retroactive sweep 2026-08-05:** fixed 20 args that failed this — the Newsom
     "the deal / the merger / the report" set (3078/3080/3083/3084…) now name the
     Paramount–Warner Bros. merger; Kelly's "his party's nominee / his admirers /
     that speech" (3040/3043/3030/3037) name the people and the case; the IRA
     "those studies" (3103) and trans-cluster "it / this / the two / these traits"
     (2814/2821/2824/2833) name their referents. Run this check on every node
     before the redline, and re-sweep new batches.
4. **Map & dedup** — run every atom against the neighborhood (§7) and
   `check_dupes.py`. Existing home → **adopt** (`argID`, optional `putForth`),
   never re-coin. Duplicates are the cardinal failure; annotate each atom
   `none | duplicate | upstream | downstream` while drafting (the semantic pass
   is primary; the lexical pass is a backstop).
5. **Cast** — assign each side to a persona by **bio/lean** (§6).
6. **Tier & route-through** — place nodes per the graph model (§3). This is the
   step most likely to be done naively; do it deliberately.
7. **Explicate** — attach source links per the rule (§4b).
8. **Redline** — present the plain-language tiered map FIRST. **This is Craig's
   editorial checkpoint.** Personas speak in the words he approves.
9. **Preflight + dupecheck** — HARD GATE. Any preflight row = STOP.
10. **Apply** — one SSH transaction, `--default-character-set=utf8mb4`.
11. **Phase-2 reroute review** (§5) — standard, not optional.
12. **Verify** — new-args list + 100% invariant check (built into the SQL).

---

## 3. The graph model (how to place a node)

The core insight (Craig, this run): **weight should flow through shared category
hubs, not jump from a generic root to a hyper-specific claim.** Trading
root-level *breadth* for *depth* through shared hubs pools *participation* where
fellow-travelers meet.

- **Interpose the criterion hub.** Never hang a specific example (especially
  about a single named individual) directly on a generic hub. Between them, name
  the most generic claim the example is an instance of — the one that examples
  about *other* subjects would also share. Attach there. Reuse an existing hub
  (§8) before coining one.
- **Gather-nodes.** When one subject accumulates examples under a criterion, coin
  a subject-scoped gather-node ("Mark Kelly is among the least ego-driven
  candidates") so the examples get one home and one place to be rebutted.
  **≥2 anecdotes is a prompt to *look* for a missing rung, not a law.** The real
  test: **each hop should be the size of step an advocate actually takes when
  pressed** — the broad claim up top, the specific anecdote in the hip pocket one
  rung down. Don't zoom too far in or out between neighbors. (A single-anecdote
  gather-node is fine when it's the claim the *debate* lands on — e.g. "Kelly can
  win" is contested even though only one fact sits under it.)
- **Route-through.** Once a gather-node exists, wire criterion → gather →
  candidacy and **do not** also wire criterion → candidacy directly. Keeps weight
  on one path and lands a criterion-shopper on the drillable claim.
- **Edges read as sentences (both ways).** An edge is one relationship seen from
  two ends: from the hub it's a **Therefore** ("we want X, so here's who
  delivers"); from the specific end the same link is a **Because** ("Kelly's
  good, because he's ego-free, because his brother says…"). Climb **Becauses** to
  interrogate ("prove it"); follow **Therefores** to act ("so who fits?").
- **Valence-neutral nodes — but never force them.** A node genuinely read both
  ways can sit under opposite-valence parents (adopted, not re-coined) — but each
  parent's point must hold *without a stretch*. **Miss from run 1:** I placed the
  VFW scene (3019) under both "ego-free" and "lacks empathy" to manufacture a
  dual-valence "jewel" — but staying on talking points in front of a distraught
  person reads as an *empathy gap*, not humility, so the ego-free placement was
  forced (removed post-hoc). Only pair a node across valences when both readings
  are independently defensible; don't reach for cleverness over faithfulness.

---

## 4. The three disciplines

**4a. Persona voice — champion, but as their best self.** The persona owns the
voice, but writes the *clearest brief statement that's hard to misread or seize
in bad faith* — not the most emotionally satisfying one.
- ❌ "Kelly smeared our troops with a grandstanding stunt."
- ✅ "Putting 'refuse illegal orders' into a campaign video invites troops to
  freelance on the chain of command."

**4b. Explication — link where the source makes the point, either side.**
- Link a node wherever the **source itself clearly makes that claim**, regardless
  of which side the node is on. Rebuttals *usually* won't link (they contradict
  the source) — but do when the source makes the unfavorable point (Kelly's own
  "without the shooting I wouldn't be here"; the Harris "untested" doubt; the
  reported White House walk-back). This run linked 9 nodes, 4 of them con-side.
- **Never** link a node the source doesn't make, or **leans opposite** (skipped
  the link on "Kelly can win" — the article's net take on his electability is
  skeptical).
- **Put the link on the verifiable specific**, not merely the summarizing
  gather-node above it. The anecdote/fact/concrete-act is what a reader clicks to
  check against the source. **Miss from run 1:** I linked the ego and competence
  *gather-nodes* but skipped the specifics beneath them (the brother quote 3017,
  the combat/shuttle facts 3021/3022) — exactly the nodes worth verifying. Link
  the specifics; the summary node may *also* carry one when the source argues the
  case.
- **Strip personal/gift tokens**; use the canonical URL. Heavy use where it fits
  — a link is nice to have; a better one can come along later.
- Mechanism: `"explication": {"url": ...}` on any node → `promoteExplication`.

**4c. Human data is untouchable.** Phase-2 rerouting and reweighting touch
**only persona profiles 1–26**. Any real human or admin edge in the neighborhood
is surfaced to Craig and left alone. The point is to lay clearer initial paths
for humans, never to move a human's stated position.

---

## 5. Phase-2 reroute review (standard step)

After apply, review every persona profile that **touches the nodes you created
or updated** and check whether its chain is now naively routed and would flow
better through the new structure. Reroute (personas 1–26 only) — reweight
existing pools with `"already": true`, preserving the 100% invariant. On a thin
topic this is often a null pass; the confirmation *is* the value. (Kelly run:
Karen's electability ranking collided live and was rescaled inline; the post-apply
sweep then found nothing external.)

**The inviolable rule — never break an association entirely (Craig, 2026-08-05).**
Rerouting a node *through* a gather-node is fine — it preserves the connection
(node → gather → target) while improving organization. What you must never do is
**orphan a useful edge**: if an edit would zero out the *last* endorsement holding
an argument-to-argument connection, keep it alive (retain the single minor weight,
or reassign it) so others can build on it. Connections are the graph's value — a
strained-but-real one beats none. The one exception is a connection that **never
fit**; before letting any sole association break, confirm with judgment that
losing it is a genuine benefit, not just tidy. (Newsom run: 2506 (PG&E) rerouted
from a direct rebuttal of 2001 to a Because of gather-node 3014 — the 2506→3014→2001
path kept it connected; 2504/2505 were left direct because they don't fit "capital
over workers" and their direct ties are useful.)

---

## 6. Casting

Cast by **biographical fit over slot** (`personas_all_26.json`: `ideology_score`
-10..+9, `identity.military`, religion, occupation, backstory). Standout castings
this run: **Sandra (19)**, a law-firm partner, on the legal-duty claims;
**Alfred (1)**, the roster's only actual veteran, as the non-caricature
chain-of-command voice. Spectrum-of-lanes pattern (maximalist → cynic → builder)
and the party-coherent cast tables carry over from
`bots/candidate_seeding/PLAYBOOK.md`.

**Flipping a persona's opinion is allowed (Craig, 2026-08-05)** — we're feeding in
new information, and a persona changing its mind is discourse working, not a
failure. Preflight still flags an opinion conflict, but treat it as a *decision
point*, not an auto-recast: flip when the new source justifies it. The only guard
is the association rule in §5 — a flip deactivates that persona's weights on the
old side, so before flipping, check it won't orphan the *last* endorsement holding
a useful edge. (Newsom run: could have flipped Yvonne's bare 2001 accept safely —
no associations hung under it — but Zachary was the better voice anyway.)

---

## 7. Neighborhood survey (run before drafting)

```sql
-- existing args on the topic (swap the LIKEs)
SELECT argumentID, LEFT(currentPhrasing,110) FROM ARGUMENT
 WHERE currentPhrasing LIKE '%<subject>%' OR currentPhrasing LIKE '%<keyword>%';
-- the candidacy/anchor node's current edges + opinions + phrasings (see §8 for hubs)
SELECT e.endorseType, e.profileID, e.supportingArgID, e.weight, LEFT(a.currentPhrasing,90)
 FROM ENDORSEMENT e JOIN ARGUMENT a ON a.argumentID=e.supportingArgID
 WHERE e.targArgID=<anchor> AND e.active=1 ORDER BY e.endorseType, e.profileID;
SELECT o.profileID, o.acceptance FROM OPINION o WHERE o.argumentID=<anchor>;
```

Connect via SSH (batch — fail2ban trips on rapid repeats):
`ssh root@178.128.74.45 "MYSQL_PWD=\$(cat /root/.digitalocean_password) mysql -u root -N -B vestigette"`

---

## 8. Criterion-hub inventory under 1963 (snapshot 2026-08-05 — verify live)

1963 = "best possible candidates for 2028." Its Therefore fan-out is **criterion
hubs** (candidates hang off these, not off 1963 directly). Reuse before coining.

| hub | criterion |
|---|---|
| 2410 / 2931 | put a Democrat / Republican in the White House |
| 2935 | strengthen democratic institutions |
| 2936 | broadest appeal to win a general |
| 2951 | a proven, competent executive |
| 2953 | an outsider who challenges the establishment |
| 2937 | champion working people vs. corporate/elite power |
| 2938 | foreign-policy restraint |
| 2939 | secure the border / enforce immigration law |
| 2934 / 2950 | climate action / energy dominance |
| 2942 / 2944 | abortion & reproductive rights / faith & traditional family |
| 2943 | trans & LGBTQ+ rights |
| 2945 / 2946 | Second Amendment / reduce gun violence |
| 2947 | racial justice & civil rights |
| 2948 / 2949 | fiscal discipline / healthcare for all |
| 2952 | strong military & allies |
| 2959 | Supreme Court reform |
| **3015** | **serve the country, not their own ego** (coined this run) |

Refresh: `SELECT e.supportingArgID, (SELECT COUNT(*) FROM ENDORSEMENT c WHERE
c.targArgID=e.supportingArgID AND c.endorseType='Therefore' AND c.active=1)
children, LEFT(a.currentPhrasing,70) FROM ENDORSEMENT e JOIN ARGUMENT a ON
a.argumentID=e.supportingArgID WHERE e.targArgID=1963 AND e.endorseType='Therefore'
AND e.active=1 GROUP BY e.supportingArgID ORDER BY children DESC;`

---

## 9. Tooling — spec schema & commands

Spec is a `{"cluster": ..., "blocks": [...]}` file. Each block targets one node
with one edgeType; personas each carry `rebuttals` (headings of that edgeType).

```jsonc
{ "targetArgID": 2993,        // or "targetRef": "<id from an earlier block>"
  "edgeType": "Because",       // Because | Therefore | Rebuttal
  "personas": [
    { "personaID": 8, "slot": "label",
      "setOpinion": 1,          // 1 accept / -1 reject; omit if already correct
      "rebuttals": [
        // coin new node:
        { "text": "...", "weight": 100, "id": "g_ego",
          "explication": { "url": "https://…" },   // links this node via promoteExplication
          "because": [ { "text": "..." }, { "text": "...", "id": "a_vfw" } ] },
        // adopt existing node (reuse, don't re-coin):
        { "argID": 2410, "already": true, "weight": 30 },   // already:true = reweight only
        { "argID": 1591, "weight": 15, "putForth": "persona's own phrasing" },
        // reference a node coined earlier THIS run (plain edge, no reciprocal):
        { "ref": "g_win", "weight": 15 }
      ] } ] }
```

Rules: weights per persona sum to 100 (or omit all → equal split). Because
children equal-split. Coined nodes get reciprocal edges + implied accept; adopted
(`argID`/`ref`) get a plain edge. **Order blocks so a node is coined (with `id`)
before it's referenced (`ref` / `targetRef`).** `already: true` is mandatory for
**every** active edge already in a persona's (target, edgeType) pool, or
normalization breaks the sum — preflight enforces this.

```bash
cd bots/candidate_seeding    # shared tooling lives here
python3 preflight.py  ../source_ingest/<spec>.json | ssh …mysql -N -B      # any row = STOP
python3 check_dupes.py ../source_ingest/<spec>.json | ssh …mysql -t        # review high scores
python3 gen_rejections.py ../source_ingest/<spec>.json > out.sql
cat out.sql | ssh …mysql --default-character-set=utf8mb4 -t                 # apply
```

**Run specs are disposable local artifacts — do NOT commit them** (gitignored:
`bots/source_ingest/*.json`). The live graph is the record. Commit only
platform-building changes: the tooling (`gen_rejections.py` etc.) and this
playbook. Keep or delete a run's spec locally as you like.

---

## 10. Showcase mode — Craig's own blog post as source

The ideal source: the explication links point **to your post** (no paywall,
canonical, no token to strip), and after the build I hand you the **arg-ID map**
so you embed those links *back* in the post (link "ego-free" to its gather-node,
etc.). Post and cluster cite each other — the "see how this works" demo. Flow
gains one step: **build first, then deliver the ID map for embedding**; the
explication URL still resolves if you later tweak the post.

---

## 11. Gotchas

- Preserve the **100% invariant** on any ENDORSEMENT change (`TERM_VALUE` exempt).
- Personas operate under **affiliation 12**; scripts set `@active_aff_id = 12`
  and insert SCOPE rows.
- MySQL ≠ MariaDB; batch SSH (fail2ban).
- 10 **pre-existing** invariant violations on args 393/630/631/1150/1152 are
  known (DATA_CLEANUP_BACKLOG.md) — ignore them in the post-apply check.
- `preflight.py` can't check `targetRef` blocks (target not yet coined) — those
  target fresh nodes with no priors, so they're safe by construction.
- **Adding `because` children to an ADOPTED node (argID) whose coining persona
  already has Becauses there OVER-WEIGHTS the pool.** `emit_because` blindly
  equal-splits assuming only the new children — there's no because-level
  `already: true`. So a persona's pre-existing Becauses on that node get reset to
  the new share and the pool blows past 100. **Guard:** don't hang new `because`
  children under an `argID` the voicing persona already structured; if you must,
  fix the sum by hand and re-run the invariant check. (Caught live 2026-08-05:
  adding 2415 under Zachary's own 2359 doubled his pool to 200 — the built-in
  invariant check flagged it; rebalanced 2005/2415 to 50/50. The invariant check
  at the end of every apply is what catches this — always read it.)
