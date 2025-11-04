#!/usr/bin/env sh

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export LESS="-Rr --raw-control-chars --quit-if-one-screen --mouse"
