#!/bin/bash

GITHUB_URL=https://github.com/psephopaiktes/dotfiles.git
DOTPATH=~/.dotfiles


# Install Xcode CUI
xcode-select --install


# Homebrew
if ! type brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
  brew doctor
fi
## Install Apps
formulas=(
  git
  tree
  cask
  python3
)
for formula in "${formulas[@]}"; do
  brew install -y $formula || brew upgrade $formula
done
brew cleanup


# Install Zsh
if ! type zsh >/dev/null 2>&1; then
  brew install zsh
  brew install zsh-completions
  ZSH_PATH=`which zsh`
  echo $ZSH_PATH >> /etc/shells
  chsh -s $ZSH_PATH
fi


# Deploy Dotfiles
git clone "$GITHUB_URL" "$DOTPATH"
cd "$DOTPATH"
ln -snf .zshenv ~/.zshenv
ln -snf .zshrc ~/.zshrc
ln -snf .gitconfig ~/.gitconfig
ln -snf .gitignore_global ~/.gitignore_global
