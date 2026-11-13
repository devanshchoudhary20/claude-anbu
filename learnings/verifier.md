# Learnings: verifier

Reviewed lessons from past missions, read by the `verifier` at the start of every spawn. `/retro` is the only writer: it adds, merges, and prunes. Cap 20 lines.

- Where code has a primary path and a fallback path, compare the fields each one fills. (pr-preflight, 2026-09-24: the DOM fallback left `hunkText` empty while tests stayed green)
