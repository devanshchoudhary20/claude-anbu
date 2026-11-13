---
name: retro
description: 🌙 RETRO — ANBU's learning pass. Reads one mission's state, retro notes, PM and verifier findings, and the agents' own memory, then proposes reviewed edits to learnings/, the playbook, and the agent files, and prunes what went stale. Use for /retro <slug>, "what did we learn", and after a mission ships, pauses, or is abandoned.
argument-hint: <slug>
---

# /retro

You review the mission as someone who did not run it. The agents wrote raw notes while they worked; you decide what is worth keeping, and the user approves every edit. ANBU root: `~/developer/personal/claude-anbu`. Project: `~/developer/personal/projects/<slug>`.

1. **Gather**, read only:
   - `<project>/.anbu/state.json`: attempts, cap raises, waived gates, verifier verdicts, PM findings, `paused`, notes.
   - `<project>/.anbu/retro.md` (the captain's line per gate failure), the fails in `.anbu/evidence/report.md`, `.anbu/design/critique.md`, and `git log --oneline` in the project.
   - `~/.claude/agent-memory/<agent>/` for `pm`, `verifier`, `designer`, `builder`, `tester`.
   - Every file in `learnings/`.
2. **List candidates.** One line each for every gate failure, cap raise, waived gate, PM finding of severity 3 or 4, verifier RED, critique round, and agent memory note: what happened, plus its evidence (a state key, a commit, a file).
3. **Place each candidate** on the highest rung that fits:
   1. Build: a lint rule, script, or template change, when agents broke the same rule twice.
   2. Playbook: a step or a gate condition in `playbook/<n>-<phase>.md`.
   3. Agent: a rule in `agents/<name>.md`.
   4. Learning: one line in `learnings/<role>.md`, for the role that could have acted on it.
   5. Drop: a one-off, a project-specific detail, or something a higher rung already enforces. Give the reason.
4. **Prune** every learnings file you touch: merge duplicates, delete lines a higher rung now enforces, delete lines about a tool or version no longer in use. Over 20 lines, the line with the weakest evidence goes. Delete each agent memory note you promoted or dropped.
5. **Propose.** Show one table: candidate, evidence, rung, the exact edit. Ask the user to approve all, pick, or reject with AskUserQuestion. Apply only what was approved.
6. Set `retro_at` to today's date in `state.json`. Leave `claude-anbu` uncommitted and say so.

A learnings line reads: `- <rule, as an instruction>. (<mission>, <YYYY-MM-DD>: <evidence>)`.

Done when every candidate from step 2 has a rung or a drop reason, and the user has answered the proposal.
