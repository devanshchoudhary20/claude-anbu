---
name: pm
description: 🧭 PM — one-off product review by ANBU's `pm` agent, outside a mission. Use for /pm <target>, "PM review this", "would you ship this", on a plan or doc, on mockups or screenshots, or on a built product.
argument-hint: <path | URL | "what we just built">
---

# /pm

Spawn the `pm` agent once. It cannot see this conversation, so your brief carries everything:

- **Target.** Resolve `$ARGUMENTS` to absolute paths or a URL. For "what we just built", name the changed files and how to run it.
- **Gate.** A plan or doc is Rubric C1. Mockups or screenshots are C2. A built product is C3. Name the gate.
- **Promise.** The acceptance line, or one sentence on what this lets a user do. If you cannot write it from the conversation, ask the user.
- **Screenshots**, for C2 and C3. The `pm` has no browser. Capture each screen in light and dark with Claude in Chrome first and pass the file paths.

Relay the verdict and findings as returned. Change nothing until the user picks which findings to fix.
