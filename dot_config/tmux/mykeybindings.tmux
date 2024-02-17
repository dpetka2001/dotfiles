# Change the prefix key to C-a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Some extra key bindings to select higher numbered windows
bind F1 selectw -t:10
bind F2 selectw -t:11
bind F3 selectw -t:12
bind F4 selectw -t:13
bind F5 selectw -t:14
bind F6 selectw -t:15
bind F7 selectw -t:16
bind F8 selectw -t:17
bind F9 selectw -t:18
bind F10 selectw -t:19
bind F11 selectw -t:20
bind F12 selectw -t:21

# Keys to toggle monitoring activity in a window, and synchronize-panes
bind m set monitor-activity
bind y set synchronize-panes\; display 'synchronize-panes #{?synchronize-panes,on,off}'

# Reload tmux config with ctrl + a + r
unbind r
bind r \
    source-file ~/.config/tmux/tmux.conf \;\
        display 'Reloaded tmux config.'

# Vertical and horizontal splits
#unbind v
#bind-key v split-window -h
unbind C-v
bind-key C-v split-window -h

#unbind h
#bind-key h split-window
unbind C-h
bind-key C-h split-window

# Moving windows/panes
bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R

# Kill all panes but current
unbind C-q
bind C-q kill-pane -a

# Kill all windows but current
unbind C-w
bind C-w kill-window -a

# Run ide command to split panes
unbind i
bind i run-shell 'ide'

bind C-j split-window -v "tmux ls | sed -E 's/:.*$//' | fzf --reverse | xargs tmux switch-client -t"
bind C-k split-window -v "tmux ls | sed -E 's/:.*$//' | fzf --reverse | xargs tmux kill-session -t"
bind C-t run-shell "tmux neww ~/.config/tmux/bin/tmux-template"

# Kill server
# bind C-k run "tmux kill-server > /dev/null"

# Enable select/yank in `copy-mode`
unbind-key -T copy-mode-vi v
setw -g mode-keys vi
bind -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection
