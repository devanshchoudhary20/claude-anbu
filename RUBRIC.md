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
