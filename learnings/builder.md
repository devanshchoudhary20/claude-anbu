# Learnings: builder

Reviewed lessons from past missions, read by the `builder` at the start of every spawn. `/retro` is the only writer: it adds, merges, and prunes. Cap 20 lines.

- Vitest 5 needs Vite 6+; pin `vitest@3` on a Vite 5 project. (pr-preflight, 2026-09-24)
- A fallback parser fills every field the primary parser fills, or checks pass silently on the fallback path. (pr-preflight, 2026-09-24: `hunkText`, caught by the verifier)
- A socket effect ignores events from a socket it no longer owns. (sesh M0, 2026-09-25: StrictMode double-mount latched a phantom socket's close as an error)
- `picomatch` `basename: true` breaks path-anchored globs like `dist/**`; apply it only to patterns without a slash. (pr-preflight, 2026-09-24)
- npm 11 rejects a `bin` path with a `./` prefix and strips the command at publish; write `index.js`. (sesh M0, 2026-09-25)
- Free-plan Cloudflare Durable Objects need `new_sqlite_classes` in the migrations block. (sesh M0, 2026-09-25)
