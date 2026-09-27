# Scorecards

Rubric A (weekend feasibility) and Rubric B (big-track SaaS: zero-ops gate, then 0-10) live in the vault at `~/developer/personal/idea-engine/scanner/RUBRIC.md`. That file is the single source because the cloud routines can only read the vault; two copies drifted once already. `/prospect` refreshes its 2026 shifts list weekly.

This file keeps the PM review only.

## C. PM review (three gates)

Synthesized 2026-09-25 from Marty Cagan's four risks, BMAD's PM/PO checklists and Test Architect gate vocabulary, Lenny's PRD critique prompts, NN/g heuristics and Don Norman via the claude-design-skills and mastepanoski audits, and Applitools-style design-vs-built diffing. Severity 0-4 per finding. Verdict: PASS (no 4s, no 2-3s), CONCERNS (2-3s present, captain decides), FAIL (any 4), WAIVED (a 4 with a written justification in state.json).

### C1. Plan review, at THINK
1. Target user named specifically, not "developers".
2. Job stated as a job to be done, not a feature.
3. One success metric with a number and a date.
4. Scope cut written as lines under `## later`, not omissions.
5. Why now answered: what changed in the last 6-12 months.
6. Demand evidence attached: at least two of HN pain threads, GitHub issues ranked by reactions, 1-2 star reviews of the nearest tool, "wish this existed" searches. Titles trending is not demand.
7. Feasibility checked against the stack, not assumed.
8. Red team survived: five reasons it fails, five unintended consequences, each answered or accepted.
9. The friend sentence: what a user says to a friend about it, in their words.

### C2. Design review, at DESIGN, on the mockups
1. Screenshot first: the reviewer looked at the frame before reading the spec.
2. Readable in light and dark, each checked separately, WCAG AA contrast.
3. Every list has an empty state; every async action has a loading state.
4. Clickable things look clickable; non-clickable things do not.
5. Error states offer a way back, not a dead end.
6. Reuses the host's patterns (GitHub, the OS, the browser) rather than inventing.
7. Copy is specific: no "Something went wrong", no "Item".
8. Hierarchy: the one thing the user came for is the biggest thing on the screen.

### C3. Ship review, after TEST, on the built product
1. Built matches the promise: each acceptance-line clause traced to a screenshot.
2. Built matches the mockup: per screen, layout, hierarchy, spacing, color compared to the Figma frame.
3. Both themes screenshot and readable.
4. First run is obvious with zero explanation.
5. Every non-happy state from the screens file is reachable in the evidence, or listed as a limitation with a reason.
6. Nothing from `## later` was built.
7. Verdict is PASS / CONCERNS / FAIL / WAIVED, never "looks good".
8. Would ship to strangers today: yes or no.
