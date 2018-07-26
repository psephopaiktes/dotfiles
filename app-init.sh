#!/bin/bash


# Node
curl -L git.io/nodebrew | perl - setup
nodebrew install-binary stable
nodebrew use stable
brew install yarn --without-node


# Symbolic link Settings by Google Drive

## Ai Scripts
## Need latest version name
sudo rm -rf "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP/スクリプト"
sudo ln -snf "/Users/a-hirata/Google Drive/App/ai scripts" "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP"
sudo mv "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP/ai scripts" "/Applications/Adobe Illustrator CC 2018/Presets.localized/ja_JP/スクリプト"

## VS code
sudo rm -rf "/Users/a-hirata/Library/Application Support/Code/User"
sudo rm -rf "/Users/a-hirata/.vscode"
sudo ln -snf "/Users/a-hirata/Google Drive/App/VS Code/User" "/Users/a-hirata/Library/Application Support/Code"
sudo ln -snf "/Users/a-hirata/Google Drive/App/VS Code/.vscode" "/Users/a-hirata"

## itunes
sudo rm -rf "/Users/a-hirata/Music/iTunes"
sudo ln -snf "/Users/a-hirata/Google Drive/App/iTunes" "/Users/a-hirata/Music"


# QuickLook Setting
## txt preview if file hasnt ext
brew cask install qlstephen
## Markdown
brew cask install qlmarkdown
## JSON
brew cask install quicklook-json
## CSV
brew cask install quicklook-csv
## syntax color, line number
brew cask install qlcolorcode
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
## zip
brew cask install hetimazip
## preview img size
brew cask install qlimagesize
brew cask install webpquicklook
## config
defaults write com.apple.finder QLEnableTextSelection -bool true
qlmanage -r


# Other Settings
defaults write com.apple.finder AppleShowAllFiles -bool true
