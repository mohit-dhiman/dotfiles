#!/bin/zsh
output=`$1 list-options |fzf-tmux -r 20% --multi --reverse| $1`
tmux send-keys "$output"
