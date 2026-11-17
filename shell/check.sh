#!/bin/zsh
# 外部状態を変更せず、dotfilesの基本的な構文を検査する

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
cd "$REPO_ROOT"

echo "...check mise config"
mise fmt --check --all
mise tasks validate --errors-only

echo "...check zsh syntax"
zsh -n init.sh shell/*.sh .bin/.zshrc .bin/.zshenv

echo "...check bash syntax"
bash -n .bin/.claude/statusline.sh .bin/.gemini/antigravity-cli/statusline.sh

echo "...check JSON syntax"
while IFS= read -r -d '' file; do
  plutil -convert json -o /dev/null "$file"
done < <(find .bin doc -type f -name '*.json' -print0)

echo "...check whitespace errors"
git diff --check

echo "DONE"
