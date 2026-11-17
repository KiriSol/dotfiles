### Environment

## Path
mut path_additions = [
    ($env.XDG_BIN_HOME? | default $"($env.HOME)/.local/bin")
    $"($env.HOME)/.cargo/bin"
]

if (which ^mise | is-not-empty) {
    $path_additions = $path_additions | prepend (
        mise settings get shims_dir
        | complete
        | get stdout
        | str trim
    )
}

$path_additions
| where {|path| $path | path exists }
| each {|path| if $path not-in $env.PATH { $env.PATH = $env.PATH | prepend $path } }

## Tools
$env.LESS = "--mouse --quit-if-one-screen --raw-control-chars"
$env.FZF_DEFAULT_OPTS = "--color base16"

$env.EDITOR = (
    [nvim vim vi nano]
    | which ...$in
    | get 0?.path?
    | default $env.EDITOR?
)
$env.VISUAL = $env.EDITOR? | default $env.VISUAL?
