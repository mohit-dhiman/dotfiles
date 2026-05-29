alias cl="claude"
alias cp="cp -i"
alias cds="cd ~/Workspaces"
alias cdc="cd ~/Workspaces/carsales"
alias cdd="cd ~/Documents"
alias cdw="cd ~/Downloads"
tmx() { tmux a -t Endor || tmux new -t Mac -s Endor}
alias grep="ggrep --color=auto"
alias tf="terraform"
alias ll="ls -ltrh"
alias lll="ls -ltrha"
alias jqp='pbpaste | jq .'
alias jqc='pbpaste | jq . | tee >(pbcopy)'
alias add='sh ~/Workspaces/sublime-notes/scripts/add.sh'
alias scratch='uv run ~/dotfiles/generalscripts/scratch.py'
