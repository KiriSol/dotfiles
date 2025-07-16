### Setup utils

## Setup nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Setup fzf
if (( $+commands[fzf] )); then
  # Catppuccin theme for fzf and other options
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,spinner:#8CAAEE,hl:#E78284 \
    --color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#8CAAEE \
    --color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
    --color=selected-bg:#51577D \
    --color=border:#6C6F85,label:#C6D0F5 \
    --bind='F2:toggle-preview' \
    --bind='shift-up:preview-page-up,shift-down:preview-page-down'"

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

## Fastfetch
if (( $+commands[fastfetch] )); then
  alias fetch="fastfetch --load-config examples/8.jsonc"
  alias ff="fastfetch --load-config examples/17.jsonc"
  alias fff="fastfetch --load-config examples/13.jsonc --logo none"
  function ffc () {
    if [ $ARGC -eq 0 ]; then
      $1="17"
    fi
    fastfetch --load-config examples/$1.jsonc "${@:2}"
  }
fi

## Yazi
if (( $+commands[yazi] )); then
  function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi
