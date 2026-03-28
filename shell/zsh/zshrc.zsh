### Zshrc

## Set path to oh-my-zsh
local omz_paths=( "${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh" "$HOME/.oh-my-zsh" )

for p in $omz_paths; do
    if [[ -d $p ]]; then
        export ZSH=$p
        break
    fi
done

if [[ -z $ZSH ]]; then
    print -P "%F{red}Oh-My-Zsh not found!%f"
    return 1
fi

# Set path to oh-my-zsh custom
export ZSH_CUSTOM="${ZSH}/custom"

## Variables

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Use case-sensitive completion.
CASE_SENSITIVE="false"

# Use hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="%F{blue}…"

# Change the command execution time stamp shown in the history command output.
HIST_STAMPS="dd.mm.yyyy"

# Disable marking untracked files under VCS as dirty.
DISABLE_UNTRACKED_FILES_DIRTY="false"

# Set the auto-update behavior
zstyle ':omz:update' mode reminder

## Plugins
plugins=()

# Standard
local -A std_plugins=(
    git     git
    docker  docker
    fzf     fzf
    zoxide  zoxide
)
for plugin cmd in ${(kv)std_plugins}; do
    (( ${+commands[$cmd]} )) && plugins+=($plugin)
done

# Custom
local -A custom_plugins=(
    zsh-autosuggestions      zsh
    zsh-syntax-highlighting  zsh
)
for plugin cmd in ${(kv)custom_plugins}; do
    (( ${+commands[$cmd]} )) && [[ -d "$ZSH_CUSTOM/plugins/$plugin" ]] && plugins+=($plugin)
done

source $ZSH/oh-my-zsh.sh
