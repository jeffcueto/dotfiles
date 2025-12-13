#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=2000

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$HOME/.local/bin:$PATH"

# This is for move to Miunidad
alias m='cd $HOME/Miunidad/'

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2025/texmf-dist/doc/man
export INFOPATH=/usr/local/texlive/2025/texmf-dist/doc/info

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/home/jeff/.ghcup/env" ] && . "/home/jeff/.ghcup/env" # ghcup-envalias 

alias config='/usr/bin/git --git-dir=/home/jeff/.dotfiles/ --work-tree=/home/jeff'
