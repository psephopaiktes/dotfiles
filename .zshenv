# PATH の設定
export PATH="/usr/local/bin:$PATH"
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# PATH の内容と同期している配列変数 path も使える
path=(
  ~/bin
  $path
)
