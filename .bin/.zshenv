export LANG=ja_JP.UTF-8

export EDITOR='code'
export VISUAL='code'

# PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# brew が依存で勝手に python/node を持ってくるのを防ぐ
# export HOMEBREW_FORBIDDEN_FORMULAE="node python python3 pip npm pnpm yarn claude"

# Claude (env only)
export ANTHROPIC_BASE_URL="${ANTHROPIC_BASE_URL:-https://litellm.unext.dev}"
export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS="${CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS:-1}"
export DISABLE_AUTOUPDATER="${DISABLE_AUTOUPDATER:-1}"

# secrets (.env)
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/projects/dotfiles}"
if [[ -f "$DOTFILES_DIR/.env" ]]; then
	set -a
	source "$DOTFILES_DIR/.env"
	set +a
fi
