#!/bin/zsh
# .binディレクトリ内のファイルを$HOMEにそのままシンボリックリンク

set -euo pipefail

# スクリプトのディレクトリとレポジトリルートを取得
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
DOTBIN="$REPO_ROOT/.bin"

# .binディレクトリの存在確認
if [[ ! -d "$DOTBIN" ]]; then
  echo ".bin directory not found: $DOTBIN" >&2
  exit 1
fi

echo "...Link dotfiles from $DOTBIN to $HOME"

backup_existing() {
  local target="$1"
  local timestamp backup suffix

  timestamp="$(date '+%Y%m%d-%H%M%S')"
  backup="${target}.backup.${timestamp}"
  suffix=1
  while [[ -e "$backup" || -L "$backup" ]]; do
    backup="${target}.backup.${timestamp}.${suffix}"
    ((++suffix))
  done

  echo "Backing up existing path: $target -> $backup"
  mv "$target" "$backup"
}

confirm_symlink_replacement() {
  local target="$1"
  local replacement="$2"
  local current reply

  if [[ "${DOTFILES_OVERWRITE_SYMLINKS:-0}" == "1" ]]; then
    return 0
  fi

  current="$(readlink "$target" 2>/dev/null || true)"
  if { printf 'Replace existing symbolic link?\n  %q -> %q\n  new target: %q\n[y/N] ' \
    "$target" "$current" "$replacement" > /dev/tty; } 2>/dev/null; then
    if ! IFS= read -r reply < /dev/tty; then
      echo "Skipped existing symbolic link: $target" >&2
      return 1
    fi
  elif [[ -t 0 ]]; then
    printf 'Replace existing symbolic link?\n  %q -> %q\n  new target: %q\n[y/N] ' \
      "$target" "$current" "$replacement" >&2
    if ! IFS= read -r reply; then
      echo "Skipped existing symbolic link: $target" >&2
      return 1
    fi
  else
    echo "Skipped existing symbolic link (confirmation unavailable): $target" >&2
    return 1
  fi

  case "$reply" in
    y|Y|yes|YES) return 0 ;;
    *)
      echo "Skipped existing symbolic link: $target" >&2
      return 1
      ;;
  esac
}

convert_codex_config_symlink() {
  local target="$1"
  local fallback="$2"
  local source temp_config

  if [[ -f "$target" ]]; then
    source="$target"
  else
    source="$fallback"
  fi

  temp_config="$(mktemp "${target:h}/.codex-config.XXXXXX")"
  if ! cp "$source" "$temp_config"; then
    rm -f "$temp_config"
    return 1
  fi

  rm "$target"
  mv "$temp_config" "$target"
}

# .bin配下の全ファイルを$HOMEにシンボリックリンク（.DS_Storeは除外）
count=0
found=0
skipped=0
while IFS= read -r -d '' source; do
  ((++found))
  rel="${source#$DOTBIN/}"
  target="$HOME/$rel"

  # 正しいリンクが既にある場合はスキップ
  if [[ "$target" -ef "$source" ]]; then
    continue
  fi

  mkdir -p "$(dirname "$target")"

  if [[ -e "$target" && ! -L "$target" ]]; then
    backup_existing "$target"
  elif [[ -L "$target" ]] && ! confirm_symlink_replacement "$target" "$source"; then
    ((++skipped))
    continue
  fi

  ln -snf "$source" "$target"
  ((++count))
done < <(find "$DOTBIN" \( -type f -o -type l \) \
  ! -name '.DS_Store' \
  ! -path "$DOTBIN/.codex/config.toml" \
  -print0)

# 共通のAgent指示を各LLM固有のグローバルパスへリンク
agent_instructions_source="$DOTBIN/AGENTS.md"
if [[ -f "$agent_instructions_source" ]]; then
  for target in \
    "$HOME/.codex/AGENTS.md" \
    "$HOME/.claude/CLAUDE.md" \
    "$HOME/.copilot/copilot-instructions.md" \
    "$HOME/.gemini/AGENTS.md"; do
    if [[ "$target" -ef "$agent_instructions_source" ]]; then
      continue
    fi

    mkdir -p "$(dirname "$target")"
    if [[ -e "$target" && ! -L "$target" ]]; then
      backup_existing "$target"
    elif [[ -L "$target" ]] && ! confirm_symlink_replacement "$target" "$agent_instructions_source"; then
      ((++skipped))
      continue
    fi

    ln -snf "$agent_instructions_source" "$target"
    ((++count))
  done
fi

# Codexのconfig.tomlは初回配置用テンプレート。ChatGPT/Codexが更新する既存の実ファイルは保持する
codex_config_source="$DOTBIN/.codex/config.toml"
codex_config_target="$HOME/.codex/config.toml"
if [[ -f "$codex_config_source" ]]; then
  mkdir -p "$(dirname "$codex_config_target")"

  if [[ -L "$codex_config_target" ]]; then
    if [[ "$codex_config_target" -ef "$codex_config_source" ]] || \
      confirm_symlink_replacement "$codex_config_target" "local config file"; then
      convert_codex_config_symlink "$codex_config_target" "$codex_config_source"
      echo "Converted Codex config symlink to a local file: $codex_config_target"
      ((++count))
    else
      ((++skipped))
    fi
  elif [[ ! -e "$codex_config_target" && ! -L "$codex_config_target" ]]; then
    cp "$codex_config_source" "$codex_config_target"
    echo "Created Codex config: $codex_config_target"
    ((++count))
  fi
fi

if (( found == 0 )); then
  echo "Warning: .binディレクトリにリンク対象ファイルが見つかりません" >&2
elif (( count == 0 )); then
  if (( skipped == 0 )); then
    echo "All links are up to date"
  fi
else
  echo "Linked $count file(s)"
fi

if (( skipped > 0 )); then
  echo "Skipped $skipped existing symbolic link(s)" >&2
  exit 1
fi

echo "DONE"
