# Persona Opinion Seeding Process

Reusable workflow for seeding a persona's opinions, argument associations, and phrasings across all topic clusters.

---

## Inputs

| Item | File | Notes |
|------|------|-------|
| Persona character sheets | `personas_all_26.json` | 26 personas (A–Z); each has identity, psychographics, politics, religion, narrative, opinion_engine |
| Topic clusters | `topic_clusters.json` | 33 cluster keys; some marked SKIP |
| Target profileID | DB: `PROFILE` table | Must match the persona's index in personas_all_26.json |

---

## Pre-flight Checks

1. Confirm MySQL is running: `/Applications/MAMP/Library/bin/mysql -u root -proot vestigette -e "SELECT 1;"`
2. Pull persona's existing opinion count: `SELECT COUNT(*) FROM OPINION WHERE profileID = <N>;`
3. If placeholder opinions exist (bulk-inserted without real stance logic), note the argID range — they will be overwritten or need cleanup.
4. Read the persona's `opinion_engine.prompt_prefix` — this is the voice anchor for all phrasing work.

---

## Cluster Workflow (repeat for each non-SKIP cluster)

### Step 1 — Query Arguments

```sql
SELECT a.argumentID, a.currentPhrasing
FROM ARGUMENT a
JOIN (
  -- argument IDs from the cluster's "args" array in topic_clusters.json
) cluster_args ON a.argumentID = cluster_args.argumentID
ORDER BY a.argumentID;
```

In practice: read the cluster's `args` array from `topic_clusters.json`, then pull current phrasings for those IDs.

### Step 2 — Generate Persona Stances

For each argument in the cluster, apply the persona's `opinion_engine` logic:

- **Accept (1)**: argument aligns with persona's hardcoded beliefs, ideology score, or lived experience
- **Reject (0)**: argument conflicts with persona's core views
- **Neutral / forced**: if the persona wouldn't naturally engage, assign 0 (disagree/no association)

Use the `opinion_engine.prompt_prefix` as the framing voice. Consider:
- Ideology score (–10 liberal to +10 conservative)
- Hardcoded beliefs (non-negotiable stances explicitly listed in the character sheet)
- Key issues (topics the persona cares about most)
- Narrative backstory (lived experiences that shape opinion formation)

### Step 3 — User Review

Present the proposed stance table to the user:

```
argumentID | currentPhrasing (truncated) | proposed acceptance
---------- | --------------------------- | -------------------
1234       | "X is Y because Z"          | 1 (accept)
1235       | "A leads to B"              | 0 (reject)
```

Wait for user approval or modification before writing any SQL.

### Step 4 — Write SQL File

Output file naming: `brianna_barnes_<CLUSTER>_seed.sql` (or `[firstname]_[lastname]_<CLUSTER>_seed.sql`)

#### OPINION rows (all arguments in cluster — both accept and reject):

```sql
-- CLUSTER: <NAME>  profileID=<N>
INSERT IGNORE INTO OPINION (argumentID, profileID, acceptance) VALUES
  (1234, 2, 1),
  (1235, 2, 0),
  ...;
```

#### PHRASING rows (accepted arguments only — coinedBy = profileID):

```sql
INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES
  (1234, '<Persona phrasing>', 2);
CALL updatePhrasingCache(1234);

INSERT INTO PHRASING (argumentID, phrasing, coinedBy) VALUES
  (1238, '<Persona phrasing>', 2);
CALL updatePhrasingCache(1238);
```

> **Critical**: `CALL updatePhrasingCache(argID)` must follow every PHRASING INSERT.

### Step 5 — Execute

```bash
/Applications/MAMP/Library/bin/mysql -u root -proot vestigette < /path/to/file.sql
```

Verify row counts after execution:
```sql
SELECT COUNT(*) FROM OPINION WHERE profileID = <N> AND argumentID IN (<cluster_arg_ids>);
SELECT COUNT(*) FROM PHRASING WHERE coinedBy = <N> AND argumentID IN (<cluster_arg_ids>);
```

---

## Phrasing Rules

1. **1–2 sentences maximum** — no exceptions
2. **Core assertion only** — no rationale, no analogies, no qualifications, no hedging
3. **Persona's authentic voice** — use the `opinion_engine.prompt_prefix` as the voice anchor; match the persona's register, vocabulary, and emotional temperature
4. **Under ~200 characters preferred** — hard limit is 300 (varchar(300) column)
5. **No filler openers** — never start with "I think", "I believe", "As a…" unless the persona's voice demands it
6. **First-person acceptable** if the character sheet voice calls for it

---

## Output File Conventions

| Convention | Value |
|-----------|-------|
| Location | `/Users/Razzmatazz/vestigette-dev/` |
| Naming | `[firstname]_[lastname]_[CLUSTER]_seed.sql` |
| Header comment | `-- [PERSONA NAME] (profileID=N) — [CLUSTER LABEL] cluster` |
| One file per cluster | Yes — keeps execution and review manageable |

---

## Cluster Execution Order (profileID=2 / Brianna Barnes)

Suggested order — lead with Brianna's high-engagement clusters, do drier ones later:

1. RACE
2. POLICE
3. HEALTH
4. ABORT
5. HOUSING
6. IMMIG
7. VOTE
8. GOP
9. BLM
10. CANCEL
11. TRANS
12. COVID
13. CLIMATE
14. GOVTREG
15. WEALTH
16. CAPCRIT
17. MEDIA
18. ISRAEL
19. GUN
20. RELIGION
21. ENVIRON
22. WAR
23. LABOR
24. LGBTQ
25. SCOTUS
26. QANON
27. CULTURE
28. SPORTS
29. MISC_DEBATE
30. CRYPTO
31. GMO
32. CATHOLIC_ABUSE

---

## Quick Reference — Brianna Barnes (profileID=2)

- **Age/background**: 34, Black female, suburban Atlanta (Lithonia, GA)
- **Occupation**: Healthcare administrator
- **Ideology score**: –7 (progressive Democrat)
- **Religion**: AME churchgoer, faith-grounded but not dogmatic
- **Hardcoded beliefs**: racism is structural; Black maternal mortality crisis is real; public schools deserve full funding; Democratic Party is imperfect but the only viable option; children's safety is non-negotiable
- **Key issues**: healthcare access, racial health disparities, education funding, criminal justice reform, economic opportunity
- **Voice**: code-switches between professional precision and warm directness; thinks structurally about race; grounds everything in human stakes; exhausted but not cynical
- **Phrasing register**: clear, grounded, human stakes front-loaded; occasional professional register; no jargon for its own sake

---

## Reuse for Other Personas

1. Open `personas_all_26.json`, find the target persona by letter/name
2. Note their `profileID`, `ideology_score`, `hardcoded_beliefs`, `key_issues`, `opinion_engine.prompt_prefix`
3. Replace Brianna-specific fields in this document's Quick Reference section
4. Follow the same cluster workflow — the SQL pattern is identical across all personas
