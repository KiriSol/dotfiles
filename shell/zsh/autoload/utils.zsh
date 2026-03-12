### Setup utils for zsh

## Fzf
if (( ${+commands[fzf]} && ${+FZF_ENABLE_PREVIEW} && FZF_ENABLE_PREVIEW != 0 )); then
    export FZF_CTRL_T_OPTS="--preview='fzf-preview.sh {}'"
    export FZF_ALT_C_OPTS="--preview='fzf-preview.sh {}'"

    _fzf_comprun() {
        local command="$1"; shift
        case "$command" in
            export | unset)
                fzf --preview "eval 'echo \${(P)1}" "$@" ;;
            ssh)
                fzf --preview "getent hosts {} || nslookup {} || echo 'No host info'" "$@" ;;
            *)
                fzf --preview="fzf-preview.sh {}" "$@" ;;
        esac
    }
fi
