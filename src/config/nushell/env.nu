use modules/activate.nu

### Environment

## Path
[
    $"($env.HOME)/.cargo/bin"
    ($env | get -o XDG_BIN_HOME | default $"($env.HOME)/.local/bin")
]
| where {|path| $path | path exists }
| each {|path| if $path not-in $env.PATH { $env.PATH = $env.PATH | prepend $path } }

# External

# TODO: fix loading order (aactivate mise before set EDITOR)
activate mise { ^mise activate nu --shims }

## Tools
$env.LESS = "--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"
$env.FZF_DEFAULT_OPTS = "--color=16,pointer:4"

$env.EDITOR = (
    [nvim vim vi nano]
    | which ...$in
    | get 0?.path?
    | default $env.EDITOR?
)
$env.VISUAL = $env.EDITOR? | default $env.VISUAL?
