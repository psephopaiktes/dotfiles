#!/bin/bash
GITHUB_URL=https://github.com/psephopaiktes/dotfiles.git
DOTPATH=~/.dotfiles

# Deploy Dotfiles
echo "Clone & Deploy Dotfils"
git clone "$GITHUB_URL" "$DOTPATH"
ln -snf $DOTPATH/.gitconfig ~
ln -snf $DOTPATH/.gitignore_global ~
ln -snf $DOTPATH/.hyper.js ~
ln -snf $DOTPATH/.zshenv ~
ln -snf $DOTPATH/.zshrc ~
source ~/.zsh
source ~/.zshrc

# create work space
mkdir ~/projects

# Install Zsh
# if ! type zsh >/dev/null 2>&1; then
#   brew install zsh
#   brew install zsh-completions
#   ZSH_PATH=`which zsh`
#   echo $ZSH_PATH >> /etc/shells
#   chsh -s $ZSH_PATH
# fi

# Other Settings
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

################################################################################

echo "install NODEs"

# Nodebrew
# curl -L git.io/nodebrew | perl - setup
# nodebrew install-binary stable
# nodebrew use stable

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
sudo nvm i --lts
sudo nvm use --lts

# Install Global NPM Packages
npm i -g firebase-tools
npm i -g @vue/cli

################################################################################

