### Variables
$env:BAT_THEME = "OneHalfDark"
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
Import-module -Name Terminal-Icons -ErrorAction SilentlyContinue
Import-Module -Name posh-git -ErrorAction SilentlyContinue

## Zoxide
if (Get-Command -Name zoxide -ErrorAction Ignore) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }
else { Import-Module -Name z -ErrorAction SilentlyContinue }

## Fzf
if (Get-Command -Name fzf -ErrorAction Ignore) {
    Import-Module -Name PSFzf -ErrorAction SilentlyContinue
    if (Get-Command -Name Set-PsFzfOption -ErrorAction Ignore) {
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordSetLocation 'Alt+c'
        Set-PsFzfOption -TabExpansion
    }
}

## Chocolatey
if (Get-Command -Name choco -ErrorAction Ignore) {
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path -Path $ChocolateyProfile) { Import-Module -Name $ChocolateyProfile }
}

## Scoop
if (Get-Command -Name scoop.ps1 -ErrorAction Ignore) {
    $ScoopCompletion = "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
    if (Test-Path -Path $ScoopCompletion) {
        Import-Module -Name $ScoopCompletion
    }
}

## Winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param ($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

## Uv (python package and environment manager)
if (Get-Command -Name uv -ErrorAction Ignore) {
    (& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
    (& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression
}


# PSReadLine
Set-PSReadLineOption -PredictionSource History # IntelliSense suggestions
Set-PSReadlineOption -HistorySearchCursorMovesToEnd # Move cursor to end at search
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete # Completions like zsh
Set-PSReadLineOption -ExtraPromptLineCount 1 # Menu appearance


### Theme
if (Get-Command -Name oh-my-posh -ErrorAction Ignore) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
    oh-my-posh completion powershell | Out-String | Invoke-Expression
}


### Keybindings
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

