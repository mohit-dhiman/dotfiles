#!/bin/zsh
WORKSPACE_DIR="/Users/mohitdhiman/Workspaces/carsales"
selected=$(cd "$WORKSPACE_DIR" && print -l *(/N) | fzf-tmux -r 20% --reverse)
[ -n "$selected" ] && code "$WORKSPACE_DIR/$selected"
