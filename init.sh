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
MISE_MIN_VERSION="2026.11.9"

mkdir -p "$HOME/projects"

# miseがない、または設定の最低バージョン未満なら公式版を導入
autoload -Uz is-at-least
mise_is_compatible() {
  local bin="$1"
  local installed_version

  [[ -n "$bin" && -x "$bin" ]] || return 1
  installed_version="$("$bin" --version 2>/dev/null || true)"
  installed_version="${${installed_version%% *}#v}"
  [[ "$installed_version" == <->.<->.<-> ]] && \
    is-at-least "$MISE_MIN_VERSION" "$installed_version"
}

MISE_BIN="$(command -v mise || true)"
if ! mise_is_compatible "$MISE_BIN"; then
  echo "...Install mise ${MISE_MIN_VERSION}"
  curl -fsSL https://mise.run | \
    MISE_VERSION="$MISE_MIN_VERSION" \
      MISE_INSTALL_PATH="$HOME/.local/bin/mise" \
      sh
  MISE_BIN="$HOME/.local/bin/mise"
fi

if ! mise_is_compatible "$MISE_BIN"; then
  echo "エラー: mise ${MISE_MIN_VERSION}以上のインストールに失敗しました" >&2
  exit 1
fi
export PATH="${MISE_BIN:h}:$PATH"

echo "...Bootstrap Mac"
REPO_MISE_CONFIG_DIR="$DOTPATH/.bin/.config/mise"
GLOBAL_MISE_CONFIG_DIR="$HOME/.config/mise"
GLOBAL_MISE_CONFIG="$GLOBAL_MISE_CONFIG_DIR/config.toml"

if [[ -d "$REPO_MISE_CONFIG_DIR" && \
  "$GLOBAL_MISE_CONFIG_DIR" -ef "$REPO_MISE_CONFIG_DIR" ]]; then
  # --config-dirで作成したディレクトリリンクからリポジトリを更新
  "$MISE_BIN" -C "$HOME" bootstrap --update --yes
else
  if [[ -d "$GLOBAL_MISE_CONFIG_DIR" && ! -L "$GLOBAL_MISE_CONFIG_DIR" && \
    -L "$GLOBAL_MISE_CONFIG" && -e "$REPO_MISE_CONFIG_DIR/config.toml" && \
    "$GLOBAL_MISE_CONFIG" -ef "$REPO_MISE_CONFIG_DIR/config.toml" ]]; then
    # 旧link.shのファイル単位リンクを、miseが自己更新できるディレクトリリンクへ移行
    legacy_entries=("$GLOBAL_MISE_CONFIG_DIR"/*(DN))
    if (( ${#legacy_entries} != 1 )) || [[ "$legacy_entries[1]" != "$GLOBAL_MISE_CONFIG" ]]; then
      echo "エラー: 旧mise設定ディレクトリに未管理のファイルがあります: $GLOBAL_MISE_CONFIG_DIR" >&2
      exit 1
    fi

    echo "...Migrate mise config directory"
    unlink "$GLOBAL_MISE_CONFIG"
    rmdir "$GLOBAL_MISE_CONFIG_DIR"
    ln -s "$REPO_MISE_CONFIG_DIR" "$GLOBAL_MISE_CONFIG_DIR"
    "$MISE_BIN" -C "$HOME" bootstrap --update --yes
  else
    if [[ -e "$GLOBAL_MISE_CONFIG_DIR" || -L "$GLOBAL_MISE_CONFIG_DIR" ]]; then
      if [[ ! -d "$GLOBAL_MISE_CONFIG_DIR" || -L "$GLOBAL_MISE_CONFIG_DIR" ]]; then
        echo "エラー: 既存のmise設定パスを移行できません: $GLOBAL_MISE_CONFIG_DIR" >&2
        exit 1
      fi

      existing_entries=("$GLOBAL_MISE_CONFIG_DIR"/*(DN))
      if (( ${#existing_entries} > 0 )); then
        echo "エラー: 既存のmise設定ディレクトリが空ではありません: $GLOBAL_MISE_CONFIG_DIR" >&2
        exit 1
      fi
    fi

    "$MISE_BIN" -C "$HOME" bootstrap \
      --from "$GITHUB_URL" \
      --from-dir "$DOTPATH" \
      --config-dir .bin/.config/mise \
      --update \
      --yes
  fi
fi

echo "DONE"
