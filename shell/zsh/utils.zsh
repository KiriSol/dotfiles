### Setup utils

## Setup fzf
if (( $+commands[fzf] )); then
    # Preview configuration
    if [ "$FZF_PREVIEW" -ne 0 ]; then
        export FZF_CTRL_T_OPTS="--preview='_fzf_complete_preview_realpath {}'"
        export FZF_ALT_C_OPTS="--preview='eza $EZA_DEFAULT_OPTS {}'"

        _fzf_comprun() {
            local command="$1"
            shift
            case "$command" in
                cd)           fzf --preview="eza $EZA_DEFAULT_OPTS {}" "$@" ;;
                export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
                ssh)          fzf --preview "dig {}"                   "$@" ;;
                *)            fzf --preview "$reader"                  "$@" ;;
            esac
        }
    fi

    # Setup fzf-git plugin
    if [ -f $ZSH_CUSTOM/plugins/fzf-git/fzf-git.sh ]; then
        source $ZSH_CUSTOM/plugins/fzf-git/fzf-git.sh
    fi
fi
