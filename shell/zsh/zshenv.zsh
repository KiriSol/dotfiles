. "$HOME/.local/bin/env"

export HISTFILE="$HOME/.local/share/zsh/zsh_history"
mkdir -p "$(dirname "$HISTFILE")"
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
mkdir -p "$(dirname "$ZSH_COMPDUMP")"

export FZF_PREVIEW=1

export EZA_DEFAULT_OPTS=(
    '--git'
    '--hyperlink'
    '--color=always'
    '--icons=always'
    '--group-directories-first'
    '--sort=type'
    '--time-style=long-iso'
    '--header'
    '--classify=always'
    # '--colour-scale-mode=gradient'
    # '--color-scale=all'
)

# Catppuccin theme for fzf and other options
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,spinner:#8CAAEE,hl:#E78284 \
    --color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#8CAAEE \
    --color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
    --color=selected-bg:#51577D \
    --color=border:#6C6F85,label:#C6D0F5 \
    --bind='F2:toggle-preview' \
    --bind='shift-up:preview-page-up,shift-down:preview-page-down'"

## Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

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
