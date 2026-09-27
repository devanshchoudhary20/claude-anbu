---
name: diagnosing-bugs
description: 🐛 KIKAICHU — Red-loop-first diagnosis for hard bugs and perf regressions. Build a tight failing signal BEFORE hypothesizing, then minimise, hypothesise, instrument, fix, regression-check. Use when the user says "diagnose"/"debug this", or reports something broken/throwing/failing/slow. Fires at T2/T3.
---

# 🐛 KIKAICHU — Diagnosing Bugs

A discipline for hard bugs. Skip a phase only with an explicit reason. Adapted from Matt Pocock's `diagnosing-bugs`; grounds the repeated memory lesson [[feedback-verify-the-input-not-the-mechanism]] into a method.

The failure this prevents: reading code to build a theory before a failing signal exists. That is exactly [[feedback_diet_backfill_two_diets_used_variables_locals]] ("don't fix blindly by closing verifier gaps") and the input-not-mechanism scar.

## Phase 1: Build a feedback loop — THIS IS THE SKILL

If you have a **tight** pass/fail signal that goes red on *this* bug, you will find the cause. Bisection, hypothesis-testing, and instrumentation all just consume it. If you don't, no amount of staring saves you. Spend disproportionate effort here.

Ways to build one, in rough order for this stack (React/TS FE, redux, SSE, browser):

1. **A failing check at the seam that reaches the bug** — a script, a `tsc` assertion, a redux selector call, a reducer invocation with a fixture action.
2. **Curl / HTTP script** against the running dev server or the BE endpoint.
3. **Replay a captured payload** — save the real SSE frame / API response / redux action to disk, feed it through the exact code path (decoder, reducer, selector) in isolation. Best fit for the payload and draft-mode bugs.
4. **Browser drive** — `kane-cli` or Playwright drives the UI and asserts on DOM / console / network.
5. **Differential loop** — same input through V2 vs V4, or FF-on vs FF-off, diff the outputs.
6. **Throwaway harness** — one function call that exercises the bug path with mocked deps.

Build the right loop and the bug is 90% fixed.

### Tighten the loop
Treat it as a product. Make it faster (skip unrelated init), sharper (assert the exact symptom, not "didn't throw"), and deterministic (pin time, seed, freeze the SSE stream to a fixture). A 2-second deterministic loop is a superpower; a 30-second flaky one barely helps.

### Non-deterministic bugs
The goal is a higher reproduction rate, not a clean repro. Loop the trigger, parallelise, narrow timing windows, inject sleeps. A 50%-flake bug is debuggable; 1% is not. Raise the rate until it is.

### Completion criterion — a tight loop that goes red
Phase 1 is done when you can name **one command you have already run at least once** (show the invocation and its output) that is:
- **Red-capable**: drives the actual bug path and asserts the user's exact symptom, not "runs without erroring".
- **Deterministic**: same verdict every run.
- **Fast**: seconds.
- **Agent-runnable**: I can run it unattended.

No red-capable command, no Phase 2. If you catch yourself theorising before this command exists, stop.

### When you genuinely cannot build a loop
Say so explicitly, list what you tried, and ask the user for the environment, a captured artifact (HAR, SSE dump, redux state export, screen recording with timestamps), or permission to add temporary instrumentation. Do not hypothesise without a loop.

## Phase 2: Reproduce + minimise
Run the loop, watch it go red. Confirm it is the user's exact failure, not a nearby one. Then shrink to the smallest scenario that still goes red: cut inputs, callers, config, rows, one at a time, re-running after each cut. Done when every remaining element is load-bearing. A minimal repro shrinks the Phase 3 hypothesis space and becomes the regression check.

## Phase 3: Hypothesise
Generate **3-5 ranked, falsifiable hypotheses before testing any**. Format: "If X is the cause, then changing Y makes the bug disappear / changing Z makes it worse." No prediction means it is a vibe; discard or sharpen it. Show the ranked list to the user first: they often re-rank instantly ("we just changed #3"). Don't block on it if they're AFK.

## Phase 4: Instrument
Each probe maps to one prediction. Change one variable at a time. Prefer a debugger/REPL over logs. Tag every debug log with a unique prefix (`[DBG-a4f2]`) so cleanup is one grep. For perf regressions, measure first (`performance.now()`, profiler, React DevTools) then bisect; logs are usually the wrong tool.

## Phase 5: Fix + regression check
Write the check **before the fix**, but only if a correct seam exists — one that exercises the real bug pattern at the call site. If the only seam is too shallow to catch this bug, that absence is itself the finding: note it, the architecture is preventing lockdown. If a correct seam exists: turn the minimised repro into a failing check, watch it fail, apply the fix, watch it pass, then re-run the Phase 1 loop against the original un-minimised scenario. At T2/T3 this ties into `/dev-test`.

## Phase 6: Cleanup
Before declaring done:
- Original repro no longer reproduces (re-run the Phase 1 loop).
- Regression check passes, or the absence of a seam is documented.
- All `[DBG-...]` instrumentation removed (grep the prefix).
- Throwaway harnesses deleted.
- The correct hypothesis is stated in the commit / PR message, so the next debugger learns.
