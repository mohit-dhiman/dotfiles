# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
#export PS1="`logDacxHistory`[\u@\h \W]\$ "
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1 )/'
}
export PS1="[\u@\h \W]\[\033[00;31m\]\$(git_branch)\[\033[00m\]\$ "

#export NVM_DIR="/home/common/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#[ -f ~/dotfiles/generalscripts/prompt.sh ] && source ~/dotfiles/generalscripts/prompt.sh

#export PROMPT_COMMAND='printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
source ~/dotfiles/bash/sync-history.sh

