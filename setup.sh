#!/usr/bin/env bash
# One-shot bootstrap for a fresh machine. Idempotent: safe to rerun.
# macOS/Linux symlink into ~/.claude; Windows (Git Bash) copies, so rerun after every git pull there.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
PERSONAL=~/developer/personal
CLAUDE=~/.claude
CEREBRUM=~/developer/company/claude-cerebrum
case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) WIN=1 ;; *) WIN=0 ;; esac
ok()   { printf '  \033[32m✔\033[0m %s\n' "$1"; }
skip() { printf '  \033[33m–\033[0m %s\n' "$1"; }
need() { printf '  \033[31m✘\033[0m %s\n' "$1"; MISSING=1; }
MISSING=0

# symlink on unix, copy on windows (symlinks there need admin or Developer Mode)
place() { if [ "$WIN" = 1 ]; then rm -rf "$2"; cp -R "$1" "$2"; else ln -sfn "$1" "$2"; fi; }
# ~/.claude/projects/<key> is the project path with every non-alphanumeric turned into '-'
project_key() { local p="$1"; [ "$WIN" = 1 ] && p="$(cygpath -w "$p")"; printf '%s' "$p" | sed 's/[^A-Za-z0-9]/-/g'; }

echo "1/9 prerequisites"
command -v node   >/dev/null && ok "node $(node -v)" || need "node 20+ (https://nodejs.org)"
command -v claude >/dev/null && ok "claude $(claude --version 2>/dev/null | head -1)" || need "claude code (npm i -g @anthropic-ai/claude-code)"
command -v gh     >/dev/null && ok "gh $(gh --version | head -1 | cut -d' ' -f3)" || need "gh cli (brew install gh | winget install GitHub.cli)"
command -v git    >/dev/null && ok "git" || need "git (Windows: Git for Windows, Claude Code needs its Git Bash)"
command -v jq     >/dev/null && ok "jq" || skip "jq missing: the status line stays blank until 'brew install jq' | 'winget install jqlang.jq'"
[ "$MISSING" = 1 ] && { echo "install the missing tools, then rerun."; exit 1; }

echo "2/9 skills and agents → ~/.claude"
mkdir -p "$CLAUDE/skills" "$CLAUDE/agents"
for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"; target="$CLAUDE/skills/$name"
  if [ -e "$target" ] && [ ! -L "$target" ] && [ "$WIN" = 0 ]; then skip "$name: real dir exists, left alone"; continue; fi
  place "${d%/}" "$target"; ok "skill $name"
done
for f in "$ROOT"/agents/*.md; do place "$f" "$CLAUDE/agents/$(basename "$f")"; ok "agent $(basename "$f" .md)"; done

echo "3/9 global CLAUDE.md (base layer)"
if [ -L "$CLAUDE/CLAUDE.md" ] && [ "$WIN" = 0 ]; then skip "CLAUDE.md is a symlink (cerebrum owns it and imports this base)"
elif [ -f "$CLAUDE/CLAUDE.md" ] && cmp -s "$CLAUDE/CLAUDE.md" "$ROOT/CLAUDE.md"; then skip "CLAUDE.md up to date"
else
  [ -f "$CLAUDE/CLAUDE.md" ] && { cp "$CLAUDE/CLAUDE.md" "$CLAUDE/CLAUDE.md.pre-anbu.$(date +%s)"; skip "existing CLAUDE.md backed up"; }
  cp "$ROOT/CLAUDE.md" "$CLAUDE/CLAUDE.md"; ok "CLAUDE.md installed"
fi

echo "4/9 settings.json (base layer, merged over what exists)"
if [ -L "$CLAUDE/settings.json" ] && [ "$WIN" = 0 ]; then skip "settings.json is a symlink (cerebrum owns it)"
else
  node -e '
const fs=require("fs");const [ex,base]=process.argv.slice(1);
const read=p=>{try{return JSON.parse(fs.readFileSync(p,"utf8"))}catch{return {}}};
const a=read(ex),b=read(base),ap=a.permissions||{},bp=b.permissions||{};
const m={...a,...b};
m.permissions={...ap,...bp,allow:[...new Set([...(ap.allow||[]),...(bp.allow||[])])],deny:[...new Set([...(ap.deny||[]),...(bp.deny||[])])]};
m.enabledPlugins={...(a.enabledPlugins||{}),...(b.enabledPlugins||{})};
fs.writeFileSync(ex,JSON.stringify(m,null,2)+"\n");' "$CLAUDE/settings.json" "$ROOT/settings.json" && ok "settings.json merged" || need "settings.json merge failed"
fi

echo "5/9 status line"
place "$ROOT/statusline-command.sh" "$CLAUDE/statusline-command.sh"; ok "statusline-command.sh"

echo "6/9 memory (durable personal preferences → project memory)"
for proj in "$PERSONAL" "$PERSONAL/idea-engine"; do
  dir="$CLAUDE/projects/$(project_key "$proj")/memory"; mkdir -p "$dir"
  for f in "$ROOT"/memory/*.md; do n="$(basename "$f")"; [ "$n" = MEMORY.md ] && continue; [ -e "$dir/$n" ] || cp "$f" "$dir/$n"; done
  [ -f "$dir/MEMORY.md" ] || printf '# Memory Index\n\n' > "$dir/MEMORY.md"
  while IFS= read -r line; do ref="$(printf '%s' "$line" | sed -n 's/.*](\([^)]*\)).*/\1/p')"; grep -qF "($ref)" "$dir/MEMORY.md" || printf '%s\n' "$line" >> "$dir/MEMORY.md"; done < "$ROOT/memory/MEMORY.md"
  ok "memory → $(basename "$proj")"
done

echo "7/9 vault and projects"
mkdir -p "$PERSONAL/projects"
if [ -d "$PERSONAL/idea-engine/.git" ]; then skip "vault present"; else
  git clone -q git@github.com-personal:devanshchoudhary20/idea-engine.git "$PERSONAL/idea-engine" 2>/dev/null \
  || git clone -q https://github.com/devanshchoudhary20/idea-engine.git "$PERSONAL/idea-engine" && ok "vault cloned"; fi

echo "8/9 npm CLIs (vercel, chrome-webstore-upload-cli, pen.dev)"
for pkg in vercel chrome-webstore-upload-cli; do
  bin="${pkg%-cli}"; command -v "$bin" >/dev/null && skip "$pkg present" || { npm i -g "$pkg" >/dev/null 2>&1 && ok "$pkg installed" || need "$pkg (npm i -g $pkg)"; }
done
command -v pen >/dev/null && skip "@pen.dev/cli present" || { npm i -g @pen.dev/cli >/dev/null 2>&1 && ok "@pen.dev/cli installed" || need "@pen.dev/cli (npm i -g @pen.dev/cli)"; }

echo "9/9 Claude Code plugins + MCP servers"
PLUGINS="$(claude plugin list 2>/dev/null)"; MCPS="$(claude mcp list 2>/dev/null)"
for p in frontend-design pr-review-toolkit figma; do
  printf '%s' "$PLUGINS" | grep -q "$p@" && skip "$p plugin present" \
  || { claude plugin install "$p@claude-plugins-official" >/dev/null 2>&1 && ok "$p plugin" || need "$p plugin (claude plugin install $p@claude-plugins-official)"; }
done
printf '%s' "$MCPS" | grep -qiE '^github:|github@' && skip "github MCP present" \
  || { claude plugin install github@claude-plugins-official >/dev/null 2>&1 && ok "github plugin" || need "github plugin (claude plugin install github@claude-plugins-official)"; }
printf '%s' "$MCPS" | grep -q '^context7:'   && skip "context7 MCP present"   || { claude mcp add --scope user context7   -- npx -y @upstash/context7-mcp >/dev/null 2>&1 && ok "context7 MCP"; }
printf '%s' "$MCPS" | grep -q '^playwright:' && skip "playwright MCP present" || { claude mcp add --scope user playwright -- npx -y @playwright/mcp@latest >/dev/null 2>&1 && ok "playwright MCP"; }
(npx -y @playwright/mcp@latest --version >/dev/null 2>&1 && ok "playwright MCP package warmed") || skip "playwright warm-up failed, it will download on first use"

echo "manual, once per machine"
echo "  - gh auth login for the personal account, and an SSH host alias 'github.com-personal' in ~/.ssh/config"
echo "  - claude login (Pro/Max) and /web-setup once, so cloud sessions and routines can reach your repos"
echo "  - Claude in Chrome extension installed and enabled, for local TEST phases"
echo "  - pen login (pen.dev, personal account), so the designer can draw screens headless"
[ "$WIN" = 1 ] && echo "  - Windows: files were copied, not linked. Rerun setup.sh after every 'git pull' in claude-anbu."
[ -d "$CEREBRUM" ] && [ ! -L "$CLAUDE/CLAUDE.md" ] && echo "  - company machine: run $CEREBRUM/setup.sh to layer MEGAMIND on top"
echo
echo "ANBU ready. Restart Claude Code, then: cd $PERSONAL/idea-engine && /weekend"
