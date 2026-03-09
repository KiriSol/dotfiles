### Setup utils for zsh

## Setup fzf
if (($+commands[fzf])); then
    # Preview configuration
    if [ "$FZF_ENABLE_PREVIEW" -ne 0 ]; then
        export FZF_CTRL_T_OPTS="--preview='fzf-preview.sh {}'"
        export FZF_ALT_C_OPTS="--preview='fzf-preview.sh {}'"

        _fzf_comprun() {
            local command="$1"; shift
            case "$command" in
                export | unset) fzf --preview "eval 'echo \${}'" "$@" ;;
                ssh) fzf --preview "
                        getent hosts {} 2>/dev/null ||
                        nslookup {} 2>/dev/null ||
                        host {} 2>/dev/null ||
                        echo 'No host info available'
                    " "$@" ;;
                *) fzf --preview="fzf-preview.sh {}" "$@" ;;
            esac
        }
    fi
fi
