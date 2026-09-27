# 🥷 ANBU

> _the Hokage's black-ops unit: give it a mission, it comes back with a shipped product._

`claude-anbu` is the central Claude Code agent system for personal work. MEGAMIND (`claude-cerebrum`) is the company brain. ANBU is the personal one. One command takes an idea from "should this exist?" to a live URL with a launch post drafted, and two scheduled routines keep the vault fed: a deep weekly prospect for big SaaS bets and a cheap scout for weekend builds.

## The loop

```
  prospect (cloud, Fable) ──weekly──▶  BIG TRACK: zero-ops SaaS ideas + weekly brief, push alert on 8+
  scout (cloud, cheap)    ──weekly──▶  WEEKEND inbox, bigger signals → leads for prospect   ◀── /idea (you)
                                            │
                            /weekend or a big idea at 7+  → pick one
                                            │
                                     /mission <slug>
                                            │
   THINK ─▶ DESIGN ─▶ BUILD ─▶ TEST ─▶ SHIP ─▶ LAUNCH        (each phase gated, resumable)
   Fable     Sonnet    Sonnet   Sonnet  Sonnet   Sonnet
              +Fable verify after BUILD and TEST
```

The vault (ideas, board, profile) lives in `~/developer/personal/idea-engine`. Built products live in `~/developer/personal/projects/<slug>`. ANBU is only the brain and the hands.

## What lives here

ANBU also owns the portable base layer of the Claude Code setup, the part that installs on any machine: `CLAUDE.md` (global base rules), `settings.json` (base settings), `statusline-command.sh`, `memory/` (durable preferences copied into project memory), and 13 portable skills in `skills/`: `unslop`, `review-checkpoint`, `writing-for-agents`, `skill-help`, `ponytail`, `ponytail-audit`, `ponytail-debt`, `ponytail-gain`, `ponytail-help`, `ponytail-review`, `diagnosing-bugs`, `blast-radius`, `remember-project`. On a company machine, `claude-cerebrum` symlinks to those same skills and its `CLAUDE.md` imports ANBU's base with `@~/developer/personal/claude-anbu/CLAUDE.md`.

## Commands

| Command | What | Model |
|---|---|---|
| `/mission <slug or one-liner> [--from phase] [--until phase] [--yolo]` | The master orchestrator. Runs `playbook/` end to end. | orchestrates; delegates by tier |
| `/prospect [slug or steer]` | Weekly big-track engine. Reads pain, shifts, discourse, and money signals, synthesizes SaaS ideas, gates on zero-ops, scores on Rubric B, writes a brief. Pushes an alert at 8+. Procedure lives in the vault at `scanner/PROSPECT.md`. | Fable, Sonnet readers |
| `/scan` | Weekend-track scout: titles only, cheap. Hands bigger signals to prospect. | Haiku/Sonnet |
| `/idea <one-liner> [--big]` | Capture into the vault with a gut-check. | session |
| `/weekend [steer]` | Triage the inbox, validate a shortlist, pick one. | session + WebSearch |

Portable skills that ship with the base layer: `unslop`, `review-checkpoint`, `writing-for-agents`, `skill-help`, `ponytail`, `ponytail-audit`, `ponytail-debt`, `ponytail-gain`, `ponytail-help`, `ponytail-review`, `diagnosing-bugs`, `blast-radius`, `remember-project`.

## Model tiering (the token rule)

| Work | Agent | Model |
|---|---|---|
| Thinking, validation, planning, council | `strategist` | Fable |
| Adversarial verification after build and test | `verifier` | Fable |
| Plan, design, and ship review like a real PM | `pm` | Opus |
| UX flows, screens, states, tokens | `designer` | Sonnet |
| Implementation, chunk by chunk | `builder` | Sonnet |
| Driving the browser, collecting evidence | `tester` | Sonnet |
| Deploy, store upload, launch kit | `shipper` | Sonnet |
| Signal fetch and first filter | `scout` | Haiku |

Run the mission session itself on Sonnet (`claude --model sonnet`) when you want the cheapest run. The Fable agents do the thinking regardless of the session model.

## Human gates

Default gates: **plan** (after THINK) and **launch** (before anything public). `--yolo` drops the plan gate. The launch gate never drops for store submissions or public posts; HN and Product Hunt have no posting API anyway, so LAUNCH ends with a ready-to-paste kit.

Cost guards: 3 builder attempts per chunk, 3 test-fix loops per screen, then the mission pauses and reports. State lives in `<project>/.anbu/state.json` so `/mission <slug>` resumes where it stopped.

## Where it runs

- **Laptop:** `/mission` in a normal session. Testing uses Claude in Chrome (your real browser).
- **Cloud, laptop closed:** `claude --cloud` then `/mission <slug>`. Testing switches to Playwright MCP (headless). Deploy needs `VERCEL_TOKEN` in the cloud environment. See `routines/README.md` for the environment checklist and the network allowlist.
- **Scheduled:** `/prospect` (Sunday) and `/scan` (Friday) run as cloud routines. Alerts arrive as mobile push.

## Install on a fresh machine

Prerequisites: node 20+, git, `gh`, `jq`, and Claude Code with a claude.ai Pro or Max login. Then:

```bash
git clone git@github.com-personal:devanshchoudhary20/claude-anbu.git ~/developer/personal/claude-anbu
~/developer/personal/claude-anbu/setup.sh
```

`setup.sh` is idempotent, safe to rerun, and runs nine steps:

1. Check for node, `claude`, `gh`, `git`, and `jq` (jq only warns; without it the status line stays blank).
2. Link `skills/` and `agents/` into `~/.claude` (a pre-existing real skill directory is left alone, not overwritten).
3. Install `CLAUDE.md` as the global base layer, or skip if `~/.claude/CLAUDE.md` is already a symlink (another repo, such as `claude-cerebrum`, owns it there).
4. Merge `settings.json` into whatever is already at `~/.claude/settings.json`, or skip the same way if that path is a symlink.
5. Link `statusline-command.sh` into `~/.claude`.
6. Copy the durable memory files into this machine's project memory folders, without overwriting anything already there, and append only the missing `MEMORY.md` index lines.
7. Clone the idea vault to `~/developer/personal/idea-engine` and create `~/developer/personal/projects`.
8. Install the `vercel` and `chrome-webstore-upload-cli` npm CLIs.
9. Install the `frontend-design`, `pr-review-toolkit`, `figma`, and `github` Claude Code plugins, plus the Context7 and Playwright MCPs.

It then prints what stays manual: `gh auth login` for the personal account plus the `github.com-personal` SSH alias, `claude login` and `/web-setup`, the Claude in Chrome extension, and Figma plugin authorization on first use.

**Windows:** run it from Git Bash. Symlinks need admin rights or Developer Mode there, so `setup.sh` copies files instead of linking them. That means a `git pull` in `claude-anbu` doesn't update `~/.claude` on its own: rerun `setup.sh` after every pull.

**On this Mac:** `claude-cerebrum` layers on top and owns `~/.claude/CLAUDE.md` and `~/.claude/settings.json` as symlinks, so steps 3 and 4 skip here on purpose. Run `claude-cerebrum/setup.sh` to wire that layer in.

`uninstall.sh` removes only what `setup.sh` placed: the skill and agent links (or copies, on Windows) and the status line symlink. It leaves `CLAUDE.md`, `settings.json`, and the memory files alone, since those are merged or copied rather than linked and may carry edits of your own.

The cloud environment (network allowlist, Vercel credential, setup script) lives on your claude.ai account, not the machine, so it carries over. See `routines/README.md`.

## Layout

| Path | What |
|---|---|
| `skills/` | The 5 ANBU skills (`/mission` `/prospect` `/scan` `/idea` `/weekend`) plus the 13 portable base-layer skills. |
| `playbook/` | One file per phase: inputs, who runs, steps, gate, outputs. `/mission` reads one at a time. |
| `agents/` | The seven tiered subagents. |
| `RUBRIC.md` | The PM review (C). Rubrics A (weekend) and B (big-track SaaS) live in the vault's `scanner/RUBRIC.md`. |
| `routines/` | Prompts and config for the cloud prospect and scout, plus the cloud environment checklist. |
| `templates/` | Mission state, per-project CLAUDE.md, launch kit. |
| `ANBU.md` | The doctrine. Read it once. |

## Status

- [x] Skills, playbook, agents, rubric, routines, templates
- [x] `setup.sh` compose-linked into `~/.claude`
- [x] First mission shipped end to end through `/mission`: [pr-preflight](https://github.com/devanshchoudhary20/pr-preflight), 2026-09-24 (store upload manual)
- [x] Cloud environment: Custom allowlist, setup script, Vercel via API credential (verified 2026-09-24: `vercel whoami` works in the sandbox)
- [ ] Chrome Web Store credentials (needed only for automated extension upload)
- [x] First big-game milestone deployed through `/mission` in milestone mode: [sesh-live](https://github.com/devanshchoudhary20/sesh-live) M0 probe, 2026-09-25 (npm publish and the probe posts are the human's)
- [x] `/radar` routine created (weekly Sunday 8:00 IST, Fable) and `idea-scan` re-pointed at the dual-track prompt with WebSearch fallback
- [x] Moonshot merged into the big track, `/radar` replaced by `/prospect` (reads instead of skims, zero-ops SaaS gate), `idea-scan` cut to weekly weekend-only, 2026-09-27
