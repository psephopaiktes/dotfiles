#!/bin/zsh

set -euo pipefail

if [[ "${OSTYPE:-}" != darwin* ]]; then
  echo "Error: このスクリプトはmacOS専用です" >&2
  exit 1
fi

if [[ $(uname -m) != "arm64" ]]; then
  echo "Error: This script is for Apple Silicon Mac only." >&2
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
    echo "Command line tools not found. Installing..."
    xcode-select --install || true
    echo "Re-run this script after the installation finishes." >&2
    exit 1
  fi
fi

# gitコマンドの存在確認
if (( needs_git )); then
  echo "git not found. Please open a new terminal and re-run." >&2
  exit 1
fi

# makeコマンドの存在確認
if (( needs_make )); then
  echo "make not found. Please open a new terminal and re-run." >&2
  exit 1
fi

# dotfilesリポジトリのクローン/更新
echo "...Clone dotfiles"
if [[ -d "$DOTPATH/.git" ]]; then
  if git -C "$DOTPATH" diff --quiet && git -C "$DOTPATH" diff --cached --quiet; then
    if ! git -C "$DOTPATH" pull --ff-only; then
      echo "Warning: pull failed, skipped update: $DOTPATH" >&2
    fi
  else
    echo "Warning: local changes detected, skipped update: $DOTPATH" >&2
  fi
else
  git clone "$GITHUB_URL" "$DOTPATH"
fi

# セットアップ実行（link, install, defaults）
echo "...Run make all"
cd "$DOTPATH"
make all

echo "DONE"
