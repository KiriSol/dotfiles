### Variables

if (Get-Command -Name nvim -Ignore) {
    $env:EDITOR = "nvim"
} elseif (Get-Command -Name vim -Ignore) {
    $env:EDITOR = "vim"
} elseif (Get-Command -Name nano -Ignore) {
    $env:EDITOR = "nano"
} elseif (Get-Command -Name edit -Ignore) {
    $env:EDITOR = "edit"
}

$env:LESS = "-R -r --raw-control-chars --quit-if-one-screen --mouse"

$env:FZF_DEFAULT_OPTS = @"
--color=bg+:#414559,spinner:#8CAAEE,hl:#E78284
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#8CAAEE
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284
--color=selected-bg:#51577D
--color=border:#6C6F85,label:#C6D0F5
--preview-window=border:rounded
--bind='F2:toggle-preview'
"@

if (Get-Command -Name fzf-preview.ps1 -ErrorAction Ignore) {
    $env:FZF_ALT_C_OPTS = "--preview='powershell -File $($(Get-Command -Name fzf-preview.ps1).Path) {}'"
    $env:FZF_CTRL_T_OPTS = "--preview='powershell -File $($(Get-Command -Name fzf-preview.ps1).Path) {}'"
}


### Modules & Plugins
if (-not (Get-Command -Name eza -ErrorAction Ignore)) { Import-module -Name Terminal-Icons -ErrorAction Ignore }

## Zoxide
if (Get-Command -Name zoxide -ErrorAction Ignore) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }

## Fzf
if (Get-Command -Name fzf -ErrorAction Ignore) {
    Import-Module -Name PSFzf -ErrorAction Ignore
    if (Get-Command -Name Set-PsFzfOption -ErrorAction Ignore) {
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordSetLocation 'Alt+c'
        Set-PsFzfOption -TabExpansion
    }
}


# PSReadLine
Set-PSReadLineOption -PredictionSource History # IntelliSense suggestions
Set-PSReadlineOption -HistorySearchCursorMovesToEnd # Move cursor to end at search
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete # Completions like zsh
Set-PSReadLineOption -ExtraPromptLineCount 1 # Menu appearance


### Theme


### Keybindings
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

