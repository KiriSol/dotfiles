### Variables
$env:BAT_THEME = "OneHalfDark"
$env:LESS = "-R -r --raw-control-chars --quit-if-one-screen --mouse"

$env:FZF_DEFAULT_OPTS = @"
--color=bg+:#414559,spinner:#8CAAEE,hl:#E78284
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#8CAAEE
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284
--color=selected-bg:#51577D
--color=border:#6C6F85,label:#C6D0F5
--bind='F2:toggle-preview'
--bind='shift-up:preview-page-up,shift-down:preview-page-down'
"@

if (Get-Command -Name fzf-preview.ps1 -ErrorAction Ignore) {
    $env:FZF_ALT_C_OPTS = "--preview='powershell -File fzf-preview.ps1 {}'"
    $env:FZF_CTRL_T_OPTS = "--preview='powershell -File fzf-preview.ps1 {}'"
}

## Append to PATH

# GNU tools
if (Get-Command -Name git.exe -ErrorAction Ignore) {
    $GitBashBinaries = "$($(Get-Item $(Get-Command git.exe).Path).Directory.Parent.FullName)\usr\bin"
    if (Test-Path -Path $GitBashBinaries) {
        $env:PATH += ";$GitBashBinaries"
    }
}


### Pretty start
if (Get-Command -Name fastfetch.exe -ErrorAction Ignore) {
    fastfetch.exe --config examples/8.jsonc
}


### Modules & Plugins
Import-module -Name Terminal-Icons -ErrorAction SilentlyContinue
Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
# Import-Module -Name PowerShellProTools -ErrorAction SilentlyContinue
Import-Module -Name posh-git -ErrorAction SilentlyContinue

## Z (modern cd)
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
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path -Path $ChocolateyProfile) { Import-Module -Name $ChocolateyProfile }

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
    Set-Alias -Name omp -Value oh-my-posh
    function Set-Theme ($theme) { oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\$theme.omp.json" | Invoke-Expression }
    Set-Theme night-owl
}


### Aliases
Set-Alias -Name touch -Value New-Item

function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }
function .... { Set-Location -Path ..\..\.. }

if (Get-Command -Name nvim.exe -ErrorAction Ignore) { Set-Alias -Name nv -Value nvim.exe -Force }

if (Get-Command -Name scoop.ps1 -ErrorAction Ignore) { function which ($command) { scoop.ps1 which $command } }
else { function which ($command) { Write-Output -InputObject $(Get-Command $command).Path } }
Set-Alias -Name w -Value Get-Command


### Keybindings
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit


### Utils

## Yazi
if (Get-Command -Name yazi.exe -ErrorAction Ignore) {
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

## Eza
if (Get-Command -Name eza.exe -ErrorAction Ignore) {
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
    function ListItems { eza.exe @EZA_DEFAULT_OPTS @args }
    Set-Alias -Name ls -Value ListItems -Force

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
if (Get-Command -Name fastfetch.exe -ErrorAction Ignore) {
    function ff { fastfetch.exe --config examples/17.jsonc @args }
    function fff { fastfetch.exe --config examples/13.jsonc --logo none @args }

    function paleofetch { fastfetch.exe --config paleofetch.jsonc @args }
    function neofetch { fastfetch.exe --config neofetch.jsonc @args }
    function archey { fastfetch.exe --config archey.jsonc @args }

    function ffc ($number_config = 13) {
        fastfetch.exe --config examples/$number_config.jsonc @args
    }
}

## Git
if (Get-Command -Name git.exe -ErrorAction Ignore) {
    Set-Alias -Name g -Value git
    function ga { git.exe add @args }
    function gst { git.exe status @args }
    function gcl { git.exe clone --recurse-submodules @args }
    function glog { git.exe log --oneline --decorate --graph @args }
    function gcam { git.exe commit --all --message @args }
}


### Applications

