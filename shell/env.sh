### Environment for posix shells

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin" ]]; then
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

# Fzf
export FZF_DEFAULT_OPTS=" \
    --color=16,pointer:4 \
    --preview-window=border:rounded \
    --bind='F2:toggle-preview' \
    --bind='shift-up:preview-page-up,shift-down:preview-page-down'"

## My variables

export FZF_ENABLE_PREVIEW=1

export EZA_DEFAULT_OPTS=" \
    --git \
    --hyperlink \
    --color=always \
    --icons=always \
    --group-directories-first \
    --sort=type \
    --time-style=long-iso \
    --header \
    --classify=always"
