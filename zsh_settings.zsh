# path for this file
export ZSH_SETTINGS="${0:a}" 

export BAT_THEME="OneHalfDark"

alias cls="clear"

if (( $+commands[vim] )); then; alias v="vim"; fi
if (( $+commands[nvim] )); then; alias nv="nvim"; fi

if (( $+commands[fastfetch] )); then
    alias fetch="fastfetch --load-config examples/8.jsonc"
    alias ff="fastfetch --load-config examples/17.jsonc"
    alias fff="fastfetch --load-config examples/13.jsonc --logo none"
fi

if (( $+commands[bpython] )); then; alias bpy="bpython"; fi

# For Debian-like system (apt)
if (( $+commands[fdfind] )); then; alias fd="fdfind"; fi
if (( $+commands[batcat] )); then; alias bat="batcat"; fi

if (( $+commands[batcat] )); then
    alias y="yazi"
    function yy() { # for yazi
	    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	    yazi "$@" --cwd-file="$tmp"
	    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		    builtin cd -- "$cwd"
	    fi
	    rm -f -- "$tmp"
    }
fi

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="yazi ~/.oh-my-zsh"

