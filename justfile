set shell := ["nu", "-c"]

base_dir := justfile_directory()
config := if os() == "windows" { ".windows.conf.yaml" } else { ".unix.conf.yaml" }

alias i := install

# Show recipes
default:
    just --list

# Dotbot install
install *args:
    dotbot -d {{ base_dir }}/src -c {{ base_dir }}/{{ config }} {{ args }}
