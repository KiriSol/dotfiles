. "$HOME/.local/bin/env"

# Rustup
. "$HOME/.cargo/env"

export BAT_THEME="Catppuccin Mocha" # theme for bat

export FZF_PREVIEW=1

export EZA_DEFAULT_OPTS=(
  '--git'                     # Информация о git status
  '--hyperlink'               # Гиперссылки на открытие программой по умолчанию
  '--color=always'            # Все цвета
  '--icons=always'            # Все иконки
  '--group-directories-first' # Сначала директории
  '--sort=type'               # Сортировка по типу
  '--time-style=long-iso'     # Стиль времени
  '--header'                  # Названия столбцов информации
  '--classify=always'         # Подсказки по типу элемента
)

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
