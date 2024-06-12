#!/bin/zsh
output=`$1 list-options |fzf-tmux`
output=`$1 $output`
tmux send-keys "$output"
