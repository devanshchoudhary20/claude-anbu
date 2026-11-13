---
name: design
description: 🎨 DESIGN — one-off design pass by ANBU's `designer`, with the `drafter` for mockups, outside a mission. Use for /design <screen or feature>, "design this screen", "rethink this page", "critique this UI".
argument-hint: <screen or feature | screenshot paths> [--draw]
---

# /design

The agents cannot see this conversation, so each brief carries the project path, the job in one sentence, the target user, and the existing UI files and tokens.

**New screen or rethink.**
1. Spawn `designer` in mode `brief`. It writes `.anbu/brief.md` and `.anbu/screens.md` in the project.
2. Show the user the three concepts and the pick. Wait for the user to confirm or swap the pick.
3. With `--draw`: spawn `drafter` in mode `draw`, then `designer` in mode `critique`. On `verdict: revise`, spawn `drafter` in mode `revise` once. Show the PNG paths.

**Critique of an existing UI.** Capture each screen in light and dark with Claude in Chrome, or take the paths in `$ARGUMENTS`. Spawn `designer` in mode `critique` with those paths and the job sentence in place of a brief.

Relay the designer's return as given. Build nothing; the output is the brief, the screens file, and the critique.
