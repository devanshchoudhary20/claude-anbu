# Learnings: tester

Reviewed lessons from past missions, read by the `tester` at the start of every spawn. `/retro` is the only writer: it adds, merges, and prunes. Cap 20 lines.

- Evidence goes under the project's `.anbu/evidence/`, never the vault. (sesh M0, 2026-09-25)
- After a fix to sockets or terminal state, rerun that screen under the dev server too; the StrictMode double-mount exposes what the production build hides. (sesh M0, 2026-09-25: two of six fix loops)
- Claude in Chrome cannot resize to a 390 viewport; list the mobile check as a limitation with the URL for manual review. (sesh M0, 2026-09-25: `m0-landing-mobile390-viewportresizefailed-dark.png`)
