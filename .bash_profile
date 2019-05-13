export PATH=./node_modules/.bin:/usr/local/bin:/usr/local/sbin::$PATH
export GOPATH=~/go
export PATH=$PATH:${GOPATH//://bin:}/bin
export LSCOLORS=exfxcxdxbxegedabagacad

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
GIT_PS1_SHOWDIRTYSTATE=true

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

#LESSPIPE=`which src-hilite-lesspipe.sh`
#export LESSOPEN="| ${LESSPIPE} %s"
export LESS='-R'

alias git-up='git pull --rebase --autostash'
alias emc='/Applications/Emacs.ap	p/Contents/MacOS/bin/emacsclient -c -n'
alias elx-login='oc login https://console.elx-os1-prod.bonniernews.io -u mattias.norlander && docker login -u $(oc whoami) -p $(oc whoami -t) docker-registry-default.internal.elx.ohoy.io'
alias oc-login='oc login https://console.prod.bonniernews.io -u mattias.norlander && docker login -u $(oc whoami) -p $(oc whoami -t) registry.trusted.ohoy.io'
#export PS1="\[$(tput setaf 1)\]\W\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
#source /usr/local/git/contrib/completion/git-completion.bash

export EXP_OSX_DOCKER=true

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#PATH=$PATH:~/bin

export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
PATH=$PATH:$HOME/bin

# Hack to ensure we are always using correct ursursnode version
function set_ps1() {
  [[ -f .nvmrc ]] && nvm use > /dev/null 2>&1
  PS1='\[$(tput setaf 1)\]\w\[$(tput setaf 4)\]$(__git_ps1) \[$(tput sgr0)\]'
}

export PS1='\[$(tput setaf 1)\]\w\[$(tput setaf 4)\]$(__git_ps1) \[$(tput sgr0)\]'
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export SBT_OPTS="-Xmx2G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -Xss2M"
export PATH="/usr/local/opt/sbt@0.13/bin:$PATH"

function cd {
  builtin cd "$@"
  if [ $? -eq 0 ] && [ -f ".nvmrc" ]; then
    # Use --latest-npm because the NPM version affects package-lock.json, so if we
    # lock the Node.js version with NVM we should try to lock NPM too, and this
    # option sort of does that: "After installing, attempt to upgrade to the latest
    # working npm on the given node version"
    nvm use --latest-npm
  fi
}
