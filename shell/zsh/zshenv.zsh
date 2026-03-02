### Zshenv

# Source User environment
if [ -f "$HOME/.local/bin/env" ]; then
    source "$HOME/.local/bin/env"
fi

# Use XDG base paths
export HISTFILE="$HOME/.local/share/zsh/zsh_history"
mkdir -p "$(dirname "$HISTFILE")"
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
mkdir -p "$(dirname "$ZSH_COMPDUMP")"


## Preview for fzf-tab plugin

_fzf_complete_preview_file () {
    local realpath="${1:--}"
    fzf-preview.sh $realpath
}

_fzf_complete_preview_realpath () {
    local realpath="${1:--}"  # read the first arg or stdin if arg is missing

    if [ "$realpath" = '-' ]; then
        # It is a stdin, always a text content:
        local stdin="$(< /dev/stdin)"
        echo "$stdin" | bat \
            --language=sh \
            --plain \
            --color=always \
            --wrap=character \
            --terminal-width="$FZF_PREVIEW_COLUMNS" \
            --line-range :100
            return
    fi

    if [ -d "$realpath" ]; then
        if (( $+commands[eza] )); then
            eza $EZA_DEFAULT_OPTS --all --oneline $realpath
        else
            ls -1 $realpath
        fi
    elif [ -f "$realpath" ]; then
        _fzf_complete_preview_file $realpath
    else
        # This is not a directory and not a file, just print the string.
        echo "$realpath" | fold -w "$FZF_PREVIEW_COLUMNS"
    fi
}
