
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"


plugins=(git)

source $ZSH/oh-my-zsh.sh


alias c="cursor"
alias t='trae'
alias cls="clear"
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

eval "$(zoxide init --cmd cd zsh)"
