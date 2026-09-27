---
name: idea
description: 💡 IDEA — capture a new idea into the vault with a fast gut-check. No web research at capture time. Use for /idea <one-liner> or "add this idea".
argument-hint: <one-line idea> [--big]
allowed-tools: Read, Write, Edit, Bash
---

# /idea

Vault: `~/developer/personal/idea-engine`.

1. Read `PROFILE.md`. Slug: `YYYYMMDD-short-kebab` from `date +%Y%m%d`.
2. Create `ideas/<slug>.md`, `source: me`, `status: inbox`, today's date. Default: from `ideas/_TEMPLATE.md` with `track: weekend`, filling title, one-liner, problem, first-cut v1 scope, niche. With `--big`: from `ideas/_TEMPLATE_BIG.md` with `track: big`, filling title, one-liner, buyer and job, and a first guess at why now and the ops check; leave the rest for `/prospect <slug>` to research.
3. Gut-check in one paragraph from your own knowledge: the weekend hard constraints, or for `--big` the Rubric B gate (SaaS, zero-ops, solo liability), plus the anti-patterns. An obvious park gets `status: parked` with the reason, but is still saved.
4. Add a row to the Inbox in `INDEX.md`.
5. Reply with the slug, the verdict in 2-3 lines, and one sharpening question if the idea is fuzzy. Do not commit.
