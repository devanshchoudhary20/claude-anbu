# Learnings

One dated entry per shipped mission, appended by LAUNCH and read by THINK. Keep entries to 3-6 lines.

## 2026-09-24 · pr-preflight
- `npx create-vite --overwrite` wipes the whole target dir including `.anbu/`; scaffold into a temp dir and move, or run create-vite before creating `.anbu/`.
- Vitest 5 needs Vite 6+; pin `vitest@3` on Vite 5 projects.
- Review-checkpoint spec axis must point at plan + screens + Figma, never a ticket.
- Builders broke the single-line-comment rule in 5 of 7 chunks despite it being in every prompt. A 40-line lint script (`templates/check-comments.mjs`) in `npm run lint` fixed it in one pass. Rules that matter go in the build, not the prompt.
- `picomatch` `basename: true` breaks path-anchored globs like `dist/**`; apply it per-glob only to slash-less patterns.
- A DOM-fallback parser must fill every field the primary parser fills (`hunkText`), or checks silently pass on the fallback path. Verifier caught it; the tests had not.
- Claude in Chrome refuses every tool on `chrome-extension://` tabs, even user-opened ones. Options and popup pages need a Playwright persistent context with `--load-extension`. Now in the playbook and the tester agent.
- A private cross-fork compare (`main...user:repo:branch`) worked first try via the `.diff` endpoint; the URL regex's lazy `(.+?)` range capture handles the colons.
- LAUNCH's "WebFetch the subreddit rules" step assumes reddit.com is reachable. It is hard-blocked in this environment (direct fetch, old.reddit.com JSON, web.archive.org mirror, and search-engine snippets all failed). Carry forward rule research from an earlier phase when this happens, disclose the block explicitly in the kit, and flag the summary for human re-verification before posting.
- Mission cost shape: 5 build chunks + 2 fix passes, 3 build verifier rounds, 2 test verifier rounds, ~11 hours wall clock with human gates. The verifier found real bugs every round (zero-diff badge copy, lockfile hunk scan, DOM-fallback hunkText, deep ignore globs); tests alone were green throughout.
- One builder stalled (600 s watchdog) mid-edit; resuming the same agent with a three-step finish list was cheaper than a fresh spawn.
- `create-vite --overwrite` wiped `.anbu/`: DESIGN now scaffolds before creating `.anbu/`, or into a temp dir.
- Three 'stale build' test runs on pr-preflight were caused by the captain rebuilding `dist/` after the user reloaded the unpacked extension: hashed asset names change, the loaded manifest points at missing files, the content script dies silently. Never build between the reload and the test.

## 2026-09-25 · sesh M0 (deployed)
- A terminal-state reducer plus React StrictMode's double-mount latches a phantom socket's late close as an error. Any socket effect must ignore events from a socket it no longer owns. The fix that made states terminal created this; verify a fix against the dev double-mount, not only the happy path.
- Every fix loop found by Claude in Chrome was a real bug (per-tab tokens, ended broadcast, host exit flush, invalid room signal, contrast, stale sockets). Unit tests were green throughout; the browser was the only thing that saw them.
- Two of six sesh M0 test loops were StrictMode double-mount bugs (socket, then terminal). Test the production build with `vite preview`; a dev server is not the artifact. Now in playbook 3-test.
- Terminal emulators rendering third-party truecolor output cannot be made contrast-compliant by theming; keep terminals dark in both page themes.
- The PM gate caught the one thing no test could: the npm name was taken by an unrelated package, so the headline command would have failed for every stranger. Plan reviews must check that names resolve.
- Cloudflare: free-plan Durable Objects need `new_sqlite_classes` in migrations; `wrangler pages project create` needs `--force` for a classic Pages project.
- Testers must write evidence under the project's `.anbu/`, never the vault; the captain checks the path on every report.
