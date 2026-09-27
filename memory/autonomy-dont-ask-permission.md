---
name: autonomy-dont-ask-permission
description: "User wants minimal permission-asking — proceed autonomously, only stop for genuinely risky actions"
metadata: 
  type: feedback
---

User does not want to be asked for permission/confirmation at every checkpoint. Just keep working and proceed autonomously.

**Why:** Constant confirmation prompts slow the work down and annoy them; they trust the agent to make reasonable calls.

**How to apply:** Only pause to ask when an action is genuinely security-concerning or hard to reverse — e.g. deleting/overwriting their data, pushing to a public/shared remote, spending money, destructive git ops, sending outward-facing content. For everything else (installing deps, scaffolding, writing code, running builds/tests, local commits, moving through playbook phases), just do it and report after. Batch planning phases instead of stopping at each one.
