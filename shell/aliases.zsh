### Aliases for zsh

alias cls="clear"

if (( $+commands[vim] )); then; alias v="vim"; fi
if (( $+commands[nvim] )); then; alias nv="nvim"; fi

# Choose alias for configure zsh
if [[ -n "${EDITOR+x}" ]]; then
  command_for_open=$EDITOR
elif (( $+commands[nvim] )); then
  command_for_open='nvim'
elif (( $+commands[vim] )); then
  command_for_open='vim'
else
  command_for_open='open'
fi
alias zshconfig="$command_for_open ~/.zshrc"

# Choose alias for configure oh-my-zsh
if (( $+commands[yazi] )); then
  command_for_open_dir='yy'
elif (( $+commands[nvim])); then
  command_for_open_dir='nvim'
elif (( $+commands[vim] )); then
  command_for_open_dir='vim'
else
  command_for_open_dir='open'
fi
alias ohmyzsh="$command_for_open_dir ~/.oh-my-zsh"

if (( $+commands[bpython] )); then; alias bpy="bpython"; fi

# For Debian-like system
if (( $+commands[fdfind] )); then; alias fd="fdfind"; fi
if (( $+commands[batcat] )); then; alias bat="batcat"; fi

# Neovim configurations
if [[ -d "~/.config/nvchad" ]]; then
    alias nvchad="NVIM_APPNAME=nvchad nvim"
fi
if [[ -d "~/.config/lazyvim" ]]; then
    alias lazyvim="NVIM_APPNAME=lazyvim nvim"
fi
