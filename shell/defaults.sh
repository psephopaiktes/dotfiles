#!/bin/zsh
# macOS の各種設定を defaults 経由で反映するスクリプト

set -euo pipefail

if [[ "${OSTYPE:-}" != darwin* ]]; then
  echo "This script is for macOS only." >&2
  exit 1
fi

log() {
  echo "[defaults] $*"
}

# アプリケーションを安全に終了
quit_app() {
  local app_name="$1"
  osascript -e "tell application \"${app_name}\" to quit" >/dev/null 2>&1 || true
}

# プロセスを安全に再起動
restart_process() {
  local process_name="$1"
  killall "$process_name" >/dev/null 2>&1 || true
}

# System Settings / System Preferences が開いていると反映が上書きされることがあるため閉じる
quit_app "System Settings"

write_defaults() {
  # 設定関数: write_defaults <domain> <key> <type> <value>
  local domain="$1"
  local key="$2"
  local type="$3"
  local value="$4"

  log "defaults write ${domain} ${key} -${type} ${value}"
  defaults write "$domain" "$key" "-$type" "$value"
}

# -----------------------------------------------------------------------------
# General (システム全体)
# -----------------------------------------------------------------------------

log "General（システム全体）を設定"

# スクロールバーのクリック動作: "クリックした場所にジャンプ"
write_defaults NSGlobalDomain AppleScrollerPagingBehavior int 0

# アプリ終了時に変更を保持するか確認: ON
write_defaults NSGlobalDomain NSCloseAlwaysConfirmsChanges bool true

# 最近使った項目の数: 10
# すべてのアプリに効くわけではないが、標準の最近使った書類・アプリの上限に影響
write_defaults NSGlobalDomain NSRecentDocumentsLimit int 10
write_defaults NSGlobalDomain NSRecentApplicationsLimit int 10
write_defaults NSGlobalDomain NSRecentServersLimit int 10

# 書類を開く時のタブ優先: 常に
write_defaults NSGlobalDomain AppleWindowTabbingMode string always

# -----------------------------------------------------------------------------
# Keyboard / Text Input
# -----------------------------------------------------------------------------

log "Keyboard / Text Input を設定"

# キーリピート速度（Key Repeat）とリピート開始までの時間（Delay Until Repeat）
# 値は個人差があるので、速め設定の代表値を採用
write_defaults NSGlobalDomain KeyRepeat int 2
write_defaults NSGlobalDomain InitialKeyRepeat int 15

# 文章入力の自動補正系をOFF
write_defaults NSGlobalDomain NSAutomaticCapitalizationEnabled bool false
write_defaults NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled bool false
write_defaults NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled bool false
write_defaults NSGlobalDomain NSAutomaticDashSubstitutionEnabled bool false
write_defaults NSGlobalDomain NSAutomaticSpellingCorrectionEnabled bool false

# -----------------------------------------------------------------------------
# Finder
# -----------------------------------------------------------------------------

log "Finder を設定"

# 隠しファイルを表示
write_defaults com.apple.finder AppleShowAllFiles bool true

# タイトルバーにフルパス表示
write_defaults com.apple.finder _FXShowPosixPathInTitle bool true

# すべての拡張子を表示
write_defaults NSGlobalDomain AppleShowAllExtensions bool true

# 拡張子変更警告をOFF
write_defaults com.apple.finder FXEnableExtensionChangeWarning bool false

# ゴミ箱を空にする警告をOFF
write_defaults com.apple.finder WarnOnEmptyTrash bool false

# ゴミ箱の項目を30日後に自動削除
write_defaults com.apple.finder FXRemoveOldTrashItems bool true

# フォルダを先頭に表示
write_defaults com.apple.finder FXSortFoldersFirst bool true
write_defaults com.apple.finder FXSortFoldersFirstOnDesktop bool true

# 検索のデフォルト: 前回の検索範囲
write_defaults com.apple.finder FXDefaultSearchScope string SCsp

# パスバー/ステータスバー表示
write_defaults com.apple.finder ShowPathbar bool true
write_defaults com.apple.finder ShowStatusBar bool true

# 新規 Finder ウィンドウ: Desktop
write_defaults com.apple.finder NewWindowTarget string PfDe
write_defaults com.apple.finder NewWindowTargetPath string "file://${HOME}/Desktop/"

# -----------------------------------------------------------------------------
# Dock
# -----------------------------------------------------------------------------

log "Dock を設定"

# Dock のサイズ/拡大の強さ
DOCK_TILE_SIZE=${DOCK_TILE_SIZE:-48}
DOCK_LARGE_SIZE=${DOCK_LARGE_SIZE:-64}

write_defaults com.apple.dock tilesize int "$DOCK_TILE_SIZE"
write_defaults com.apple.dock magnification bool true
write_defaults com.apple.dock largesize int "$DOCK_LARGE_SIZE"

# ウィンドウ最小化: Scale effect
write_defaults com.apple.dock mineffect string scale

# アプリのアイコンに最小化
write_defaults com.apple.dock minimize-to-application bool true

# Dock を自動的に隠す
write_defaults com.apple.dock autohide bool true

# Dock に最近使ったアプリを表示しない
write_defaults com.apple.dock show-recents bool false

# -----------------------------------------------------------------------------
# Security / Screen Saver
# -----------------------------------------------------------------------------

log "ロック画面（パスワード要求）を設定"

# スリープ/スクリーンセーバ開始後にパスワードを要求
write_defaults com.apple.screensaver askForPassword int 1

# -----------------------------------------------------------------------------
# Quick Look
# -----------------------------------------------------------------------------

log "Quick Look を設定"

# Quick Look でテキスト選択を可能にする
write_defaults com.apple.finder QLEnableTextSelection bool true

# 反映のための再起動（対象プロセスのみ）
log "反映のため Finder/Dock を再起動"
restart_process Finder
restart_process Dock
restart_process SystemUIServer

# Quick Look のキャッシュをリセット
log "Quick Look をリロード"
qlmanage -r >/dev/null 2>&1 || true

log "DONE"
