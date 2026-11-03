### Aliases & Abbreviations
abbr -a cls clear
abbr -a e echo

# Editor
test $VISUAL; and abbr -a v (basename $VISUAL)

## External
type -q mise; and abbr -a m mise
type -q just; and abbr -a j just
type -q zellij; and abbr -a zj zellij

if type -q git
    abbr -a g git
    abbr -a gpl "git pl"
    abbr -a gps "git ps"
    abbr -a ga "git a"
    abbr -a gd "git d"
    abbr -a gst "git st"
    abbr -a gco "git co"
    abbr -a gbr "git br"
    abbr -a gc "git c"
    abbr -a gca "git ca"
    abbr -a gcm "git cm"
    abbr -a gcam "git cam"
    abbr -a gcl "git cl"
    abbr -a glg "git lg"
    alias groot="cd (git rev-parse --show-toplevel)"
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
