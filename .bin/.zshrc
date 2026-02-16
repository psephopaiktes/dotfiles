

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
if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s zsh)"
fi

# Alt + Backspaceを有効にする
autoload -U select-word-style
select-word-style bash

# cdの後にlsを実行
function chpwd() {
  ls
}

# emacs key forward
bindkey -e

# ディレクトリ名だけでcdする
setopt auto_cd

# short command
alias server="python3 -m http.server"
alias cl='claude'
alias clp='claude -p'
alias ls='ls -GAp'
alias gho='gh repo view --web'
alias fb='firebase'
alias nr='npm run'
alias nrs='npm start'
alias nrb='npm run build'
alias nrd='npm run dev'
alias p="cd ~/projects"
alias d="cd ~/Desktop"
alias mk="touch"
alias -g C='| pbcopy'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias cat='bat'
alias grep='rg'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# prompt setting
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

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd='z'
  alias cdi='zi'
fi

# zsh-autosuggestions
if [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
