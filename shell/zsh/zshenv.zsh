### Zshenv

# Source User environment
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

## Use XDG base paths

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history"
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

# Create if doesn't exist
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h
[[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h
