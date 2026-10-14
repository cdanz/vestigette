# Agitate

**Live at [agitate-discourse.org](https://agitate-discourse.org)** — an open civic-discourse platform that maps public debate into a structured, navigable argument graph, so a reader can see *why* people accept or reject a claim, what follows from it, and what rebuts it, and weigh in themselves.

Designed, built, and operated solo by [Craig Danz](https://www.linkedin.com/in/craig-danz) since 2020 — product, backend, frontend, data model, deployment, all of it.

## The model

- **Argument** — a claim (a shell with an ID, independent of specific wording).
- **Phrasing** — an alternate wording of an argument; users weight which phrasing states it best.
- **Opinion** — each user accepts or rejects an argument. Accepting unlocks **Because** (supporting reasons) / **Therefore** (consequences) weighting; rejecting unlocks **Rebuttal**.
- **Explication** — an external link that elaborates an argument, also weighted.
- **Personas** — a small set of LLM-driven accounts that seed low-engagement arguments with dialectical scaffolding (both sides represented), retiring probabilistically as real human engagement arrives.

## Engineering notes

- **Backend:** PHP + MySQL (deliberately framework-free — a choice made early on to actually learn the fundamentals rather than assemble a site from pre-built pieces).
- **Bots/automation:** Python, calling the Anthropic API for persona-driven content seeding, dedup, and candidate-argument generation.
- **Payments:** Stripe (hosted Checkout for donations).
- **Frontend:** vanilla JS/CSS — custom graph visualization, a press-and-hold "joystick" weighting control, no UI framework.
- **AI-assisted development:** since 2026, feature work is directed through Claude Code — plain-language problem descriptions through to shipped, iteratively refined implementation — used as a real part of the delivery workflow, not a novelty.

## Scale

- **370 commits** since **August 2020**.
- **~27,890 lines** of PHP/Python/JS/CSS (hand-written application code; excludes SQL schema/seed files and JSON data).

## A note on content

This is a tool for mapping *contested* claims, so the subject matter deliberately includes politically and socially charged topics (immigration, abortion, policing, and similar). That's the product working as intended, not an accident of what got seeded first — a discourse-mapping tool that avoided hard topics wouldn't be testing the thing it's actually for.

---

Questions about the project or the engineering behind it: [craigdanz@gmail.com](mailto:craigdanz@gmail.com).
