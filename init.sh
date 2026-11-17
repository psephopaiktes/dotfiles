#!/bin/zsh

set -euo pipefail

if [[ "${OSTYPE:-}" != darwin* ]]; then
  echo "エラー: このスクリプトはmacOS専用です" >&2
  exit 1
fi

if [[ $(uname -m) != "arm64" ]]; then
  echo "エラー: このスクリプトはApple Silicon Mac専用です" >&2
  exit 1
fi

# Command Line Toolsの確認
if ! git --version &> /dev/null; then
  echo "エラー: Command Line Toolsが見つかりません。" >&2
  echo "先に以下を実行してインストールを完了させてください:" >&2
  echo "  xcode-select --install" >&2
  exit 1
fi

GITHUB_URL="https://github.com/psephopaiktes/dotfiles.git"
DOTPATH="$HOME/projects/dotfiles"

mkdir -p "$HOME/projects"

# miseがなければ公式インストーラーで導入
MISE_BIN="$(command -v mise || true)"
if [[ -z "$MISE_BIN" ]]; then
  echo "...Install mise"
  curl -fsSL https://mise.run | sh
  MISE_BIN="$HOME/.local/bin/mise"
fi

if [[ ! -x "$MISE_BIN" ]]; then
  echo "エラー: miseのインストールに失敗しました" >&2
  exit 1
fi

echo "...Bootstrap Mac"
"$MISE_BIN" bootstrap \
  --from "$GITHUB_URL" \
  --from-dir "$DOTPATH" \
  --config-dir .bin/.config/mise \
  --update \
  --yes

echo "DONE"
