#!/bin/zsh
# 公式配布元からAgent Skillsの最新版を取得し、各AgentへSKILL単位でリンクする

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
MANIFEST="${AGENT_SKILLS_MANIFEST:-$REPO_ROOT/agent-skills.tsv}"
DEFAULT_SKILLS_HOME="$HOME/.local/agent-skills"
SKILLS_HOME="${AGENT_SKILLS_HOME:-$DEFAULT_SKILLS_HOME}"
AGENT_CONFIG_HOME="${AGENT_CONFIG_HOME:-$HOME}"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles"
CHECK_STAMP="$CACHE_DIR/skills-last-check"
SKILLS_MARKER_NAME=".dotfiles-agent-skills-managed"
mode="${1:---sync}"

case "$mode" in
  --sync|--check) ;;
  *)
    echo "Usage: $0 [--sync|--check]" >&2
    exit 2
    ;;
esac

if [[ -L "$SKILLS_HOME" ]]; then
  echo "Unsafe AGENT_SKILLS_HOME (symbolic link): $SKILLS_HOME" >&2
  exit 1
fi

# rsync --deleteの対象を物理パスで検証し、HOMEや設定ディレクトリを
# 別表現（末尾の/.、..、親ディレクトリなど）で指定できないようにする。
SKILLS_HOME="${SKILLS_HOME:A}"
home_path="${HOME:A}"
agent_config_path="${AGENT_CONFIG_HOME:A}"
repo_path="${REPO_ROOT:A}"

if [[ "$SKILLS_HOME" == "/" ]]; then
  echo "Unsafe AGENT_SKILLS_HOME: $SKILLS_HOME" >&2
  exit 1
fi

for protected_path in "$home_path" "$agent_config_path" "$repo_path"; do
  if [[ "$protected_path" == "$SKILLS_HOME" || "$protected_path" == "$SKILLS_HOME/"* ]]; then
    echo "Unsafe AGENT_SKILLS_HOME: $SKILLS_HOME" >&2
    exit 1
  fi
done

if [[ -e "$SKILLS_HOME" && ! -d "$SKILLS_HOME" ]]; then
  echo "Agent Skills path is not a directory: $SKILLS_HOME" >&2
  exit 1
fi

skills_marker="$SKILLS_HOME/$SKILLS_MARKER_NAME"
if [[ "$mode" == "--sync" && -d "$SKILLS_HOME" && ! -e "$skills_marker" ]]; then
  existing_entry="$(find "$SKILLS_HOME" -mindepth 1 -maxdepth 1 -print -quit)"
  if [[ -n "$existing_entry" ]]; then
    echo "Refusing to replace unmanaged Agent Skills directory: $SKILLS_HOME" >&2
    echo "Move or back up its contents before running the sync again." >&2
    exit 1
  fi
fi

if [[ -L "$skills_marker" || ( -e "$skills_marker" && ! -f "$skills_marker" ) ]]; then
  echo "Invalid Agent Skills management marker: $skills_marker" >&2
  exit 1
fi

if [[ ! -f "$MANIFEST" ]]; then
  echo "Agent Skills manifest not found: $MANIFEST" >&2
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "gh command not found" >&2
  exit 1
fi

if ! gh auth status -h github.com >/dev/null 2>&1; then
  echo "GitHub authentication required: gh auth login" >&2
  exit 1
fi

staging_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-agent-skills.XXXXXX")"
trap 'rm -rf "$staging_dir"' EXIT
install_log="$staging_dir/.gh-skill-install.log"

echo "...download Agent Skills"
while IFS=$'\t' read -r repository selector skill_options; do
  [[ -z "$repository" || "$repository" == \#* ]] && continue
  : > "$install_log"
  echo "  $repository ($selector)"

  if [[ "$selector" == "*" || "$selector" == "**" ]]; then
    echo "Wildcard Agent Skill selectors are not allowed: $repository $selector" >&2
    exit 1
  fi

  install_options=()
  if [[ "$skill_options" == "allow-hidden" ]]; then
    install_options+=(--allow-hidden-dirs)
  fi

  if ! gh skill install "$repository" "$selector" --dir "$staging_dir" --force "${install_options[@]}" >> "$install_log" 2>&1; then
    cat "$install_log" >&2
    exit 1
  fi
done < "$MANIFEST"
rm -f "$install_log"

# 隠しディレクトリ内のSKILLも各Agentから見えるトップレベルへ揃える
if [[ -d "$staging_dir/.curated" ]]; then
  while IFS= read -r -d '' source; do
    target="$staging_dir/${source:t}"
    if [[ -e "$target" ]]; then
      echo "Duplicate Agent Skill: ${source:t}" >&2
      exit 1
    fi
    mv "$source" "$target"
  done < <(find "$staging_dir/.curated" -mindepth 1 -maxdepth 1 -type d -print0)
  rmdir "$staging_dir/.curated"
fi

# gh skillで保持されない実行権限をshebangから復元する
while IFS= read -r -d '' file; do
  first_line="$(head -n 1 "$file" 2>/dev/null || true)"
  if [[ "$first_line" == '#!'* ]]; then
    chmod +x "$file"
  fi
done < <(find "$staging_dir" -type f -print0)

skill_count="$(find "$staging_dir" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
if (( skill_count == 0 )); then
  echo "No Agent Skills were downloaded" >&2
  exit 1
fi

mkdir -p "$CACHE_DIR"

if [[ "$mode" == "--check" ]]; then
  if [[ ! -d "$SKILLS_HOME" ]]; then
    echo "Agent Skills are not installed. Run: mise run skills:update"
  elif diff -qr -x "$SKILLS_MARKER_NAME" "$SKILLS_HOME" "$staging_dir" >/dev/null; then
    echo "Agent Skills are up to date ($skill_count skills)"
  else
    echo "Agent Skills updates are available:"
    diff -qr -x "$SKILLS_MARKER_NAME" "$SKILLS_HOME" "$staging_dir" || true
  fi
  touch "$CHECK_STAMP"
  exit 0
fi

target_dirs=(
  "$AGENT_CONFIG_HOME/.agents/skills"
  "$AGENT_CONFIG_HOME/.claude/skills"
)

# 未管理のディレクトリリンクを解除する前に停止する
for target_dir in "${target_dirs[@]}"; do
  if [[ -L "$target_dir" ]]; then
    echo "Refusing to replace unmanaged Agent Skills link: $target_dir" >&2
    exit 1
  elif [[ -e "$target_dir" && ! -d "$target_dir" ]]; then
    echo "Agent Skills path is not a directory: $target_dir" >&2
    exit 1
  fi
done

mkdir -p "$SKILLS_HOME"
touch "$skills_marker"
rsync -a --delete --exclude="/$SKILLS_MARKER_NAME" "$staging_dir/" "$SKILLS_HOME/"

for target_dir in "${target_dirs[@]}"; do
  mkdir -p "$target_dir"

  # このスクリプトが作成した、配布終了済みSKILLへのリンクを除去する
  while IFS= read -r -d '' link; do
    link_target="$(readlink "$link")"
    if [[ "$link_target" == "$SKILLS_HOME/"* && ! -e "$link" ]]; then
      rm "$link"
    fi
  done < <(find "$target_dir" -mindepth 1 -maxdepth 1 -type l -print0)

  while IFS= read -r -d '' source; do
    target="$target_dir/${source:t}"
    if [[ -e "$target" && ! -L "$target" ]]; then
      echo "Refusing to replace unmanaged Agent Skill: $target" >&2
      exit 1
    elif [[ -L "$target" && ! "$target" -ef "$source" ]]; then
      echo "Refusing to replace unmanaged Agent Skill link: $target" >&2
      exit 1
    fi
    ln -sfn "$source" "$target"
  done < <(find "$SKILLS_HOME" -mindepth 1 -maxdepth 1 -type d -print0)
done

touch "$CHECK_STAMP"
echo "Installed and linked $skill_count Agent Skills"
