### Environment for posix shells

## User specific environment
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

## Variables

export LESS="-Rr --raw-control-chars --quit-if-one-screen --mouse"

# Preferred editor
if command -v nvim >/dev/null 2>&1; then
    export EDITOR='nvim'
elif command -v vim >/dev/null 2>&1; then
    export EDITOR='vim'
elif command -v nano >/dev/null 2>&1; then
    export EDITOR='nano'
fi

# Fzf
export FZF_DEFAULT_OPTS=" \
    --color=16,pointer:4 \
    --preview-window=border:rounded \
    --bind='F2:toggle-preview' \
    --bind='shift-up:preview-page-up,shift-down:preview-page-down'"

## My

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
