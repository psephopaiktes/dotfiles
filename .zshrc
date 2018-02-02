export LANG=ja_JP.UTF-8

export EDITOR='code'
export VISUAL='code'

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# 自動補完を有効にする
autoload -U compinit; compinit

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# cdの後にlsを実行
function chpwd() {
  if [ 20 -gt `ls -1 | wc -l` ]; then
    ls -lahp
  else
    ls
  fi
}

# emacs key forward
bindkey -e

# ディレクトリ名だけでcdする
setopt auto_cd

# short command
alias server="python -m SimpleHTTPServer"
alias nr='npm run'
alias p="cd ~/projects"
alias mk="touch"
alias -g C='| pbcopy'

# prompt
autoload -Uz vcs_info
autoload -U colors; colors
setopt prompt_subst
zstyle ':vcs_info:*' formats '%F{247}[ %b ]%f'
zstyle ':vcs_info:*' actionformats '%F{red}[ %b(%a) ]%f'
precmd() { vcs_info }
PROMPT='
%F{178}%~%f ${vcs_info_msg_0_}
%F{178}%B>>%b%f  '

#nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
