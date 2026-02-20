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
if ! git --version &> /dev/null || ! make --version &> /dev/null; then
  echo "エラー: Command Line Toolsが見つかりません。" >&2
  echo "先に以下を実行してインストールを完了させてください:" >&2
  echo "  xcode-select --install" >&2
  exit 1
fi

GITHUB_URL="https://github.com/psephopaiktes/dotfiles.git"
DOTPATH="${DOTPATH:-$HOME/projects/dotfiles}"

mkdir -p "$HOME/projects"

# dotfilesリポジトリのクローン/更新
echo "...Clone dotfiles"
if [[ -d "$DOTPATH/.git" ]]; then
  if git -C "$DOTPATH" diff --quiet && git -C "$DOTPATH" diff --cached --quiet; then
    if ! git -C "$DOTPATH" pull --ff-only; then
      echo "警告: pullに失敗しました。更新をスキップします: $DOTPATH" >&2
    fi
  else
    echo "警告: ローカルに変更があるため、更新をスキップします: $DOTPATH" >&2
  fi
else
  git clone "$GITHUB_URL" "$DOTPATH"
fi

# セットアップ実行（link, install, defaults）
echo "...Run make all"
cd "$DOTPATH"
make all

echo "DONE"
