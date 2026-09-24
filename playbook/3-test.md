# Phase 3: TEST

## Owner
`tester` (Sonnet). `verifier` (Fable) reads the evidence.

## Inputs
- `.anbu/screens.md` (the states are the test cases), the dev server command, `--cloud` flag.

## Steps
1. Start the dev server in the background. For an extension, build to `dist/` and load it unpacked.
2. Local: Claude in Chrome only, in the user's real browser. No Playwright locally (user decision 2026-09-25). Extension pages (`chrome-extension://…/options.html`, `popup.html`) cannot be driven by Claude in Chrome: the tester lists them as a manual review, the user opens them in light and dark and shares screenshots, and the PM reviews those screenshots at gate 3. Cloud sessions (`--cloud`) have no Chrome, so Playwright headless is the only option there. Same script either way: for every screen, drive the happy path, then force the empty, loading, and error states (block the network request, clear storage, send bad input).
3. Record a GIF per screen locally, or screenshots per state in cloud, into `.anbu/evidence/`. Every screen also gets a still in BOTH themes (`<screen>-light.png`, `<screen>-dark.png`): for web pages, Claude in Chrome switches the site theme (GitHub: the appearance setting, or `data-color-mode` via javascript_tool) and screenshots; for extension pages, the user supplies them. The PM compares these against the Figma frames. Read the console for errors after every screen. Run axe on each screen if the page is a web app.
4. Write `.anbu/evidence/report.md`: a table of screen, state, pass or fail, evidence file, console errors.
5. Any fail: hand the exact state and console output to `builder`, one fix attempt, rerun that screen only.

## Steps (continued)
6. PM gate 3: spawn `pm` for the ship review on the evidence, the Figma frames, and the plan. FAIL routes findings to one builder fix loop then re-tests the affected screens. CONCERNS continues to SHIP with the findings logged. A WAIVED 4 needs the captain's written reason in state.

## Gate
`report.md` has every screen and state from the screens file marked pass, zero console errors, and the verifier confirms the evidence files exist and match the claims.

## Extension rule
A Vite/CRXJS build renames hashed assets. After the user loads or reloads `dist/` unpacked, do NOT run `npm run build` or `npm run package` until the browser checks are done; packaging happens in SHIP. Every rebuild requires a fresh reload from the user first.

## Cap
3 fix loops per screen.
