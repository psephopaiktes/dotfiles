#!/bin/zsh
# dotfilesの基本的な構文と設定を検査する

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
cd "$REPO_ROOT"

echo "...check mise config"
mise fmt --check --all
mise tasks validate --errors-only

config_mise_min_version="$(mise config get --file .bin/.config/mise/config.toml min_version)"
init_mise_min_version="$(sed -n 's/^MISE_MIN_VERSION="\([^"]*\)"$/\1/p' init.sh)"
if [[ -z "$init_mise_min_version" || "$init_mise_min_version" != "$config_mise_min_version" ]]; then
  echo "init.shとmise configの最低バージョンが一致しません" >&2
  exit 1
fi

echo "...check zsh syntax"
zsh -n init.sh shell/*.sh .bin/.zshrc .bin/.zshenv

echo "...check bash syntax"
bash -n .bin/.claude/statusline.sh

echo "...check JSON syntax"
while IFS= read -r -d '' file; do
  plutil -convert json -o /dev/null "$file"
done < <(find .bin doc -type f -name '*.json' -print0)

echo "...check TOML syntax"
while IFS= read -r -d '' file; do
  if ! python -c 'import sys, tomllib; tomllib.load(open(sys.argv[1], "rb"))' "$file"; then
    echo "Invalid TOML: $file" >&2
    exit 1
  fi
done < <(find .bin -type f -name '*.toml' -print0)

echo "...check whitespace errors"
git diff --check
git diff --cached --check

echo "DONE"
