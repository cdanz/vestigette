# Agitate — Project Hub

_Discourse-mapping platform. Live (alpha) at **agitate-discourse.org**.
Repo: **github.com/cdanz/vestigette**. Local working dir: `/Users/Razzmatazz/vestigette-dev`._

**This file is the entry point.** It gives orientation + the operational workflow, and
links to focused docs you only need to open when relevant. It's a living document —
keep it current and let **git history** be the version trail (don't create dated copies).

> New session? Read this top-to-bottom first. Claude also auto-loads its own notes from
> `~/.claude/projects/-Users-Razzmatazz-vestigette-dev/memory/MEMORY.md`.

---

## What it is

A tool for mapping the structure of an argument/debate as a weighted graph, so a reader
can see *why* people accept or reject a claim, what follows from it, and what rebuts it —
and weigh in themselves.

- **Argument** = a claim (a shell with an ID; not tied to specific wording).
- **Phrasing** = an alternate wording of an argument. Users weight which phrasing best
  states the claim; the winner is cached on `ARGUMENT.currentPhrasing` / `currentPhrasingID`.
- **Opinion** = each user **accepts** or **rejects** an argument. Accepting unlocks the
  Because/Therefore weighting UI; rejecting unlocks Rebuttal.
- **Relationships** (`ENDORSEMENT`, the weighted edges):
  - **Because** — supporting reasons
  - **Therefore** — consequences that follow
  - **Rebuttal** — counters
- **Explications** = external links that elaborate an argument (also weighted).
- **Personas** (profileIDs **1–26**) = LLM/admin-driven "dialectic scaffolding" used to
  seed poorly-populated, low-engagement arguments. The goal is to remove persona input
  once an argument has enough genuine human engagement. **Admin** = profileID **28**
  (`isAdmin`). A yellow robot badge marks any argument a persona holds an opinion on.

### The 100% invariant (important)
For each `(profileID, targArgID, endorseType)`, the **active** endorsement weights sum to
**100%**. Phrasing and explication endorsements follow the same per-user/per-arg rule.
Anything touching `ENDORSEMENT` must preserve this (see the merge and rebalance logic).

---

## Infrastructure & how to work  (read this before touching anything)

- **Production:** a DigitalOcean droplet `root@178.128.74.45` (= agitate-discourse.org).
  Apache + PHP + MySQL. Web root `/var/www/html`, persona bot in `/var/www/bot`.
- **Database:** `ssh root@178.128.74.45 "mysql vestigette ..."` — root connects via the
  unix socket, **no password**. Use `-N -B` for terse output. **Batch your SSH** — rapid
  repeated connections trip **fail2ban** and you'll get "Connection refused" for a while.
- **No git on the server.** Deploy by scp via **`./deploy_droplet.sh {php|bot|all}`**
  (batches scp + ssh into single connections and lints PHP afterward). New web files must
  be added to `PHP_FILES` / `STATIC_FILES` in that script or they won't ship.
- **Stored procs / triggers** are deployed by piping SQL to `ssh "mysql vestigette"` as
  root. This is **MySQL 8, not MariaDB** → use `DROP PROCEDURE IF EXISTS` + `CREATE`
  (there is **no** `CREATE OR REPLACE PROCEDURE`). Canonical proc/trigger source lives in
  the tracked `*_procedures.sql` files; some helpers historically lived only in the live
  DB — when you touch one, bring it into a `*_procedures.sql` file.
- **Git workflow:** work in `/Users/Razzmatazz/vestigette-dev`. Branch off `main`, make
  focused commits, push, open a PR; **the owner merges**; then sync `main` and delete the
  branch. Only commit/push when asked. End commit messages with the
  `Co-Authored-By: Claude ...` trailer.
- **Cache-busting:** `index.php` links CSS/JS with `?v=<filemtime>` so every deploy busts
  the browser cache automatically.
- **Secrets:** `.env` and `persona_credentials.json` are gitignored — never commit them.
  The persona/test-account password is intentionally weak (`Pa$word`) for alpha accounts.

---

## Data model (run `SHOW TABLES` / `SHOW PROCEDURE STATUS` for the live, full list)

Current key tables:

| Table | Role |
|---|---|
| `ARGUMENT` | the claim shell; caches `currentPhrasing` / `currentPhrasingID` |
| `PHRASING` | alternate wordings of an argument |
| `PHRASE_ENDORSE` | per-user weighted endorsement of phrasings |
| `ENDORSEMENT` | weighted edges. PK `(targArgID, profileID, endorseType, supportingArgID, active)` |
| `OPINION` | accept/reject. PK `(argumentID, profileID)`, `acceptance` |
| `EXPLICATION` | external links; UNIQUE `(argumentID, profileID)` |
| `EXPLICATION_ENDORSE` | weighted endorsement of explications |
| `ARGUMENT_REDIRECT` | `oldArgumentID → newArgumentID` for merged arguments |
| `ARGUMENT_FLAG` | user flags (one active per user/arg; resolved rows kept) |
| `ADMIN_SETTINGS` | admin prefs incl. `pickerType` = `none`/`manual`/`auto` |
| `BOT_SEED_QUEUE` | persona-bot seeding queue |
| `USER_PROFILE` | accounts (personas = 1–26, admin = 28) |
| `INVITATION`, `REMEMBER_ME` | invite codes; persistent-login tokens |
| `PHRASING_ARCHIVE`, `PUT_FORTH_ARCHIVE` | legacy tables |

> Older docs mention `PHRASING_NEW` / `PUT_FORTH_NEW` — those no longer exist (now
> `PHRASING` + the `*_ARCHIVE` tables).

**Trigger:** `impliedAssertion` (BEFORE INSERT on `ENDORSEMENT`) records an implied
acceptance of the supporting argument. It must **not** modify `ENDORSEMENT` (a trigger
can't write the table that fired it).

**Notable procedures:** `assertOpinion` (accept/reject + cascade; reject branch calls
`rebalanceRecentRejections`), `getAssociated`, `getNeighborhood` / `getNeighborhoodAll`,
`mergeArguments`, `flagArgument` / `unflagArgument` / `resolveArgumentFlags`,
`prepareForNewEndorse` / `resolveOldWithNewEndorse`, `updatePhrasingCache`,
`foldInAssertion`, `promoteExplication`. (35 total — list is in the DB.)

---

## Key code files

- **`index.php`** — main page: argument header (phrasing, verdict %, "Argument ID" +
  persona badge), Because/Therefore/Rebuttal sections, Find section, admin picker bar,
  flag control. Loads its data, **closes `$db` early** (~line 159), then renders.
- **`query_current_argument.php`** — fetches the current argument's data via procs.
- **`functions.php`** — POST action handler (`buttonClicked` switch: accept/reject,
  `weighBecause/Therefore/Rebuttal`, flag/unflag, etc.). Weighting a support also applies
  **implied acceptance** at commit (overrides a prior rejection of that support).
- **`flesh_out.php`** — the association-builder page (uses `getNeighborhood`).
- **`admin_tools.php`** — admin-only: merge arguments, Profile Picker config, flagged-args
  resolve, invite codes. Requires `isAdmin`.
- **`neighborhood.php`** — lazy-load endpoint for the Find ▸ Neighborhood list.
- **`includes/dbconnect.php`** — provides `$db` (mysqli).
- **`style_vestigette.css`**, **`script_vestigette.js`** — front end. Palette includes
  `--cddbYellow` (#d4a017), used for flagged state and the persona badge.

---

## Current feature set (built & live)

- Weighted **Because / Therefore / Rebuttal**, **phrasing**, and **explication**
  endorsement (100% per user, per type).
- **Argument merge** (admin) — `mergeArguments` conserves weights (sums support
  collisions, keep-wins on target collisions, renormalizes self-loops) and writes
  `ARGUMENT_REDIRECT` so old URLs resolve.
- **Argument flagging** — users flag (offensive / phrasing-mismatch / duplicate-assoc /
  spam / incoherent / other); admin "Flagged Arguments" list resolves them.
- **Find section** — Last Visited, Recent Assertions, Go to ID (← / → / Popular), and a
  lazy-loaded **Neighborhood** list (`getNeighborhoodAll`, hop-3 adaptive). Open subsection
  persists across pages via `localStorage`.
- **Admin Profile Picker** — `manual` (designated IDs) or `auto` (personas with an opinion
  on the current arg + you, by last-name initial); mutually exclusive via
  `ADMIN_SETTINGS.pickerType`.
- **AI-persona transparency badge** — yellow robot beside "Argument ID" when any persona
  (1–26) holds an opinion on the argument.
- **Persona seeding bot** — queue + cron: `BOT_SEED_QUEUE → process_seed_queue.py →
  persona_bot.py` (in `/var/www/bot`). See `PERSONA_SEEDING_PROCESS.md`.
- **Persistent login** — rememberMe cookie (30-day).

---

## Gotchas

- **MySQL ≠ MariaDB:** `DROP`+`CREATE` for procs; no `CREATE OR REPLACE PROCEDURE`.
- **fail2ban:** don't hammer SSH; batch connections (the deploy script already does).
- **Light panel vs dark header:** the expanded argument panel renders on a **light**
  background while the argument header is **dark**. Style for the surface you're on
  (e.g., the flag control uses dark colors because it sits on the light panel).
- **Preserve the 100% invariant** on any `ENDORSEMENT` change.
- **Trigger rule:** `impliedAssertion` can't touch `ENDORSEMENT`.
- **`rebalanceRecentRejections`** loops must stay scoped per `endorseType` (an unscoped
  condition once caused an infinite loop / hung requests).

---

## Deeper references

- **`PERSONA_SEEDING_PROCESS.md`** — persona seeding workflow (current).
- **`DATA_CLEANUP_BACKLOG.md`** — known data-quality issues to clean (current).
- **`core_procedures.sql`, `merge_procedures.sql`, `flag_procedures.sql`,
  `neighborhood_procedures.sql`, `explication_procedures.sql`** — canonical proc/trigger
  source.
- **`deploy_droplet.sh`** — the deploy script (also the source of truth for which files
  ship).

---

## Roadmap / parked

- Phase out persona input on arguments that reach enough human engagement (the badge is
  the transparency bridge until then).
- Tutorial/demo experience; first-login weighting indicators; About / Explore / Profile
  pages; bot transparency + blog; cost monitoring & scale-back rules; branding pass.

_Last refreshed: 2026-06-12._
