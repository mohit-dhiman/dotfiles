#!/bin/zsh
output=`$1 list-options |fzf-tmux -r 20% --multi --reverse`
output=`$1 $output`
tmux send-keys "$output"
