# Agitate — Creative Brief (Look & Feel)

_Creative north star and the design-token system for the front end
(`style_vestigette.css`). Read this before any visual/CSS work so changes pull in
one consistent direction. This is guidance, not a spec — when in doubt, favor the
**register** below over any single rule._

_Companion to [PROJECT.md](PROJECT.md) (what the product is) and the Logo Ring
Redesign note in Claude's memory (the mark itself)._

---

## 1. North star — the register

**Agitate should read as a measured reference work, not a bold poster.**

The product's job is to make people *trust* a map of contested arguments. Trust comes
from calm, consistency, and restraint — the feel of a well-set reference page or a
serious civic instrument — **not** from loud, saturated, shouting UI. The brand has
energy (the name "Agitate", the tri-color ring), but that energy is an **anchor and an
accent**, not the ambient temperature of every screen.

Guiding tension to hold in balance:

| Pull toward energy (brand) | Pull toward trust (register) — **usually wins** |
|---|---|
| Saturated tri-color, big type, full-bleed color bars | Calm neutral surfaces, restrained type, generous quiet space |
| "Poster" — grab attention | "Reference" — reward attention |

When a choice is between *louder* and *calmer*, default to calmer. Reserve intensity
for the few load-bearing moments (the logo; the semantic accept/reject/rebut colors).

**Anti-goal:** the "amateurish / slightly off" feeling that comes from *inconsistency* —
thirty near-identical greys, sixteen breakpoints, one-off font sizes. Consistency itself
is a primary trust signal here. Tokenization (§5) is how we buy it.

---

## 2. Hierarchy — what anchors, what recedes

On any screen the eye should land in this order:

1. **The logo** (tri-color ring + all-caps Cabin "AGITATE") — the anchor. It does not
   need to be the *biggest* thing, but nothing in the masthead area should out-shout it.
2. **Section headers** (Because / Rebuttal / Therefore / Find / Filter) — substantial and
   obviously tappable, but **below** the logo. They are chrome/navigation, not content.
3. **The argument claim** — the content. Set like a **post body on X / Bluesky**:
   **regular weight** (`--text-md` / 400) — the largest *content* on the page, but
   lighter than the chrome that frames it, and light enough to fit more text before the
   5-line clamp. Never headline-bold; that reads as shouting.

The mistake we corrected this session: section headers were larger **and** heavier than
the logo (32px/700 vs. logo 28px/500), so the chrome shouted over the anchor and the
claim competed with both. Fixed by dialing headers **down**, not lifting the logo.

Concrete result (mobile):

| Element | Before | After |
|---|---|---|
| Logo | 28px / 500 | 28px / 500 *(unchanged — the anchor)* |
| Section headers | 32px / **700** | **24px / 600** |
| Claim (`.arg-phrasing`) | 21px / 700 | **18px / 400** (`--text-md`, true microblog post weight) |

---

## 3. Type system

Self-hosted **Cabin** for the logo wordmark (all-caps, tracked). Helvetica/system stack
for everything else.

**Scale** (rem tokens in `:root`; snap new type to these, don't invent sizes):

```
--text-2xs .7  --text-xs .8  --text-sm .9  --text-base 1
--text-md 1.15 --text-lg 1.5 --text-xl 1.9 --text-2xl 2.4 --text-3xl 3
```

**Weights:** `--weight-regular 400 · medium 500 · semibold 600 · bold 700`.
Bold (700) is now rare by design — it reads as shouting. Prefer 500–600 for emphasis.

**Section headers** use a deliberately restrained treatment: `--text-lg` / `600`, in a
tall colored bar (see §4). Height + weight — not size, and never a chevron — signal
"expand/collapse".

_Migration status: tokens are defined; the hierarchy elements are on-token. Remaining
one-off sizes get snapped to the scale as files are touched (a cleanup pass, not a
milestone)._

---

## 4. Color system

**Color is semantic and load-bearing — not decoration.** The three relationship colors
are the product's grammar and must stay legible and consistent:

- **Because → blue** (`--because`, `#2d58a8`)
- **Rebuttal → red** (`--rebuttal`, `#af1a17`)
- **Therefore → green** (`--therefore`, `#10a020`)
- **Accent / persona / highlight → gold** (`--cddbYellow`, `#d4a017`)

These live as full-bleed section bars today. That saturation is the loudest brand
element left; it's *acceptable* because the color is meaningful, but it's the main place
where the "poster" register still fights the "reference" register — an open question
(§7), not a settled good.

### Neutral scale (the workhorse)

Collapsed ~30 one-off greys into an **11-step cool-neutral ramp** (subtle blue tint —
reads modern/reference-grade and complements the blue-heavy brand). Each old grey was
snapped to its nearest **lightness**, so contrast/role was preserved.

```
--n-0  #ffffff   --n-50 #f7f8fa  --n-100 #eef0f3  --n-200 #dcdfe3
--n-300 #c4c8ce  --n-400 #9aa0a8 --n-500 #6b7079   --n-600 #4b5158
--n-700 #2e3339  --n-800 #1a1c1f --n-900 #0e0e0e
```

Rough role map: **50–100** surfaces/fills · **200–300** borders/dividers · **400**
faint/disabled · **500** muted text · **600–700** secondary/strong text · **800–900**
near-black surfaces & text. Legacy `--cddbGrey / --cddbLiteGrey / --percentage_bg` now
alias into this scale.

> **Because everything references the tokens, the neutral hue is a one-line tune.** If
> the cool tint ever reads too blue, change the `--n-*` values in `:root` and the whole
> site follows. Same leverage applies to every token category.

### Semantic accents (done)

Beyond the four brand colors, ~20 one-off reds/blues/greens/golds were rationalized into
**semantic tokens** (values preserved — named, not restyled), because they carry *meaning*
that lightness-snapping would erase:

- **`--danger` / `--danger-hover` / `--danger-bg` / `--danger-border`** — delete/error.
- **`--success` / `-bg` / `-border`**, **`--info` / `-bg`** — status messages.
- **`--link` / `--link-hover`** — bright-blue action button.
- **`--because-dark` / `--rebuttal-dark` / `--gold-dark`** — readable dark "inks" of the
  brand hues, for text/edges sitting on tinted fills.
- **`--surface-dark` / `--surface-dark-2` / `--on-dark-accent`** — the dark weighting-UI
  (joystick) theme.

**Left intact on purpose:** the `.picker-band-0..6` diverging scale (blue → center → red)
is a coherent, single-use *data ramp*; tokenizing it would add indirection with no
control-point gain. Treat any future diverging/data scale the same way — a labeled ramp,
not scattered semantic tokens.

### Entry & front-facing pages (login, register — the template for About/Explore/Profile)

The black full-bleed section bars are **app-interior chrome** — right for the dense weighing
UI, wrong for a front door. Reusing them on the login/register pages is what read as
"amateurish"; it was a violation of §1, not a gap in it. Entry pages get the **opposite**
treatment: **light cards** (white, `--n-200` border, soft shadow, `--radius-lg`, dark-text
headings — no black bars), generous whitespace, a short welcoming lead, `--because` pill
CTAs, and — most importantly — **trust signals featured, not buried.** Agitate's trust story
*is* the pitch: invite-only / **one real human**, nonprofit / never monetized, and the **Data
Promise** (never sold, never advertised against, never AI-trained, aggregate-only, deletable,
*binding*). Surface it; don't footnote it. Echoing "one real human" across the page is
deliberate reinforcement — it's the core promise of how inputs are measured, not redundancy
to trim. Shipped on login + register (2026-07-28), scoped to `.login-main`/`.reg-main`;
About / Explore / Profile still wear the old chrome and are the next candidates.

---

## 5. Tokenization principle

**One idea = one token = one control point.** Every raw value that repeats is a future
inconsistency and a missed global lever. The categories, in priority order:

1. **Type** — scale + weights ✅ defined
2. **Color** — 11-step neutral scale ✅ done · semantic accents ✅ done
3. **Spacing** — 14-step `--sp-*` scale ✅ done
4. **Radii** — `--radius-*` scale ✅ done
5. **Breakpoints** — canonical **480 / 640 / 768 / 1200** ✅ done

Migrate by **snapping to the nearest existing intent** (preserve the current look), then
harmonize by tuning the token, not the usages.

**Spacing** (`--sp-N`, where `N` = rem × 100 — so `--sp-50` = `0.5rem`): steps `10 20 25
30 40 50 60 75 100 125 150 200 300 600`. High-frequency values were kept exact; only rare
oddballs (0.35/0.45/0.55/0.65/0.9/1.1…) snapped to the nearest step. Applied **only inside
`padding` / `margin` / `gap`** — negatives and `calc()`/`var()` left alone (can't `-var()`).
Positioning offsets (`top/left`) and sizes (`width/height`) are deliberately **not** on
this scale.

**Radii:** `--radius-sm 4px` (was 3/4/5px/0.25rem) · `--radius-md 7px` (6/7/8px/0.55rem) ·
`--radius-lg 11px` (11/12px) · `--radius-pill 999px` (2rem/34px pill buttons & toggles) ·
`--radius-circle 50%`. Bare `0` stays inline.

**Breakpoints:** canonical **480 · 640 · 768 · 1200** (min/max pair at N-1/N — e.g. 767/768,
1199/1200; CSS can't use `var()` in media conditions, so these are standardized values, not
literal tokens). `<640` small-phone tweaks · `≥768` nav-under-logo (was 800) · `≥1200` the
two-column desktop layout. Consolidated from 7 ad-hoc values (merged 759+800→768, 680→640).

**The 1200 two-column ↔ one-column reflow is load-bearing design, not just responsiveness.**
`#left-col`/`#right-col` are `display:contents` below 1200 (their sections stack in one column
by flex `order`); at ≥1200 they become real **60/40 flex columns — left = the reasoning spine
(because → argument → therefore), right = masthead + rebuttal + find + filter.** That
spine-vs-rebuttal split visually suggests the shape of the argument graph — **preserve it
through any future breakpoint change.** In the right column, **rebuttal keeps priority
(`flex: 2`)** and Find/Filter (a mutually-exclusive pair) share the space beneath it; expanded
Find is `flex: 1 1 0` so a long result list scrolls inside its own share instead of ballooning
on `flex-basis:auto` and collapsing rebuttal (a bug fixed 2026-07-28).

---

## 6. Working method (how we make visual changes)

- **Faithful previews only — no hand-built mockups.** Preview *real* CSS on the *live*
  page at the **two real layouts**: mobile (hamburger) and desktop (nav-under-logo).
  Inject/resize the actual page; measure computed styles to verify (don't eyeball).
- **Two browsers:** the in-app preview browser is *Claude's* view (user can't see it);
  the user's Chrome is what *they* see. Confirm which surface a preview is on.
- **Token-first de-risks review:** ship the migration to tokens, then tune values
  globally — the user reacts to a live result, and adjustments are one-liners.
- **Deploy:** `git push origin main`, then `./deploy_droplet.sh php` (droplet has no git
  repo; the script is the source of truth for what ships). CSS is **not** linted on
  deploy — verify token references resolve by looking at a live grey-heavy surface.
- Keep intensity for the anchor and the semantic colors; everywhere else, calmer.

---

## 7. Open threads / creative questions

- **The full-bleed saturated section bars** are the last big "poster" element. Do they
  soften toward the reference register (color as an accent/edge rather than a saturated
  full-width fill) while staying semantically legible? Deliberately unresolved.
- **All token categories are now done** — type, color, spacing, radii, breakpoints. Future
  visual work should consume the existing tokens/scales rather than introduce new raw values.
- **Other front-facing pages** (About, Explore, Profile) still wear the app's black
  section-bar chrome — the login/register redesign (§4) is the template for bringing them
  into the welcoming, trust-first entry style. Explore is also thin on content.

---

_Last refreshed: 2026-07-28. Update the concrete numbers when they change; keep the
register (§1) stable — it's the part that shouldn't drift._
