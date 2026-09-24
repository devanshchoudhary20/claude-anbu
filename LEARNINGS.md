# Learnings

One dated entry per shipped mission, appended by LAUNCH and read by THINK. Keep entries to 3-6 lines.

## 2026-09-24 · pr-preflight (in progress)
- `npx create-vite --overwrite` wipes the whole target dir including `.anbu/`; scaffold into a temp dir and move, or run create-vite before creating `.anbu/`.
- Vitest 5 needs Vite 6+; pin `vitest@3` on Vite 5 projects.
- Review-checkpoint spec axis must point at plan + screens + Figma, never a ticket.
- Builders broke the single-line-comment rule in 5 of 7 chunks despite it being in every prompt. A 40-line lint script (`templates/check-comments.mjs`) in `npm run lint` fixed it in one pass. Rules that matter go in the build, not the prompt.
- `picomatch` `basename: true` breaks path-anchored globs like `dist/**`; apply it per-glob only to slash-less patterns.
- A DOM-fallback parser must fill every field the primary parser fills (`hunkText`), or checks silently pass on the fallback path. Verifier caught it; the tests had not.
- Claude in Chrome refuses every tool on `chrome-extension://` tabs, even user-opened ones. Options and popup pages need a Playwright persistent context with `--load-extension`. Now in the playbook and the tester agent.
- A private cross-fork compare (`main...user:repo:branch`) worked first try via the `.diff` endpoint; the URL regex's lazy `(.+?)` range capture handles the colons.
