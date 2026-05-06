set shell := ["sh", "-c"]
set windows-shell := ["cmd.exe", "/c"]

alias i := install

default:
    @just --list

config := if os_family() == "windows" { ".windows.conf.yaml" } else { ".unix.conf.yaml" }

[group("setup")]
install *args:
    @dotbot -d {{ justfile_dir() }}/src -c {{ justfile_dir() }}/{{ config }} {{ args }}

[group("setup")]
create-work-dirs:
    -mkdir {{ home_dir() }}/{{ if os_family() == "windows" { "Dev" } else { "dev" } }}
    -mkdir {{ home_dir() }}/{{ if os_family() == "windows" { "Tmp" } else { "tmp" } }}

nerd-fonts-url := "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts"
font-path := "JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf"

[group("setup")]
[linux]
install-termux-font:
    @curl -Lo {{ home_dir() }}/.termux/font.ttf {{ nerd-fonts-url }}/{{ font-path }}

winterm-conf-path := "src/windows/apps/Microsoft.WindowsTerminal/settings.json"
winterm-conf-target := "AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

[group("setup")]
[windows]
install-winterm-settings:
    @cp {{ justfile_dir() }}/{{ winterm-conf-path }} {{ home_dir() }}/{{ winterm-conf-target }}
