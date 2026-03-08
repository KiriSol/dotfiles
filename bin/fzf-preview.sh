#!/bin/env bash

# The purpose of this script is to demonstrate how to preview a file or an
# image in the preview window of fzf.

# Optional dependencies:
# - https://github.com/eza-community/eza
# - https://github.com/sharkdp/bat
# - https://github.com/hpjansson/chafa

#!/bin/sh

# Usage: fzf-reader "FILENAME[:LINENO]" or pipe text to it
input="${1:-}"

# 1. Handle stdin if input is empty or "-"
if [ -z "$input" ] || [ "$input" = "-" ]; then
    stdin_content=$(cat)
    if [ -n "$stdin_content" ]; then
        echo "$stdin_content" | bat --plain --color=always --terminal-width="${FZF_PREVIEW_COLUMNS:-80}" --line-range :100 2>/dev/null || echo "$stdin_content"
    fi
    exit 0
fi

# 2. Expand Tilde (POSIX way)
case "$input" in
    \~*) path="$HOME/${input#\~/}" ;;
    *) path="$input" ;;
esac

# 3. Parse filename and line number
# Logic: Try to split by ':' and check if the left part is a readable file
file_path=$(echo "$path" | sed 's/:[0-9]*$//; s/:[0-9]*:[0-9]*$//')
center=$(echo "$path" | sed -n 's/^.*:\([0-9][0-9]*\).*/\1/p')
[ -z "$center" ] && center=0

# 4. Directory Preview
if [ -d "$file_path" ]; then
    if command -v eza >/dev/null 2>&1; then
        eza --all --oneline --color=always --icons "$file_path"
    else
        ls -1F --color=always "$file_path"
    fi

# 5. File Preview
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

# 6. Fallback for strings/environment variables
else
    echo "$input" | fold -w "${FZF_PREVIEW_COLUMNS:-80}"
fi
