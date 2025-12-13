


export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

autoload -Uz compinit
compinit                                
set -o vi


plugins=(git)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
nvm use default > /dev/null 2>&1 || true
export PATH="$(nvm_path):$PATH"

eval "$(ssh-agent -s)" ssh-add ~/.ssh/jemo
ssh -T git@github.com
clear



alias c="cursor"
alias flutter="~/flutter/bin/flutter"
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


# bun completions
[ -s "/home/jemo/.bun/_bun" ] && source "/home/jemo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"





eval "$(zoxide init --cmd cd zsh)"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(atuin init zsh)"
eval "$(~/.local/bin/oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/jandedobbeleer.omp.json)"
export PATH="$PATH:~/flutter/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
