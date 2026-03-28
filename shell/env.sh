### Environment for POSIX shells

## Variables

# Add to PATH
case ":$PATH:" in
    *":${XDG_BIN_HOME:-$HOME/.local/bin}:"*) ;;
    *) export PATH="${XDG_BIN_HOME:-$HOME/.local/bin}:$PATH" ;;
esac

# Tools
export LESS="--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"
export FZF_DEFAULT_OPTS="--color=16,pointer:4"

# Editor
if command -v nvim >/dev/null; then
    export EDITOR="nvim"
elif command -v vim >/dev/null; then
    export EDITOR="vim"
elif command -v vi >/dev/null; then
    export EDITOR="vi"
fi
