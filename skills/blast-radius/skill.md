---
name: blast-radius
description: 💥 KATSU — Find what a change breaks BEYOND the diff before it ships, and prove the one fact it's safe because of by running real code, not asserting it. Use for "blast radius of X", "what could this break", reviewing a small diff you don't trust, or before editing a shared/gated/payload file at T2/T3.
---

# 💥 KATSU — Blast Radius

Find what a change breaks somewhere else, before it ships. Adapted from pstack's `blast-radius`. This is the T2/T3 floor check in the CLAUDE.md task router. It targets the exact scar class in [[feedback_ui_redesign_preserve_functionality]] (a redesign froze the auth gate) and [[feedback_ui_only_change_needs_pm_approval]] (a relabel spread across V2/V4/Modules then reverted).

Listing callers is not the job; grep does that in a second. The job is the breakage grep won't show you.

## Don't trust your own writeup

A blast-radius writeup that sounds right is worthless: it reads as convincing whether or not it's true. Find the one or two facts the whole thing depends on and **prove them by running code**. Words are where you start, not what you ship.

### How sure are you
For each fact the change's safety depends on, get as far down this list as is cheap, and say where it stopped:
1. You said so. Worthless alone.
2. You pointed at the line. A real `file:line`, or the library's own source.
3. You showed the bad case can't happen. Walked the failure step by step; it doesn't reach.
4. You ran it. A script/test that calls the real code and fails loud if you're wrong.
5. You reproduced it in the running app.

Any safety fact you can't get to step 4, say so out loud. Don't write it up as settled.

## Steps

1. **Read the change.** The diff, the symbols it adds/changes/deletes, and what it now does differently, including the part the diff doesn't spell out.
2. **Find the one fact it's safe because of.** Most scary-looking changes are safe because of a single fact ("this only drops already-dead entries"). Find it. If it holds, most scary cases die at once. Spend your time here, not on a list of maybes.
3. **Look where grep stops.** For this stack that means: the SSE frame shape another view decodes, a redux field a distant selector reads, a payload key the BE requires, a shared component consumed by V2 AND V4, a feature flag, a gate predicate, the draft-mode copy of state. Trace three hops downstream.
4. **Be honest about each risk.** Real chance, real cost. Cite `file:line`. A search that finds nothing is still an answer. Never invent a caller or an API.
5. **Prove the one fact.** Write a script or `tsc`/selector call that runs the real code, run it, paste what happened. If you can't prove it cheaply, mark it unproven. Don't round up.
6. **Wide change → run it as parallel workers.** Ask several agents/models the same question and merge. Different models catch different real bugs.

## Hand back

- **What it does.** Including the non-obvious part.
- **The one fact it's safe because of.** State it, say which step you reached, show the proof, or write "unproven".
- **Risks.** Only the real ones: how it breaks, `file:line`, likelihood, cost, how to check.
- **Cleared.** What you checked and why it's fine.
- **Before you merge.** The cheapest repro that catches the real bug.
