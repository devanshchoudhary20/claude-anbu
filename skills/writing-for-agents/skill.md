---
name: writing-for-agents
description: 🖋 FUINJUTSU — Discipline for writing anything an agent reads: a skill, CLAUDE.md, a memory file, a doc reached by a pointer. Use when creating or editing a skill, MEMORY.md, a memory file, or CLAUDE.md, or when the setup feels too heavy to load. Governs against sprawl.
---

# 🖋 FUINJUTSU — Writing for Agents

Reference for writing any document an agent consumes. The packaging differs (skill, `CLAUDE.md`, a memory file, a pointer); the writing does not. Adapted from Matt Pocock's `writing-for-agents`. Use it to keep the cerebrum setup lean, not just to add to it.

## Context pointers

A **context pointer** names out-of-context material and encodes the condition for reaching it. A skill's `description`, a line in `CLAUDE.md`, a `MEMORY.md` index line, a `[[memory-link]]` — all the same object. The pointer's **wording**, not its target, decides when the agent reaches the material and how reliably. A must-have target behind a weak pointer is a variance bug: sharpen the wording first, inline the material only if that fails.

A pointer does two jobs: say what the material is, and list the **branches** (distinct cases) that should trigger reaching it. Every word of an always-loaded pointer (a `CLAUDE.md` line, a skill description, a `MEMORY.md` line) costs on every turn, so prune it hard:
- Front-load the trigger word.
- One trigger per branch; collapse synonyms.
- Cut identity the body already carries.

## The two loads

- **Context load**: the cost of always-loaded material on the window (a `CLAUDE.md` line, a skill description, a `MEMORY.md` line), spent every turn whether it fires or not.
- **Cognitive load**: the cost on the human of knowing which documents exist and when to reach for each. Not to minimise; it is the price of your own agency. Spend it where your judgement matters, remove it where it does not.

Material behind a pointer escapes context load for the price of the pointer's line. This is the lever for a heavy setup: push on-demand reference out of always-loaded files.

## Information hierarchy

Two content types: **steps** (ordered actions) and **reference** (facts consulted on demand). Rank each by how immediately the agent needs it:
1. **In-file step** — what the agent does, in order.
2. **In-file reference** — consulted on demand; a flat peer-set (every rule of a review on one rung) is fine, not a smell.
3. **Disclosed reference** — pushed to a separate file behind a pointer, loaded only when the pointer fires.

**Progressive disclosure** is the move down that ladder so the top stays legible. The test is branching: inline what every path needs, disclose what only some paths reach.

**Co-location**: keep a concept's definition, rules, and caveats under one heading, so reading one part brings its neighbours. Scattering fragments one meaning across many places; that is worse than duplication.

**Sprawl** is the failure mode: a document too long even when every line is live. Attention thins across the excess. The cure is the ladder: disclose reference, split by branch or sequence.

## Completion criteria

Every step ends on a **completion criterion**: the condition that says the work is done.
- **Clarity**: can the agent tell done from not-done? A vague bound invites premature completion. Sharpen the bound first; only hide later steps (split the sequence) if it is irreducibly fuzzy.
- **Demand**: how much it requires. "Every modified model accounted for" forces more legwork than "produce a change list". Demand binds a flat reference too ("every rule applied").

The strongest criteria are checkable and exhaustive.

## Leading words

A **leading word** is a compact concept already in the model's priors (*lesson*, *red loop*, *tight*, *blast radius*) that the agent thinks with while running the document. Repeated as a token, never spelled out as a sentence, it anchors a whole region of behaviour cheaply. Coining your own works only if you define it; a made-up word recruits no priors. When the same word lives in your prompts, docs, and code, the agent links them and reaches the material more reliably.

**Negation is the failure mode beside this.** Steering by prohibition drags the forbidden behaviour into context and makes it more available. "Don't think of an elephant." Prompt the **positive**: state the target behaviour so the banned one is never spoken. A prohibition earns its place only as a hard guardrail you cannot phrase positively, and even then pair it with the positive target.

## Pruning — the cerebrum-heaviness cure

- **Single source of truth.** One authoritative place per meaning, so a change is a one-place edit. Duplication costs maintenance and tokens and inflates a meaning's rank. (A leading word repeats the token on purpose, never the meaning.)
- **The environment is a source of truth too.** `package.json` scripts, config, directory layout, `--help`. A document that restates them is a cache, earning its load only when the lookup is expensive. Cache what the agent cannot find by looking: the unwritten convention, the reason behind a choice, the gotcha no config confesses.
- **Relevance, line by line.** A line loses it by never bearing on the task, or by going stale. Without a pruning discipline the default fate is **sediment**: stale layers that settle because adding feels safe and removing feels risky.
- **No-ops.** An instruction the model already obeys by default pays load to say nothing. The test (does it change behaviour vs the default?) is model-relative. When a sentence fails, delete the whole sentence. A leading word too weak to beat the default (*be thorough*) is a no-op; the fix is a stronger word (*relentless*), not more text.

## When to use on this setup

Reach for this before adding a skill, a memory, or a `CLAUDE.md` line, and periodically to prune `MEMORY.md` and skill descriptions. The net-surface rule: adding a document is only paid for when a prune of equal weight rides with it.
