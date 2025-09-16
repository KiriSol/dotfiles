### Aliases for zsh

alias cls="clear"
alias e="echo"

if (( $+commands[vim] )); then alias v="vim"; fi
if (( $+commands[nvim] )); then alias nv="nvim"; fi

if (( $+commands[bpython] )); then alias bpy="bpython"; fi

# For Debian-like system
# if (( $+commands[fdfind] )); then alias fd="fdfind"; fi
# if (( $+commands[batcat] )); then alias bat="batcat"; fi

## Zsh

# Choose alias for configure zsh
if [ -n "${EDITOR+x}" ]; then
    cmd_for_open_file=$EDITOR
elif (( $+commands[nvim] )); then
    cmd_for_open_file='nvim'
elif (( $+commands[vim] )); then
    cmd_for_open_file='vim'
elif (( $+commands[vi] )); then
    cmd_for_open_file='vi'
else
    cmd_for_open_file='cat'
fi
alias zshconfig="$cmd_for_open_file ${ZDOTDIR:-$HOME}/.zshrc"
unset cmd_for_open_file

# Choose alias for configure oh-my-zsh
if (( $+commands[yy] )); then
    cmd_for_open_dir='yy'
elif (( $+commands[yazi] )); then
    cmd_for_open_dir='yazi'
elif (( $+commands[nvim])); then
    cmd_for_open_dir='nvim'
elif (( $+commands[vim] )); then
    cmd_for_open_dir='vim'
else
    cmd_for_open_dir='ls'
fi
alias ohmyzsh="$cmd_for_open_dir $ZSH"
unset cmd_for_open_dir

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
fi

# Neovim configurations
if [ -d ~/.config/nvchad ]; then
    alias nvchad="NVIM_APPNAME=nvchad nvim"
fi
if [ -d ~/.config/lazyvim ]; then
    alias lazyvim="NVIM_APPNAME=lazyvim nvim"
fi
