### Aliases for zsh

alias cls="clear"
alias e="echo"

# Neovim and vim
if (( $+commands[vim] )); then alias v="vim"; fi
if (( $+commands[nvim] )); then
    alias nv="nvim"
    alias v="nvim"
fi

# Yazi
if (( $+commands[yazi] )); then
    function yy() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '' cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
    }
fi

# Fastfetch
if (( $+commands[fastfetch] )); then
    alias fetch="fastfetch -c examples/8.jsonc"
    alias ff="fastfetch -c examples/17.jsonc"
    alias fff="fastfetch -c examples/13.jsonc --logo none"
    function ffc () {
        if [ ! $1 ]; then
            fastfetch -c "examples/17.jsonc" "${@:2}"
        else
            fastfetch -c "examples/$1.jsonc" "${@:2}"
        fi
    }
    alias clr="clear && ff"
fi
