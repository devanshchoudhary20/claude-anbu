---
name: verify
description: 🩸 VERIFY — one-off adversarial check by ANBU's `verifier` agent, outside a mission. It tries to refute that the work meets its done-condition: unrendered states, falsy values reaching the DOM, missing evidence. Use for /verify [base ref], "try to refute this", "is this really done". For a general bug hunt on a diff, use /code-review.
argument-hint: [base ref | evidence folder]
---

# /verify

Spawn the `verifier` agent once. It cannot see this conversation, so your brief carries everything:

- **Repo** as an absolute path.
- **Range.** `$ARGUMENTS` as the base ref when given. Otherwise the uncommitted diff, or the merge base with the default branch when the tree is clean. For an evidence check, the evidence folder.
- **Done-condition.** `.anbu/plan.md` and `.anbu/screens.md` when they exist. Otherwise the spec file, or one sentence on what done means here. If you cannot write it from the conversation, ask the user.

Relay the verdict and findings as returned. Change nothing until the user picks which findings to fix.
