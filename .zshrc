setopt vi
autoload -Uz compinit edit-command-line
zle -N edit-command-line
bindkey '^X' edit-command-line

fpath=("$HOME/.zfunc" $fpath)
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

_nvm_load() {
  [[ -n ${_NVM_LOADED-} ]] && return 0
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 1
  source "$NVM_DIR/nvm.sh" || return 1
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  command -v nvm >/dev/null 2>&1 && nvm use default >/dev/null 2>&1 || true
  unset -f nvm node npm npx yarn pnpm 2>/dev/null || true
  _NVM_LOADED=1
}
nvm() { _nvm_load && nvm "$@"; }
node() { _nvm_load && node "$@"; }
npm() { _nvm_load && npm "$@"; }
npx() { _nvm_load && npx "$@"; }
yarn() { _nvm_load && yarn "$@"; }
pnpm() { _nvm_load && pnpm "$@"; }

_ng() {
  unfunction _ng 2>/dev/null || true
  local cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions/ng.zsh"
  local ng_bin
  ng_bin="$(command -v ng 2>/dev/null)" || return 1
  if [[ ! -s "$cache" || "$cache" -ot "$ng_bin" ]]; then
    mkdir -p "${cache:h}" || return 1
    ng completion script >| "$cache" 2>/dev/null || return 1
  fi
  source "$cache"
  _ng_yargs_completions
}
compdef _ng ng

_bun() {
  unfunction _bun 2>/dev/null || true
  [[ -r "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
  _bun
}
compdef _bun bun

export PIPENV_DONT_LOAD=1
export EDITOR="nvim"
export BUN_INSTALL="$HOME/.bun"
export ANDROID_HOME="$HOME/android-sdk"
typeset -U path
path=(
  "$HOME/.opencode/bin"
  "$BUN_INSTALL/bin"
  "$HOME/flutter/bin"
  "$ANDROID_HOME/cmdline-tools/latest/bin"
  "$ANDROID_HOME/platform-tools"
  "$ANDROID_HOME/emulator"
  $path
)

[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
[[ -r "$HOME/.config/envman/load.sh" ]] && source "$HOME/.config/envman/load.sh"
[[ -r "$HOME/.deno/env" ]] && source "$HOME/.deno/env"
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

if command -v atuin >/dev/null 2>&1; then
  [[ -r "$HOME/.atuin/bin/env" ]] && source "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
fi

if command -v oh-my-posh >/dev/null 2>&1 && [[ -r "$HOME/.config/oh-my-posh/theme.omp.json" ]]; then
  eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/theme.omp.json")"
fi

command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)
command -v uv >/dev/null 2>&1 && eval "$(uv generate-shell-completion zsh)"
command -v jj >/dev/null 2>&1 && source <(jj util completion zsh)
command -v tv >/dev/null 2>&1 && eval "$(tv init zsh)"
command -v carapace >/dev/null 2>&1 && source <(carapace _carapace)
command -v ruff >/dev/null 2>&1 && eval "$(ruff generate-shell-completion zsh)"

alias c="cursor"
alias flutter="$HOME/flutter/bin/flutter"
alias t='trae'
alias cls="clear"
alias n="nvim"
alias ls="eza"
alias open='explorer.exe .'
alias oc="opencode"

# git aliases
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

code-session() {
  local session_name="${PWD:t}"
  tmux new-session -A -s "$session_name" -c "$PWD"
}

# suffix aliases
alias -s py=$EDITOR
alias -s ts=$EDITOR
alias -s js=$EDITOR
alias -s css=$EDITOR
alias -s html=$EDITOR
alias -s svelte=$EDITOR
alias -s md=bat

zstyle ':completion:*' menu select
