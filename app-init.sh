#!/bin/bash


# Node関連
curl -L git.io/nodebrew | perl - setup
nodebrew install-binary stable
nodebrew use stable
brew install yarn --without-node


# Synchronous Settings by Google Drive

## Ai Scripts シンボリックリンク設定
## 要バージョンごとの設定
rm -rf "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP/スクリプト"
ln -s "/Users/a-hirata/Google Drive/App/ai scripts" "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP"
mv "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP/ai scripts" "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP/スクリプト"

## VS code シンボリックリンク設定
rm -rf "/Users/a-hirata/Library/Application Support/Code/User"
rm -rf "/Users/a-hirata/.vscode"
ln -s "/Users/a-hirata/Google Drive/App/VS Code/User" "/Users/a-hirata/Library/Application Support/Code"
ln -s "/Users/a-hirata/Google Drive/App/VS Code/.vscode" "/Users/a-hirata"

## itunesのシンボリックリンク設定
###WIP


# QuickLook Setting
## 拡張子のないファイルをテキストプレビュー
brew cask install qlstephen
## Markdown
brew cask install qlmarkdown
## JSON
brew cask install quicklook-json
## CSV
brew cask install quicklook-csv
## コード色分け, 行表示設定 色の設定も可能
brew cask install qlcolorcode
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
## zipファイルのサムネ表示、クイックルック表示
brew cask install hetimazip
## 画像表示の際にサイズをタイトルに提示
brew cask install qlimagesize
brew cask install webpquicklook
## config
defaults write com.apple.finder QLEnableTextSelection -bool true
qlmanage -r


# Other Settings
curl -L 'https://gist.github.com/ysaotome/7286145/raw/installing_ricty_on_MacOSX.sh' | bash
defaults write com.apple.finder AppleShowAllFiles -bool true
