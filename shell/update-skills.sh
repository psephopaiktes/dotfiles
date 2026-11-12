#!/bin/zsh
# Agent Skillsと、それらが使用するCLIを最新版へ更新

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
mode="${1:---sync}"

case "$mode" in
  --sync)
    if command -v mise >/dev/null 2>&1; then
      echo "...update Agent Skills CLI dependencies"
      mise upgrade \
        'npm:@playwright/cli' \
        'npm:chrome-devtools-mcp'
    fi
    zsh "$REPO_ROOT/shell/sync-skills.sh" --sync
    ;;
  --check)
    if command -v mise >/dev/null 2>&1; then
      echo "...check Agent Skills CLI dependencies"
      mise upgrade --dry-run \
        'npm:@playwright/cli' \
        'npm:chrome-devtools-mcp'
    fi
    zsh "$REPO_ROOT/shell/sync-skills.sh" --check
    ;;
  *)
    echo "Usage: $0 [--sync|--check]" >&2
    exit 2
    ;;
esac

echo "DONE"
