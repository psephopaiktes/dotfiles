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

# .bin配下の全ファイルを$HOMEにシンボリックリンク（.DS_Storeは除外）
count=0
while IFS= read -r -d '' source; do
  rel="${source#$DOTBIN/}"
  target="$HOME/$rel"
  mkdir -p "$(dirname "$target")"

  if [[ -e "$target" && ! -L "$target" ]]; then
    echo "Backing up existing file: $target"
    mv "$target" "${target}.backup"
  fi

  ln -snf "$source" "$target"
  ((++count))
done < <(find "$DOTBIN" \( -type f -o -type l \) ! -name '.DS_Store' -print0)

if (( count == 0 )); then
  echo "Warning: .binディレクトリにリンク対象ファイルが見つかりません" >&2
else
  echo "Linked $count file(s)"
fi

echo "DONE"
