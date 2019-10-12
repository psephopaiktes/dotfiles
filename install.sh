#!/bin/zsh

# node ########################################################

echo "...install NODEs"

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
source ~/.zshenv
source ~/.zshrc
nvm i --lts
nvm use --lts

# Install Global NPM Packages
npm i -g firebase-tools
npm i -g @vue/cli


# brew ########################################################

echo "...install brew"
/usr/bin/ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
brew bundle --global
brew cleanup
brew cask cleanup


# SSH ########################################################
mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub


# other ########################################################

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
defaults write com.apple.finder QLEnableTextSelection -bool true
qlmanage -r

xcodebuild -license accept  
