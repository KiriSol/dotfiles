### Aliases for zsh

alias cls="clear"
alias e="echo"

# Neovim and vim
if (( ${+commands[nvim]} )); then
    alias nv="nvim" v="nvim"
elif (( ${+commands[vim]} )); then
    alias v="vim"
fi

# Yazi
if (( ${+commands[yazi]} )); then
    function yy() {
        local tmp="${TMPDIR:-/tmp}/yazi-cwd.$RANDOM" cwd
        yazi "$@" --cwd-file="$tmp"
        if [[ -f "$tmp" ]] && cwd=$(<"$tmp") && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi

# Fastfetch
if (( ${+commands[fastfetch]} )); then
    alias fetch="fastfetch -c examples/8.jsonc"
    alias ff="fastfetch -c examples/17.jsonc"
    alias fff="fastfetch -c examples/13.jsonc --logo none"
    alias clr="clear && ff"
    function ffc() {
        local config="${1:-17}"
        shift $(( $# > 0 ))
        fastfetch -c "examples/${config}.jsonc" "$@"
    }
fi
