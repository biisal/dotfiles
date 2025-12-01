[ "$TERM" = "xterm-kitty" ] && export TERM=xterm-256color

. "$HOME/.local/bin/env"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
[[ ":$PATH:" != *":$BUN_INSTALL/bin:"* ]] && export PATH="$BUN_INSTALL/bin:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Shell integrations
eval "$(zoxide init zsh)"

export PATH="/home/avisek/bin:$PATH"
export PATH=$PATH:$HOME/go/bin
export MANPAGER="nvim +Man!"
export EDITOR=nvim 
export DOCKER_HOST=unix:///var/run/docker.sock


# zsh plugins
fpath+=(~/.zsh/plugins/zsh-completions/src)
autoload -Uz compinit
compinit -C

source "$HOME/.zsh_functions"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "Aloxaf/fzf-tab"

# Load fzf keybindings 
source /usr/share/fzf/key-bindings.zsh 2>/dev/null

# History
HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY      
setopt SHARE_HISTORY
HISTSIZE=10000       # Max lines in memory
SAVEHIST=10000       # Max lines in the file

# Keybindings
bindkey '^E' autosuggest-accept
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^A' beginning-of-line
bindkey "^[[3~" delete-char

setopt PROMPT_SUBST
PROMPT='%F{yellow}%n%f@%m %F{cyan}%~%f $(git_status) %B%F{#FF00E4}%f%b '

alias dsa='docker stop $(docker ps -q)'
alias dra='docker rm $(docker ps -a -q)'
alias note='nvim "$HOME/notes.txt"'
alias swag=${HOME}/go/bin/swag
alias cd="z"

# opencode
export PATH=/home/avisek/.opencode/bin:$PATH
