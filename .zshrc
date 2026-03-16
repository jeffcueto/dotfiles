# Menu and menu select
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# prompt themes:
autoload -Uz promptinit
promptinit

alias ls='ls --color=auto'

# historical commads
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Default editor
export EDITOR=vim

# keybinding open defualt editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line
#bindkey -M vicmd v edit-command-line # this is very popular but not for me

# This is for move to Miunidad
alias m='cd $HOME/Miunidad/'


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# For .local/bin in home
export PATH="$HOME/.local/bin:$PATH"

export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
export MANPATH=/usr/local/texlive/2026/texmf-dist/doc/man
export INFOPATH=/usr/local/texlive/2026/texmf-dist/doc/info


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias config='/usr/bin/git --git-dir=/home/jeff/.dotfiles/ --work-tree=/home/jeff'
