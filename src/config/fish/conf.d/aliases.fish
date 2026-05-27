### Aliases and Abbreviations
abbr -a cls clear
abbr -a e echo

# Editor
test $EDITOR; and abbr -a v (basename $EDITOR)

## External
type -q mise; and abbr -a m mise
type -q just; and abbr -a j just

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

if type -q fastfetch
    alias ff="fastfetch -c examples/17.jsonc"
    alias fff="fastfetch -c examples/13.jsonc --logo none"
    alias clr="clear; fastfetch -c examples/17.jsonc"
end

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
    alias ls="eza $default_opts"
    alias la="ls --sort=Name --all"
    alias l="ls --header --long"
    alias ll="l --all"
    alias tree="ls --tree"
    alias ltg="ls --tree --no-user --no-permissions --all --git-ignore"
end
