# path for this file
export ZSH_SETTINGS="${0:a}" 

export BAT_THEME="OneHalfDark"

# Aliases
alias cls="clear"

alias v="vim"
alias nv="nvim"
alias y="yazi"

alias fetch="fastfetch --load-config examples/8.jsonc"
alias ff="fastfetch --load-config examples/17.jsonc"
alias fff="fastfetch --load-config examples/13.jsonc --logo none"

alias bpy="bpython"

alias fd="fdfind"; alias bat="batcat" # for Debian-like system (apt)

# Functions
function yy() { # for yazi
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="yazi ~/.oh-my-zsh"

