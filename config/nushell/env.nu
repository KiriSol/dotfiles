### Environment

# CC
if (which zig | is-not-empty) {
  $env.CC = "zig cc"
}

## Path

# Local bin & Cargo
let local_bin = ($env | get -i XDG_BIN_HOME | default $"($env.HOME)/.local/bin")
let cargo_bin = $"($env.HOME)/.cargo/bin"

[$local_bin, $cargo_bin] |
  filter { |path| ($path | path exists) } |
    each {
      |path|
      if $path not-in $env.PATH {
        $env.PATH = ($env.PATH | prepend $path)
      }
    }

## Tools

$env.LESS = "--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"
$env.FZF_DEFAULT_OPTS = "--color=16,pointer:4"

# Editor
$env.EDITOR = (
  if (which nvim | is-not-empty) { "nvim" }
  else if (which vim | is-not-empty) { "vim" }
  else if (which vi | is-not-empty) { "vi" }
  else if (which edit | is-not-empty) { "edit" }
)
