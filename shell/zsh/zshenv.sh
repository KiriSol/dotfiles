### Zshenv

# Source User environment
if [ -f "$HOME/.local/bin/env" ]; then
    source "$HOME/.local/bin/env"
fi

# Use XDG base paths
export HISTFILE="$HOME/.local/share/zsh/zsh_history"
mkdir -p "$(dirname "$HISTFILE")"
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
mkdir -p "$(dirname "$ZSH_COMPDUMP")"
