#!/usr/bin/env bash
# Compose-link ANBU skills and agents into ~/.claude next to cerebrum's.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.claude/skills ~/.claude/agents
for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  target=~/.claude/skills/"$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then echo "skip $name: real dir exists"; continue; fi
  ln -sfn "$d" "$target"; echo "linked skill $name"
done
for f in "$ROOT"/agents/*.md; do
  name="$(basename "$f")"
  ln -sfn "$f" ~/.claude/agents/"$name"; echo "linked agent $name"
done
mkdir -p ~/developer/personal/projects
echo "ANBU linked. Restart Claude Code to load."
