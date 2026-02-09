#!/bin/env sh

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
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
