### Variables

if (Get-Command -Name nvim -ErrorAction Ignore) {
    $env:EDITOR = "nvim"
} elseif (Get-Command -Name edit -ErrorAction Ignore -and $IsWindows) {
    $env:EDITOR = "edit"
}

$env:LESS = "--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"

$env:FZF_DEFAULT_OPTS = @"
--color=16,pointer:4
--preview-window=border:rounded
--bind='F2:toggle-preview'
--bind='shift-up:preview-page-up,shift-down:preview-page-down'
"@

$EZA_DEFAULT_OPTS = (
    '--git',
    '--hyperlink',
    '--color=always',
    '--icons=always',
    '--group-directories-first',
    '--sort=type',
    '--time-style=long-iso',
    '--header',
    '--classify=always'
)

$EZA_IGNORE_GLOB = ".git"


### Modules & Plugins

## Zoxide
if (Get-Command -Name zoxide -ErrorAction Ignore) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }

## PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -ExtraPromptLineCount 1
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit


### Theme


### Aliases

function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }
function .... { Set-Location -Path ..\..\.. }
function ..... { Set-Location -Path ..\..\..\.. }

function which ($command) { Write-Output -InputObject $(Get-Command $command).Path }

## Tools

# Neovim
if (Get-Command -Name nvim -ErrorAction Ignore) {
    Set-Alias -Name nv -Value nvim -Force
    Set-Alias -Name v -Value nvim -Force
}

# Yazi
if (Get-Command -Name yazi -ErrorAction Ignore) {
    function yy {
        $tmp = [System.IO.Path]::GetTempFileName()
        yazi @args --cwd-file="$tmp"
        $cwd = Get-Content -Path $tmp -Encoding UTF8
        if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
            Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
        }
        Remove-Item -Path $tmp
    }
}

# Eza
if (Get-Command -Name eza -ErrorAction Ignore) {
    Remove-Alias ls -Force
    function ls { eza @EZA_DEFAULT_OPTS @args }
    function la { ls --sort=Name --all @args }
    function l { ls --header --long @args }
    function ll { l --all @args }
    function tree { ls --tree @args }
    function lt ($level = 1) { tree --level=$level @args }
    function ltt { tree --no-user --no-permissions --all --ignore-glob=$EZA_IGNORE_GLOB @args }
}

# Fastfetch
if (Get-Command -Name fastfetch -ErrorAction Ignore) {
    function ffc ($config = 17) { fastfetch -c "examples/$config.jsonc" @args }
    function ff { ffc 17 @args }
    function fff { ffc 13 --logo none @args }
    function clr { Clear-Host && ff @args }
}

# Git
if (Get-Command -Name git -ErrorAction Ignore) {
    Set-Alias -Name g -Value git -Force
}
