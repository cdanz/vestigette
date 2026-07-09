---
title: Data Promise
description: Agitate's binding commitments on your data — what we collect (exhaustively), what your browser talks to (only us), and what we will never do (sell, advertise, or train AI on your words).
status: published
---

What you believe, and why, is among the most sensitive data there is. Agitate
exists to map beliefs, so we hold ourselves to a stricter standard than the
platforms we hope to replace. Agitate is run on a non-profit basis and funded
by donations. There is no business model here that improves when you are
watched more closely — and there never will be.

This page is written to be checked, not skimmed. Every claim below describes
what the software actually does, and the page follows the same amendment rules
as our [AI Policy and Pledge](/ai-policy-pledge): promises can get stricter
without notice, but never looser without a dated, explained amendment.

## The short version {#the-short-version}

1. We collect the minimum needed to run the platform, and this page lists **all
   of it**.
2. Your browser talks to **agitate-discourse.org and no one else**. No
   analytics, no trackers, no ad tech, no third-party fonts or scripts.
3. Your words are **never sold, never advertised against, and never used to
   train AI** — ours or anyone's.
4. Your individual opinions are shown to other users **only in aggregate**.
5. You can get a copy of your data, or have it deleted, by asking. No process,
   no friction, no questions.

## What we collect, exhaustively {#what-we-collect}

1. **Account:** first name, last name, email address, and a bcrypt hash of your
   password. That is the entire registration form. We never see or store your
   password in plain text.
2. **Your contributions:** the arguments, phrasings, and explication links you
   add; your accept/reject opinions and endorsement weights; flags you raise;
   the groups you join. This is the product itself — it's what you came here to
   create.
3. **Operational data:** a session cookie while you're logged in; an optional
   30-day "keep me logged in" token (a random value, set only if you tick the
   box, marked Secure and HttpOnly); and standard web-server logs, which
   include IP addresses and are **automatically deleted within 15 days**.

That's the whole list. We do not collect location, contacts, device
fingerprints, browsing history, or behavioral profiles. We don't want them.

## What your browser talks to {#what-your-browser-talks-to}

Loading Agitate makes requests to **agitate-discourse.org only**. Zero
analytics scripts, zero tracking pixels, zero social-media embeds, zero
third-party CDNs — even our fonts are served from our own server. We set
exactly two cookies, both first-party: the session cookie and the optional
login token above. There is no cookie banner because there is nothing to
confess.

Two deliberate, narrow exceptions:

1. **Donations.** If you click Donate, checkout happens on Stripe. Stripe sees
   what a payment processor must see; we never see your card details. This
   happens only when you choose it.
2. **Link previews.** When an argument links to an outside article, **our
   server** — never your browser — fetches the preview (via noembed.com or
   microlink.io). Those services see the linked URL and our server's address.
   They never see you.

## What is public, and what stays yours {#what-is-public}

Arguments, phrasings, and explication links are public content — the shared
map everyone is building. Your individual accept/reject choices and weights are
stored under your account but surface to other users only as **aggregates**:
percentages and counts, never "this person believes that."

Two honest caveats, because a promise you can't stress-test is marketing:

- While the community is small, an aggregate over very few people can still
  hint at individuals. We won't pretend arithmetic away; this fades as Agitate
  grows.
- Engagement you attribute to a **private group** is visible only inside that
  group. It is never surfaced publicly, never searchable, and never included in
  public aggregates.

## AI and your words {#ai-and-your-words}

Nothing you write on Agitate is used to train any AI model — not our Seed
Users' model, not anyone else's. We block known AI-training crawlers in
[robots.txt](https://agitate-discourse.org/robots.txt), which you can inspect
at any time. Our own AI personas read only the public argument graph they are
scaffolding — never private-group content, user profiles, or behavioral data.
The full rules governing them are in the
[AI Policy and Pledge](/ai-policy-pledge).

## Money and incentives {#money-and-incentives}

Agitate runs on donations. We will never sell or rent user data, never show
advertising, and never adopt a revenue model that monetizes your attention or
engagement. If how Agitate is funded ever changes, this page changes **first**,
with a dated amendment — before, not after.

## Your data, your call {#your-data-your-call}

Ask, and within 30 days we will:

- **Give you a copy** of everything attached to your account, or
- **Delete your account** — your name, email, credentials, opinions, and
  weights. One honest limit: arguments and phrasings are collective structure,
  like posts quoted in a public mailing list. Deleting your account severs the
  link between you and them; the public claims themselves may remain where
  others have built on them.

Deleted data also ages out of our backups, which are retained for at most 90
days.

To make either request, contact
[@agitate-discourse.bsky.social](https://bsky.app/profile/agitate-discourse.bsky.social)
on Bluesky.

## Security, honestly {#security-honestly}

Passwords are bcrypt-hashed. Everything travels over HTTPS. The persistent
login token is random, opt-in, and flagged Secure and HttpOnly. Our best
security feature, though, is structural: **a page with no third-party scripts
has no third-party script to be compromised, and data we never collected can't
leak.** If we ever suffer a breach affecting user data, you will hear it from
us — promptly, specifically, and on this page.

## Legal requests {#legal-requests}

We disclose user data only under valid legal process, read as narrowly as the
law allows, and we will notify affected users unless we are legally barred from
doing so. Data minimalism is the real protection here: the most privacy-
respecting answer to a demand for data is to have very little to hand over.

## Amending this promise {#amending-this-promise}

This page is never silently edited. Every substantive change is recorded below
with a date and a one-line rationale. Commitments may become stricter without
notice; they become looser only with a dated amendment explaining why.

---

## Amendment Log {#amendment-log}

- **2026-07-09** — Data Promise published.
