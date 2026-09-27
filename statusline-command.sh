#!/bin/sh
# Claude Code status line — robbyrussell Oh My Zsh style

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Token counts from last API call
in_tok=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
out_tok=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // empty')

# Rate limits
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

# Folder name (basename of cwd)
if [ -n "$cwd" ]; then
  folder=$(basename "$cwd")
else
  folder=$(basename "$(pwd)")
fi

# Git branch (skip optional locks)
branch=""
if git -C "${cwd:-$(pwd)}" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "${cwd:-$(pwd)}" symbolic-ref --short HEAD 2>/dev/null \
            || git -C "${cwd:-$(pwd)}" rev-parse --short HEAD 2>/dev/null)
fi

# Helper: build a compact N-block progress bar (arg1=pct, arg2=width)
make_bar() {
  _pct="$1"; _width="$2"
  _filled=$(( _pct * _width / 100 ))
  _empty=$(( _width - _filled ))
  _bar=""; _i=0
  while [ $_i -lt $_filled ]; do _bar="${_bar}█"; _i=$(( _i + 1 )); done
  _i=0
  while [ $_i -lt $_empty ]; do _bar="${_bar}░"; _i=$(( _i + 1 )); done
  printf '%s' "$_bar"
}

# Helper: human-readable token count (e.g. 12k, 1.2M)
fmt_tok() {
  _n="$1"
  if [ "$_n" -ge 1000000 ] 2>/dev/null; then
    printf '%.1fM' "$(echo "$_n 1000000" | awk '{printf "%.1f", $1/$2}')"
  elif [ "$_n" -ge 1000 ] 2>/dev/null; then
    printf '%dk' "$(( _n / 1000 ))"
  else
    printf '%d' "$_n"
  fi
}

# Helper: seconds → "Xh Ym" until reset
fmt_reset() {
  _now=$(date +%s)
  _diff=$(( $1 - _now ))
  if [ $_diff -le 0 ]; then
    printf 'soon'
  else
    _h=$(( _diff / 3600 ))
    _m=$(( (_diff % 3600) / 60 ))
    if [ $_h -gt 0 ]; then
      printf '%dh%dm' "$_h" "$_m"
    else
      printf '%dm' "$_m"
    fi
  fi
}

# ── Build the line ──────────────────────────────────────────────

# Arrow + folder
printf "\033[32m➜\033[0m  \033[36m%s\033[0m" "$folder"

# Git branch
if [ -n "$branch" ]; then
  printf "  \033[33mgit:(%s)\033[0m" "$branch"
fi

# Model
if [ -n "$model" ]; then
  printf "  \033[35m%s\033[0m" "$model"
fi

# Context usage bar (20 blocks)
if [ -n "$used" ]; then
  pct=$(printf '%.0f' "$used")
  bar=$(make_bar "$pct" 20)
  printf "  ctx:[%s] %s%%" "$bar" "$pct"
fi

# Token usage (last call): in / out / cache-read
if [ -n "$in_tok" ] && [ -n "$out_tok" ]; then
  in_fmt=$(fmt_tok "$in_tok")
  out_fmt=$(fmt_tok "$out_tok")
  if [ -n "$cache_read" ] && [ "$cache_read" -gt 0 ] 2>/dev/null; then
    cr_fmt=$(fmt_tok "$cache_read")
    printf "  \033[90mtok: %s↓ %s↑ %s$\033[0m" "$in_fmt" "$out_fmt" "$cr_fmt"
  else
    printf "  \033[90mtok: %s↓ %s↑\033[0m" "$in_fmt" "$out_fmt"
  fi
fi

# Rate limit bars (only shown when data is present)
if [ -n "$five_pct" ]; then
  fp=$(printf '%.0f' "$five_pct")
  fbar=$(make_bar "$fp" 10)
  if [ -n "$five_reset" ]; then
    reset_str=$(fmt_reset "$five_reset")
    printf "  \033[90m5h:[%s] %s%% (%s)\033[0m" "$fbar" "$fp" "$reset_str"
  else
    printf "  \033[90m5h:[%s] %s%%\033[0m" "$fbar" "$fp"
  fi
fi


printf "\n"
