---
name: weekend
description: 📅 WEEKEND — triage the vault, validate a shortlist with real searches, and pick one idea for /mission. Use for /weekend [steer] or "what should I build this weekend".
argument-hint: [focus or constraint]
allowed-tools: Read, Write, Edit, Bash, WebSearch, WebFetch, Glob, Grep, AskUserQuestion
---

# /weekend

Vault: `~/developer/personal/idea-engine`. Rubric A in `~/developer/personal/claude-anbu/RUBRIC.md`. Optional steer: `$ARGUMENTS`.

1. Read `INDEX.md` and `PROFILE.md`. The inbox may hold 50+ scanner rows: triage by title only. Keep a shortlist of 5 that match the steer, a niche, and freshness; mark the rest as untouched, not parked.
2. Rank the 5 to a shortlist of 2-3. Validate each with WebSearch: competitors, does it exist, pricing signals. Score on Rubric A. Move winners to `status: validated` with the score and stack; park clear losers with the reason. Update `INDEX.md`.
3. Present the table and ask the user to pick one with AskUserQuestion. Do not start building.
4. On the pick: `status: building`, move the row to Building, and say: run `/mission <slug>`. Leave the vault uncommitted.
