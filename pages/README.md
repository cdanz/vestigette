# Standing pages

Undated, amendable policy documents — a second content type beside blog posts.
**Posts argue; pages promise.** Posts live in the `CONTENT` table and are listed
on `/blog.php`; standing pages live *here* as markdown files in git, rendered by
`page.php`, and never appear in the post index (or any future feed — if RSS is
ever added, build it from `CONTENT` only).

Each `<slug>.md` here is served at **`https://agitate-discourse.org/<slug>`**
(via the `.htaccess` rewrite). Git history is the verifiable twin of each
page's Amendment Log — that's the whole point of keeping these in the repo.

## File format

```markdown
---
title: Data Promise
description: One-sentence summary used for og:description / meta description.
status: draft        # or: published
---

Body in Markdown…
```

- `status: draft` → visible to admins only (404 for everyone else).
- Headings h2–h4 get anchor ids automatically; **pin them explicitly** with
  `## Heading text {#pinned-id}` before first publication.

## Iron rules (the public commitment)

1. **URLs never change** once published. Renaming a page requires a permanent
   301 in `.htaccess`.
2. **Anchor ids never change** once published — pin every id so rewording a
   heading can't silently move it.
3. **No silent edits.** Every change appends a line to the page's
   `## Amendment Log` section (reverse-chronological):

   ```markdown
   - **YYYY-MM-DD** — What changed, in one line.
   ```

   The date shown at the top of the page ("Last amended:") is read from the
   newest log entry, so forgetting the log line means the page misrepresents
   itself — don't skip it.

## To amend a page

1. Edit the `.md` file.
2. Add the Amendment Log line (top of the log, dated today).
3. Commit (the commit is the log entry's verifiable twin).
4. `./deploy_droplet.sh php`

## To publish a page for the first time

1. Finish the content; remove the stub blockquote; pin all anchor ids.
2. **Constitution only:** audit every ⚠-marked clause against actual bot
   behavior (`bots/persona_bot.py`, `bots/process_seed_queue.py`, the
   `queueOpinionForSeeding` trigger in `functions.php`). Build or strike any
   clause the code doesn't honor — never publish a promise the cron job is
   quietly breaking. (Data Promise: verify `/robots.txt` is live first.)
3. Flip `status:` to `published`, add an Amendment Log line ("Published."),
   commit, deploy.
4. Publication automatically lights up: the page in blog footers, the platform
   masthead links, and (for the constitution) the persona badge becoming a
   link to `/constitution`.
5. Announce with a short dated *post* on the blog that links to the page.
