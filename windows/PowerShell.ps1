# NOTE: use git bash utils

### Variables
$env:BAT_THEME = "OneHalfDark"
$env:LESS = "-R -r --raw-control-chars --quit-if-one-screen --mouse"

## Append to PATH
if (Get-Command git.exe -ErrorAction Ignore) {
    $env:PATH += ";C:\Program Files\Git\usr\bin" # GNU tools
}


### Pretty start
if (Get-Command fastfetch.exe -ErrorAction Ignore) {
    clear.exe -x
    fastfetch.exe --load-config examples/8.jsonc
}


### Modules & Completions
Import-module -Name Terminal-Icons
Import-Module -Name Microsoft.WinGet.CommandNotFound
# Import-Module -Name PowerShellProTools
Import-Module -Name posh-git
# Import-Module -Name oh-my-posh # I usually install separately

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

## Uv (python package and environment manager)
if (Get-Command uv -ErrorAction Ignore) {
    (& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
    (& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression
}

## Winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}


# PSReadLine
Set-PSReadLineOption -PredictionSource History # IntelliSense suggestions
Set-PSReadlineOption -HistorySearchCursorMovesToEnd # Move cursor to end at search
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete # Completions like zsh
Set-PSReadLineOption -ExtraPromptLineCount 1 # Menu appearance


### Theme
if (Get-Command oh-my-posh -ErrorAction Ignore) {
    Set-Alias -Name omp -Value 'oh-my-posh'
    function Set-Theme ($theme) { oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\$theme.omp.json" | Invoke-Expression }
    Set-Theme night-owl
}


### Aliases
Set-Alias -Name touch -Value New-Item

function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }
function .... { Set-Location -Path ..\..\.. }

if (Get-Command scoop.ps1 -ErrorAction Ignore) { function which ($command) { scoop.ps1 which $command } }
else { function which ($command) { Get-Command $command } }


### Keybindings
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit


### Utils

## Yazi
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

## Eza
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

    function tree { ls --tree @args }

    function la { ls --sort=Name --all @args }
    function l { ls --header --long @args }
    function ll { l --all @args }

    # Full information about files
    function lla { ls -lbhHigUmuSa @args }
    function llx { ls -lbhHigUmuSa@ @args }

    # Ls with sorting
    function lgit { ls --all --git-ignore @args }
    function lmod { ls --all --header --long --sort=modified @args }
    function lcreate { ll --sort=created @args }
    function lsize { ll --sort=size @args }
    function ldirs { ls --only-dirs @args }
    function lfiles { ls --only-files @args }

    # Tree with level (first argument)
    function lt ($level = 1) {
        tree --level=$level @args
    }

    function ls1 { ls --tree --level=1 @args }
    function ls2 { ls --tree --level=2 @args }
    function ls3 { ls --tree --level=3 @args }

    # Others
    function ltt { tree --no-user --all --ignore-glob=$EZA_IGNORE_GLOB @args }
    function lss { ls --oneline @args }
    function lxx { ls --across @args }
    function lrr { ls --recurse @args }

    function labs { ls --absolute=on @args }
    function lpwd { labs -d . @args }
}

## Fastfetch
if (Get-Command fastfetch.exe -ErrorAction Ignore) {
    function ff { fastfetch.exe --load-config examples/17.jsonc @args }
    function fff { fastfetch.exe --load-config examples/13.jsonc --logo none @args }

    function paleofetch { fastfetch.exe --load-config paleofetch.jsonc @args }
    function neofetch { fastfetch.exe --load-config neofetch.jsonc @args }
    function archey { fastfetch.exe --load-config archey.jsonc @args }

    function ffc {
        param ( $number_config = 13 )
        fastfetch.exe --load-config examples/$number_config.jsonc @args
    }
}

## Git
if (Get-Command git.exe -ErrorAction Ignore) {
    Set-Alias -Name g -Value git
    function gst { git.exe status @args }
    function glog { git.exe log --oneline --decorate --graph @args }
}


### Applications

