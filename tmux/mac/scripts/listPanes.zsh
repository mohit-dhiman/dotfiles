#!/bin/bash
output=`tmux list-panes -F '#{pane_index}: #{pane_title} #{?pane_active, (active),}' |fzf-tmux -r 20% --multi --reverse|cut -c 1`
if [ -n "$output" ] 
then
    `tmux select-pane -t $output`
fi
