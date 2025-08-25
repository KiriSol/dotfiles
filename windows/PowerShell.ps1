# NOTE: use git bash utils

### Variables
$env:BAT_THEME = "OneHalfDark"
$env:LESS = "-R -r --raw-control-chars"

### Append to PATH
if (Get-Command git.exe -ErrorAction Ignore) {
    $env:PATH += ";C:\Program Files\Git\usr\bin" # GNU tools
}

### Pretty start
clear.exe -x
fastfetch.exe --load-config examples/8.jsonc

### Theme
if (Get-Command oh-my-posh -ErrorAction Ignore) {
    Set-Alias -Name omp -Value 'oh-my-posh'
    function Set-Theme ($theme) { oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\$theme.omp.json" | Invoke-Expression }
    Set-Theme night-owl
}


### Modules
Import-module -Name Terminal-Icons
Import-Module -Name Microsoft.WinGet.CommandNotFound
Import-Module -Name PowerShellProTools

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}


# PSReadLine
Set-PSReadLineOption -PredictionSource History


### Completions
(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
(& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression


### Aliases
Set-Alias -Name touch -Value 'New-Item'

function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }
function .... { Set-Location -Path ..\..\.. }

if (Get-Command scoop.ps1 -ErrorAction Ignore) { function which ($command) { scoop.ps1 which $command } }
else { function which ($command) { Get-Command $command } }


### Keybindings
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit


### Utils

# Yazi
if (Get-Command yazi.exe -ErrorAction Ignore) {
    function yy {
        $tmp = [System.IO.Path]::GetTempFileName()
        yazi $args --cwd-file="$tmp"
        $cwd = Get-Content -Path $tmp -Encoding UTF8
        if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
            Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
        }
        Remove-Item -Path $tmp
    }
}

# Eza
if (Get-Command eza.exe -ErrorAction Ignore) {
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

    $EZA_IGNORE_GLOB = ".git|.venv|venv|node_modules|__pycache__|.idea|.buildozer|.ruff_cache"

    # Standard aliases
    function ListItems { eza.exe $EZA_DEFAULT_OPTS @args }
    Set-Alias -Name ls -Value ListItems

    function tree { eza.exe $EZA_DEFAULT_OPTS --tree @args }

    function la { eza.exe $EZA_DEFAULT_OPTS --sort=Name --all @args }
    function l { eza.exe $EZA_DEFAULT_OPTS --header --long @args }
    function ll { eza.exe $EZA_DEFAULT_OPTS --all --header --long @args }

    # Full information about files
    function lla { eza.exe $EZA_DEFAULT_OPTS -lbhHigUmuSa @args }
    function llx { eza.exe $EZA_DEFAULT_OPTS -lbhHigUmuSa@ @args }

    # Ls with sorting
    function lgit { eza.exe $EZA_DEFAULT_OPTS --all --git-ignore @args }
    function lmod { eza.exe $EZA_DEFAULT_OPTS --all --header --long --sort=modified @args }
    function lcreate { eza.exe $EZA_DEFAULT_OPTS --all --header --long --sort=created @args }
    function lsize { eza.exe $EZA_DEFAULT_OPTS --all --header --long --sort=size @args }
    function ldirs { eza.exe $EZA_DEFAULT_OPTS --only-dirs @args }
    function lfiles { eza.exe $EZA_DEFAULT_OPTS --only-files @args }

    # Tree with level (first argument)
    function lt {
        $level = if ($args.Count -eq 0) { "1" } else { $args[0] }
        $args = if ($args.Count -le 1) { "." } else { $args[1..($args.Count-1)] }

        tree --level=$level @args
    }

    function ls1 { eza.exe $EZA_DEFAULT_OPTS --tree --level=1 @args }
    function ls2 { eza.exe $EZA_DEFAULT_OPTS --tree --level=2 @args }

    # Others
    function lT { eza.exe $EZA_DEFAULT_OPTS --tree --no-user --all --ignore-glob=$EZA_IGNORE_GLOB @args }
    function lS { eza.exe $EZA_DEFAULT_OPTS --oneline @args }
    function lX { eza.exe $EZA_DEFAULT_OPTS --across @args }
    function lR { eza.exe $EZA_DEFAULT_OPTS --recurse @args }

    function labs { eza.exe $EZA_DEFAULT_OPTS --absolute=on @args }
    function lpwd { eza.exe $EZA_DEFAULT_OPTS --absolute=on -d . @args }
}

# Fastfetch
if (Get-Command fastfetch.exe -ErrorAction Ignore) {
    function ff { fastfetch.exe --load-config examples/17.jsonc $args }
    function fff { fastfetch.exe --load-config examples/13.jsonc $args --logo none }

    function paleofetch { fastfetch.exe --load-config paleofetch.jsonc $args }
    function neofetch { fastfetch.exe --load-config neofetch.jsonc $args }
    function archey { fastfetch.exe --load-config archey.jsonc --logo arch2 $args }

    function ffc {
        param ( $number_config = 13 )
        fastfetch.exe --load-config examples/$number_config.jsonc $args
    }
}

# Git
if (Get-Command git.exe -ErrorAction Ignore) {
    Set-Alias -Name g -Value git
    function gst { git.exe status $args }
    function glog { git.exe log --oneline --decorate --graph $args }
}


### Applications

