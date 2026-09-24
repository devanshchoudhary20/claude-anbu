#!/usr/bin/env bash
# One-shot bootstrap for a fresh machine. Idempotent: safe to rerun.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
PERSONAL=~/developer/personal
ok()   { printf '  \033[32m✔\033[0m %s\n' "$1"; }
skip() { printf '  \033[33m–\033[0m %s\n' "$1"; }
need() { printf '  \033[31m✘\033[0m %s\n' "$1"; MISSING=1; }
MISSING=0

echo "1/7 prerequisites"
command -v node   >/dev/null && ok "node $(node -v)"        || need "node 20+ (https://nodejs.org)"
command -v claude >/dev/null && ok "claude $(claude --version 2>/dev/null | head -1)" || need "claude code (npm i -g @anthropic-ai/claude-code)"
command -v gh     >/dev/null && ok "gh $(gh --version | head -1 | cut -d' ' -f3)" || need "gh cli (brew install gh)"
command -v git    >/dev/null && ok "git" || need "git"
[ "$MISSING" = 1 ] && { echo "install the missing tools, then rerun."; exit 1; }

echo "2/7 skills and agents → ~/.claude"
mkdir -p ~/.claude/skills ~/.claude/agents
for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"; target=~/.claude/skills/"$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then skip "$name: real dir exists, left alone"; continue; fi
  ln -sfn "$d" "$target"; ok "skill $name"
done
for f in "$ROOT"/agents/*.md; do ln -sfn "$f" ~/.claude/agents/"$(basename "$f")"; ok "agent $(basename "$f" .md)"; done

echo "3/7 global CLAUDE.md section"
mkdir -p ~/.claude; touch ~/.claude/CLAUDE.md
if grep -q "## ANBU" ~/.claude/CLAUDE.md; then skip "ANBU section present"; else cat "$ROOT/templates/CLAUDE-section.md" >> ~/.claude/CLAUDE.md; ok "ANBU section appended"; fi

echo "4/7 vault and projects"
mkdir -p "$PERSONAL/projects"
if [ -d "$PERSONAL/idea-engine/.git" ]; then skip "vault present"; else
  git clone -q git@github.com-personal:devanshchoudhary20/idea-engine.git "$PERSONAL/idea-engine" 2>/dev/null \
  || git clone -q https://github.com/devanshchoudhary20/idea-engine.git "$PERSONAL/idea-engine" && ok "vault cloned"; fi

echo "5/7 npm CLIs (vercel, chrome-webstore-upload-cli)"
for pkg in vercel chrome-webstore-upload-cli; do
  bin="${pkg%-cli}"; command -v "$bin" >/dev/null && skip "$pkg present" || { npm i -g "$pkg" >/dev/null 2>&1 && ok "$pkg installed" || need "$pkg (npm i -g $pkg)"; }
done

echo "6/7 Claude Code plugin + MCP servers"
claude plugin list 2>/dev/null | grep -q frontend-design && skip "frontend-design plugin present" \
  || { claude plugin install frontend-design@claude-plugins-official >/dev/null 2>&1 && ok "frontend-design plugin" || need "frontend-design plugin (claude plugin install frontend-design@claude-plugins-official)"; }
claude mcp list 2>/dev/null | grep -q '^context7:'   && skip "context7 MCP present"   || { claude mcp add --scope user context7   -- npx -y @upstash/context7-mcp >/dev/null 2>&1 && ok "context7 MCP"; }
claude mcp list 2>/dev/null | grep -q '^playwright:' && skip "playwright MCP present" || { claude mcp add --scope user playwright -- npx -y @playwright/mcp@latest >/dev/null 2>&1 && ok "playwright MCP"; }
(npx -y @playwright/mcp@latest --version >/dev/null 2>&1 && ok "playwright MCP package warmed") || skip "playwright warm-up failed, it will download on first use"

echo "7/7 manual, once per machine"
echo "  - gh auth login for the personal account, and an SSH host alias 'github.com-personal' in ~/.ssh/config"
echo "  - claude login (Pro/Max) and /web-setup once, so cloud sessions and routines can reach your repos"
echo "  - Claude in Chrome extension installed and enabled, for local TEST phases"
echo "  - Figma: the plugin is in the official marketplace; run 'claude plugin install figma@claude-plugins-official' and authorize on first use"
echo
echo "ANBU ready. Restart Claude Code, then: cd $PERSONAL/idea-engine && /weekend"
