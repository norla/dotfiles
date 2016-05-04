export PATH=./node_modules/.bin:/usr/local/bin:/usr/local/sbin:~/bin:$PATH
export GOPATH=~/go
export PATH=$PATH:${GOPATH//://bin:}/bin
export LSCOLORS=exfxcxdxbxegedabagacad

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[$(tput setaf 1)\]\w\[$(tput setaf 4)\]$(__git_ps1) \[$(tput sgr0)\]'

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS='-R'

alias denv='eval $(docker-machine env exp-docker)'

#export PS1="\[$(tput setaf 1)\]\W\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
#source /usr/local/git/contrib/completion/git-completion.bash
