### Zshrc

# Set path to oh-my-zsh and check Oh My Zsh installation.
if [ -d "$HOME/.local/share/oh-my-zsh" ]; then
    export ZSH="$HOME/.local/share/oh-my-zsh"
elif [ -d "$HOME/.oh-my-zsh" ]; then
    export ZSH="$HOME/.oh-my-zsh"
else
    print "Oh-My-Zsh not found!"
    return 1
fi

# Set name of the theme to load
if [ -n "$TERMUX_VERSION" ]; then
    ZSH_THEME="robbyrussell"
else
    ZSH_THEME="bira"
fi

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

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    # Standard
    git
    docker
    fzf
    zoxide

    # Custom
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf-tab

    # My plugins
    eza-zsh
)

source $ZSH/oh-my-zsh.sh

# Configuration fzf-tab completion
zstyle ':completion:*' ignored-patterns '**/.|**/..|**/.git'

zstyle ':fzf-tab:*' use-fzf-default-opts yes

if [ "$ENABLE_FZF_PREVIEW" -ne 0 ]; then
  zstyle ':fzf-tab:complete:(\\|*/|)(ls|eza|bat|cat|cd|z|rm|rmdir|cp|mv|ln|nano|vi|vim|nvim|open|tail|tree|source):*' \
    fzf-preview \
    '_fzf_complete_preview_realpath "$realpath"'
fi
