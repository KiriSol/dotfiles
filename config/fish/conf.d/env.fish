### Environment

# Path
set -l local_bin_home (set -q XDG_BIN_HOME; and echo $XDG_BIN_HOME; or echo $HOME/.local/bin)
if test -d $local_bin_home; and not contains $local_bin_home $PATH
    set -gx PATH $local_bin_home $PATH
end

# Tools
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
