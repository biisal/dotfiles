[ "$TERM" = "xterm-kitty" ] && export TERM=xterm-256color

# zinit 
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# source "${ZINIT_HOME}/zinit.zsh"


function git_status() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    echo ""
  fi
}
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
[[ ":$PATH:" != *":$BUN_INSTALL/bin:"* ]] && export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"

#docker 
export DOCKER_HOST=unix:///var/run/docker.sock


# sudoeditor
export EDITOR=nvim 

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# run_godo shortcut
function run_godo() {
 	 godo
}

zle -N run_godo
# bindkey '^g' run_godo



export PATH="/home/avisek/bin:$PATH"
export PATH=$PATH:$HOME/go/bin

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export MANPAGER="nvim +Man!"

# zsh plugins
# zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab
# zinit light zsh-users/zsh-syntax-highlighting

fpath+=(~/.zsh/plugins/zsh-completions/src)

autoload -Uz compinit
compinit -C

source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.zsh/plugins/fzf-tab/fzf-tab.zsh"



HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY      
setopt SHARE_HISTORY

HISTSIZE=10000       # Max lines in memory
SAVEHIST=10000       # Max lines in the file

bindkey '^E' autosuggest-accept
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^A' beginning-of-line
bindkey "^[[3~" delete-char

setopt PROMPT_SUBST
PROMPT='%F{yellow}%n%f@%m %F{cyan}%~%f $(git_status) %B%F{#FF00E4}%f%b '

#docker alias 
alias dsa='docker stop $(docker ps -q)'
alias dra='docker rm $(docker ps -a -q)'
alias note='nvim "$HOME/notes.txt"'
# swagger alias
alias swag=${HOME}/go/bin/swag
alias cd="z"

# opencode
export PATH=/home/avisek/.opencode/bin:$PATH
