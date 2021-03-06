#!/bin/zsh

# node ########################################################

echo "...install NODEs"

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
wait

source ~/.zshenv
source ~/.zshrc

nvm i --lts
wait

nvm use --lts

# Install Global NPM Packages
npm i -g firebase-tools
npm i -g @vue/cli
npm i -g vercel
npm i -g @squoosh/cli
wait


# brew ########################################################

echo "...install brew"

/usr/bin/ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
wait

brew bundle --global
wait

brew cleanup
wait


# SSH ########################################################
mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
wait

pbcopy < ~/.ssh/id_rsa.pub


# other ########################################################

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
defaults write com.apple.finder QLEnableTextSelection -bool true
qlmanage -r
wait

xcodebuild -license accept  


echo "DONE"
