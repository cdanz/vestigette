# Data Cleanup Backlog — ARGUMENT and PHRASING

Audit of known data quality issues uncovered during the phrasing
standardization pass (May 2026). This document lists problematic
arguments and phrasings that should be **excluded from production
queries and any future bulk operations** until manually resolved.

Each category includes ready-to-use SQL exclusion clauses so callers
can write `WHERE argumentID NOT IN (...)` or `WHERE phrasingID NOT IN
(...)` against the consolidated ID lists at the bottom of this file.

---

## Summary

| Category | Affected rows | Severity |
|---|---|---|
| 1. Test-placeholder argument parents | 7 args | **High** — entire arg is junk |
| 2. Empty parent phrasings | 1 arg | **High** — arg cannot render |
| 3. Misattributed phrasings under test parents | 7 phrasings (real text on junk args) | **Medium** — content worth salvaging |
| 4. Junk subsequent phrasings under real parents | 7 phrasings | **Low** — easy delete |
| 5. Wrong-argument contradictions | 4 phrasings | **Medium** — phrasing rebuts its own parent |
| 6. Argument-level duplicates | 5 clusters (15 args) | **High** — needs merge of args + endorsements |
| 7. Cross-argument subsequent text dupes | derived from category 6 | **Low** — auto-resolves with arg merge |

---

## Category 1 — Test/placeholder argument parents

The argument's earliest (and authoritative) phrasing is itself a
testing placeholder. These args were never genuine arguments.

| argumentID | phrasingID | First phrasing |
|---|---|---|
| 48 | 49 | `TEST ARGUMENT #1` |
| 49 | 52 | `TEST ARGUMENT #2` |
| 54 | 62 | `TEST ARGUMENT #7` |
| 55 | 64 | `TEST ARGUMENT #8` |
| 83 | (first) | `Hey this is crazy but here's my number so call me maybe.` (song lyric, not an argument) |
| 1060 | 1111 | `Test values passed from one page reload to the next alternating between submitting differing weights (endorse) and adding unique assertion.` |

**Recommended resolution:** delete the ARGUMENT row and all of its
PHRASING, OPINION, PHRASE_ENDORSE, ENDORSEMENT, and EXPLICATION
children. Mind FK constraints: PHRASE_ENDORSE must be cleared first.

---

## Category 2 — Empty parent phrasing

Argument's first phrasing is an empty string, so the UI has nothing to
render as the canonical wording.

| argumentID | phrasingID | First phrasing |
|---|---|---|
| 1436 | 1493 | *(empty)* |

**Recommended resolution:** either provide a genuine first phrasing
(and demote `1493` to a subsequent), or delete the argument if it has
no genuine content.

---

## Category 3 — Misattributed phrasings under test parents

Real-looking text stored under a test-placeholder argumentID (see
Category 1). The text itself may be worth preserving — but it is
currently anchored to a junk argument.

| phrasingID | argumentID | Phrasing | Right home? |
|---|---|---|---|
| 315 | 48 | `It is not possible for the government to delivery anything efficiently.` | Probably a govt-inefficiency arg (~412, 1850) |
| 53 | 49 | `America's criminal justice system is racist.` | Likely arg 171 or 1664 |
| 234 | 49 | `The American criminal justice system is racist to its core.` | Likely arg 171 or 1664 |
| 58 | 50 | `Black people receive much harsher sentences than white people` | Likely arg 103 |
| 63 | 54 | `A wealth tax is a critical tool toward societal harmony.` | Likely arg 745, 3242, or 3249 |
| 3236 | 54 | `A wealth tax on extreme concentrations is not punishment — it's the price of a society stable enough to generate that wealth.` | Likely arg 745 or 3242 |
| 65 | 55 | `We have fewer heroes than we should.` | No clear home; possibly delete |

**Recommended resolution:** for each, either (a) move the phrasingID
to the correct argumentID via `UPDATE PHRASING SET argumentID = X`, or
(b) delete if no plausible home exists. Repoint any PHRASE_ENDORSE
rows accordingly.

---

## Category 4 — Junk subsequent phrasings under real parents

The argument parent is fine; the subsequent phrasing is a placeholder
or non-content.

| phrasingID | argumentID | Phrasing |
|---|---|---|
| 6 | 5 | `Something distinct 1` |
| 50 | 48 | `Still test argument #1 but testing add button with user 2.` |
| 51 | 48 | `Take 3 with testing argument 1` |
| 56 | 50 | `Something distinct 2` |
| 57 | 50 | `Something distinct 3` |
| 301 | 66 | `https://twitter.com/parisdaguerre/status/1344206765076983809?s=21` (bare URL) |
| 1056 | 110 | *(empty)* |

**Recommended resolution:** straight `DELETE FROM PHRASING WHERE
phrasingID IN (...)` after repointing any PHRASE_ENDORSE rows. None of
these phrasings convey usable content.

---

## Category 5 — Wrong-argument contradictions

Subsequent phrasing argues the **opposite** of its parent argument's
claim. Almost certainly the result of UI confusion at creation time —
someone phrased a rebuttal under the argument it rebuts.

| phrasingID | argumentID | Parent's claim | Subsequent argues |
|---|---|---|---|
| 2160 | 52 | No functional difference between tax cut and direct payment | OPPOSITE — there *is* a difference |
| 1827 | 62 | Earmarking puts a program in jeopardy | OPPOSITE — earmarking *guarantees* funding |
| 1921 | 92 | Descriptive: GOP is anti-government | Endorses anti-gov ideology as correct |
| 1922 | 93 | Descriptive: GOP denies climate change | Praises GOP for pushing back on alarmism |

**Recommended resolution:** for each, identify the argument the
subsequent actually phrases (it should be the rebuttal of its current
parent) and move it there with `UPDATE PHRASING SET argumentID = X`.

---

## Category 6 — Argument-level duplicates

Multiple ARGUMENT rows have identical or near-identical first
phrasings, indicating duplicate arguments that should be merged into
one canonical argumentID.

### 6a. Seven-way cluster
| argumentIDs | Shared parent text |
|---|---|
| **207, 208, 209, 210, 211, 212, 213** | `Black people are stopped for looking suspicious far more often than white people.` |

### 6b. Two-way clusters
| argumentIDs | Shared parent text |
|---|---|
| 145, 146 | `Policing in America must be reformed.` |
| 148, 149 | `Police should be required to use de-escalation techniques.` |
| 176, 177 | `Non-white males are statistically less well educated than white counterparts.` (near-identical) |
| 1233, 1234 | `It's okay to be white, but not okay to not recognize what that means.` |
| 1315, 1316 | `Black people are right not to expect justice when crimes are committed against them.` |
| 435, 446 | *Distinct parent text*, but a subsequent phrasing (2891) duplicated text from arg 435's phrasing 2886 about Senate Wyoming/California — likely related/duplicate args |
| 1125, 1126 | *Distinct parent text*, but subsequent phrasings 2494 and 2495 once shared identical text about Michael Jackson — possibly related args |

**Recommended resolution:** for each cluster, choose one canonical
argumentID (lowest is conventional), then:
1. `UPDATE PHRASING SET argumentID = <canonical>` for all phrasings
   under the doomed args
2. `UPDATE OPINION SET argumentID = <canonical>` (de-duplicating
   per-profile collisions)
3. `UPDATE ENDORSEMENT SET argumentID = <canonical>` and
   `UPDATE ENDORSEMENT SET supportingArgID = <canonical>` (de-duplicating
   `(profile, targ, support, type)` collisions)
4. `UPDATE PHRASE_ENDORSE SET argumentID = <canonical>`
5. `UPDATE EXPLICATION SET argumentID = <canonical>`
6. `DELETE FROM ARGUMENT WHERE argumentID IN <doomed ids>`

The 7-way cluster (207–213) is the highest-leverage item — collapsing
it would clean up 6 redundant arguments and unify ~7× phrasings,
opinions, and endorsements.

---

## Category 7 — Cross-argument subsequent text duplicates

Subsequent phrasings whose text appears verbatim on multiple
argumentIDs. As of the May 2026 cleanup, the only remaining instance
is a consequence of Category 6a (the 207–213 cluster). When those args
are merged, the cross-arg dupe collapses naturally.

| Phrasing | phrasingIDs / args |
|---|---|
| `Black people are stopped for 'looking suspicious' at rates that have nothing to do with actual crime.` | 2554@207, 2555@208, 2556@209, 2557@210, 2558@211, 2559@212, 2560@213 |

**Recommended resolution:** resolves automatically with Category 6a.
No standalone action needed.

---

## Consolidated exclusion lists

For SQL queries that should ignore broken data, use these.

### Argument IDs to exclude
```sql
-- All categories 1 + 2 + 6 (any arg that is junk or duplicated):
argumentID NOT IN (
  -- Category 1: test parents
  48, 49, 54, 55, 83, 1060,
  -- Category 2: empty parent
  1436,
  -- Category 6: arg-level duplicates (the non-canonical ones to drop on merge)
  146,           -- dupe of 145
  149,           -- dupe of 148
  177,           -- dupe of 176
  208, 209, 210, 211, 212, 213,   -- dupes of 207
  1234,          -- dupe of 1233
  1316,          -- dupe of 1315
  446,           -- likely dupe of 435 (verify before merge)
  1126           -- likely dupe of 1125 (verify before merge)
)
```

### Phrasing IDs to exclude
```sql
-- All categories 3 + 4 + 5 (junk or misattributed phrasings to skip):
phrasingID NOT IN (
  -- Category 3: misattributed under test parents
  315, 53, 234, 58, 63, 3236, 65,
  -- Category 4: junk subsequents
  6, 50, 51, 56, 57, 301, 1056,
  -- Category 5: wrong-arg contradictions
  2160, 1827, 1921, 1922
)
```

### Combined exclusion view (optional)
A view simplifies day-to-day queries:
```sql
CREATE OR REPLACE VIEW PHRASING_CLEAN AS
SELECT * FROM PHRASING
WHERE argumentID NOT IN (
        48,49,54,55,83,1060,1436,146,149,177,208,209,210,211,212,213,
        1234,1316,446,1126
      )
  AND phrasingID NOT IN (
        315,53,234,58,63,3236,65,6,50,51,56,57,301,1056,
        2160,1827,1921,1922
      );

CREATE OR REPLACE VIEW ARGUMENT_CLEAN AS
SELECT * FROM ARGUMENT
WHERE argumentID NOT IN (
        48,49,54,55,83,1060,1436,146,149,177,208,209,210,211,212,213,
        1234,1316,446,1126
      );
```

---

## Verification queries

Re-run these periodically to confirm nothing new has slipped in.

```sql
-- Junk first phrasings
SELECT p.argumentID, p.phrasingID, p.phrasing
FROM PHRASING p
JOIN (SELECT argumentID, MIN(phrasingID) AS firstID
      FROM PHRASING GROUP BY argumentID) m
  ON p.phrasingID = m.firstID
WHERE p.phrasing REGEXP 'TEST ARGUMENT|Something distinct|Take [0-9]+ with testing|^test '
   OR p.phrasing = ''
   OR p.phrasing REGEXP '^https?://';

-- Arg-level duplicates by first-phrasing text
SELECT first_text, GROUP_CONCAT(argumentID ORDER BY argumentID) AS arg_ids
FROM (
  SELECT p.argumentID, p.phrasing AS first_text
  FROM PHRASING p
  JOIN (SELECT argumentID, MIN(phrasingID) AS firstID
        FROM PHRASING GROUP BY argumentID) m
    ON p.phrasingID = m.firstID
) x
GROUP BY first_text HAVING COUNT(*) > 1;

-- Cross-arg subsequent text dupes
SELECT phrasing, GROUP_CONCAT(CONCAT(phrasingID,'@arg',argumentID)
       ORDER BY phrasingID) AS occurrences
FROM PHRASING
WHERE phrasingID NOT IN (SELECT MIN(phrasingID) FROM PHRASING GROUP BY argumentID)
GROUP BY phrasing HAVING COUNT(*) > 1;
```

---

*Document established: May 28, 2026, after completion of phrasing
standardization pass (1,376 rewrites, 49 deletes, 39 endorsement
repoints across 6 batches).*


---

## Addendum — July 2026 phrasing-polish pass findings

Items discovered during the July 9, 2026 full-corpus phrasing review
(see `PHRASING_TRIAGE.md`). Not yet resolved.

### New junk/meta content candidates
| ID | Type | Content | Suggested action |
|---|---|---|---|
| arg 1048 (phr 1099) | meta | "There is an SQL failure - proportions of endorsements get miscalculated…" (bug report stored as argument) | delete with children |
| arg 1136 (phr 1188) | meta | demo-video UX description stored as argument | review/delete |
| phr 1528 @ arg 1471 | junk | "FDT" (non-content abbreviation) | delete phrasing |
| phr 1735 | meta | "Codename: vindaloo vNow" | review/delete |
| phr 1140, phr 738 | stale | reference old "Vestigette" name/URL and pronunciation | rewrite for Agitate branding |

### Possible argument-level duplicates (verify before merge)
| argumentIDs | Shared claim |
|---|---|
| 436, 438 | road wear scales with fourth power of axle weight |

### Structural anomalies
- **arg 413** carries stray bicycle-related edges (431/432/453) — endorsement cross-contamination; audit.
- **args 1738–1745** (intersex counterexamples) currently rebut arg 142 directly; once arg **2366**
  ("There are only two biological sexes.", coined July 2026) accrues engagement, they more precisely
  rebut 2366 and could be re-pointed.

### Pre-existing 100% invariant violations (predate July 2026 pass; June bot-run artifacts)
Active endorsement weights not summing to 100 for:
(393,2,Because) (393,21,Because) (393,23,Because) (393,1,Because) (393,25,Therefore)
(630,22,Because) (630,9,Because) (631,15,Because) (1150,14,Therefore) (1152,15,Therefore)
Likely caused by persona retirement/rebalance edge cases on Agitate-meta args. Needs a
re-normalization script or investigation of `retirePersonaFromArgument`.

### Pre-existing opinion↔endorsement inconsistencies (found July 2026 QA pass; predate candidate seeding)
Active endorsements whose holder lacks the required opinion direction on the target:
- Rebuttal without reject: (4,100) (18,105) (19,574) (24,527)
- Because without accept: (2,379) (2,574) (19,1967) (28,48) (28,1994) (28,2000)
- Args 2411/2412 have no ACTIVE phrase-endorse rows (coined while coiner rejects 1968); phrasing cache is set and correct — cosmetic only.
