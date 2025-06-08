# zinit 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# powerlevel10 setup
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# PROMPT='%F{green}%n%f@%m:%F{cyan}%~%f %(!.#.$) ' # if pl10k is on then it will be replaced by pl10k prompt

source $ZSH/oh-my-zsh.sh


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"

#docker 
export DOCKER_HOST=unix:///var/run/docker.sock

# go hot reload
alias air='$(go env GOPATH)/bin/air'

# git alias 
alias gs='git status'
alias ga='git add'
# alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gi='git init'

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
