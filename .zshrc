# zinit 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# powerlevel10 setup
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"



function git_status() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "🐱"
  fi
}

PROMPT='%F{yellow}%n%f@%m %F{cyan}%~%f $(git_status) %B%F{#FF00E4}❯%f%b '
# PROMPT='%F{yellow}%n%f@%m %F{cyan}%~%f %B%F{#FF00E4}❯%f%b '

source $ZSH/oh-my-zsh.sh


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
[[ ":$PATH:" != *":$BUN_INSTALL/bin:"* ]] && export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"

#docker 
export DOCKER_HOST=unix:///var/run/docker.sock

# go hot reload
alias air='$(go env GOPATH)/bin/air'

#docker alias 
alias dsa='docker stop $(docker ps -q)'
alias dra='docker rm $(docker ps -a -q)'

# sudoeditor
export EDITOR=nvim 

# Shell integrations
eval "$(fzf --zsh)"

# showing ascii art on start
cat $HOME/.config/ascii/go.txt

#custom scripts
alias gc=$HOME/.config/scriptisto-scripts/ai-commit-push/main.go

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# run_godo shortcut
function run_godo() {
 	 godo
}

zle -N run_godo
bindkey '^g' run_godo
