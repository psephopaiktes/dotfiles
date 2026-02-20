#!/bin/zsh
# Homebrew、Node.js、Python環境の構築など

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
cd "$REPO_ROOT"


# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------

# Install
echo "...install brew"

if ! command -v brew >/dev/null 2>&1; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# PATH
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "brew not found after install" >&2
    exit 1
fi

# Brewfile
BREWFILE="$HOME/.Brewfile"

if [[ ! -f "$BREWFILE" ]]; then
    echo "Brewfile not found: $BREWFILE" >&2
    echo "Run shell/link.sh first to create the symlink (from dotfiles/.bin/.Brewfile)." >&2
    exit 1
fi

echo "...brew bundle ($BREWFILE)"
brew bundle --file="$BREWFILE"

# Cleanup
brew cleanup


# -----------------------------------------------------------------------------
# Node, Python
# -----------------------------------------------------------------------------

# miseによるNode.jsのインストール
echo "...install NODEs"
mise use -g node@lts

# npmグローバルパッケージのインストール
echo "...install npm global packages"

# mise環境設定
eval "$(mise activate zsh --shims)"
eval "$(mise hook-env)"

# npmグローバルパッケージリストの読み込み
NPM_GLOBAL_FILE="$REPO_ROOT/.bin/.npm-global"
if [[ -f "$NPM_GLOBAL_FILE" ]]; then
    while IFS= read -r package; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        npm install -g "$package"
    done < "$NPM_GLOBAL_FILE"
else
    echo "Warning: $NPM_GLOBAL_FILE not found, skipping global npm packages" >&2
fi

# uvによるPythonのインストール
echo "...install PYTHONs"
uv python install


# -----------------------------------------------------------------------------
# clone
# -----------------------------------------------------------------------------

if ! gh auth status -h github.com >/dev/null 2>&1; then
	gh auth login
fi

mkdir -p "$HOME/projects"

echo "...clone repositories"
sync_repo() {
	local repo_name="$1"
	local repo_dir="$2"
	if [[ -d "$repo_dir/.git" ]]; then
		git -C "$repo_dir" pull --ff-only || echo "Warning: pull failed, skipped: $repo_dir" >&2
	else
		gh repo clone "$repo_name" "$repo_dir"
	fi
}

sync_repo psephopaiktes/chrome-stylize "$HOME/projects/chrome-stylize"
sync_repo psephopaiktes/hira.page "$HOME/projects/hira.page"


# -----------------------------------------------------------------------------
# Generate .env
# -----------------------------------------------------------------------------

# .envファイルの生成（存在しない場合のみ）
if [[ ! -f .env ]]; then
    cp .env.example .env
fi


echo "DONE"
