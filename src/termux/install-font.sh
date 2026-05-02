#!/bin/env sh

# Install font for termux

if [ -n "$TERMUX_VERSION" ]; then
  curl -Lo ~/.termux/font.ttf \
    https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
else
  echo "You're not in Termux!"
  exit 1
fi
