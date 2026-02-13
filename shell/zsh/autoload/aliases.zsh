### Aliases for zsh

alias cls="clear"
alias e="echo"

if (( $+commands[vim] )); then alias v="vim"; fi
if (( $+commands[nvim] )); then
    alias nv="nvim"
    alias v="nvim"
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
    alias neofetch="fastfetch -c neofetch.jsonc"
    alias paleofetch="fastfetch -c paleofetch.jsonc"
    alias clr="clear && ff"
fi

# Neovim configurations
if [ -d ~/.config/nvchad ]; then
    alias nvchad="NVIM_APPNAME=nvchad nvim"
fi
if [ -d ~/.config/lazyvim ]; then
    alias lazyvim="NVIM_APPNAME=lazyvim nvim"
fi
