# Phase 0: THINK

## Owner
`strategist` (Fable). Spawn once. Spawn a council of two more strategists only if the first returns `ambiguous: true`.

## Inputs
- `ideas/<slug>.md`, `PROFILE.md`, `RUBRIC.md`.
- The vault's `INDEX.md` Shipped and Parked sections (for "did we already try this").

## Steps
1. Competitor search: WebSearch three queries (the product category, "<category> chrome extension" or "<category> npx", pricing). Name competitors and the one thing none of them do. No moat means park, not build.
2. Score on Rubric A. Rubric B too if `track: moonshot`.
3. Write the v1 acceptance line: "v1 is done when a stranger can ____." One sentence. Everything not on that line goes to `## later`.
4. Pick the lightest stack from `PROFILE.md`. Vite static > Next.js > extension (Vite + CRXJS, not Plasmo) > add Supabase only if auth or storage is unavoidable.
5. List risks with a mitigation each: store review latency, API cost, DOM selector fragility, and whatever is specific.
6. Produce `.anbu/plan.md`: score, acceptance line, later list, stack, screens (names only), chunks for BUILD (3-6, each one vertical slice), risks, the two distribution channels.

## Gate
`.anbu/plan.md` exists, score is 6 or higher, the acceptance line is one sentence, chunks are between 3 and 6. Below 6: set the idea to `parked` with the reason and end the mission.
Then the human plan gate unless `--yolo`.

## Cap
2 attempts.
