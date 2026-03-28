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

# Eza
if (( ${+commands[eza]} )) && (( ! ${plugins[(I)eza-zsh]} )); then
    alias ls="eza $EZA_DEFAULT_OPTS"
    alias la='ls --sort=Name --all'
    alias l='ls --header --long'
    alias ll='l --all'
    alias tree='ls --tree'
    lt() { tree --level "${1:-1}" "${@:2}" }
    alias lT="ls --tree --no-user --no-permissions --all --ignore-glob='$EZA_IGNORE_GLOB'"
fi

# Fastfetch
if (( ${+commands[fastfetch]} )); then
    alias ff="fastfetch -c examples/17.jsonc"
    alias fff="fastfetch -c examples/13.jsonc --logo none"
    alias clr="clear && ff"
fi
