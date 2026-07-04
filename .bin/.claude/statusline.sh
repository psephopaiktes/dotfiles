#!/bin/bash
# Custom statusline for Claude Code
# Styled after .zshrc PROMPT: orange directory + git branch
# Reads JSON from stdin and outputs formatted status line.

input=$(cat)

# --- Extract fields from input JSON ---
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')

# --- ANSI colors ---
RESET=$'\033[0m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
ORANGE=$'\033[38;5;178m'  # matches %F{178} from .zshrc PROMPT
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
GRAY=$'\033[38;5;247m'    # matches %F{247} from vcs_info

# --- Context window usage (from pre-calculated fields) ---
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

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

# --- Git branch (styled like vcs_info in .zshrc) ---
git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    # Dirty / staged counts via --porcelain (fast, single pass)
    git_indicators=""
    porcelain=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    staged_count=$(echo "$porcelain" | grep -c "^[MADRC]" 2>/dev/null || echo 0)
    dirty_count=$(echo "$porcelain"  | grep -c "^.[MD]"   2>/dev/null || echo 0)
    [ "$dirty_count"  -gt 0 ] && git_indicators="${git_indicators} *${dirty_count}"
    [ "$staged_count" -gt 0 ] && git_indicators="${git_indicators} +${staged_count}"

    # Ahead / behind via rev-list (skips lock acquisition with --no-optional-locks)
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

# --- Directory display (styled like %~ in .zshrc) ---
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
