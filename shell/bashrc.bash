### Bashrc

local_bin_home="${XDG_BIN_HOME:-$HOME/.local/bin}"

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

# Source User environment
[[ -f "$local_bin_home/env" ]] && source "$local_bin_home/env"

## Variables

# Bash
export HISTFILESIZE=0
unset HISTFILE

# Add to PATH
if [[ -d $local_bin_home ]] && [[ ! "$PATH" =~ $local_bin_home ]]; then
    export PATH="$local_bin_home:$PATH"
fi

unset local_bin_home
