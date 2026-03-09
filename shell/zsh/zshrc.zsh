### Zshrc

## Set path to oh-my-zsh and check Oh My Zsh installation.
if [ -d "$HOME/.local/share/oh-my-zsh" ]; then
    export ZSH="$HOME/.local/share/oh-my-zsh"
elif [ -d "$HOME/.oh-my-zsh" ]; then
    export ZSH="$HOME/.oh-my-zsh"
else
    print "Oh-My-Zsh not found!"
    return 1
fi

# Set path to zsh custom
export ZSH_CUSTOM="$ZSH/custom"

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
(( $+commands[git] )) && plugins+=(git)
(( $+commands[docker] )) && plugins+=(docker)
(( $+commands[fzf] )) && plugins+=(fzf)
(( $+commands[zoxide] )) && plugins+=(zoxide)

# Custom
[[ -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]] && plugins+=(zsh-autosuggestions)
[[ -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]] && plugins+=(zsh-syntax-highlighting)
[[ -d $ZSH_CUSTOM/plugins/fzf-tab ]] && plugins+=(fzf-tab)

# My
[[ -d $ZSH_CUSTOM/plugins/eza-zsh ]] && plugins+=(eza-zsh)

source $ZSH/oh-my-zsh.sh

# Configuration fzf-tab plugin
if [ -d $ZSH_CUSTOM/plugins/fzf-tab ]; then
    zstyle ':fzf-tab:*' use-fzf-default-opts yes
    zstyle ':fzf-tab:*' switch-group ',' '.'
    if [ "$FZF_ENABLE_PREVIEW" -ne 0 ]; then
        zstyle ':fzf-tab:complete:(-tilde-|-subscript-|-command-|-parameter-|-variant-):*' fzf-preview 'echo ${(P)word}'
    fi
fi
