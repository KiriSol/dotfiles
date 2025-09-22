### Aliases

function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }

if (Get-Command -Name nvim -ErrorAction Ignore) { Set-Alias -Name nv -Value nvim -Force }

if (Get-Command -Name oh-my-posh -ErrorAction Ignore) { Set-Alias -Name omp -Value oh-my-posh }

if (Get-Command -Name scoop.ps1 -ErrorAction Ignore) { function which ($command) { scoop.ps1 which $command } }
else { function which ($command) { Write-Output -InputObject $(Get-Command $command).Path } }


### Utils

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
    if (-not $env:EZA_DEFAULT_OPTS) {
        $env:EZA_DEFAULT_OPTS = (
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

    if (-not $env:EZA_IGNORE_GLOB) {
        $env:EZA_IGNORE_GLOB = ".git|.venv|venv|node_modules|__pycache__|.idea|.buildozer|.ruff_cache"
    }

    # Standard aliases
    function ListItems { eza @EZA_DEFAULT_OPTS @args }
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
    function ltt { tree --no-user --all --ignore-glob=$env:EZA_IGNORE_GLOB @args }
    function lss { ls --oneline @args }
    function lxx { ls --across @args }
    function lrr { ls --recurse @args }

    function labs { ls --absolute=on @args }
    function lpwd { labs -d . @args }
}

## Fastfetch
if (Get-Command -Name fastfetch -ErrorAction Ignore) {
    function ff { fastfetch --config examples/17.jsonc @args }
    function fff { fastfetch --config examples/13.jsonc --logo none @args }

    function paleofetch { fastfetch --config paleofetch.jsonc @args }
    function neofetch { fastfetch --config neofetch.jsonc @args }

    function ffc ($number_config = 13) {
        fastfetch --config examples/$number_config.jsonc @args
    }
}

## Git
if (Get-Command -Name git -ErrorAction Ignore) {
    Set-Alias -Name g -Value git
    function ga { git add @args }
    function gst { git status @args }
    function gcl { git clone --recurse-submodules @args }
    function glog { git log --oneline --decorate --graph @args }
    function gcam { git commit --all --message @args }
}


### Applications

