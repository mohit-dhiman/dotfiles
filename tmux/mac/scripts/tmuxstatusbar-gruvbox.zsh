#!/bin/zsh

# gruvbox (neutral tones)
cStatusBG="#282828"
cStatusFG="#ebdbb2"
cActivePaneBorder="#689d6a"
cInActivePaneBorder="#504945"
cMessageBG="#504945"
cMessageFG="#ebdbb2"
cActivePaneNum="#fabd2f"
cInActivePaneNum="#665c54"
cClock="#458588"

cSessionBG="#cc241d"
cSessionPrefixBG="#b16286"
cSessionTXT="#fbf1c7"
cActiveWindowBG="#689d6a"
cActiveWindowTXT="#1d2021"
cInActiveWindowBG=$cStatusBG
cInActiveWindowTXT="#a89984"

cLoadBG="#d79921"
cLoadTXT="#282828"
cMusicBG="#98971a"
cMusicTXT="#282828"
cLocalIPBG="#d65d0e"
cLocalIPTXT="#fbf1c7"
cDateBG="#458588"
cDateTXT="#fbf1c7"

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
#[fg=$cSessionTXT, bg=$cSessionBG, bold]#{?client_prefix,#[bg=$cSessionPrefixBG],} #S:#I.#P/#{window_panes} \
#[fg=$cSessionBG, bg=$cInActiveWindowBG]#{?client_prefix,#[fg=$cSessionPrefixBG],}#{?#{==:#I,1},#[bg=$cActiveWindowBG],}"

# Right of Status bar
tmux set-option -g status-right "\
#[fg=$cLoadBG, bg=$cStatusBG]#[fg=$cLoadTXT bg=$cLoadBG] 󰓅 #(~/dotfiles/tmux/mac/scripts/loadaverage.zsh) \
#[fg=$cMusicBG, bg=$cLoadBG]#[fg=$cMusicTXT bg=$cMusicBG] 󰝚 #(~/dotfiles/tmux/mac/scripts/musicplaying.zsh) \
#[fg=$cLocalIPBG, bg=$cMusicBG]#[fg=$cLocalIPTXT, bg=$cLocalIPBG] #(~/dotfiles/tmux/mac/scripts/localip.zsh) \
#[fg=$cDateBG, bg=$cLocalIPBG]#[fg=$cDateTXT, bg=$cDateBG ,bold] 󰃯 %a %b %d, %H:%M "

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
