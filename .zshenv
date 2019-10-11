# PATH の設定
export PATH="/usr/local/bin:$PATH"
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH=$PATH:/Users/a-hirata/Library/Android/sdk/platform-tools

# PATH の内容と同期している配列変数 path も使える
path=(
  ~/bin
  $path
)

#nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
