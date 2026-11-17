[windows]
set shell := ["cmd", "/c"]

alias f := format
alias i := install

@default:
    just --list

[group("dev")]
@format *args:
    treefmt {{ args }} -- {{ justfile_dir() }}

[group("setup")]
@install config="dotbot.conf.yaml":
    dotbot -d {{ justfile_dir() }}/src -c {{ justfile_dir() }}/{{ config }}

[group("setup")]
@create-work-dirs:
    -mkdir -- {{ home_dir() }}/dev
    -mkdir -- {{ home_dir() }}/tmp

[android]
[group("setup")]
@termux-font-install url="https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/Ligatures/JetBrainsMonoNerdFont-Regular.ttf":
    [ -n "${TERMUX_VERSION:-}" ] && \
        curl -Lo {{ home_dir() }}/.termux/font.ttf --create-dirs {{ url }} || \
        (echo "You are not in Termux" && false)
