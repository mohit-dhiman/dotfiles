#!/bin/bash

cStatusBG="colour238"
cStatusFG="colour223"
cActivePaneBorder="colour27"
cInActivePaneBorder="colour239"
cMessageBG="colour239"
cMessageFG="colour223"
cActivePaneNum="colour27"
cInActivePaneNum="colour234"
cClock="colour129"

cSessionBG="colour76"
cSessionPrefixBG="colour82"
cSessionTXT="colour0"
cActiveWindowBG="colour45"
cActiveWindowTXT="colour239"
cInActiveWindowBG=$cStatusBG
cInActiveWindowTXT="colour242"
cActiveWindowSecondaryTXT="colour33"

cLoadBG="colour241"
cLoadTXT="colour195"
cSpotifyBG="colour83"
cSpotifyTXT="colour239"
cLocalIPBG="colour202"
cLocalIPTXT="colour230"
cDateBG="colour27"
cDateTXT="colour230"

# Length of tmux status line
tmux set -g status-left-length 30
tmux set -g status-right-length 250

tmux set-option -g status "on"
tmux set -g window-status-separator ''

# Default statusbar color
tmux set-option -g status-style bg=$cStatusBG,fg=$cStatusFG # bg=bg2, fg=fg1

# Set active pane border color
tmux set-option -g pane-active-border-style fg=$cActivePaneBorder

# Set inactive pane border color
tmux set-option -g pane-border-style fg=$cInActivePaneBorder

# Message info
tmux set-option -g message-style bg=$cMessageBG,fg=$cMessageFG # bg=bg2, fg=fg1

# Pane number display
tmux set-option -g display-panes-active-colour $cActivePaneNum #fg2
tmux set-option -g display-panes-colour $cInActivePaneNum #bg1

# Clock
tmux set-window-option -g clock-mode-colour $cClock #blue

# Left of Status bar
tmux set-option -g status-left "\
#[fg=$cSessionTXT, bg=$cSessionBG, bold]#{?client_prefix,#[bg=$cSessionPrefixBG],} #S:#I.#P:#{window_panes} \
#[fg=$cSessionBG, bg=$cInActiveWindowBG]#{?client_prefix,#[fg=$cSessionPrefixBG],}#{?#{==:#I,1},#[bg=$cActiveWindowBG],}"

# Right of Status bar
tmux set-option -g status-right "\
#[fg=$cLoadBG, bg=$cStatusBG]#[fg=$cLoadTXT bg=$cLoadBG] #(~/dotfiles/tmux/scripts/loadaverage.sh) \
#[fg=$cSpotifyBG, bg=$cLoadBG]#[fg=$cSpotifyTXT bg=$cSpotifyBG]  #(~/dotfiles/tmux/scripts/spotifyplaying.sh) \
#[fg=$cLocalIPBG, bg=$cSpotifyBG]#[fg=$cLocalIPTXT, bg=$cLocalIPBG] #(~/dotfiles/tmux/scripts/localip.sh) \
#[fg=$cDateBG, bg=$cLocalIPBG]#[fg=$cDateTXT, bg=$cDateBG ,bold]  %a %b %d, %H:%M "

# Active Window in Status bar
tmux set-window-option -g window-status-current-format "\
#[fg=$cInActiveWindowBG, bg=$cActiveWindowBG]#{?#{!=:#I,1},,}\
#[fg=$cActiveWindowTXT, bg=$cActiveWindowBG] #I \
#[fg=$cActiveWindowTXT, bg=$cActiveWindowBG, bold] #W \
#[fg=$cActiveWindowBG, bg=$cInActiveWindowBG]#{?#{==:#I,#{session_windows}},#[bg=$cStatusBG],}"

# Window in Status bar
tmux set-window-option -g window-status-format "\
#[fg=$cInActiveWindowTXT, bg=$cInActiveWindowBG] #I \
#[fg=$cInActiveWindowTXT, bg=$cInActiveWindowBG] #W "
#BELOW LINE NOT IN USE
#[fg=$cInActiveWindowBG, bg=$cActiveWindowBG]#{?#{==:#I,#{session_windows}},#[bg=$cStatusBG],}"
