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

echo "install homebrew"
# Homebrew
if ! type brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
  brew doctor
fi

brew tap homebrew/cask-fonts

## Install CUI Apps
echo "install homebrew CUI Apps"
formulas=(
  cask
  hugo
  hub
  mas
  python3
  tree
)
for formula in "${formulas[@]}"; do
  brew install -y $formula || brew upgrade $formula
done

## Install GUI Apps
echo "install homebrew GUI Apps"
casks=(
  abstract
  appcleaner
  adobe-creative-cloud
  alfred
  bettertouchtool
  dropbox
  docker
  figma
  firefox
  font-noto-sans-cjk-jp
  font-ricty-diminished
  font-roboto
  google-backup-and-sync
  google-chrome
  google-drive-file-stream
  google-japanese-ime
  hyper
  iina
  imageoptim
  namechanger
  opera
  keycastr
  kindle
  sf-symbols
  sketch
  sourcetree
  # skybox
  visual-studio-code
  vivaldi
  woff2
)
for cask in "${casks[@]}"; do
  brew cask install -y $cask || brew upgrade $cask
done

## Install AppStore Apps
echo "install homebrew AppStore Apps"
mass={
  409203825 #Numbers
  497799835 #Xcode
  409201541 #Pages
  409183694 #Keynote
  539883307 #LINE
  425424353 #The Unarchiver
  1206246482 #EdgeView 2
}
for mas in "${mass[@]}"; do
  mas install $mas
done

echo "install homebrew Quicklook Apps"
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
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
### zip
brew cask install hetimazipql
### preview img size
brew cask install qlimagesize
brew cask install webpquicklook
### config
defaults write com.apple.finder QLEnableTextSelection -bool true
qlmanage -r


brew cleanup
brew cask cleanup

################################################################################

echo "complete."
