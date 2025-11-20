
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

autoload -Uz compinit
compinit                                
set -o vi


plugins=(git)

source $ZSH/oh-my-zsh.sh
eval "$(ssh-agent -s)" ssh-add ~/.ssh/jemo
ssh -T git@github.com
clear
export PATH="$PATH:$HOME/flutter/bin"


alias c="cursor"
alias t='trae'
alias cls="clear"
alias n="nvim"
alias ls="eza"
alias open='explorer.exe .'
alias gs='git stash'
alias gsp='git stash pop'
alias gss='git stash show'
alias gsl='git stash list'
alias gsa='git stash apply'
alias gsd='git stash drop'
alias gsc='git stash clear'
alias gsh='git show'
alias gshp='git show --pretty="" --name-only'
alias gshs='git show --stat'
alias gsha='git show --name-only --pretty=""'
alias gst='git status'
alias gsta='git stash apply'
alias gstaa='git stash apply --index'
alias gstd='git stash drop'
alias gstc='git stash clear'
alias gstl='git stash list'
alias gstlsa='git stash list --stat'
alias activate='source .venv/bin/activate'


export PIPENV_DONT_LOAD=1
source <(fzf --zsh)

source <(ng completion script)

. "$HOME/.local/bin/env"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
. "/home/jemo/.deno/env"
# pnpm
export PNPM_HOME="/home/jemo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/jemo/.bun/_bun" ] && source "/home/jemo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:/home/jemo/.local/share/pnpm/global/5/node_modules/.bin"
export ANDROID_SDK_ROOT=$HOME/android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
# --- Android SDK Configuration ---
export ANDROID_HOME=$HOME/Android/Sdk
# Add command-line tools, platform-tools (for adb), and build tools to PATH
export PATH=$PATH:$ANDROID_HOME/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# --- End Android SDK Configuration ---

eval "$(zoxide init --cmd cd zsh)"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(atuin init zsh)"
eval "$(~/.local/bin/oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/jandedobbeleer.omp.json)"
