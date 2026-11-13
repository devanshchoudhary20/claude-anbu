# Phase 1: DESIGN

## Owner
`designer` (Opus) decides. `drafter` (Sonnet) scaffolds and draws. The captain spawns them in the order below, one at a time.

## Inputs
- `.anbu/plan.md`, `PROFILE.md`.
- `templates/PROJECT_CLAUDE.md` and `templates/check-comments.mjs` for the scaffold.
- `playbook/design-kit.md` (designer) and `playbook/openpencil.md` (drafter). The agent files point at them.

## Steps
1. Spawn `drafter` in mode `scaffold` at `~/developer/personal/projects/<slug>`. Check `npm run build` and `npm run lint` yourself.
2. Spawn `designer` in mode `brief`. It writes `.anbu/brief.md` (arrival, job, three references, three concepts, the pick, direction) and `.anbu/screens.md` (every screen's happy path, four states with exact copy, fallbacks, tokens).
3. Spawn `drafter` in mode `draw`. It draws every screen and state in `<project>/design/<slug>.fig` and exports light and dark PNGs to `.anbu/design/`. A product with no graphical UI (a CLI, a library) skips steps 3 and 4; the exact terminal text in screens.md is the design.
4. Spawn `designer` in mode `critique` on the PNGs. On `verdict: revise`, spawn `drafter` in mode `revise` once. Findings still open after that round go to the PM as written.
5. PM gate 2: spawn `pm` on the PNG exports in `.anbu/design/`, the brief, and the critique (or, for a CLI, the brief and the terminal text). FAIL returns the findings to the designer when they are about the brief or the screens file, and to the drafter when they are about the drawing (counts an attempt). CONCERNS or PASS continues; CONCERNS findings are carried into the builder prompts.

If the `openpencil` command is missing and `npm i -g @open-pencil/cli` fails, the phase pauses for the human.

## Gate
- `.anbu/brief.md` has all six sections, three reference URLs, and three concepts with one picked.
- `.anbu/screens.md` lists every screen from the plan with all four states, plus a tokens section.
- For a graphical UI: the `.fig` exists, `.anbu/design/` holds a light and a dark PNG for every row of the `## Design files` table, and `.anbu/design/critique.md` ends with a verdict.
- `npm run build` exits 0 on the scaffold.

## Cap
2 attempts.
