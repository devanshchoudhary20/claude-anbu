#!/usr/bin/env bash
# Remove only ANBU's links.
ROOT="$(cd "$(dirname "$0")" && pwd)"
for d in "$ROOT"/skills/*/; do rm -f ~/.claude/skills/"$(basename "$d")"; done
for f in "$ROOT"/agents/*.md; do rm -f ~/.claude/agents/"$(basename "$f")"; done
echo "ANBU unlinked."
