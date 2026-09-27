#!/usr/bin/env bash
# Remove only what setup.sh placed. Safe to rerun.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
CLAUDE=~/.claude
case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) WIN=1 ;; *) WIN=0 ;; esac

# unix: only remove a symlink that points at our copy; windows: setup.sh always overwrites with a fresh copy, so always remove
unlink_placed() {
  local target="$1" src="$2"
  if [ "$WIN" = 1 ]; then
    [ -e "$target" ] && rm -rf "$target"
  elif [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    rm -f "$target"
  fi
}

for d in "$ROOT"/skills/*/; do n="$(basename "$d")"; unlink_placed "$CLAUDE/skills/$n" "${d%/}"; done
for f in "$ROOT"/agents/*.md; do n="$(basename "$f")"; unlink_placed "$CLAUDE/agents/$n" "$f"; done

if [ -L "$CLAUDE/statusline-command.sh" ] && [ "$(readlink "$CLAUDE/statusline-command.sh")" = "$ROOT/statusline-command.sh" ]; then
  rm -f "$CLAUDE/statusline-command.sh"
  echo "statusline-command.sh: unlinked"
else
  echo "statusline-command.sh: left alone (not an ANBU symlink)"
fi

echo "ANBU skill and agent links removed."
echo "left in place on purpose: ~/.claude/CLAUDE.md, ~/.claude/settings.json, and the memory files under ~/.claude/projects/*/memory."
echo "setup.sh merged or copied those instead of linking them, and you may have edited them since, so uninstall won't touch them."
