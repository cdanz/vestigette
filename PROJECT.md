# Agitate — Project Hub

_Discourse-mapping platform. Live (alpha) at **agitate-discourse.org**._
_Repo: **github.com/cdanz/vestigette**. Local working dir: `/Users/Razzmatazz/vestigette-dev`._

**This file is the entry point.** Read it top-to-bottom at the start of a new session.
Claude also auto-loads its own notes from
`~/.claude/projects/-Users-Razzmatazz-vestigette-dev/memory/MEMORY.md`.
It's a living document — keep it current and let **git history** be the version trail.

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
- **Personas** (profileIDs **1–26**) = LLM/admin-driven bots used to seed
  low-engagement arguments with dialectical scaffolding. Retire probabilistically as human
  engagement grows. A yellow robot badge marks any argument a persona holds an opinion on.
- **Admin** = profileID **28** (`isAdmin` flag in session).

### The 100% invariant (critical)
For each `(profileID, targArgID, endorseType)`, the **active** endorsement weights sum to
**100%**. Phrasing and explication endorsements follow the same per-user/per-arg rule.
Anything touching `ENDORSEMENT` must preserve this.

---

## Infrastructure & operational workflow

- **Production:** DigitalOcean droplet `root@178.128.74.45` (= agitate-discourse.org).
  Apache + PHP 8 + MySQL 8. Web root `/var/www/html`, bot scripts in `/var/www/bot`.
- **Database access:**
  - App connects via credentials in `/var/www/html/includes/config.local.php` on the
    droplet (gitignored, manually placed — follows the `config.local.php` branch in
    `dbconnect.php`).
  - MySQL root for maintenance/backups:
    `MYSQL_PWD=$(cat /root/.digitalocean_password) mysql -u root vestigette`
  - Use `-N -B` flags for terse script output. **Batch SSH** — rapid repeated connections
    trip **fail2ban** and produce "Connection refused" for several minutes.
- **No git on the server.** Deploy via **`./deploy_droplet.sh {php|bot|all}`** — batches
  scp + ssh into single connections and lints PHP after transfer. New web files must be
  added to `PHP_FILES` (or `INCLUDE_FILES`) in that script or they won't ship.
- **Stored procs / triggers** are deployed by piping SQL to `ssh "mysql vestigette"` as
  root. **MySQL 8, not MariaDB** → use `DROP PROCEDURE IF EXISTS` + `CREATE` (there is no
  `CREATE OR REPLACE PROCEDURE`). Canonical proc/trigger source lives in the `db/`
  `*_procedures.sql` files.
- **Git workflow:** commit directly to `main`; push when a logical unit of work is done.
  End commit messages with the `Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>`
  trailer.
- **Cache-busting:** `index.php` links CSS/JS with `?v=<filemtime>`.
- **Secrets:** `.env` and `persona_credentials.json` (in `bots/`) are gitignored.
- **DB backup:** full backup (structure + data + procedures + triggers) at
  `db/backups/vestigette_backup_2026-07-08.sql` — gitignored, keep a copy off-machine.
  To take a fresh backup: `MYSQL_PWD=$(cat /root/.digitalocean_password) mysqldump --user=root --routines --triggers --events --single-transaction --add-drop-table --add-drop-trigger --databases vestigette > /tmp/backup.sql` then scp it down.

---

## Repo structure

```
/                   PHP app files, CSS/JS, deploy scripts, top-level docs
includes/           dbconnect.php, content_chrome.php, Parsedown.php
pages/              Standing-page markdown (ai-policy-pledge, data-promise) — see pages/README.md
db/                 Active stored-procedure SQL files (*_procedures.sql)
db/seeds/           Historical one-time data-seed SQL (persona seeds, wiki, etc.)
db/backups/         DB dumps — gitignored (contain user data)
bots/               Bot scripts (active + archived), JSON data, seeding docs
```

---

## Groups & scoped engagement (Phase 5 — live)

This is the key architectural layer added in 2026. Understand it before touching
engagement code.

- **`AFFILIATION`** — groups. `public = 1` means open/visible; `public = 0` is private.
  `affiliationID = 12` ("All Users - Public") is the universal default; constant
  `ALL_PUBLIC_AFF_ID = 12` is defined in `dbconnect.php`.
- **`MEMBER`** — group membership rows.
- **`USER_PROFILE.activeAffiliationID`** — which group context the user is currently
  "operating as." Defaults to 12. Changed via `switchGroup` action in `functions.php`.
- **`@active_aff_id`** — MySQL session variable set by `dbconnect.php` on every request
  from the user's `activeAffiliationID`. Every engagement action inserts a SCOPE row using
  this value.
- **`SCOPE_OPINION`, `SCOPE_ENDORSEMENT`, `SCOPE_PHRASE_ENDORSE`,
  `SCOPE_EXPLICATION_ENDORSE`** — record which group context each action was taken under.
  These are the data backing the filter's group-affiliation view.
- **Operating-as vs. filter-view are separate:**
  - *Operating-as* controls how actions are attributed (via SCOPE inserts).
  - *Filter-view* controls what metrics you see (via `FILTER_PROFILES` temp table).
  - `switchGroup` auto-applies the new group as a filter; switching back to All Users -
    Public clears the group filter entirely. `$_SESSION['filters']['auto_aff_id']` tracks
    the auto-applied affiliation so it can be cleanly removed.
- **Bot personas always operate under affiliationID 12.** `process_seed_queue.py` pins
  `activeAffiliationID = 12` in the DB before each bot run; `persona_bot.py` also calls
  `switchGroup` to affiliationID 12 after login. `queueOpinionForSeeding` in `functions.php`
  only fires when the triggering user's active affiliation is public (`AFFILIATION.public = 1`).

---

## Data model

23 tables. Run `SHOW TABLES` / `SHOW PROCEDURE STATUS WHERE Db='vestigette'` for the live list.

| Table | Role |
|---|---|
| `ARGUMENT` | Claim shell; caches `currentPhrasing` / `currentPhrasingID` |
| `PHRASING` | Alternate wordings |
| `PHRASE_ENDORSE` | Per-user phrasing weights |
| `ENDORSEMENT` | Weighted edges. PK `(targArgID, profileID, endorseType, supportingArgID, active)` |
| `OPINION` | Accept/reject. PK `(argumentID, profileID)`, col `acceptance` |
| `EXPLICATION` | External links. UNIQUE `(argumentID, profileID)` |
| `EXPLICATION_ENDORSE` | Weighted explication endorsements |
| `AFFILIATION` | Groups. `public` flag; affiliationID 12 = "All Users - Public" |
| `MEMBER` | Group membership |
| `SCOPE_OPINION` | Group context for each OPINION action |
| `SCOPE_ENDORSEMENT` | Group context for each ENDORSEMENT action |
| `SCOPE_PHRASE_ENDORSE` | Group context for phrasing endorsements |
| `SCOPE_EXPLICATION_ENDORSE` | Group context for explication endorsements |
| `USER_PROFILE` | Accounts. Personas = profileID 1–26, admin = 28. `activeAffiliationID` col |
| `ADMIN_SETTINGS` | Per-admin prefs: `pickerType` (`none`/`manual`/`auto`), `demoMode` |
| `INVITATION` | Invite codes for registration. `usesRemaining` (NULL = unlimited), `expiresAt` (NULL = never) |
| `REMEMBER_ME` | Persistent-login tokens (30-day) |
| `BOT_SEED_QUEUE` | Persona-bot seeding queue |
| `ARGUMENT_REDIRECT` | `oldArgumentID → newArgumentID` for merged arguments |
| `ARGUMENT_FLAG` | User flags; one active per user/arg; resolved rows kept |
| `CONTENT` | Blog/content storage |
| `PHRASING_ARCHIVE`, `PUT_FORTH_ARCHIVE` | Legacy tables |

**Trigger:** `impliedAssertion` (BEFORE INSERT on `ENDORSEMENT`) — records an implied
acceptance of the supporting argument AND inserts a `SCOPE_OPINION` row. Must **not**
modify `ENDORSEMENT` (trigger can't write the table that fired it).

**Procedures (38 total):** `assertOpinion` (accept/reject + cascade; reject calls
`rebalanceRecentRejections`), `getDetail` / `getAssociated` / `getAltPhrasing` /
`getExplication` (all take a `filtered` param — when 1, JOIN `FILTER_PROFILES` temp table),
`getNeighborhood` / `getNeighborhoodAll`, `mergeArguments`, `flagArgument` /
`unflagArgument` / `resolveArgumentFlags`, `prepareForNewEndorse` /
`resolveOldWithNewEndorse`, `updatePhrasingCache`, `foldInAssertion`,
`retirePersonaFromArgument`, `getTrending`, `getMostContested`, and others.

---

## Key code files

- **`index.php`** — main page. Argument header (phrasing, verdict %, Argument ID, persona
  badge, filter badge), Because / Therefore / Rebuttal sections, Filter section, Find
  section, admin picker bar, flag control, filter overlay modal. Loads data then closes
  `$db` early before render. Desktop layout: `#left-col` (60%) and `#right-col` (40%);
  mobile uses `display: contents` + `order` properties. Filter section is always rendered
  for logged-in users (no feature flag).
- **`query_current_argument.php`** — fetches current argument data via stored procs.
  Builds `FILTER_PROFILES` temp table from `$_SESSION['filters']` before proc calls when
  filters are active. Affiliation filter uses SCOPE table UNION (not MEMBER lookup).
- **`functions.php`** — POST action handler (`buttonClicked` switch). Handles weighting,
  flagging, filter actions (`addOpinionFilter`, `addAffiliationFilter`,
  `removeOpinionFilter`, `removeAffiliationFilter`, `clearAllFilters`, `setTimeFilter`,
  `clearTimeFilter`), `switchGroup`, group search. Inserts SCOPE rows on every engagement
  action. `queueOpinionForSeeding` only triggers for public-affiliation users.
- **`search_affiliations.php`** — AJAX endpoint for the Filter section's group search.
  Returns public affiliations matching a query string.
- **`flesh_out.php`** — association-builder page (uses `getNeighborhood`).
- **`admin_tools.php`** — admin-only: merge arguments, Profile Picker config (`manual` /
  `auto`), flagged-args resolve, invite-code management, demo mode toggle.
- **`register.php`** — invite-code registration. Validates `INVITATION` (handles NULL
  `expiresAt` and `usesRemaining`); decrements `usesRemaining` on success.
- **`find_similar.php`** — full-text + SOUNDEX similarity search. Used by `flesh_out.php`
  (duplicate detection) and `Explore.php` (live search).
- **`neighborhood.php`** — lazy-load endpoint for Find ▸ Neighborhood list.
- **`includes/dbconnect.php`** — provides `$db`; defines `ALL_PUBLIC_AFF_ID = 12`; sets
  `@active_aff_id` session variable from `USER_PROFILE.activeAffiliationID` on every request.
- **Blog & standing pages** — two content types (posts argue; pages promise):
  - *Posts* (dated writing): `CONTENT` table → listed at `blog.php`, read at
    `post.php?slug=…`, authored in `admin_content.php`.
  - *Standing pages* (undated, amendable policy docs): `pages/*.md` in git →
    rendered by `page.php` at `/{slug}` (`.htaccess` rewrite; needs the
    `vestigette-htaccess.conf` AllowOverride enabled on the droplet). Front matter
    `title/description/status`; drafts admin-only; "Last amended" comes from the
    page's Amendment Log; anchor ids pinned with `{#id}`. Publication auto-enables
    cross-links (blog footer, masthead nav, persona badge → `/ai-policy-pledge`).
    **URLs and anchor ids are permanent once published; every edit gets an
    Amendment Log line.** See `pages/README.md` for the amend/publish workflow.
  - `robots.txt` (deployed to web root) blocks AI-training crawlers; the Data
    Promise page cites it as evidence. Keep the crawler list current.
- **`style_vestigette.css`**, **`script_vestigette.js`** — front end. Palette includes
  `--cddbYellow` (#d4a017) for flagged state and persona badge, `--cddbBlue` for filter badge.
- **`bots/persona_bot.py`** — browser-session bot that navigates the web UI to cast
  opinions and weights. Called by `process_seed_queue.py`.
- **`bots/process_seed_queue.py`** — drains `BOT_SEED_QUEUE`; pins bot `activeAffiliationID
  = 12` in DB before each run; invokes `persona_bot.py`.
- **`bots/seed_argument.py`**, **`bots/seed_cluster.py`** — generate seeding SQL / manage
  topic clusters.
- **`db/*_procedures.sql`** — canonical source for all stored procedures and triggers.

---

## Current feature set

- Weighted **Because / Therefore / Rebuttal**, **phrasing**, and **explication**
  endorsement (100% per user per type).
- **Groups / scoped engagement** — users operate under a group context; all actions are
  attributed via SCOPE tables. Filter view is independent of operating context.
- **Filter section** (always-on for logged-in users) — filter the argument graph by who
  accepts/rejects a specific argument, by group affiliation, and by time. Eye icon badge
  with count appears in the Argument section when filters are active; clicking jumps to
  the Filter section. Advanced overlay for time filters.
- **Argument merge** (admin) — `mergeArguments` conserves weights and writes
  `ARGUMENT_REDIRECT` so old URLs resolve.
- **Argument flagging** — users flag (offensive / phrasing-mismatch / duplicate-assoc /
  spam / incoherent / other); admin "Flagged Arguments" list resolves them.
- **Find section** — Last Visited, Recent Assertions, Go to ID (← / → / Popular), and a
  lazy-loaded **Neighborhood** list (`getNeighborhoodAll`, hop-3 adaptive). Open subsection
  persists via `localStorage`.
- **Admin Profile Picker** — `manual` (designated IDs) or `auto` (personas with an opinion
  on the current arg + you, by last-name initial). On desktop the bar is `position: fixed`
  at top; `body:has(#adminPickerBar)` nudges columns down `2rem`.
- **Persona seeding bot** — `BOT_SEED_QUEUE → process_seed_queue.py → persona_bot.py`
  (cron in `/var/www/bot`). Personas always operate under All Users - Public (affiliationID
  12). Only triggered by real users with a public active affiliation.
- **Persona retirement** — `assertOpinion` probabilistically retires personas as human
  engagement grows (S-curve: `(humanCount/100)²`; completes by ~100 human opinions).
- **Trending / Most Contested** — `getTrending` and `getMostContested` power Explore lists.
- **Persistent login** — 30-day rememberMe cookie via `REMEMBER_ME` table.
- **Invite-only registration** — `INVITATION` table; admin manages codes in admin_tools.
- **OG share cards** — `og_image.php` renders a dialectic card (verdict bar + strongest
  Because/Rebuttal). Headcounts/percentages gated behind `SOCIAL_PROOF_MIN_HUMANS` (25
  human opinions; personas excluded). `index.php` versions the og:image URL by a content
  hash so platforms re-scrape when the card's inputs change. **Hub mode**
  (`includes/hub_metrics.php`): when opinions concentrate on an argument's Therefore
  fan-out (T≥25; dialectic dormant: D<25 or T≥8D; ≥4 effective engaged children; T≥2×own
  opinions), the card swaps the two panels for a full-width Therefore panel listing the
  top 3 positions by engagement ("Which do you back?"). Fires on e.g. arg 1963 (2028
  candidates).
- **Demo mode** — admin toggle that suppresses iOS auto-zoom / scroll jumps for screen
  recording. Site-wide while enabled.
- **Donate button** — masthead on every page; mobile hamburger on left to avoid crowding.
- **AI-persona transparency badge** — yellow robot beside Argument ID when a persona has
  an opinion on the argument.
- **Group badge** — masthead shows current active group name when not on All Users - Public.

---

## Gotchas

- **MySQL ≠ MariaDB:** `DROP PROCEDURE IF EXISTS` + `CREATE`; no `CREATE OR REPLACE`.
- **fail2ban:** batch SSH connections — the deploy script already does, but ad-hoc commands
  can still trigger it (wait a few minutes if you hit "Connection refused").
- **ALL_PUBLIC_AFF_ID = 12** is the exception to almost every group rule. Private groups
  can only enter the filter via `switchGroup` auto-apply, not via manual group search.
- **`@active_aff_id`** must be set before any SCOPE insert. It's set by `dbconnect.php` on
  every PHP request; the bot explicitly calls `switchGroup` to pin it to 12.
- **100% invariant** — preserve it on any `ENDORSEMENT` change.
- **`impliedAssertion` trigger** — can't touch `ENDORSEMENT`; also inserts `SCOPE_OPINION`.
- **`rebalanceRecentRejections`** loops must stay scoped per `endorseType` (unscoped once
  caused an infinite loop).
- **OG card cache is in Apache's PrivateTmp** — `og_image.php` caches PNGs under
  `sys_get_temp_dir()`, which for Apache (systemd `PrivateTmp=true`) is
  `/tmp/systemd-private-*-apache2.service-*/tmp/agitate_og/`, NOT `/tmp/agitate_og`.
  Clear it there when verifying card changes (TTL 3600s otherwise).
- **Light panel vs dark header** — the expanded argument panel is light; the header is dark.
  Style for the surface you're on.
- **Bot personas** — profileIDs 1–26 must always have `activeAffiliationID = 12`. Both
  `process_seed_queue.py` (DB update) and `persona_bot.py` (switchGroup POST) enforce this.

---

## Deeper references

- **`bots/PERSONA_SEEDING_PROCESS.md`** — persona seeding workflow.
- **`DATA_CLEANUP_BACKLOG.md`** — known data-quality issues.
- **`db/*_procedures.sql`** — canonical proc/trigger source (8 files).
- **`db/seeds/`** — 84 historical seed SQL files (forensic reference, not re-run).
- **`deploy_droplet.sh`** — source of truth for which files ship and how.

---

## Roadmap / parked

- **Private groups** — schema approved (SCOPE tables already live; `AFFILIATION.public`
  flag exists); captains, private-invite flows, and group management UI not yet built.
- **Phase out persona input** per-argument as human engagement reaches threshold (retirement
  logic exists; the badge is the transparency bridge until then).
- **`useInstead` / `thereforeUseInstead` / `rebuttalUseInstead`** actions in `functions.php`
  call a stored procedure that was marked TODO/untested; buttons are wired in JS but the
  feature is incomplete.
- Cost monitoring & scale-back rules; branding pass.

_Last refreshed: 2026-07-08._
