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
    alias fetch="fastfetch --load-config examples/8.jsonc"
    alias ff="fastfetch --load-config examples/17.jsonc"
    alias fff="fastfetch --load-config examples/13.jsonc --logo none"
    function ffc () {
        if [ $ARGC -eq 0 ]; then
            $1="17"
        fi
        fastfetch --load-config examples/$1.jsonc "${@:2}"
    }
    alias neofetch="fastfetch --load-config neofetch.jsonc"
    alias paleofetch="fastfetch --load-config paleofetch.jsonc"
    alias clr="clear && ff"
fi

# Neovim configurations
if [ -d ~/.config/nvchad ]; then
    alias nvchad="NVIM_APPNAME=nvchad nvim"
fi
if [ -d ~/.config/lazyvim ]; then
    alias lazyvim="NVIM_APPNAME=lazyvim nvim"
fi
