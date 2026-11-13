# Personal overlay (ANBU)

Loads for every repo under `~/developer/personal/` (`setup.sh` links it to `~/developer/personal/CLAUDE.md`), on top of the global MEGAMIND base that `claude-cerebrum` owns at `~/.claude/CLAUDE.md`. Personal projects skip the company rules in that base: `/contract`, Jira, the `stage-*` PR flow. Everything else there still applies.

## ANBU — my personal agent

`~/developer/personal/claude-anbu/` is the personal counterpart to MEGAMIND. Vault of ideas at `~/developer/personal/idea-engine/`, products at `~/developer/personal/projects/<slug>/`.
- **`/mission <slug>`** — idea to live URL through six gated phases (`playbook/`), Fable thinks and verifies, Opus designs and reviews, Sonnet draws, builds, tests, ships. Resumable. `--yolo` drops the plan gate; the launch gate never drops.
- **`/prospect`** (weekly, Fable, cloud) feeds the big track: it reads threads, issues, newsletters, changelogs, and funding news, and files zero-ops SaaS ideas scored on Rubric B (push alert at 8+). **`/scan`** (weekly, cloud) feeds the weekend track on Rubric A. `/idea`, `/weekend` capture and pick.
- **`/pm`, `/verify`, `/design`** — one mission agent on its own, for a task too small for `/mission`. **`/retro <slug>`** turns a mission's failures and agent notes into reviewed edits to `learnings/`, the playbook, and the agents.
- **`/dojo`** — senior FE interview trainer: 12-module syllabus in `dojo/`, probe before teach, user builds in `~/developer/personal/fe-dojo`, Claude reviews as the panel, spaced reviews gate progress. Resumable from the ledger.

## Git

- Repos under `~/developer/personal/` use the personal GitHub account via the SSH alias `github.com-personal`, never a company account.
