# Phase 3: TEST

## Owner
`tester` (Sonnet). `verifier` (Fable) reads the evidence.

## Inputs
- `.anbu/screens.md` (the states are the test cases), the dev server command, `--cloud` flag.

## Steps
1. Start the dev server in the background. For an extension, build to `dist/` and load it unpacked.
2. Local: use Claude in Chrome for web pages. Extension pages (`chrome-extension://…/options.html`, `popup.html`) are off-limits to Claude in Chrome even when the user opens the tab; drive those with a Playwright script (`chromium.launchPersistentContext` with `--load-extension=dist`) kept as `scripts/e2e-extension.mjs` in the project. Cloud: Playwright for everything. Same script either way: for every screen, drive the happy path, then force the empty, loading, and error states (block the network request, clear storage, send bad input).
3. Record a GIF per screen locally, or screenshots per state in cloud, into `.anbu/evidence/`. Read the console for errors after every screen. Run axe on each screen if the page is a web app.
4. Write `.anbu/evidence/report.md`: a table of screen, state, pass or fail, evidence file, console errors.
5. Any fail: hand the exact state and console output to `builder`, one fix attempt, rerun that screen only.

## Gate
`report.md` has every screen and state from the screens file marked pass, zero console errors, and the verifier confirms the evidence files exist and match the claims.

## Cap
3 fix loops per screen.
