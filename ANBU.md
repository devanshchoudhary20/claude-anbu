# ANBU doctrine

Seven rules. Everything in `playbook/` derives from them.

1. **Judgment is expensive, hands are cheap.** Fable thinks, plans, and verifies. Sonnet designs, builds, tests, ships. Haiku fetches. Never invert this.
2. **A phase is done when its gate passes, not when the agent says so.** Gates are verifiable artifacts: a plan file, a screens file, a green build, a browser recording, a live URL, a launch kit.
3. **Prove it in the real artifact.** A test phase without a browser run is not a test phase. A ship phase without a URL a stranger can open is not shipped.
4. **Bounded loops.** Every retry has a cap. When the cap hits, stop and report. A mission that pauses is fine. A mission that burns tokens in a circle is a bug.
5. **Reuse before create.** Grep by behavior before any new helper. Same rule as the company brain.
6. **Two-track scouting, opposite economics.** The weekend track skims cheaply and keeps the shipping muscle warm. The big track reads deeply once a week and files only zero-ops SaaS ideas with a named buyer, a price anchor, and demand from two sources; it reaches you when one clears 8.
7. **Portfolio, not bet.** Ship many small things, prune what nobody uses after 90 days, feed what you learned back into `PROFILE.md`.
