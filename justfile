alias f := fmt
alias i := install

@default:
    just --list

[group("dev")]
@fmt:
    treefmt

[group("setup")]
@install config="dotbot.conf.yaml":
    dotbot -d {{ justfile_dir() }}/src -c {{ justfile_dir() }}/{{ config }}

[group("setup")]
@create-dirs:
    -mkdir {{ home_dir() }}/dev
    -mkdir {{ home_dir() }}/tmp

[group("setup")]
[linux]
@termux-font-install url="https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf":
    [ -d "{{ home_dir() }}/.termux" ] && \
        curl -Lo {{ home_dir() }}/.termux/font.ttf {{ url }} || \
        echo "You are not in Termux"
