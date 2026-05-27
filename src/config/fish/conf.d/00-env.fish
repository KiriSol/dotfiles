### Environment
set -gx EDITOR (command -s nvim vim vi nano; echo $EDITOR)[1]
set -gx VISUAL (string match -r '.+' $EDITOR $VISUAL)[1]

## Path
fish_add_path --global --move --path \
    (set -q XDG_BIN_HOME; and echo $XDG_BIN_HOME; or echo $HOME/.local/bin) \
    $HOME/.cargo/bin

type -q mise; and mise activate fish --shims | source

## Tools
set -gx LESS "--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"
set -gx FZF_DEFAULT_OPTS "--color=16,pointer:4"
