export LANG=ja_JP.UTF-8

export EDITOR='code'
export VISUAL='code'

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# コマンド履歴管理系
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups

# 自動補完を有効にする
autoload -U compinit; compinit
eval "$(gh completion -s zsh)"

# Alt + Backspaceを有効にする
autoload -U select-word-style
select-word-style bash

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# cdの後にlsを実行
function chpwd() {
  ls
}

# emacs key forward
bindkey -e

# ディレクトリ名だけでcdする
setopt auto_cd

# short command
alias server="python -m SimpleHTTPServer"
alias ls='ls -GAp'
alias fb='firebase'
alias nr='npm run'
alias nrs='npm start'
alias nrb='npm run build'
alias nrd='npm run dev'
alias dc='docker-compose'
alias p="cd ~/projects"
alias d="cd ~/Desktop"
alias mk="touch"
alias -g C='| pbcopy'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias st='open -a SourceTree'
alias owa='say -v Kyoko おわりましたああああああああ'

# prompt
add_newline() {
  if [[ -z $PS1_NEWLINE_LOGIN ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
autoload -Uz vcs_info
autoload -U colors; colors
setopt prompt_subst
zstyle ':vcs_info:*' formats '%F{247}[ %b ]%f'
zstyle ':vcs_info:*' actionformats '%F{red}[ %b(%a) ]%f'
precmd() {
  vcs_info
  add_newline
}
PROMPT='
%F{178}%~%f ${vcs_info_msg_0_}
%F{178}%B>%b%f  '

# plugin
plugins=(
  zsh-autosuggestions
)

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(/opt/homebrew/bin/brew shellenv)"


# pnpm
export PNPM_HOME="/Users/a-hirata/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
