#!/bin/zsh

set -euo pipefail

if [[ "${OSTYPE:-}" != darwin* ]]; then
  echo "Error: このスクリプトはmacOS専用です" >&2
  exit 1
fi

if [[ $(uname -m) != "arm64" ]]; then
  echo "Error: このスクリプトはApple Silicon Mac専用です" >&2
  exit 1
fi

GITHUB_URL="https://github.com/psephopaiktes/dotfiles.git"
DOTPATH="${DOTPATH:-$HOME/projects/dotfiles}"

mkdir -p "$HOME/projects"

# Command Line Toolsの確認とインストール
needs_git=0
needs_make=0
command -v git >/dev/null 2>&1 || needs_git=1
command -v make >/dev/null 2>&1 || needs_make=1

if (( needs_git || needs_make )); then
  if ! xcode-select --print-path &> /dev/null; then
    echo "Command Line Toolsが見つかりません。インストールを開始します..."
    xcode-select --install || true

    echo "ポップアップの「インストール」を押してください。完了まで待機中..."
    until git --version &> /dev/null && make --version &> /dev/null; do
      sleep 5
      echo "インストール中..."
    done
    echo "Command Line Toolsのインストールが完了しました。"
  fi
fi

# gitコマンドの存在確認
if ! git --version &> /dev/null; then
  echo "エラー: gitが見つかりません。新しいターミナルを開いて再実行してください。" >&2
  exit 1
fi

# makeコマンドの存在確認
if ! make --version &> /dev/null; then
  echo "エラー: makeが見つかりません。新しいターミナルを開いて再実行してください。" >&2
  exit 1
fi

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
