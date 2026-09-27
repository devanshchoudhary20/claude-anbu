---
name: prospect
description: ⛏ PROSPECT — ANBU's big-track engine. Fable reads pain threads, issues ranked by reactions, newsletters, blogs, vendor changelogs, and funding news, synthesizes SaaS ideas through four lenses, gates them on zero-ops, scores them on Rubric B, files up to 3, rescores existing big ideas, and writes a weekly brief. Use for /prospect, /prospect <slug>, "find big ideas", "what could be big", "what's worth building in AI right now". Runs weekly as a cloud routine.
argument-hint: [slug | steer]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Agent, WebSearch, WebFetch, PushNotification
---

# /prospect

Follow `~/developer/personal/idea-engine/scanner/PROSPECT.md` exactly. The cloud routine `idea-prospect` reads the same file, so change the procedure there, never here.

Local-run differences:
- With a slug in `$ARGUMENTS`: run only step 5 (rescore) and step 6 for that idea.
- With a steer in `$ARGUMENTS` (a buyer, vertical, or shift): bias the gather and synthesis steps toward it; every other rule holds.
- Run the four signal classes as four parallel `general-purpose` agents on `model: sonnet`, each handed its class section of `scanner/SOURCES.md`, each returning at most 15 signal lines. Fable does the clustering, synthesis, gate, and scoring itself.
- Leave the vault uncommitted and say so.
