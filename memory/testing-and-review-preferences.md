---
name: testing-and-review-preferences
description: "User's rules for ANBU missions set 2026-09-25: Claude in Chrome only for local testing (no Playwright windows), extension pages reviewed by the user, PM-style critique expected, big-game track is the priority"
metadata: 
  type: feedback
---

Local testing runs only through Claude in Chrome in the user's real browser. No Playwright locally; the user found the headed Chromium window a waste and said "close the playwright window, we'll test only with Claude in Chrome". Extension pages (`chrome-extension://`) can't be driven by Claude in Chrome even when the user opens the tab, so the tester lists them for manual review and the user shares screenshots. Playwright stays only for cloud sessions.

**Why:** The Playwright run in light mode passed everything while the dark-mode pages were unreadable; the user saw it in five seconds. Automation answered narrow questions; the gap was judgment, not coverage.

**How to apply:** Every screen gets a still in both themes. The `pm` agent (Opus) gates plan, design, and ship with PASS/CONCERNS/FAIL/WAIVED and looks at screenshots before prose. Bring the user real critique, not "looks good". The big-game track (multi-week, demand-first, milestone missions with kill criteria) is now the priority over weekend builds; the first bet is multiplayer agent sessions, chosen by the user over the strategist's Fake Done pick, with a demand probe gating any build. See [[anbu-personal-agent-system]].
