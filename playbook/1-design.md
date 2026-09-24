# Phase 1: DESIGN

## Owner
`designer` (Sonnet).

## Inputs
- `.anbu/plan.md`, `PROFILE.md`.
- `templates/PROJECT_CLAUDE.md` to copy into the project as `CLAUDE.md`.

## Steps
1. Scaffold the project at `~/developer/personal/projects/<slug>` with the stack's official tool. `git init`, first commit "chore: scaffold". Copy the project CLAUDE.md. Create `.anbu/` and move `plan.md` in if THINK wrote it elsewhere.
2. For each screen in the plan, write its happy path as numbered states, then the empty, loading, error, and success state. Every external value gets a fallback named here, not later.
3. Pick a design direction: one typeface pair, a 5-token color scale, spacing scale, radius. Use the `frontend-design` skill if installed. No Inter-plus-purple-gradient default.
4. Component plan: which shadcn or Radix pieces, which custom. Custom needs a reason.
5. Write `.anbu/screens.md`. Optional: if the Figma MCP is connected and the user asked for Figma, push the screens to a Figma file and record the link.

## Gate
`.anbu/screens.md` lists every screen from the plan with all four states, plus a tokens section. Project builds empty (`npm run build` exit 0).

## Cap
2 attempts.
