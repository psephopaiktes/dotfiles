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

if command -v git-lfs >/dev/null 2>&1; then
    git lfs install
fi

# Cleanup
brew cleanup


# -----------------------------------------------------------------------------
# Node, Python
# -----------------------------------------------------------------------------

# miseによるNode.js、Python、npm CLIのインストール
echo "...install mise tools"
mise install

# mise環境設定
eval "$(mise activate zsh --shims)"
eval "$(mise hook-env)"


# -----------------------------------------------------------------------------
# clone
# -----------------------------------------------------------------------------

if ! gh auth status -h github.com >/dev/null 2>&1; then
	gh auth login
fi

# Agent Skillsを公式配布元から取得し、Codex・Claude Code・Gemini CLIへリンク
zsh "$REPO_ROOT/shell/update-skills.sh" --sync

# Claude CodeのユーザースコープMCPは~/.claude.jsonに保存されるためCLIで登録
if command -v claude >/dev/null 2>&1; then
    # 既存設定も正しいコマンドへ収束させる
    claude mcp remove figma --scope user >/dev/null 2>&1 || true
    claude mcp add --scope user --transport http figma https://mcp.figma.com/mcp

    claude mcp remove chrome-devtools --scope user >/dev/null 2>&1 || true
    claude mcp add --scope user chrome-devtools -- \
        /opt/homebrew/bin/mise x -- chrome-devtools-mcp --categoryExtensions --memoryDebugging

    # 旧dotfilesで登録したFirebase MCPを除去
    claude mcp remove firebase --scope user >/dev/null 2>&1 || true
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
echo "DONE"
