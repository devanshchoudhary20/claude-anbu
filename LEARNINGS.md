# Learnings

One dated entry per shipped mission, appended by LAUNCH and read by THINK. Keep entries to 3-6 lines.

## 2026-09-24 · pr-preflight (in progress)
- `npx create-vite --overwrite` wipes the whole target dir including `.anbu/`; scaffold into a temp dir and move, or run create-vite before creating `.anbu/`.
- Vitest 5 needs Vite 6+; pin `vitest@3` on Vite 5 projects.
- Review-checkpoint spec axis must point at plan + screens + Figma, never a ticket.
