# Phase 2: BUILD

## Owner
`builder` (Sonnet), one spawn per chunk, sequential. `verifier` (Fable) once at the end.

## Inputs
- `.anbu/plan.md` (chunks), `.anbu/screens.md`, `<project>/CLAUDE.md`.
- For each chunk: the chunk name, the screens it touches, the states it must render, and the files from the previous chunk.

## Steps
1. For each chunk in order: spawn `builder` with the chunk contract. It implements the vertical slice, runs `npm run build` and `npm run lint`, commits "feat(<chunk>): ...", and returns the changed files and any deviations from the screens file.
2. After each chunk, run `/review-checkpoint` on the diff. Its eight axes are generic; the spec-fidelity axis must be judged against `.anbu/plan.md`, `.anbu/screens.md`, and the Figma frames named there, never against a ticket. Ignore any company-only reference inside the skill (contracts, V2/V4). Under 7: send the findings back to the same builder, count an attempt.
3. Wire analytics early if the plan has a channel that needs it (PostHog free tier or none).
4. After the last chunk, spawn `verifier` with the full diff, the plan, and the screens file. It hunts: falsy values rendered, logic in JSX, components over 400 lines, secrets in client code, hallucinated packages (check every dependency exists on npm), unused abstractions.

## Gate
`npm run build` exit 0, `npm run lint` exit 0, every chunk committed, verifier verdict not RED.

## Cap
3 attempts per chunk. 2 verifier rounds.
