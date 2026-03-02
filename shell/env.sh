#!/bin/env sh

### Environment for posix shells

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export LESS="-Rr --raw-control-chars --quit-if-one-screen --mouse"

# Preferred editor
if command -v nvim >/dev/null; then
    export EDITOR='nvim'
elif command -v vim >/dev/null; then
    export EDITOR='vim'
elif command -v nano >/dev/null; then
    export EDITOR='nano'
fi

# Catppuccin theme for fzf
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,spinner:#8CAAEE,hl:#E78284 \
    --color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#8CAAEE \
    --color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
    --color=selected-bg:#51577D \
    --color=border:#6C6F85,label:#C6D0F5 \
    --bind='F2:toggle-preview' \
    --bind='shift-up:preview-page-up,shift-down:preview-page-down'"

## My variables

export ENABLE_FZF_PREVIEW=1

export EZA_DEFAULT_OPTS="--git \
    --hyperlink \
    --color=always \
    --icons=always \
    --group-directories-first \
    --sort=type \
    --time-style=long-iso \
    --header \
    --classify=always"
