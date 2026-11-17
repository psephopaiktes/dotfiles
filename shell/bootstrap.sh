#!/bin/zsh
# miseで宣言できない、対話やCLI経由の初期設定

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

install_mas_apps() {
  if ! command -v mas >/dev/null 2>&1; then
    echo "mas command not found after package installation" >&2
    return 1
  fi

  # packagesフェーズ開始時にmasがPATH上にない新規Mac向けに、導入後に再適用する
  mise -C "$HOME" bootstrap packages apply --manager mas --yes
}

install_switchbot_screen_saver() {
  local version="1.0.1"
  local checksum="72124a7b432b1f373256b9dcf0f8302f4971584236050598c0cfb9f1204c87a5"
  local target="$HOME/Library/Screen Savers/SwitchBotScreenSaver.saver"
  local installed_version temp_dir archive

  installed_version="$(/usr/libexec/PlistBuddy \
    -c 'Print :CFBundleShortVersionString' "$target/Contents/Info.plist" 2>/dev/null || true)"
  if [[ "$installed_version" == "$version" ]]; then
    return
  fi

  temp_dir="$(mktemp -d "${TMPDIR:-/tmp}/switchbot-screen-saver.XXXXXX")"
  archive="$temp_dir/SwitchBotScreenSaver.tar.gz"
  curl -fsSL \
    "https://github.com/psephopaiktes/switchbot-screen-saver/releases/download/v${version}/SwitchBotScreenSaver-macos.tar.gz" \
    -o "$archive"

  if [[ "$(shasum -a 256 "$archive" | awk '{print $1}')" != "$checksum" ]]; then
    echo "SwitchBotScreenSaverのチェックサムが一致しません" >&2
    rm -rf -- "$temp_dir"
    return 1
  fi

  tar -xzf "$archive" -C "$temp_dir"
  mkdir -p "${target:h}"
  rm -rf -- "$target"
  mv -- "$temp_dir/SwitchBotScreenSaver.saver" "$target"
  rm -rf -- "$temp_dir"
}

if command -v git-lfs >/dev/null 2>&1; then
  git lfs install
fi

install_mas_apps
install_switchbot_screen_saver

if ! gh auth status -h github.com >/dev/null 2>&1; then
  gh auth login
fi

# Agent Skillsを公式配布元から取得し、各Agentへリンク
zsh "$REPO_ROOT/shell/update-skills.sh" --sync

# Claude CodeのユーザースコープMCPは ~/.claude.json に保存されるためCLIで登録
if command -v claude >/dev/null 2>&1; then
  MISE_BIN="$(command -v mise)"

  claude mcp remove figma --scope user >/dev/null 2>&1 || true
  claude mcp add --scope user --transport http figma https://mcp.figma.com/mcp

  claude mcp remove atlassian --scope user >/dev/null 2>&1 || true
  claude mcp add --scope user --transport http atlassian https://mcp.atlassian.com/v2/mcp

  claude mcp remove chrome-devtools --scope user >/dev/null 2>&1 || true
  claude mcp add --scope user chrome-devtools -- \
    "$MISE_BIN" x -- chrome-devtools-mcp --categoryExtensions --memoryDebugging

  # 旧dotfilesで登録したFirebase MCPを除去
  claude mcp remove firebase --scope user >/dev/null 2>&1 || true
fi
