### Bashrc

export HISTFILESIZE=0
unset HISTFILE

## Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

## User specific environment
[ -f ~/.local/bin/env ] && source ~/.local/bin/env

## Alaises

# Useful
alias l="ls -l"
alias la="ls -a"
alias ll="ls -al"
alias md="mkdir"
alias cls="clear"
alias e="echo"

# Utils
alias g="git"
alias ff="fastfetch"

if command -v nvim >/dev/null 2>&1; then
    alias nv="nvim"
    alias v="nvim"
elif command -v vim >/dev/null 2>&1; then
    alias v="vim"
fi

if command -v yazi >/dev/null 2>&1; then
    yy() {
        local tmp
        tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if [ -f "$tmp" ]; then
            local cwd
            cwd=$(<"$tmp")
            [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && cd -- "$cwd"
            rm -f -- "$tmp"
        fi
    }
fi
