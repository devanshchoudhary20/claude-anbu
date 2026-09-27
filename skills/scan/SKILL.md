---
name: scan
description: 🔭 SCAN — ANBU's weekend-track scout. Cheaply skims HN, GitHub, and Reddit titles, files up to 3 weekend-build ideas into the vault, and hands bigger-than-a-weekend signals to /prospect via scanner/leads.md. Token-frugal by design; the scout agent does the fetching. Use for /scan or "scan for weekend ideas". Runs weekly as a cloud routine.
allowed-tools: Read, Write, Edit, Bash, Agent, WebSearch
---

# /scan

Vault: `~/developer/personal/idea-engine` (in a cloud routine it is the working directory). Read `PROFILE.md` (Weekend track and anti-patterns) and the Weekend track section of `scanner/SOURCES.md`. `ls ideas/` for dedup.

1. Spawn `scout` (Haiku) with the paths. It returns a WEEKEND block of at most 10 lines, a LEADS block of at most 5, and which sources were blocked.
2. Pick at most 3 WEEKEND lines that match a niche, are not in the vault, trip no anti-pattern, and imply a weekend-sized adjacent tool. Create `ideas/<YYYYMMDD-slug>.md` from `ideas/_TEMPLATE.md` at `status: inbox`, `track: weekend`, `source: scan:<src>`, with a one-line feasibility note. No deep research here.
3. Append each LEADS line to `scanner/leads.md` as `- <YYYY-MM-DD> <P|S> <title> <url> <why>`. Do not file or score them; `/prospect` reads them weekly.
4. Add rows to the `INDEX.md` Inbox.
5. Heartbeat, always, even with zero adds: append `- <YYYY-MM-DD> — <scheduled|manual>: added N → <slugs or "nothing new">; leads: N; blocked: <sources or none>` to `scanner/log.md`.
6. In a cloud routine: commit `scan: add N candidate ideas (<date>)` or `scan: heartbeat, nothing new (<date>)` and push to `origin master`. Locally: leave the changes uncommitted and say so.
7. Digest, 3 lines: what is trending, weekend adds, leads handed to prospect.

Hard cap: 3 weekend ideas. Never manufacture filler. A blocked source is reported, not silently skipped.
