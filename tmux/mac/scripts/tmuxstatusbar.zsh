#!/bin/zsh
# Dispatcher: applies the chosen status bar variant.
# Switch themes by changing the filename below to a sibling script
# (e.g. tmuxstatusbar-gruvbox-bright.zsh). ${0:A:h} = this script's dir.
exec "${0:A:h}/tmuxstatusbar-gruvbox.zsh"
