---
name: scan
description: 🔭 SCAN — ANBU's dual-track scout. Cheaply pulls signals (HN, GitHub, Product Hunt, Hugging Face) and files up to 3 weekend-build ideas plus up to 2 moonshot signals into the vault. Token-frugal by design; the scout agent does the fetching. Use for /scan or "scan for ideas". Runs as a cloud routine 3x a week.
allowed-tools: Read, Write, Edit, Bash, Agent, WebSearch, PushNotification
---

# /scan

Vault: `~/developer/personal/idea-engine` (in a cloud routine it is the working directory). Read `PROFILE.md` and `scanner/SOURCES.md`. `ls ideas/` for dedup.

1. Spawn `scout` (Haiku) with the paths. It returns a WEEKEND block and a MOONSHOT block, 10 lines each, plus which sources were blocked.
2. WEEKEND track: pick at most 3 lines that match a niche, are not in the vault, trip no anti-pattern, and imply a weekend-sized adjacent tool. Create `ideas/<YYYYMMDD-slug>.md` from `ideas/_TEMPLATE.md` at `status: inbox`, `track: weekend`, `source: scan:<src>`, with a one-line feasibility note. No deep research here.
3. MOONSHOT track: pick at most 2 lines that name a new capability, protocol, or platform shift. Score each on Rubric B from `~/developer/personal/claude-anbu/RUBRIC.md` using only what the line and one WebSearch tell you. 6 or above: create the idea file with `track: moonshot`, `moonshot: <score>`, `status: inbox`. 8 or above: `status: exploring` and send a PushNotification: "First-mover signal <score>/10: <title>. Run /radar <slug>." Below 6: one line in the log only.
4. Add rows to `INDEX.md` Inbox (or Exploring for 8+).
5. Heartbeat, always, even with zero adds: append `- <YYYY-MM-DD> — <scheduled|manual>: added N → <slugs or "nothing new">; blocked: <sources or none>` to `scanner/log.md`.
6. In a cloud routine: commit `scan: add N candidate ideas (<date>)` or `scan: heartbeat, nothing new (<date>)` and push to `origin master`. Locally: leave the changes uncommitted and say so.
7. Digest, 4 lines: what is trending, weekend adds, moonshot adds with scores, the one you'd build this weekend.

Hard caps: 3 weekend, 2 moonshot. Never manufacture filler. A blocked source is reported, not silently skipped.
