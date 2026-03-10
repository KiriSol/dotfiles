#!/bin/env sh

# The purpose of this script is to demonstrate how to preview a file or an
# image in the preview window of fzf.

# Optional dependencies:
# - https://github.com/eza-community/eza
# - https://github.com/sharkdp/bat
# - https://github.com/hpjansson/chafa

input="${1:-}"

# 1. Handle stdin if input is empty or "-"
if [ -z "$input" ] || [ "$input" = "-" ]; then
    stdin_content=$(cat)
    if [ -n "$stdin_content" ]; then
        bat_cmd=$(command -v batcat || command -v bat)
        if [ -n "$bat_cmd" ]; then
            echo "$stdin_content" | "$bat_cmd" --plain --color=always --terminal-width="${FZF_PREVIEW_COLUMNS:-80}" --line-range :100
        else
            echo "$stdin_content"
        fi
    fi
    exit 0
fi

# Expand Tilde
case "$input" in
    \~*) path="$HOME/${input#\~/}" ;;
    *) path="$input" ;;
esac

# Parse filename and line number
# Logic: Try to split by ':' and check if the left part is a readable file
file_path=$(echo "$path" | sed 's/:[0-9]*$//; s/:[0-9]*:[0-9]*$//')
center=$(echo "$path" | sed -n 's/^.*:\([0-9][0-9]*\).*/\1/p')
[ -z "$center" ] && center=0

# 2. Directory Preview
if [ -d "$file_path" ]; then
    if command -v eza >/dev/null 2>&1; then
        eza --all --oneline --color=always $EZA_DEFAULT_OPTS "$file_path"
    else
        ls -1F --color=always "$file_path"
    fi

# 3. File Preview
elif [ -f "$file_path" ]; then
    mime=$(file --brief --dereference --mime -- "$file_path" 2>/dev/null)
    case "$mime" in
        *image/*)
            dim="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}"
            if { [ -n "$KITTY_WINDOW_ID" ] || [ -n "$GHOSTTY_RESOURCES_DIR" ]; } && command -v kitten >/dev/null 2>&1; then
                kitten icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place="$dim@0x0" "$file_path" | sed '$d' | sed 's/$/\e[m/'
            elif command -v chafa >/dev/null 2>&1; then
                chafa -s "$dim" "$file_path"
            else
                file "$file_path"
            fi
            ;;
        *=binary*)
            file "$file_path"
            ;;
        *)
            # Text preview
            bat_cmd=$(command -v batcat || command -v bat)
            if [ -n "$bat_cmd" ]; then
                "$bat_cmd" --style="${BAT_STYLE:-numbers}" --color=always --pager=never --highlight-line="$center" "$file_path"
            else
                cat "$file_path"
            fi
            ;;
    esac

# 4. Fallback for strings/environment variables
else
    echo "$input" | fold -w "${FZF_PREVIEW_COLUMNS:-80}"
fi
