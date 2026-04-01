### Aliases and Abbreviations

abbr -a cls clear
abbr -a e echo

# Neovim and Vim
if type -q nvim
    abbr -a nv nvim
    abbr -a v nvim
    alias lazyvim="NVIM_APPNAME=lazyvim nvim"
else if type -q vim
    abbr -a v vim
end

# Mise
if type -q mise
    abbr -a m mise
end

# Git
if type -q git
    alias g=git
    alias ga="g add"
    alias gd="g diff"
    alias gst="g status"
    alias gco="g checkout"
    alias gbr="g branch"
    alias gcm="g commit"
    alias gcma="gcm --all"
    alias gcam="gcma --message"
    alias gcl="g clone --recurse-submodules"
    alias glg="g log --oneline --decorate --graph"
end

# Fastfetch
if type -q fastfetch
    alias ff="fastfetch -c examples/17.jsonc"
    alias fff="fastfetch -c examples/13.jsonc --logo none"
    alias clr="clear; fastfetch -c examples/17.jsonc"
end

# Eza
if type -q eza
    set -l default_opts \
        --git \
        --hyperlink \
        --color=always \
        --icons=always \
        --group-directories-first \
        --sort=type \
        --time-style=long-iso \
        --header \
        --classify=always
    set -l ignore_glob ".git"

    alias ls="eza $default_opts"
    alias la="ls --sort=Name --all"
    alias l="ls --header --long"
    alias ll="l --all"
    alias tree="ls --tree"
    alias lT="ls --tree --no-user --no-permissions --all --ignore-glob='$ignore_glob'"
end
