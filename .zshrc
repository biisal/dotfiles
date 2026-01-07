[ "$TERM" = "xterm-kitty" ] && export TERM=xterm-256color


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
[[ ":$PATH:" != *":$BUN_INSTALL/bin:"* ]] && export PATH="$BUN_INSTALL/bin:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Shell integrations
# eval "$(zoxide init zsh)"

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
source <(fzf --zsh)

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
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey '^[[D' backward-char
bindkey '^[[C' forward-char

setopt PROMPT_SUBST
PROMPT='%F{#66FF7E}%n%f@%m %F{#43C0FE}%~%f %F{#C39AFF}$(git_status)%f %B%F{#FF00E4}%f%b '

alias dsa='docker stop $(docker ps -q)'
alias dra='docker rm $(docker ps -a -q)'
# alias note='nvim "$HOME/notes.md"'
alias swag=${HOME}/go/bin/swag
# alias cd="z"

# opencode
export PATH=/home/avisek/.opencode/bin:$PATH
fastfetch


mdn_logic() {
    (
        cd ~/mdn/files/en-us || return
        fileName=$(fzf --prompt="mdn doc> " --preview="bat --color=always --style=numbers,changes --line-range :500 {}" < /dev/tty)
        if [ -n "$fileName" ]; then
            nvim -M -c "set nonumber norelativenumber wrap" -c "nnoremap q :quit<CR>" "$fileName" < /dev/tty
        fi
    )
}

mdn_widget() {
    zle -I           
    mdn_logic        
    zle reset-prompt 
}

zle -N mdn_widget
bindkey '^O' mdn_widget

alias mdn=mdn_logic

. "$HOME/.local/bin/env"


note_logic(){
	cd ~/notes || return
	nvim "$(date +%Y/%b-%d | tr 'A-Z' 'a-z').md"
	cd - > /dev/null
}
notes_logic() { 
	cd ~/notes || return 
	local count=$(ls -1 **/*.md | wc -l | tr -d ' ')
	fileName=$(fzf --prompt="~/notes [$count]> " --border=rounded \
		--margin=1,2 \
		--no-sort \
		--preview-window="right:60%:border-left" \
		--preview="bat --color=always --style=numbers,changes --line-range :500 {}" < /dev/tty)
		if [ -n "$fileName" ]; then
		nvim $fileName
		fi
		cd - > /dev/null
}
alias notes=notes_logic
alias note=note_logic



d_logic(){
	cd ~/diary || return
	nvim "$(date +%Y/%b-%d | tr 'A-Z' 'a-z').md"
	rm ~/.cache/diary_md_files
	cd - > /dev/null
}

ds_logic() {
	cd ~/diary || return
	cache="$HOME/.cache/diary_md_files"
	if [ ! -f "$cache" ]; then
		mkdir -p ~/.cache
		fd -e md . \
			| sort -t/ -k1,1 -k2,2M -k3,3n -r \
			> "$cache"
	fi
	count=$(wc -l < "$cache")
	fileName=$(fzf < "$cache" \
		--prompt="~/diary [$count]> " \
		--border=rounded \
		--margin=1,2 \
		--no-sort \
		--preview-window="right:60%:border-left" \
		--preview='sleep 0.1; bat --color=always --style=numbers --line-range :200 {}')

	[ -n "$fileName" ] && nvim "$fileName"

	cd - > /dev/null
}
alias d=d_logic
alias ds=ds_logic
