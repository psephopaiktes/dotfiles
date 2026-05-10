#!/bin/bash
# Custom statusline for Claude Code
# Reads JSON from stdin and outputs formatted status line.

input=$(cat)

# --- Extract fields from input JSON ---
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
transcript=$(echo "$input" | jq -r '.transcript_path // ""')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')

# --- ANSI colors ---
RESET=$'\033[0m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
CYAN=$'\033[36m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
MAGENTA=$'\033[35m'

# --- Context window usage ---
ctx_tokens=0
ctx_pct=0
ctx_limit=200000
if [ -f "$transcript" ]; then
  ctx_tokens=$(jq -r 'select(.message.usage) | (.message.usage.input_tokens // 0) + (.message.usage.cache_read_input_tokens // 0) + (.message.usage.cache_creation_input_tokens // 0)' "$transcript" 2>/dev/null | tail -1)
  if [ -z "$ctx_tokens" ] || [ "$ctx_tokens" = "null" ]; then
    ctx_tokens=0
  fi
  ctx_pct=$(awk -v t="$ctx_tokens" -v l="$ctx_limit" 'BEGIN { printf "%.0f", t * 100 / l }')
fi

# Color by usage
if [ "$ctx_pct" -lt 50 ]; then
  ctx_color="$GREEN"
elif [ "$ctx_pct" -lt 80 ]; then
  ctx_color="$YELLOW"
else
  ctx_color="$RED"
fi

# --- Git branch ---
git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd" ]; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    git_branch="${MAGENTA} ${branch}${RESET}"
  fi
fi

# --- Format helpers ---
ctx_tokens_fmt=$(awk -v t="$ctx_tokens" 'BEGIN {
  if (t >= 1000) printf "%.1fk", t/1000;
  else printf "%d", t;
}')
cost_fmt=$(awk -v c="$cost_usd" 'BEGIN { printf "%.4f", c }')

# --- Build output ---
sep="${DIM} | ${RESET}"
output="${CYAN}●${RESET} ${BOLD}${model}${RESET}"
[ -n "$git_branch" ] && output="${output}${sep}${git_branch}"
output="${output}${sep}${ctx_color}${ctx_pct}% (${ctx_tokens_fmt})${RESET}"
output="${output}${sep}${GREEN}\$${cost_fmt}${RESET}"
if [ "$lines_added" -gt 0 ] || [ "$lines_removed" -gt 0 ]; then
  output="${output}${sep}${GREEN}+${lines_added}${RESET}/${RED}-${lines_removed}${RESET}"
fi

printf "%b" "$output"
