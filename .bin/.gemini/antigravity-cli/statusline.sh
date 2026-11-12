#!/bin/bash
# Custom statusline for Antigravity CLI
# Styled after .zshrc PROMPT & Claude statusline: orange directory + git branch + model + context window usage

input=$(cat)

# --- Extract fields from input JSON (macOS built-in; no jq dependency) ---
json_get() {
  printf '%s' "$input" | plutil -extract "$1" raw -n -o - -- - 2>/dev/null
}

model=$(json_get "model.display_name")
[ -z "$model" ] && model=$(json_get "model")
[ -z "$model" ] && model="Antigravity"

cwd=$(json_get "workspace.current_dir")
[ -z "$cwd" ] && cwd=$(json_get "cwd")

# --- ANSI colors ---
RESET=$'\033[0m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
ORANGE=$'\033[38;5;178m'  # matches %F{178} from .zshrc PROMPT
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
GRAY=$'\033[38;5;247m'    # matches %F{247} from vcs_info

# --- Context window usage ---
ctx_pct=$(json_get "context_window.used_percentage")
[ -z "$ctx_pct" ] && ctx_pct=$(json_get "context_window_pct")

if [ -n "$ctx_pct" ]; then
  ctx_pct_int=$(printf "%.0f" "$ctx_pct")
  if [ "$ctx_pct_int" -lt 50 ]; then
    ctx_color="$GREEN"
  elif [ "$ctx_pct_int" -lt 80 ]; then
    ctx_color="$YELLOW"
  else
    ctx_color="$RED"
  fi
  ctx_display="${ctx_color}${ctx_pct_int}%${RESET}"
else
  ctx_display=""
fi

# --- Git branch ---
git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    git_indicators=""
    porcelain=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    staged_count=$(printf '%s\n' "$porcelain" | grep -c "^[MADRC]" 2>/dev/null || true)
    dirty_count=$(printf '%s\n' "$porcelain" | grep -Ec '^(\?\?|.[MD])' 2>/dev/null || true)
    [ "$dirty_count"  -gt 0 ] && git_indicators="${git_indicators} *${dirty_count}"
    [ "$staged_count" -gt 0 ] && git_indicators="${git_indicators} +${staged_count}"

    upstream=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref '@{u}' 2>/dev/null)
    if [ -n "$upstream" ]; then
      ahead_behind=$(git -C "$cwd" --no-optional-locks rev-list --left-right --count HEAD..."$upstream" 2>/dev/null)
      ahead=$(echo "$ahead_behind" | awk '{print $1}')
      behind=$(echo "$ahead_behind" | awk '{print $2}')
      [ "$ahead"  -gt 0 ] && git_indicators="${git_indicators} ↑${ahead}"
      [ "$behind" -gt 0 ] && git_indicators="${git_indicators} ↓${behind}"
    fi

    git_branch="${GRAY}[ ${branch}${git_indicators} ]${RESET}"
  fi
fi

# --- Directory display ---
home_dir="$HOME"
if [ -n "$cwd" ]; then
  display_dir="${cwd/#$home_dir/~}"
else
  display_dir="~"
fi

# --- Build output ---
sep="${DIM} | ${RESET}"
output="${ORANGE}${display_dir}${RESET}"
[ -n "$git_branch" ] && output="${output} ${git_branch}"
[ -n "$ctx_display" ] && output="${output}${sep}${BOLD}${model}${RESET}${sep}ctx: ${ctx_display}"
[ -z "$ctx_display" ] && output="${output}${sep}${BOLD}${model}${RESET}"

printf "%b" "$output"
