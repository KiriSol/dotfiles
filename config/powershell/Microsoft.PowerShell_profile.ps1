### Aliases

function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }
function .... { Set-Location -Path ..\..\.. }
function ..... { Set-Location -Path ..\..\..\.. }

function which ($command) { Write-Output -InputObject $(Get-Command $command).Path }


### Tools

## Neovim
if (Get-Command -Name nvim -ErrorAction Ignore) {
    Set-Alias -Name nv -Value nvim -Force
    Set-Alias -Name v -Value nvim -Force
}

## Yazi
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

## Eza
if (Get-Command -Name eza -ErrorAction Ignore) {
    if (-not $EZA_DEFAULT_OPTS) {
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
    }
    if (-not $EZA_IGNORE_GLOB) {
        $EZA_IGNORE_GLOB = ".git|.venv|node_modules"
    }

    function Eza-ListItems { eza @EZA_DEFAULT_OPTS @args }
    Set-Alias -Name ls -Value Eza-ListItems -Force

    function la { ls --sort=Name --all @args }
    function l { ls --header --long @args }
    function ll { l --all @args }
    function tree { ls --tree @args }
    function lt ($level = 1) { tree --level=$level @args }
    function ltt { tree --no-user --all --ignore-glob=$EZA_IGNORE_GLOB @args }
}

## Fastfetch
if (Get-Command -Name fastfetch -ErrorAction Ignore) {
    function ff { fastfetch -c examples/17.jsonc @args }
    function fff { fastfetch -c examples/13.jsonc --logo none @args }
    function clr { Clear-Host && ff }
    function ffc ($config = 17) { fastfetch -c examples/config.jsonc @args }
}

## Git
if (Get-Command -Name git -ErrorAction Ignore) {
    Set-Alias -Name g -Value git
}
