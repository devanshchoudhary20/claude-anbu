# Scorecards

Two scorecards. Every idea in the vault gets the first. Only moonshots get the second. Scores are integers, written into the idea file's frontmatter (`score:` for weekend, `moonshot:` for moonshot).

## A. Weekend feasibility (0-10)

Used by `/scan`, `/weekend`, and THINK. An idea must pass every hard constraint in `PROFILE.md` to score at all.

| Points | Criterion | Evidence required |
|---|---|---|
| 0-2 | Weekend-sized: usable v1 in 1-2 days, one person | A v1 scope of 3-5 bullets, no integrations |
| 0-2 | Zero ongoing cost and no babysitting | No per-use API cost on the core path, no scraping |
| 0-2 | Distribution path to the first 50 users | A named channel: store, subreddit, Show HN, directory |
| 0-2 | Gap survives a competitor search | Named competitors and the one thing they don't do |
| 0-2 | Niche fit and freshness | Matches a `PROFILE.md` niche; signal is under 90 days old |

Verdicts: 8-10 validate and build. 6-7 validate with the thin moat named. 5 or below park with the reason.

## B. Moonshot potential (0-10)

Used by `/radar` and by THINK when an idea is tagged `track: moonshot`. Eight criteria, synthesized from YC's Requests for Startups, Bill Gross's timing study, Paul Graham's "live in the future", and the speedrun wedge framework. Score each 0 or 1, then add the two double-weight ones.

| Weight | Criterion | The question |
|---|---|---|
| 2 | Tech-enablement unlock | Did a model, API, protocol, or platform capability in the last 6-12 months make this newly possible, not merely convenient? |
| 2 | Why-now | Would this have failed two years ago and be crowded two years from now? Timing explains more variance than team or idea. |
| 1 | Live-in-the-future | Am I already using the bleeding-edge thing daily and noticing this gap, rather than brainstorming it? |
| 1 | Real wedge | Urgent for someone, displaces an existing workflow, and rests on a belief the market doesn't hold yet. |
| 1 | Solo-executable MVP | An earned-secret MVP in 1-3 months by one person. |
| 1 | Cross-source corroboration | The theme shows up in at least two uncorrelated signal classes: discussion volume, repo velocity, hiring, funding, launches. One spike is noise. |
| 1 | Picks-and-shovels on a shift | Sits on infrastructure a new platform layer needs but hasn't built, not the app layer incumbents will out-execute. |
| 1 | Capital already positioned | The category appears in a current YC RFS or a16z theme list. |

Verdicts: 8-10 is a first-mover alert, push it to the phone and open a `track: moonshot` idea at `status: exploring`. 6-7 goes to the inbox tagged moonshot. Below 6 gets one line in `scanner/log.md` and nothing else.

## The 2026 shifts to score against

Refresh this list from `/radar` output each month. Current:

- MCP spec rewrite (July 2026): stateless tool servers, catalogs going from tens to hundreds of tools. Selection, trust, and observability are the gap, not tool creation.
- Agent-to-agent async delegation: capability negotiation and partial failure are unstandardized.
- Browser agents are commodity (Claude for Chrome, ChatGPT Agent, Gemini in Chrome). Value moved up-stack to task-specific agents.
- On-device SLMs run a full agentic loop locally. Privacy-first and offline products a cloud competitor can't match on cost.
- YC Summer 2026 RFS: software with machine-readable interfaces so agents, not humans, sign up and transact.

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
