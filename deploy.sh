#!/bin/bash
GITHUB_URL=https://github.com/psephopaiktes/dotfiles.git
DOTPATH=~/.dotfiles

# Deploy Dotfiles
echo "...Clone & Deploy Dotfils"
git clone "$GITHUB_URL" "$DOTPATH"
ln -snf $DOTPATH/.gitconfig ~
ln -snf $DOTPATH/.gitignore_global ~
ln -snf $DOTPATH/.hyper.js ~
ln -snf $DOTPATH/.zshenv ~
ln -snf $DOTPATH/.zshrc ~

# create work space
mkdir ~/projects