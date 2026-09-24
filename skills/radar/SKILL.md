---
name: radar
description: 🛰 RADAR — ANBU's weekly moonshot deep-think. Fable reads every idea tagged track: moonshot plus the fresh scout signals, scores them on Rubric B with real searches, refreshes the "2026 shifts" list in RUBRIC.md, and pushes a first-mover alert for anything at 8 or above. Use for /radar, /radar <slug>, or "what could be big". Runs as a weekly cloud routine.
argument-hint: [slug]
allowed-tools: Read, Write, Edit, Bash, Agent, WebSearch, WebFetch, PushNotification
---

# /radar

This is the one place ANBU spends Fable tokens on discovery. Once a week, or on demand for one slug.

Vault: `~/developer/personal/idea-engine`. Rubric: `~/developer/personal/claude-anbu/RUBRIC.md`.

1. Candidates: with a slug, just that idea. Without, every `ideas/*.md` with `track: moonshot` and status `inbox` or `exploring`, plus a fresh `scout` (Haiku) MOONSHOT block.
2. Spawn one `strategist` (Fable) per candidate, at most 5 per run, with the idea path and the rubric. Each returns: Rubric B score with one line of evidence per criterion, the wedge MVP in one sentence, the "why now" in one sentence, who else is building it.
3. Write the score into the idea file (`moonshot:`), append a dated `## Radar` section with the evidence, and set status: 8+ `exploring`, 6-7 stays `inbox`, below 6 `parked` with the reason.
4. Refresh the "2026 shifts" list in `RUBRIC.md`: add a shift the searches surfaced, drop one that went mainstream. One in, one out, at most.
5. Alert: for every 8+, PushNotification "First-mover signal <score>/10: <title>. <why now>. Run /mission <slug> --yolo to start." One push per idea, never repeated for the same idea on a later run (check the Radar section for a prior alert line).
6. Append to `scanner/log.md`: `- <date> — radar: scored N, alerts: <slugs or none>`.
7. In a cloud routine: commit `radar: scored N (<date>)` and push. Locally: leave uncommitted.
8. Report: a table of candidate, score, verdict, why now. Then the one you'd bet a month on.
