# Agitate.org - Discourse Mapping Platform

**Project Restored:** May 2026  
**Original Deployment:** 2019-2021  
**Current Status:** Local Development on MAMP

---

## Vision & Mission

### The Big Picture
Agitate.org aims to become a foundational resource for humanity - as consequential as dictionaries, encyclopedias, and atlases - by mapping "the discourse" in a structured, navigable way. Like a topographic map helps users navigate terrain, Agitate helps users navigate how people think.

### Core Innovation
A novel method for capturing individual lines of reasoning and aggregating them into a collective consciousness, revealing the crux of arguments and helping people identify gaps in their own thinking.

### Long-term Goal
With sufficient users, provide a representative sample of aggregate human thought that could:
- Replace traditional polling
- Inform policy decisions
- Create a superior system for organizing governing bodies
- Chart courses for collective action

### Immediate Goals
1. **Improve user experience** with more content and consistency
2. **Lower barriers to content creation** - make it easier for users to add arguments
3. **Leverage LLMs** to generate placeholder "dummy" content for users to refine
4. **Encourage consensus** - bias users toward adopting and improving existing arguments rather than creating duplicates

---

## How It Works

### The Discourse Graph

Agitate models discourse as a **directed graph** where:

- **Vertices (Nodes)** = Arguments (core claims/positions)
- **Edges (Connections)** = Weighted relationships between arguments

### Three Types of Relationships

1. **Because** - Supporting argument (justification/evidence)
2. **Therefore** - Consequent argument (logical conclusion)
3. **Rebuttal** - Opposing argument (counter-claim)

### The Accept/Reject Dichotomy

Users first decide: **Do I accept or reject this argument?**

This choice determines what they can interact with:

#### **ACCEPTORS can:**
- Endorse or create phrasings
- Provide or endorse explication links
- Weight "Because" arguments (how strongly they support)
- Weight "Therefore" arguments (how strongly they follow)
- **CANNOT** interact with rebuttals

#### **REJECTORS can:**
- Weight "Rebuttal" arguments (how strongly they counter)
- **CANNOT** interact with phrasings, explications, because, or therefore

**Business Rule:** Only active opinions count. When a user toggles accept/reject, their previous opinions become inactive and their new opinions become active.

---

## Data Model

### Core Tables

#### **ARGUMENT**
- The shell/container for a claim
- Identified by `argumentID`
- Not tied to specific wording - that's what phrasings are for

#### **PHRASING_NEW**
- Different wordings for the same argument
- `putForthID` = unique identifier for this phrasing
- `argumentID` = which argument this phrasing represents
- `phrasing` = the actual text (varchar 300)
- `coinedBy` = user who created it
- Multiple phrasings can exist for one argument

#### **PUT_FORTH_NEW**
- Tracks which users endorse which phrasings
- `argumentID`, `putForthID`, `profileID` = composite key
- Endorsement tracking for phrasing preferences
- **NOTE:** Relationship between PUT_FORTH_NEW and PHRASE_ENDORSE is currently unclear and needs investigation

#### **PHRASE_ENDORSE**
- Another layer of phrasing endorsement tracking
- `phraseEndorseID` = auto-increment primary key
- `phrasingID` references `PHRASING_NEW.putForthID`
- **Needs clarification on how this differs from PUT_FORTH_NEW**

#### **ENDORSEMENT**
- The weighted edges of the discourse graph
- `argumentID` = the main argument being viewed
- `supportingArgID` = the related argument
- `endorseType` = 'Because', 'Therefore', or 'Rebuttal'
- `weight` = strength of relationship (how strongly it supports/follows/rebuts)
- `profileID` = who provided this endorsement
- `active` = whether this endorsement currently counts

#### **OPINION**
- Tracks accept/reject for each user on each argument
- `argumentID`, `profileID` = composite key
- `acceptance` = TRUE (accept) or FALSE (reject)
- Determines which interface/features user can access

#### **EXPLICATION**
- External links that explain/elaborate on arguments
- `argumentID` = which argument this explains
- `explicationType` = type of link (article, video, etc.)
- `link` = URL to external content

#### **USER_PROFILE**
- User accounts
- `profileID` = unique identifier
- Currently 59 users in database

---

## Current Database State (May 2026)

### Table Counts
- **ARGUMENT:** 219 arguments
- **USER_PROFILE:** 59 users
- **PHRASING_NEW:** 233 phrasings
- **PUT_FORTH_NEW:** 250 endorsements
- **PHRASE_ENDORSE:** 249 endorsements (incomplete - references missing phrasing data)
- **ENDORSEMENT:** 6,146 weighted connections
- **OPINION:** 1,276 accept/reject decisions
- **EXPLICATION:** 11 external links
- **AFFILIATION:** 11 (purpose unclear)
- **MEMBER:** 44 (purpose unclear)

### Known Data Issues
- PHRASE_ENDORSE only has 249 rows instead of full dataset (~1,789 in original backup)
- Missing phrasing records (only 233 exist, but endorsements reference up to ID 1762)
- Some table relationships unclear (PUT_FORTH_NEW vs PHRASE_ENDORSE)
- Data discrepancies visible in UI (unexpected information displaying)

---

## Technology Stack

### Current Setup
- **Server:** MAMP 5.7 (free version)
- **OS:** macOS Monterey 12.7.6
- **Hardware:** Intel MacBook Pro (early 2015)
- **PHP Version:** (matched to project needs)
- **Database:** MySQL 5.7
- **Ports:** Apache 80, MySQL 3306
- **Web Root:** Custom folder (not default MAMP htdocs)

### Key Technologies
- **Backend:** PHP, MySQL
- **Frontend:** JavaScript, HTML, CSS
- **Database:** MySQL with stored procedures

---

## File Structure & Key Files

### Entry Point
**URL Pattern:** `agitate.org/index.php?arg=[argumentID]`
- Default argument (if none specified): `argID = 75` (help page)
- Each argument has its own entry point URL
- Intended use: Share links to specific arguments from other platforms

### Core PHP Files

#### **index.php**
- Main UI foundation
- Uses multiple include/require_once statements
- Orchestrates page assembly

#### **query_current_argument.php**
- Fetches all data related to current argument being viewed
- Calls stored procedures via `mysqli_multi_query()`
- Provides:
  - Rate of acceptance for argument
  - Current preferred phrasing (aggregate of user endorsements)
  - Explication links
  - Related arguments (Because/Therefore/Rebuttal)
  - Weighted connections
- Recently fixed to handle empty result sets properly

#### **functions.php**
- Performs user actions/tasks
- Handles interactions with database

#### **dbconnect.php**
- Database connection configuration
- Loads from `includes/config.local.php`
- Creates `$db` connection object (aliased as `$mysqli`)

#### **includes/config.local.php**
```php
return [
    'environment' => 'DEVELOPMENT',
    'dblocation' => 'LOCAL',
    'servername' => 'localhost',
    'username' => 'root',
    'pass' => 'root',
    'dbname' => 'vestigette'
];
```

---

## Stored Procedures (25 total)

### Key Procedures

#### **getAssociated**
- Fetches related arguments (Because/Therefore/Rebuttal)
- Returns weighted aggregate connections
- Recently updated to use PHRASING_NEW table

#### **getDetail**
- Gets main argument details
- Returns current preferred phrasing
- Acceptance rate and assertion count
- Complex COALESCE logic for phrasing selection
- Recently updated to use PHRASING_NEW and correct column names

#### **getAltPhrasing**
- Returns alternative phrasings for current argument
- Sorted by endorsement count
- Recently updated to use PHRASING_NEW

#### **getOpinion**
- Gets current user's opinion (accept/reject) on argument
- Returns user's preferred phrasing

#### **getExplication**
- Fetches explication links for argument

#### **getUserAssociated**
- Gets user's specific endorsements on related arguments

### Other Procedures
- assertOpinion
- cosignMotJuste
- cosignPutForth
- foldInAssertion
- getAggrEndorse
- getAllTheRest
- getHeterodox
- getMostEndorsed
- newExplication
- newPutForth
- prepareForNewEndorse
- promoteExplication
- promoteMotJuste
- promotePhrasing
- promotePutForth
- rebalanceRecentRejections
- replacePutForth
- resolveOldWithNewEndorse
- updateCurrentPhrasing
- useInstead

---

## Current User Workflows

### Viewing an Argument
1. User navigates to `index.php?arg=X`
2. System loads argument details via stored procedures
3. Page displays:
   - Argument phrasing (aggregate preferred version)
   - Acceptance rate
   - Related arguments (Because/Therefore/Rebuttal)
   - Explication links (if any)
   - Alternative phrasings (if user has endorsed)

### Accepting an Argument
**User sees:**
- Interface to endorse or create phrasings
- Interface to add/endorse explication links
- Weighting controls for "Because" arguments
- Weighting controls for "Therefore" arguments
- **NO access to rebuttals**

**Current Issues:**
- Creating new content is too difficult
- Phrasing/explication interface inconsistent with weighting interface

### Rejecting an Argument
**User sees:**
- Weighting controls for "Rebuttal" arguments
- **NO access to phrasings, explications, because, or therefore**

### Toggling Opinion
When user switches between accept/reject:
- Previous opinions become inactive (`active = 0`)
- User sees different interface based on new opinion
- Can provide new opinions which become active

---

## Known Issues & Technical Debt

### High Priority
1. **Difficult to add new content** - Current UI makes creating arguments/phrasings too hard
2. **Missing phrasing data** - Only 233/1762 phrasings present
3. **Incomplete PHRASE_ENDORSE** - Only 249/1789 endorsements imported
4. **Unclear table relationships** - PUT_FORTH_NEW vs PHRASE_ENDORSE needs investigation
5. **Inconsistent interfaces** - Phrasing/explication UX different from weighting UX

### Medium Priority
6. **Data discrepancies** - Some information displaying incorrectly
7. **Navigation challenges** - Hard to discover what parts of graph exist
8. **No identity verification** - Need "one person, one vote" enforcement
9. **No merging mechanism** - Can't consolidate duplicate arguments
10. **No splitting mechanism** - Can't separate arguments that should be distinct

### Low Priority (Future)
11. **Stored procedure optimization** - Some may have inefficient queries
12. **Error handling** - Could be more robust
13. **Security review** - Authentication/authorization needs assessment

---

## Development Priorities (Ordered)

### Phase 1: Foundation (Current)
✅ **1.1 Restore local environment**
- MAMP installed and configured
- Database schema rebuilt
- Core data imported
- Stored procedures updated
- Application loading without errors

🔲 **1.2 Establish development best practices**
- Create comprehensive documentation (this file)
- Set up version control access
- Define deployment workflow
- Establish testing procedures

🔲 **1.3 Investigate data model ambiguities**
- Clarify PUT_FORTH_NEW vs PHRASE_ENDORSE relationship
- Document phrasing endorsement workflow
- Map complete user interaction flows

### Phase 2: Data Integrity
🔲 **2.1 Add database safeguards**
- Validate business rules in stored procedures
- Prevent acceptors from weighting rebuttals
- Prevent rejectors from endorsing phrasings
- Ensure opinion toggles properly activate/deactivate related data

🔲 **2.2 Build AI agent for data quality**
- Detect duplicate arguments
- Identify arguments that should be split
- Flag inconsistent data
- Suggest corrections

### Phase 3: Content Creation UX
🔲 **3.1 Improved interface for new content**
- Streamlined argument creation
- Easier phrasing submission
- Simpler explication linking
- Better related argument connection

🔲 **3.2 Unified interface for preferences**
- Consistent UX for phrasing endorsement
- Consistent UX for explication selection
- Match existing weighting interface design
- Nuanced preference expression

### Phase 4: LLM Content Generation
🔲 **4.1 Generate placeholder arguments**
- AI generates "Because" arguments (supporting)
- AI generates "Therefore" arguments (consequences)
- AI generates "Rebuttal" arguments (counter-claims)
- Users refine AI-generated content rather than creating from scratch

🔲 **4.2 Generate alternative phrasings**
- AI suggests different wordings for same argument
- Users select/refine preferred versions
- Reduces burden on users to create phrasings

🔲 **4.3 Generate explications**
- AI finds relevant external content
- AI generates explanatory text
- Users validate/improve suggestions

### Phase 5: Navigation & Discovery
🔲 **5.1 Graph visualization**
- Visual map of discourse
- Navigate by clicking on arguments
- See strength of connections visually

🔲 **5.2 Search & explore**
- Search for arguments by keyword
- Browse by topic/category
- Discover highly-weighted connections
- Find consensus vs. contested areas

### Phase 6: Scaling & Identity
🔲 **6.1 Identity verification**
- "One person, one vote" enforcement
- Prevent multiple accounts
- Maintain data integrity at scale

🔲 **6.2 Invite-only growth**
- High-integrity group invitations
- Gradual rollout strategy
- Community moderation

---

## Resources & References

### Database
- **Name:** vestigette
- **Location:** localhost:3306
- **Access:** root/root (local dev only)
- **phpMyAdmin:** http://localhost/phpMyAdmin

### Backups
- **Primary:** `/Users/Razzmatazz/dumps/Dump20201013-1/`
- **Alternative:** `/mnt/user-data/uploads/Cloud_SQL_Export_2023-03-01__09_47_23_.sql`
- **Note:** March 2023 backup appears most complete but not fully analyzed

### Code
- **Project Root:** `~/Library/Mobile Documents/com~apple~CloudDocs/Desktop/ArguAtlas Site Files`
- **Web Root:** Custom MAMP location
- **Config:** `includes/config.local.php`

### Documentation
- **This file:** PROJECT.md
- **Session transcript:** `/mnt/transcripts/2026-05-11-18-24-46-vestigette-database-restoration.txt`

---

## Open Questions & Investigations Needed

### Data Model
1. What is the exact relationship between PUT_FORTH_NEW and PHRASE_ENDORSE?
2. Why do both tables exist? Do they serve different purposes?
3. What are AFFILIATION and MEMBER tables for?
4. Are there other missing tables from original schema?

### User Workflows
5. What is the complete flow for endorsing a phrasing?
6. How does phrasing selection aggregate across users?
7. What determines the "current phrasing" shown?
8. How do users discover alternative phrasings?

### Technical
9. Which stored procedures are actually used vs. deprecated?
10. Are there any API endpoints or just web UI?
11. What JavaScript libraries/frameworks are used?
12. Are there any automated tests?

---

## Immediate Next Steps

### For Developer (Claude)
1. ✅ Create comprehensive PROJECT.md
2. 🔲 Investigate PUT_FORTH_NEW vs PHRASE_ENDORSE relationship
3. 🔲 Document complete phrasing endorsement workflow
4. 🔲 Create data model diagram
5. 🔲 Map user interaction flows

### For Project Owner
1. 🔲 Review and validate this documentation
2. 🔲 Answer open questions about data model
3. 🔲 Provide access to Git repository (if exists)
4. 🔲 Share any existing design documents
5. 🔲 Prioritize which Phase 2+ items to tackle first

### Together
1. 🔲 Set up version control workflow
2. 🔲 Define testing strategy
3. 🔲 Plan first feature implementation (likely Phase 3.1)
4. 🔲 Establish communication/collaboration process

---

## Success Metrics

### Short-term (Next 3 months)
- Application running stably on local dev
- Core workflows documented and validated
- Data integrity safeguards in place
- New content creation UX improved

### Medium-term (6-12 months)
- LLM content generation working
- Consistent interface for all preference types
- AI agent detecting/correcting data issues
- Small group of test users invited

### Long-term (1+ years)
- Scaled user base with quality discourse
- "One person, one vote" enforced
- Replacing traditional polling in some contexts
- Demonstrable impact on collective decision-making

---

*Document Version: 2.0*  
*Last Updated: May 23, 2026*  
*Next Review: [After Phase 3 UI work begins]*


---

## Recent Updates (May 15, 2026)

### Database Cleanup Completed
- ✅ Dropped orphaned PUT_FORTH_NEW table (never used)
- ✅ Dropped MOT_JUSTE and QUIBBLES_N_BITS (unused advanced system)
- ✅ Archived legacy PHRASING → PHRASING_ARCHIVE (1,762 phrasings preserved)
- ✅ Archived legacy PUT_FORTH → PUT_FORTH_ARCHIVE (103 cached phrasings)
- ✅ Renamed PHRASING_NEW → PHRASING (cleaner naming)
- ✅ Renamed putForthID → phrasingID (less confusing)

### Weighted Phrasing System Implemented
- ✅ Added weight column to PHRASE_ENDORSE (supports 0-100 weighting)
- ✅ Migrated all 1,762 phrasings from archive to active PHRASING table
- ✅ Added cache columns to ARGUMENT (currentPhrasing, currentPhrasingID)
- ✅ Created populatePhrasingCache() procedure
- ✅ Populated cache for 1,699 of 1,701 arguments

**Cache Statistics:**
- 136 arguments use phrasings from weighted user endorsements
- 1,563 arguments use fallback phrasings (oldest from PHRASING table)

### Updated Table Counts (May 15, 2026)
- ARGUMENT: 1,701 arguments (was 219 - miscount corrected)
- USER_PROFILE: 59 users
- PHRASING: 1,762 phrasings (complete dataset)
- PHRASE_ENDORSE: 249 endorsements (now with weight support)
- ENDORSEMENT: 6,146 weighted connections
- OPINION: 1,276 accept/reject decisions
- EXPLICATION: 11 external links

### Remaining Work for Weighted Phrasings
- Fix getOpinion procedure
- Fix newPutForth procedure
- Update getDetail to use weighted aggregation
- Update getAltPhrasing to show weighted scores
- Create endorsePhrasing() procedure for UI
- Create updatePhrasingCache() procedure
- Update assertOpinion to refresh cache on toggle
- Build UI for weighted phrasing endorsement

# Session Summary - May 15, 2026

## Accomplishments

### 1. Fixed Critical Bugs
- Login system working (fixed email mismatch, JavaScript errors)
- Weigh-in functionality operational (fixed script_vestigette.js errors)
- Identified correct file location

### 2. Established Git Workflow
- Cloned GitHub repository
- Created deployment script
- Committed working baseline
- Set up .gitignore for sensitive files

### 3. Database Investigation & Cleanup
- Mapped phrasing table relationships
- Dropped orphaned tables
- Archived legacy tables
- Renamed for clarity

### 4. Implemented Weighted Phrasing System
- Added weight column to PHRASE_ENDORSE
- Migrated 1,762 phrasings from archive
- Added cache to ARGUMENT table
- Created populatePhrasingCache() procedure
- Successfully cached 1,699 arguments

### 5. Documentation
- Created comprehensive PROJECT.md
- Created PHRASING_SYSTEM_ANALYSIS.md
- Created GIT_WORKFLOW.md

## Next Session Priorities

1. Fix stored procedures
2. Create endorsePhrasing() and updatePhrasingCache() procedures
3. Update assertOpinion to refresh cache
4. Test weighted phrasing system
5. Build UI for phrasing weights


## Current Work In Progress (May 18, 2026)

### Weighted Phrasing UI - 80% Complete

**Goal:** Allow users to weight multiple phrasings like they weight Because/Therefore/Rebuttal

**Completed:**
- ✅ Modal UI updated with Weigh In/Endorse/Reset buttons
- ✅ generatePhrasingLines() function created (displays phrasings with circles)
- ✅ bumpPhrasing() JavaScript function added to script_vestigette.js
- ✅ PHP handler for weighPhrasing action in functions.php
- ✅ endorsePhrasing() stored procedure

**In Progress:**
- ⚠️ getAltPhrasing procedure needs update to show ALL phrasings for argument (not just endorsed ones)
- ⚠️ Need to test full flow: click "Weigh In", weight phrasings, click "Endorse"

**Issue Found:**
Argument 50 has 5 phrasings but getAltPhrasing returns 0 results because all PHRASE_ENDORSE records have `active=0`. Need to modify getAltPhrasing to show all phrasings from PHRASING table, with endorsement data joined.

**Next Steps:**
1. Update getAltPhrasing to use LEFT JOIN on PHRASING (show all) instead of PHRASE_ENDORSE (only endorsed)
2. Test weighting flow on argument 50
3. Get user's current weights to pre-populate in UI
4. Handle case where user hasn't endorsed any phrasings yet

---

## Development Environment & Workflow

### Two-Location Pattern (Critical)

Every code change requires touching **two separate directories**:

| Location | Purpose |
|---|---|
| `/Users/Razzmatazz/vestigette-dev/` | Git repository — where edits are made |
| `/Users/Razzmatazz/localHost/root/` | MAMP web root — what the browser actually serves |

**After editing any file in `vestigette-dev/`, sync it to `localHost/root/` before testing:**
```bash
cp /Users/Razzmatazz/vestigette-dev/About.php /Users/Razzmatazz/localHost/root/About.php
```

Or sync multiple files at once:
```bash
cp /Users/Razzmatazz/vestigette-dev/{About,Explore,Profile,login}.php /Users/Razzmatazz/localHost/root/
```

**Never edit files directly in `localHost/root/`** — changes there won't be tracked by git.

### Git Repository

- **Remote:** GitHub (origin)
- **Branch:** `main`
- **Local path:** `/Users/Razzmatazz/vestigette-dev/`
- The repo is ~29 commits ahead of origin as of May 2026

### MAMP Configuration

- **Web root:** `/Users/Razzmatazz/localHost/root/` (custom, not default htdocs)
- **Apache port:** 80
- **MySQL port:** 3306
- **phpMyAdmin:** `http://localhost/phpMyAdmin`
- **display_errors:** ON (development mode — errors print inline in HTML output)

---

## Frontend Architecture

### Pages

| File | Purpose | Notes |
|---|---|---|
| `index.php` | Main argument viewer | Includes `query_current_argument.php` and `functions.php` |
| `About.php` | About / How-To | Static content only |
| `Explore.php` | Browse arguments | Calls `getMostEndorsed()` and `getAllTheRest()` stored procs |
| `Profile.php` | User profile / Most Heterodox | Calls `getHeterodox($profileID)` |
| `login.php` | Login form | Was historically broken (script commented out) — now fixed |
| `logout.php` | Session destroy | Redirects to login |

### CSS — `style_vestigette.css`

All pages link with **cache-busting**:
```php
<link rel="stylesheet" href="style_vestigette.css?v=<?php echo filemtime($_SERVER['DOCUMENT_ROOT'].'/style_vestigette.css'); ?>" />
```

**Desktop layout (`@media (min-width: 1200px)`):**

The page body becomes a flex container with a 3-row / 2-column grid. Layout uses fixed `vh` heights:

| Section ID | Column | Row | Width | Height |
|---|---|---|---|---|
| `#mastHead` | Right | 1 | 33% | 25vh |
| `#because` | Left | 1 | 66% | 25vh |
| `#rebuttal` | Right | 2 | 33% | 50vh |
| `#argument` | Left | 2 | 66% | 50vh |
| `#find` / `#filter` | Right | 3 | 33% | — |
| `#therefore` | Left | 3 | 66% | 25vh |

On desktop, **all panels are always visible** at their fixed viewport heights — the accordion expand/collapse has no visible effect. This is intentional, not a bug.

**Mobile layout (below 1200px):**

Sections stack vertically. Each `.accordion` section collapses to just its `<h2>` header. Clicking an `<h2>` expands that section's `.panel` (max-height animates from 0 → 338px) and collapses all others. This is handled by `accordionExpand()` in `script_vestigette.js`.

**Panel default state:**

Only the `#argument` panel starts with `class="panel expanded"` on secondary pages (About, Explore, Profile, login). All other panels start collapsed (`class="panel"` only) and expand on click.

### JavaScript — `script_vestigette.js`

Single JS file shared by all pages. Key functions:

- **`init()`** — Called on `DOMContentLoaded`. Attaches all handlers.
- **`resize(why)`** — Attaches `accordionExpand` click listener to every `.accordion` element. Uses a `listening` class guard to prevent duplicate listeners.
- **`accordionExpand(evt)`** — Handles accordion clicks. Guards against clicks originating inside `.panel, button, a, input, select, textarea, form` (returns early). Closes all panels, then opens the clicked one (unless it was already open).
- **`openNav()` / `closeNav()`** — Adds/removes `shownav` class on `#mastHead div`, which slides the mobile nav into view via CSS transition.

### Inline PHP Script Block (All Pages)

Every page has an inline `<script>` block that passes PHP variables to JS:

```javascript
let arg = <?php echo isset($arg) ? $arg : 'undefined'; ?>,
    profile = <?php echo isset($profile) ? $profile : 'undefined'; ?>,
    opinion = <?php echo isset($opinion) ? $opinion : 'undefined'; ?>,
    assoc = <?php echo isset($assocWeights) ? "JSON.parse(" + $assocWeights + ")" : 'undefined'; ?>,
    because = <?php echo json_encode(isset($because) ? $because : null); ?>,
    therefore = <?php echo json_encode(isset($therefore) ? $therefore : null); ?>,
    rebuttal = <?php echo json_encode(isset($rebuttal) ? $rebuttal : null); ?>;
```

---

## Critical Gotchas

### 1. `$because` / `$therefore` / `$rebuttal` Only Defined on index.php

These variables are populated by `query_current_argument.php`, which is **only included in `index.php`**. Secondary pages (About, Explore, Profile, login) do not include it.

**If you use `json_encode($because)` without an `isset()` guard on a secondary page**, MAMP's `display_errors = On` will inject a PHP Warning directly into the JavaScript block, producing output like:

```html
because = <br /><b>Warning</b>:  Undefined variable $because in ...line 65<br />
null,
```

This is a JavaScript syntax error that silently kills **all** JS on the page — accordion, nav button, everything stops working. Always use:
```php
<?php echo json_encode(isset($because) ? $because : null); ?>
```

### 2. CSS Changes Don't Apply on Mobile Until Hard Refresh

Mobile browsers aggressively cache CSS. The `?v=filemtime()` cache-buster on the stylesheet link handles this automatically when the file changes. To force a manual cache bypass while testing on device, append a dummy query param to the URL:
```
http://localhost/About.php?v=2
```
DuckDuckGo browser has a "Fire" button that wipes all cache in one tap.

### 3. Always Sync to localHost After Editing

Git commits in `vestigette-dev/` have **no effect** on what MAMP serves. You must `cp` the file to `localHost/root/` to see changes in the browser.

### 4. Do Not Re-Scope the Desktop CSS Grid

A past mistake scoped the `@media (min-width: 1200px)` desktop grid rules to `body.index-layout`, intending to make the accordion work on secondary pages. This broke the grid layout on all non-index pages. **The grid CSS must remain unscoped** — it applies to all pages by ID (`#because`, `#argument`, etc.), which exist on all pages.

---

## Session Summary — May 23, 2026

### Problems Solved

**1. Secondary pages had broken desktop layout**
Commit `5b3b197` incorrectly scoped the desktop CSS grid to `body.index-layout`, causing About/Explore/Profile to render sections as a single stacked column instead of the 3-row/2-col grid. Fix: reverted the CSS scoping and removed `class="index-layout"` from `index.php` body tag.

**2. All JavaScript dead on secondary pages (mobile and desktop)**
The inline `<script>` block on About.php, Explore.php, Profile.php, and login.php referenced `$because`, `$therefore`, `$rebuttal` without `isset()` guards. With MAMP's `display_errors = On`, PHP injected warning HTML into the JS block on every page load, causing a syntax error that prevented `script_vestigette.js` from initializing. Nothing clicked — not accordion headers, not the mobile nav button. Fix: added `isset()` guards to all three variables on all four pages.

**3. login.php had JS entirely commented out**
Historically, the entire `<script language="javascript" src="script_vestigette.js"></script>` block and the inline variable script on `login.php` were wrapped in `<!-- -->` HTML comment tags, disabling all JavaScript. Fix: removed the comment tags (done in the previous session cycle).

### Commits This Session
- `ca036aa` — Revert bad CSS scoping; restore panel defaults on secondary pages
- `b444b46` — Fix JS broken on secondary pages: guard undefined PHP vars in inline script