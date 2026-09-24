---
name: idea
description: 💡 IDEA — capture a new idea into the vault with a fast gut-check. No web research at capture time. Use for /idea <one-liner> or "add this idea".
argument-hint: <one-line idea> [--moonshot]
allowed-tools: Read, Write, Edit, Bash
---

# /idea

Vault: `~/developer/personal/idea-engine`.

1. Read `PROFILE.md`. Slug: `YYYYMMDD-short-kebab` from `date +%Y%m%d`.
2. Create `ideas/<slug>.md` from `ideas/_TEMPLATE.md`: title, one-liner, problem, first-cut v1 scope, niche, `source: me`, `status: inbox`, `track: weekend` (or `moonshot` with `--moonshot`), today's date.
3. Gut-check in one paragraph from your own knowledge: hard constraints, anti-patterns. An obvious park gets `status: parked` with the reason, but is still saved.
4. Add a row to the Inbox in `INDEX.md`.
5. Reply with the slug, the verdict in 2-3 lines, and one sharpening question if the idea is fuzzy. Do not commit.
