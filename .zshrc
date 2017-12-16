autoload -U compinit; compinit
ZSH_THEME="wedisagree"

source ~/.zsh/antigen/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# short command
# alias master='git checkout master'
alias server="python -m SimpleHTTPServer"
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

# for Muchiri
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PATH:/usr/local/bin
eval "$(pyenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
