# 🥷 ANBU

> _the Hokage's black-ops unit: give it a mission, it comes back with a shipped product._

`claude-anbu` is the central Claude Code agent system for personal work. MEGAMIND (`claude-cerebrum`) is the company brain. ANBU is the personal one. One command takes an idea from "should this exist?" to a live URL with a launch post drafted, and a scheduled scout keeps the vault fed with both weekend builds and moonshots.

## The loop

```
  scout (cloud, cheap)  ──2-3x/week──▶  VAULT inbox  ◀── /idea (you)
  radar (cloud, Fable)  ──weekly────▶  moonshot shortlist + push alert on a first-mover signal
                                            │
                                     /weekend  → pick one
                                            │
                                     /mission <slug>
                                            │
   THINK ─▶ DESIGN ─▶ BUILD ─▶ TEST ─▶ SHIP ─▶ LAUNCH        (each phase gated, resumable)
   Fable     Sonnet    Sonnet   Sonnet  Sonnet   Sonnet
              +Fable verify after BUILD and TEST
```

The vault (ideas, board, profile) lives in `~/developer/personal/idea-engine`. Built products live in `~/developer/personal/projects/<slug>`. ANBU is only the brain and the hands.

## Commands

| Command | What | Model |
|---|---|---|
| `/mission <slug or one-liner> [--from phase] [--until phase] [--yolo]` | The master orchestrator. Runs `playbook/` end to end. | orchestrates; delegates by tier |
| `/scan` | Dual-track scout: weekend builds + moonshot signals. Cheap. | Haiku/Sonnet |
| `/radar` | Weekly moonshot deep-think against `RUBRIC.md`. Pushes an alert when a first-mover signal scores 8+. | Fable |
| `/idea <one-liner>` | Capture into the vault with a gut-check. | session |
| `/weekend [steer]` | Triage the inbox, validate a shortlist, pick one. | session + WebSearch |

## Model tiering (the token rule)

| Work | Agent | Model |
|---|---|---|
| Thinking, validation, planning, council | `strategist` | Fable |
| Adversarial verification after build and test | `verifier` | Fable |
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
- **Scheduled:** `/scan` and `/radar` run as cloud routines. Alerts arrive as mobile push.

## Install on a fresh machine

Prerequisites: node 20+, git, `gh`, Claude Code, and a claude.ai Pro or Max login. Then:

```bash
git clone git@github.com-personal:devanshchoudhary20/claude-anbu.git ~/developer/personal/claude-anbu
~/developer/personal/claude-anbu/setup.sh
```

`setup.sh` is idempotent. It links `skills/` and `agents/` into `~/.claude`, appends the ANBU section to `~/.claude/CLAUDE.md`, clones the vault to `~/developer/personal/idea-engine`, installs the `vercel` and `chrome-webstore-upload` CLIs, the `frontend-design` plugin, and the Context7 and Playwright MCPs, and prints the four things that stay manual: `gh auth login` for the personal account plus the `github.com-personal` SSH alias, `claude login` and `/web-setup`, the Claude in Chrome extension, and the Figma plugin authorization. `uninstall.sh` removes only ANBU's links.

The cloud environment (network allowlist, Vercel credential, setup script) lives on your claude.ai account, not the machine, so it carries over. See `routines/README.md`.

## Layout

| Path | What |
|---|---|
| `skills/` | `/mission` `/scan` `/radar` `/idea` `/weekend` |
| `playbook/` | One file per phase: inputs, who runs, steps, gate, outputs. `/mission` reads one at a time. |
| `agents/` | The seven tiered subagents. |
| `RUBRIC.md` | Two scorecards: weekend feasibility (0-10) and moonshot potential (0-10). |
| `routines/` | Prompts and config for the cloud scout and radar, plus the cloud environment checklist. |
| `templates/` | Mission state, per-project CLAUDE.md, launch kit. |
| `ANBU.md` | The doctrine. Read it once. |

## Status

- [x] Skills, playbook, agents, rubric, routines, templates
- [x] `setup.sh` compose-linked into `~/.claude`
- [x] First mission shipped end to end through `/mission`: [pr-preflight](https://github.com/devanshchoudhary20/pr-preflight), 2026-09-24 (store upload manual)
- [x] Cloud environment: Custom allowlist, setup script, Vercel via API credential (verified 2026-09-24: `vercel whoami` works in the sandbox)
- [ ] Chrome Web Store credentials (needed only for automated extension upload)
- [x] `/radar` routine created (weekly Sunday 8:00 IST, Fable) and `idea-scan` re-pointed at the dual-track prompt with WebSearch fallback
