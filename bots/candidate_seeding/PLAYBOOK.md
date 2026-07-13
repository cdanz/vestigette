# Candidate Rejection Seeding — Playbook

Repeatable process for building each candidate's rejection-side discourse
(acceptor-side playbook to follow once this is tuned). Established July 2026
off the manually-built AOC page (arg 1968).

## The five rejection perspectives and their persona casts

Casts differ by candidate party so leans stay coherent. **Primary** carries the
slot by default; rotate to bench personas every few candidates so no single
account appears on every page.

### Rejecting a DEMOCRATIC candidate
| Slot | Voice | Primary | Bench |
|---|---|---|---|
| Absolute hater | contempt, personal | **Robert Ramirez (18)** MAGA | James Jennings (10) |
| Thoughtful conservative | fiscal/experience/coalition critique | **Eleanor Evans (5)** R | Alfred Anderson (1), Maria Martinez (13), Frank Fletcher (6) |
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

## Argument structure rules (per persona)

- 3–5 **rebuttal headings** on the candidacy arg, weights summing 100.
  Weights express the persona's emphasis (hater = flat 20s; analysts vary).
- Each heading ≤ 1 short sentence, fully atomic. Bundled reasons split into
  **Because children** (2–3 max, equal weights) per the granularity rule:
  terse heading as the direct rebuttal, reasons one jump down.
- New Because children get reciprocal Therefore edges automatically
  (`foldAndReciprocate`); reused existing args get a plain endorsement only.
- **Reuse before coining.** Grep `corpus_snapshot.tsv` and check
  `claim_registry.md` first. Candidate-specific facts (votes, record) get new
  args; generic claims ("no executive experience" logic, "socialism at scale")
  are registry items shared across candidates and across personas — sharing
  supporting args across personas is exactly what makes the graph converge.

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
