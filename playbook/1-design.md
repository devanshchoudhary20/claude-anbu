# Phase 1: DESIGN

## Owner
`designer` (Sonnet).

## Inputs
- `.anbu/plan.md`, `PROFILE.md`.
- `templates/PROJECT_CLAUDE.md` to copy into the project as `CLAUDE.md`.

## Steps
1. Scaffold the project at `~/developer/personal/projects/<slug>` with the stack's official tool. `git init`, first commit "chore: scaffold". Copy the project CLAUDE.md and `templates/check-comments.mjs` into `scripts/`, and wire `"lint": "<linter> && node scripts/check-comments.mjs"` in package.json so the single-line-comment rule is enforced by the build, not by review. Create `.anbu/` and move `plan.md` in if THINK wrote it elsewhere.
2. For each screen in the plan, write its happy path as numbered states, then the empty, loading, error, and success state. Every external value gets a fallback named here, not later.
3. Pick a design direction: one typeface pair, a 5-token color scale, spacing scale, radius. Use the `frontend-design` skill if installed. No Inter-plus-purple-gradient default.
4. Component plan: which shadcn or Radix pieces, which custom. Custom needs a reason.
5. Write `.anbu/screens.md`.

## Steps (continued)
6. Pencil: draw every screen and state in `<project>/design/<slug>.pen` through the headless pen.dev CLI (`pen interactive`), with tokens as light and dark variables, and export each frame to `.anbu/design/<screen>-<state>-<theme>.png`. The designer agent file has the exact procedure. It needs `pen login` once per machine on the personal account; if `pen status` says not authenticated, the phase pauses for the human. Products with no graphical UI (a CLI, a library) skip this step, and the exact terminal text in screens.md is the design.
7. PM gate 2: spawn `pm` on the PNG exports in `.anbu/design/` (or, for a CLI, the terminal text in screens.md). FAIL returns to the designer with the findings (counts an attempt). CONCERNS or PASS continues; CONCERNS findings are carried into the builder prompts.

## Gate
`.anbu/screens.md` lists every screen from the plan with all four states, plus a tokens section. For a graphical UI, the `.pen` file exists and `.anbu/design/` holds a light and a dark PNG for every screen and state listed in the `## Design files` table. Project builds empty (`npm run build` exit 0).

## Cap
2 attempts.
