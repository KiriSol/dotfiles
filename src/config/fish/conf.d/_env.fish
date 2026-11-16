### Environment

## Path
set -l path_additions \
    $HOME/.cargo/bin \
    (set -q XDG_BIN_HOME; and echo $XDG_BIN_HOME; or echo $HOME/.local/bin)

type -q mise; and set -l path_additions (mise settings get shims_dir 2>/dev/null; or true) $path_additions

fish_add_path --global --move --path $path_additions

## Tools
set -gx LESS "--mouse --quit-if-one-screen --raw-control-chars"
set -gx FZF_DEFAULT_OPTS "--color base16"

set -gx EDITOR (command -s nvim vim vi nano; echo $EDITOR)[1]
set -gx VISUAL (string match -r '.+' $EDITOR $VISUAL)[1]
