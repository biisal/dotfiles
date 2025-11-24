[ "$TERM" = "xterm-kitty" ] && export TERM=xterm-256color
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
    echo ""
  fi
}

PROMPT='%F{yellow}%n%f@%m %F{cyan}%~%f $(git_status) %B%F{#FF00E4}%f%b '
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
alias air='$HOME/go/bin/air'

#docker alias 
alias dsa='docker stop $(docker ps -q)'
alias dra='docker rm $(docker ps -a -q)'

# sudoeditor
export EDITOR=nvim 

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
# showing ascii art on start
# cat $HOME/.config/ascii/go.txt
fastfetch


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# run_godo shortcut
function run_godo() {
 	 godo
}

zle -N run_godo
bindkey '^g' run_godo


function clear_screen_without_history() {
	printf '\033[H\033[2J'
	zle reset-prompt
}

zle -N clear_screen_without_history
# bindkey '^u' clear_screen_without_history

# swagger alias
alias swag=${HOME}/go/bin/swag


export PATH="/home/avisek/bin:$PATH"
export PATH=$PATH:$HOME/go/bin

# vs code for wayalnd
alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias agy="antigravity  --ozone-platform=wayland"
alias note='nvim "$HOME/notes.txt"'


# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias cd="z"
