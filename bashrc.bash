### Bashrc

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

## Variables

# Bash
export HISTFILESIZE=0
unset HISTFILE

# Add to PATH

local_bin_home="${XDG_BIN_HOME:-$HOME/.local/bin}"

if [[ -d $local_bin_home ]] && [[ ! "$PATH" =~ $local_bin_home ]]; then
    export PATH="$local_bin_home:$PATH"
fi

unset local_bin_home
