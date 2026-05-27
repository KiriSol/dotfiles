### Environment
$env.EDITOR = (
    [nvim vim vi nano edit]
    | which ...$in
    | get 0?.name?
    | default $env.EDITOR
)
$env.VISUAL = $env.EDITOR? | default $env.VISUAL

## Path
[
    ($env | get -o XDG_BIN_HOME | default $"($env.HOME)/.local/bin")
    $"($env.HOME)/.cargo/bin"
]
| where {|path| ($path | path exists) }
| each {|path| if $path not-in $env.PATH { $env.PATH = ($env.PATH | prepend $path) } }

## Tools
$env.LESS = "--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"
$env.FZF_DEFAULT_OPTS = "--color=16,pointer:4"
