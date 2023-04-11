# colors
tm_color_bg=colour235
tm_color_bg_alt=colour237
tm_color_separator=colour8
tm_color_active=colour214
tm_color_inactive=colour68
tm_color_fg=colour68
tm_color_fg_alt=colour34

#vars
tm_separator="#[fg=$tm_color_separator]|"
#tm_battery_state="#[fg=$tm_color_active]⚡ #[fg=$tm_color_fg_alt]#{battery_percentage}"
#tm_date="#[fg=$tm_color_fg]%d %b, %R"
tm_host="#[fg=$tm_color_fg] #H"
tm_session="#[fg=$tm_color_fg_alt]#S"

# arch only
#tm_ip="#[fg=$tm_color_fg_alt]#(ip addr show wlan0 | grep 'inet\ ' | awk '{print $2}' | cut -d/ -f1-1)"

# center window list
set -g status-justify centre

# visual notification of activity in other windows
setw -g monitor-activity on
set -g visual-activity on

# set color for status bar
set-option -g status-bg colour235 #base02
set-option -g status-fg $tm_color_fg
# set-option -g status-attr dim 

# status bar
set -g status-left-length 25 
set -g status-left "$tm_host $tm_separator $tm_session"
# set -g status-right "$tm_ip $tm_separator $tm_date "
set -g status-right ""

# window status
setw -g window-status-current-format "#[fg=$tm_color_bg_alt,bold]#[bg=$tm_color_active] #I #[bg=$tm_color_bg_alt]#[fg=$tm_color_active,nobold] #W "
setw -g window-status-format "#[bg=$tm_color_inactive]#[fg=$tm_color_bg_alt,bold] #I #[fg=$tm_color_inactive,nobold]#[bg=$tm_color_bg_alt] #W "

# pane border
# set-option -g pane-border-fg $tm_color_bg_alt
# set-option -g pane-active-border-fg $tm_color_inactive

# message text
# set-option -g message-bg colour235
# set-option -g message-fg $tm_color_fg

# pane number display
set-option -g display-panes-active-colour $tm_color_active
set-option -g display-panes-colour $tm_color_inactive

# clock
set-window-option -g clock-mode-colour $tm_color_fg

# selection window
# @url http://superuser.com/questions/603448/change-tmux-windowlist-selection-color
# set-window-option -g mode-bg colour235
# set-window-option -g mode-fg $tm_color_fg
