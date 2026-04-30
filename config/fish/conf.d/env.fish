### Environment

# CC
if type -q zig
    set -gx CC "zig cc"
end

## Path

# Local bin
set -l local_bin_home (set -q XDG_BIN_HOME; and echo $XDG_BIN_HOME; or echo $HOME/.local/bin)
if test -d $local_bin_home; and not contains $local_bin_home $PATH
    fish_add_path --global --move --path $local_bin_home
end

# Cargo
set -l cargo_bin_home $HOME/.cargo/bin
if test -d $cargo_bin_home; and not contains $cargo_bin_home $PATH
    fish_add_path --global --move --path $cargo_bin_home
end

# Mise shims
if type -q mise
    mise activate fish --shims | source
end

## Tools

set -gx LESS "--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"
set -gx FZF_DEFAULT_OPTS "--color=16,pointer:4"

# Editor
if type -q nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
else if type -q vi
    set -gx EDITOR vi
end
