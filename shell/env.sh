#!/usr/bin/env sh

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
