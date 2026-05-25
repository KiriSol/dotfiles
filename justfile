set shell := ["sh", "-c"]
set windows-shell := ["cmd.exe", "/c"]

alias i := install
alias f := fmt

default:
    @just --list

[group("dev")]
fmt:
    treefmt

config := "install.conf.yaml"

[group("setup")]
install *args:
    @dotbot -d {{ justfile_dir() }}/src -c {{ justfile_dir() }}/{{ config }} {{ args }}

[group("setup")]
create-work-dirs:
    -mkdir {{ home_dir() }}/dev
    -mkdir {{ home_dir() }}/tmp

[group("setup")]
[linux]
install-termux-font font-url:
    @curl --create-dirs -Lo {{ home_dir() }}/.termux/font.ttf {{ font-url }}
