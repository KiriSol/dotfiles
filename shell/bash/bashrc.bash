### Bashrc

export HISTFILESIZE=0
unset HISTFILE

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

# User specific environment
if [ -d "$HOME/.local/bin" ] && [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
