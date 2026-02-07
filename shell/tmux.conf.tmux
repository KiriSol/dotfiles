# NOTE: This is a self-contained configuration for bare tmux.

### ========== Enable features ==========

# True Colors
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# For images
set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM

### ========== Core settings ==========

# Main prefix
set -g prefix C-a

set -s escape-time 0
set -g history-limit 10000
set -g focus-events on

# Sort by name
bind s choose-tree -sZ -O name

# Change first indexes
set -g base-index 1
setw -g pane-base-index 1

set -g mouse on # Enable Mouse
set-option -g status-position top # Move status bar

## Change keybindings
unbind %
bind | split-window -h # Vertical split

unbind '"'
bind - split-window -v # Horizontal split

unbind r
bind r source-file ~/.tmux.conf # Reload settings

# Resize pane
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5

bind -r m resize-pane -Z

set-window-option -g mode-keys vi

# Visual mode and yank like Vim
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection

unbind -T copy-mode-vi MouseDragEnd1Pane

