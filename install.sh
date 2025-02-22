#!/usr/bin/env bash 


# node ########################################################

echo "...install NODEs"

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
wait

exec $SHELL -l
wait

nvm i --lts
wait

nvm use --lts
wait

nvm alias default 'lts/*'
wait


# brew ########################################################

echo "...install brew"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
wait

exec $SHELL -l

eval "$(/opt/homebrew/bin/brew shellenv)"
wait

brew bundle --global
wait

brew cleanup
wait


# other ########################################################

sudo xcodebuild -license accept 

gh auth login

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
defaults write com.apple.finder QLEnableTextSelection -bool true
qlmanage -r
wait


echo "DONE"
