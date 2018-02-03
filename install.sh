#!/bin/bash

GITHUB_URL=https://github.com/psephopaiktes/dotfiles.git
DOTPATH=~/.dotfiles


# Install Xcode CUI
sudo xcode-select --install


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
ln -snf $DOTPATH/.zshenv ~
ln -snf $DOTPATH/.zshrc ~
ln -snf $DOTPATH/.gitconfig ~
ln -snf $DOTPATH/.gitignore_global ~


# create work space
mkdir ~/projects
