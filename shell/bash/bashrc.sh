### Bashrc

export HISTFILESIZE=0
unset HISTFILE

## Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

## User specific environment
if [ -f "~/.local/bin/env" ]; then
    . ~/.local/bin/env
fi

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
alias v="vim"
alias nv="nvim"
alias ff="fastfetch"

if command -v yazi >/dev/null; then
    function yy() { # Yazi
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '' cwd <"$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
    }
fi
