thm_bg="#1e1e2e"
thm_fg="#cdd6f4"
thm_cyan="#89dceb"
thm_black="#181825"
thm_gray="#313244"
thm_magenta="#cba6f7"
thm_pink="#f5c2e7"
thm_red="#f38ba8"
thm_green="#a6e3a1"
thm_yellow="#f9e2af"
thm_blue="#89b4fa"
thm_orange="#fab387"
thm_black4="#585b70"

# status
set -g status "on"
set -g status-bg "${thm_bg}"
set -g status-justify "left"
set -g status-left-length "100"
set -g status-right-length "100"

# messages
set -g message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
set -g message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

# panes
set -g pane-border-style "fg=${thm_gray}"
set -g pane-active-border-style "fg=${thm_blue}"

  # windows
set -w window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
set -w window-status-separator ""
set -w window-status-style "fg=${thm_fg},bg=${thm_bg},none"

# --------=== Statusline
# These variables are the defaults so that the setw and set calls are easier to parse.
show_directory="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics]  #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} #{?client_prefix,#[fg=$thm_red]"

show_window="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray] #W #{?client_prefix,#[fg=$thm_red]"

show_session="#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray] #S "

show_directory_in_window_status="#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #W "

show_directory_in_window_status_current="#[fg=colour232,bg=$thm_orange] #I #[fg=colour255,bg=colour237] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) "

show_window_in_window_status="#[fg=$thm_fg,bg=$thm_bg] #W #[fg=$thm_bg,bg=$thm_blue] #I#[fg=$thm_blue,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "

show_window_in_window_status_current="#[fg=$thm_fg,bg=$thm_gray] #W #[fg=$thm_bg,bg=$thm_orange] #I#[fg=$thm_orange,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "
 #setw -g window-status-current-format "#[fg=colour232,bg=$thm_orange] #I #[fg=colour255,bg=colour237] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) "

show_user="#[fg=$thm_blue,bg=$thm_gray]$right_separator#[fg=$thm_bg,bg=$thm_blue] #[fg=$thm_fg,bg=$thm_gray] #(whoami) "

show_host="#[fg=$thm_blue,bg=$thm_gray]$right_separator#[fg=$thm_bg,bg=$thm_blue]󰒋 #[fg=$thm_fg,bg=$thm_gray] #H "

show_date_time="#[fg=$thm_blue,bg=$thm_gray]$right_separator#[fg=$thm_bg,bg=$thm_blue] #[fg=$thm_fg,bg=$thm_gray] $date_time "

# Right column 1 by default shows the Window name.
right_column1=$show_window

# Right column 2 by default shows the current Session name.
right_column2=$show_session

# Window status by default shows the current directory basename.
window_status_format=$show_directory_in_window_status
window_status_current_format=$show_directory_in_window_status_current

right_column1=$show_directory
window_status_format=$show_window_in_window_status
window_status_current_format=$show_window_in_window_status_current
right_column2=$right_column2$show_user
right_column2=$right_column2$show_host
right_column2=$right_column2$show_date_time

set -g status-left ""
set -g status-right "${right_column1},${right_column2}"
set -w window-status-format "${window_status_format}"
set -w window-status-current-format "${window_status_current_format}"

# --------=== Modes
set -w clock-mode-colour "${thm_blue}"
set -w mode-style "fg=${thm_pink} bg=${thm_black4} bold"
