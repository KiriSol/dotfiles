### ========== Enable features ==========

# True Colors
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",*256col*:Tc"

# Under curl/line
set-option -as terminal-overrides ",tmux-256color:Tc"
set -as terminal-overrides ',*:Setulc=\E[58::2::::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'

# Hyperlinkshighlight SignColumn ctermbg=NONE guibg=NONE
set -as terminal-features ",*:hyperlinks"

# Sixel and etc
set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM


### ========== Core settings ==========

# Main prefix
set -g prefix C-a

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


### ========== Plugins ==========

set -g @plugin 'tmux-plugins/tpm' # plugin menager

# Core
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-sessionist'

# Appearance
set -g @plugin 'fabioluciano/tmux-tokyo-night'

## Sessions

set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'

## Tokyo Night Theme configuration

# set -g @theme_variation '' # night, storm, moon
set -g @theme_left_separator ''
set -g @theme_transparent_left_separator_inverse ''
set -g @theme_plugins 'datetime' # datetime, battery, weather
# set -g @theme_disable_plugins 1
set -g @theme_transparent_status_bar 'true'

# Start tpm
run '~/.tmux/plugins/tpm/tpm'
