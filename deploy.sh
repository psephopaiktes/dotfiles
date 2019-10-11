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






409203825 #Numbers
  497799835 #Xcode
  
  409201541 #Pages
  409183694 #Keynote
  539883307 #LINE
  425424353 #The Unarchiver
  1206246482 #EdgeView 2

## Install QuickLook Apps
### txt preview if file hasnt ext
brew cask install qlstephen
### Markdown
brew cask install qlmarkdown
### JSON
brew cask install quicklook-json
### CSV
brew cask install quicklook-csv
### syntax color, line number
brew cask install qlcolorcode
### zip
brew cask install hetimazipql
### preview img size
brew cask install qlimagesize
brew cask install webpquicklook
### config
