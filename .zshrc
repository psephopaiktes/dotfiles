ZSH_THEME="wedisagree"

# 自動補完を有効にする
autoload -U compinit; compinit

# emacs key forward
bindkey -e

# short command
alias server="python -m SimpleHTTPServer"
alias nr='npm run'
alias p="cd ~/projects"

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# auto cd
setopt auto_cd

# Tell antigen that you're done.
antigen apply

#nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# Preview Git branch name
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '%F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%F{green}%b%f(%F{red}%a%f)'
precmd() { vcs_info }
PROMPT='[${vcs_info_msg_0_}]:%~/%f '
