---
name: skill-help
description: 🧿 RINNEGAN — Explain any skill in the arsenal from its live source: what it does, every way to invoke it, what it needs, what it returns, its guardrails, and the best way to use it. Use for "explain <skill>", "how do I use <skill>", "what can <skill> do", "best way to use <skill>", "what skills do I have", "which skill for <task>", or /skill-help. Resolves a codename (SUSANOO), a command (/dev-test) or a folder name.
---

# 🧿 RINNEGAN — Skill Help

The eye that knows every jutsu. It carries no copy of any skill: it reads each skill's own file at answer time, so it is never stale. This file owns only the **method** and the **card format**.

## Sources (read, never restate)

- Personal arsenal: `~/.claude/skills/<name>/` (company skills live in `claude-cerebrum/skills/`, portable ones in `claude-anbu/skills/`; both are linked into `~/.claude/skills/`).
- Project-local: `./.claude/skills/<name>/` in the current repo, when one exists.
- Plugin skills (figma, slack, atlassian, ...) have no folder here; answer those from the available-skills listing only, and say so.
- The skill file is `SKILL.md` or `skill.md` (the FS is case-insensitive); `ls` the folder and open whichever exists. Also open every sibling: `*.sh` (take its usage header), `references/` and `assets/` (list titles, open one only when the card needs it).

Codenames live in each description (`🛡️ SUSANOO — ...`), so resolve a name by grepping every description for the token, the `/command`, or the folder name. Two hits → show both, one line each, and ask which.

## Modes

**1. Roster** — no argument, or "what skills do I have".
Read every skill's frontmatter (name + description only). Print one table per group, one line per skill: `codename · /command · the first clause of its description`. Groups: **Plan** (gather-requirements, explore-codebase, implement, blast-radius) · **Build** (worktree, contract, kane-cli, interactive-flow, create-rfc, bulk-update-packages) · **Verify** (dev-test, review-checkpoint, diagnosing-bugs, create-verification-skill) · **Review** (fable-review, ponytail*) · **Write** (unslop, writing-for-agents, remember-project, relay, skill-help). A skill that fits no group goes under **Other**. Done when every folder that has a skill file appears exactly once.

**2. Card** — `/skill-help <name>`.
Read the whole skill file plus its side files, then render the card below. Done when every subcommand, flag and mode named anywhere in the skill file or a script's usage header appears in **Invoke**; every rule, "do not" and threshold appears in **Guardrails**, phrased as what the skill requires; every skill the file mentions appears in **Works with**.

**3. Route** — "which skill for <task>".
Read every description, pick the one to three whose triggers match, and answer: the pick, one line on why, and the order to run them in. Point at the neighbour that is *not* the answer when the two are commonly confused (`/dev-test` vs `/review-checkpoint`, `/fable-review` vs `/code-review`, `/ponytail-mega` vs `/ponytail-review`).

## The card

Fill every section from the source; drop a section only when the source truly has nothing for it, and say "none" rather than invent.

```markdown
# <emoji> CODENAME · /<command>
<one sentence: what it does, from the description>

**Reach for it when** <the triggers, verbatim from the description>
**Instead of it, use** <the neighbouring skill for the adjacent job, or "no close neighbour">

## Invoke
| Form | What happens |
|---|---|
| `/cmd` | ... |
| `/cmd <arg>` / `--flag` | ... |
(every form; scripts get their usage lines here too)

## What it does
1. <step> → done when <its completion criterion>
2. ...
(the skill's phases or procedure, condensed; keep its own numbering and phase names)

## You give → it returns
| You give | It gives back |
|---|---|

## Guardrails
- <each hard rule, threshold or refusal, as a requirement: "blocks commit on any ❌", "pass mark 8.5">

## Reads / writes
- <files, registries, references, scripts it touches; where output lands>

## Works with
- **Before it:** ... · **After it:** ... · **Instead of it:** ...

## Best use
<two or three sentences: when in a task's life it earns the most, the invocation most people want, and the trap the skill file itself warns about>
```

## Voice

Unslop, as everywhere: short sentences, exact identifiers unchanged, no em dashes, no praise. Quote the skill's own words for triggers and rules so the card cannot drift from its source. When the source contradicts itself, show both lines and name the file.
