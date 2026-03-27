### Zshrc

## Set path to oh-my-zsh
local omz_paths=( "$HOME/.local/share/oh-my-zsh" "$HOME/.oh-my-zsh" )

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

# My fzf preview switcher
ENABLE_FZF_PREVIEW="true"

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
    fzf-tab                  fzf
    zsh-autosuggestions      zsh
    zsh-syntax-highlighting  zsh
    eza-zsh                  eza
)
for plugin cmd in ${(kv)custom_plugins}; do
    (( ${+commands[$cmd]} )) && [[ -d "$ZSH_CUSTOM/plugins/$plugin" ]] && plugins+=($plugin)
done

source $ZSH/oh-my-zsh.sh

# Configuration fzf-tab plugin
if (( ${plugins[(I)fzf-tab]} )); then
    zstyle ':fzf-tab:*' use-fzf-default-opts yes
    zstyle ':fzf-tab:*' switch-group ',' '.'
    if [[ "$ENABLE_FZF_PREVIEW" == "true" ]]; then
        zstyle ':fzf-tab:complete:(-tilde-|-subscript-|-command-|-parameter-|-variant-):*' fzf-preview 'echo ${(P)word}'
    fi
fi
