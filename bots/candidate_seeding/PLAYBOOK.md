# Candidate Rejection & Acceptance Seeding — Playbook

Repeatable process for building each candidate's rejection-side and
acceptance-side discourse. Established July 2026 off the manually-built AOC
page (arg 1968).

## Acceptor side (added 2026-07-14)

**Because edges only.** Candidacy-level Therefores ("has my vote", "donate")
are exclusive cross-candidate commitments — left entirely to real users.
(foldAndReciprocate still auto-adds the valid reciprocal Therefore from each
new heading/child back to its parent.)

**Four acceptor lanes** (mirrors of the rejection slots):
| Lane | Mirror | Character |
|---|---|---|
| Super fan | absolute hater | affect-driven, flat weights, shallow (fans don't chain). **Hard uniqueness both ways:** a persona super-fans at most ONE candidate ever, and a candidate gets at most one super fan. Ledger below. Most candidates get none. |
| Policy-aligned | thoughtful critic | deepest chains; domain headings + record facts |
| Strategic | centrist-electability | candidate-as-instrument: turnout, coalition math, money |
| Casual | (none) | **adopts only, never coins** — light weights across existing nodes incl. cluster root 1963; the many bare "1963 @ 100%" acceptors are proto-casuals to upgrade |

Rejected lanes (Craig, 2026-07-14): single-issue (emerges naturally in weights),
identity-representation (left to humans), crossover (reserve for a uniquely
cross-aligned candidate someday).

**Structure: high-level first.** Level-1 headings on the candidacy arg stay
domain-level ("X would deliver on climate"); specific record facts chain
beneath them. **Salience lives in weights, not nodes** — "climate is urgent"
is not a Because of "X is good on climate"; it is why that heading gets 40
instead of 15. Adopt existing nodes freely, including admin's and even
rejection-side FACT nodes where the fact is valence-neutral (e.g., a McKinsey
career or an eliminated-cash-bail record can support opposite conclusions —
that tension is the platform working).

**Super-fan ledger:** Diana Delgado (4) → AOC. Robert Ramirez (18) → JD Vance.

## Rejection side


## The five rejection perspectives and their persona casts

Casts differ by candidate party so leans stay coherent. **Primary** carries the
slot by default; rotate to bench personas every few candidates so no single
account appears on every page.

### Rejecting a DEMOCRATIC candidate
| Slot | Voice | Primary | Bench |
|---|---|---|---|
| Absolute hater | contempt, personal | **Robert Ramirez (18)** MAGA | James Jennings (10) |
| Thoughtful conservative | fiscal/experience/coalition critique | **Frank Fletcher (6)** R, culture-war-averse | Alfred Anderson (1); Eleanor Evans (5) when the candidate's record makes abortion/faith the natural conservative lens; Maria Martinez (13) for anti-socialism angles |
| Centrist | electability, polarization | **Leonard Larson (12)** Ind | Nathan Nguyen (14), Victor Vasquez (22), Olivia O'Brien (15) |
| Strategic progressive (aligned but wary) | risk, timing, wasted value | **Sandra Sullivan (19)** D | Harold Hughes (8), Karen Kim (11), Yvonne Young (25) |
| Disillusioned left ("not committed enough") | party loyalty, systemic critique | **Zachary Zeller (26)** apolitical/disillusioned | Quinn Quigley (17)* |

### Rejecting a REPUBLICAN candidate
| Slot | Voice | Primary | Bench |
|---|---|---|---|
| Absolute hater | contempt, personal | **Diana Delgado (4)** prog/left | Irene Ingram (9) |
| Thoughtful liberal | policy/record critique | **Brianna Barnes (2)** D | Karen Kim (11), Patricia Powell (16) |
| Centrist | electability, polarization | **Leonard Larson (12)** Ind | Nathan Nguyen (14), Victor Vasquez (22) |
| Strategic conservative (aligned but wary) | risk, timing | **Carlos Castillo (3)** Ind-R | Wendy Walsh (23), Xavier Xiong (24) |
| Not-MAGA-enough right | purity critique | **James Jennings (10)** MAGA | Robert Ramirez (18) |

\* Quinn and Diana often *accept* left candidates (both accept 1968), which
disqualifies them from carrying rebuttals there — rebuttal weights require a
reject opinion. **Always run the persona-opinion precheck** (below) before
casting; never flip an existing accept to reject, pick a bench persona instead.

**Casting principle (carried over from the first pass):** the tables above are
defaults, not law. The first-pass initiative (see memory: project-2028-candidate-seeding)
established that biographical fit beats slot assignment — Xavier's Hmong
anti-communism on AOC, Wendy's crime lens on Moore, Robert's tariff populism on
Rand Paul. Override the default whenever a persona's actual backstory
(`personas_all_26.json`, incl. `ideology_score` -10..+9) gives a sharper voice.

**This is a second pass.** Every candidate arg under 1963 already carries 1-2
first-pass opponents with heading+sub-bullet rebuttal/because sets. Before
drafting, pull the candidacy arg's existing edges: extend personas already in a
slot (like Sandra on 1968) instead of duplicating their angle, and let existing
attack args be reused across the new perspectives.

## Argument structure rules (per persona)

- **Chain, don't star.** Before adding a heading, scan the candidacy arg's
  existing rebuttals (every persona's — the nodes are shared) for the
  outcome-level version of the claim. If your claim sits *upstream* of an
  existing one (a mechanism or reason for it), adopt the existing node as your
  heading and hang your claim beneath it as a Because — e.g. Frank adopted
  Carlos's "would drive up the deficit" (2429) and chained "no credible
  financing mechanism" (2430) ← "costs tens of trillions" (2431) under it.
  The ideal shape is outcome ← mechanism ← evidence; flat spokes on the
  candidacy arg should be reserved for genuinely parallel claims. (Exception:
  the absolute-hater slot staying flat is characterful — haters don't reason
  in chains.)
- 3–5 **rebuttal headings** on the candidacy arg, weights summing 100.
  Weights express the persona's emphasis (hater = flat 20s; analysts vary).
- Each heading ≤ 1 short sentence, fully atomic. Bundled reasons split into
  **Because children** (2–3 max, equal weights) per the granularity rule:
  terse heading as the direct rebuttal, reasons one jump down.
- New Because children get reciprocal Therefore edges automatically
  (`foldAndReciprocate`); reused existing args get a plain endorsement only.
- **Reuse before coining — duplicates are the cardinal failure.** The
  scaffolding must model exactly the discipline arg 1150 asks of humans
  ("Arguments on Agitate should not be duplicated"). Three layers of defense:
  1. **Semantic (primary, at drafting):** read the candidacy arg's FULL
     existing neighborhood (every persona's rebuttals + children) and annotate
     every draft claim in the redline spec with its **nearest existing arg**
     and the relationship: `none | duplicate | upstream | downstream`.
     Lesson case: "AOC has never run anything" (2424) vs "AOC has no executive
     experience" — same claim, zero shared keywords; only a semantic read
     catches it. (Resolved by mergeArguments(2424, 2432), redirect written.)
  2. **Lexical backstop:** `python3 check_dupes.py <spec>.json` emits a
     full-text ranking of every new text against all existing phrasings
     (same FULLTEXT index find_similar.php uses); review before generating.
  3. **Registry:** `claim_registry.md` for generic cross-candidate claims.
- **A duplicate is not coined — it is adopted, optionally with a new
  phrasing.** Spec: `{"argID": N, "putForth": "persona's own wording", ...}`
  endorses the existing node and adds the persona's tonally-matched wording as
  an alternative phrasing (`newPutForth`), letting phrasing weights compete —
  the platform's native answer to "same claim, different voice." Candidate-
  specific facts (votes, record) get new args; generic claims are registry
  items shared across candidates and personas — that sharing is what makes
  the graph converge.

## Per-candidate workflow

1. Refresh `corpus_snapshot.tsv` (one SSH, see command in gen_rejections.py docstring — swap the SELECT for the snapshot query below).
2. Claude drafts the spec JSON (all perspectives, atomized, deduped, registry
   reuses wired in). No external chat round-trip needed.
3. Craig redlines the spec — this is the editorial checkpoint; personas speak
   in these words.
4. **Precheck** (one query): confirm no cast persona currently *accepts* the
   candidacy arg:
   `SELECT profileID, acceptance FROM OPINION WHERE argumentID=<cand> AND profileID IN (...);`
5. `python3 gen_rejections.py <spec>.json > out.sql` → apply via single SSH
   with `--default-character-set=utf8mb4` (always).
6. Verification is built into the emitted SQL (new-args list + global 100%
   invariant check; the 10 known pre-existing violations on args
   393/630/631/1150/1152 are documented in DATA_CLEANUP_BACKLOG.md).
7. Add any newly-coined generic claims to `claim_registry.md`; commit spec +
   registry.

Snapshot query:
`SELECT p.phrasingID, p.argumentID, p.coinedBy, p.phrasing FROM PHRASING p ORDER BY p.phrasingID;`

## Notes

- Personas always operate under All Users - Public: every script sets
  `@active_aff_id = 12` and inserts SCOPE_ENDORSEMENT rows explicitly.
- Do NOT insert into BOT_SEED_QUEUE from these scripts; if bot texture is
  wanted on a new arg later, queue it deliberately.
- Batch 3–5 candidates per working session; specs live in this directory as
  `<candidate>_rejections.json` and are committed as the record of what was
  seeded.
