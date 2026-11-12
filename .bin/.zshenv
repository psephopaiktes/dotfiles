export LANG=ja_JP.UTF-8

export EDITOR='code'
export VISUAL='code'

# PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# Formulaが必要とするHomebrew管理のPython/Nodeは依存関係として許可する

# Claude (env only)
# export ANTHROPIC_BASE_URL="${ANTHROPIC_BASE_URL:-https://litellm.unext.dev}"
export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS="${CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS:-1}"
export DISABLE_AUTOUPDATER="${DISABLE_AUTOUPDATER:-1}"

export PATH="$HOME/projects/flutter/bin:$PATH"
