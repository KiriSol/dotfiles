# Переменные
$DotFiles = "$env:USERPROFILE/.dotfiles"

$env:BAT_THEME = "OneHalfDark"
$env:PY_PYTHON = "3.10"

# Append to PATH (only for PowerShell)
$env:PATH += ";C:\Program Files\Git\usr\bin" # GNU tools


clear.exe -x
fastfetch.exe --load-config examples/8.jsonc # красивый старт

if (Get-Command oh-my-posh -ErrorAction Ignore) {
    # Тема для PowerShell и функция для смены
    function Set-Theme ($theme) { oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\$theme.omp.json" | Invoke-Expression }
    Set-Theme night-owl

    Set-Alias -Name omp -Value 'oh-my-posh'
}


# Модули
Import-module -Name Terminal-Icons
Import-Module -Name Microsoft.WinGet.CommandNotFound
Import-Module -Name PowerShellProTools

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile" # Автозаполнение для Chocolatey
}


# Aliases
Set-Alias -Name touch -Value 'New-Item'


# Keybindings
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit # Выход


# Python
#region
# ==============================================================

# ==============================================================
#endregion


# Смена директории
#region
function Set-ParentDirectory { Set-Location -Path .. }
Set-Alias -Name .. -Value Set-ParentDirectory
function Set-ParentDirectory2 { Set-Location -Path ../.. }
Set-Alias -Name ... -Value Set-ParentDirectory2
function Set-ParentDirectory3 { Set-Location -Path ../../.. }
Set-Alias -Name .... -Value Set-ParentDirectory3

function Set-Location-DotFiles { Set-Location -Path $DotFiles }

#endregion


# Утилиты
# ==============================================================

# Yazi
if (Get-Command yazi.exe -ErrorAction Ignore) {
    Set-Alias -Name y -Value yazi
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
    $eza_params = ( # standard settings
        "--icons=always", # все иконки
        "--color=always", # все цвета
        "--classify=always", # символы показывающие тип элемента
        "--header", # заголовок для --long
        "--hyperlink", # гиперссылки
        "--time-style=long-iso", # нормальный стиль времени
        "--group-directories-first", # сначала директории
        "--git" # информация о git status
    )

    # Базовые
    function ListItems { eza.exe $eza_params --sort=type $args } # eza с приятными параметрами
    function TreeItems { eza.exe $eza_params --tree $args } # дерево элементов

    function la { eza.exe $eza_params --sort=name --all $args } # ls со скрытыми элементами
    function l { eza.exe $eza_params --long --group $args } # полная информация о файлах
    function ll { eza.exe $eza_params --long --group --all $args } # l со скрытыми элементами
    function lla { eza.exe $eza_params -lbhHigUmuSa $args } # увеличенная полная информация
    # function llx { base_list -lbhHigUmuSa@ $args }

    # С сортировкой
    function ltree { eza.exe $eza_params --tree --long --no-user $args } # Дерево с полной информацией
    function lgit { eza.exe $eza_params --long --no-user --git-ignore --git-repos $args } # без элементов, указанных в .gitignore
    function labs { eza.exe $eza_params --absolute=on $args } # абсолютный путь

    function ldir { eza.exe $eza_params --only-dirs $args } # только директории
    function lfile { eza.exe $eza_params --only-files $args } # только файлы

    function lx { eza.exe $eza_params --across $args } # вывод в таблицу не по столбикам, а по строкам
    function lr { eza.exe $eza_params --recurse $args } # рекурсия по директориям

    # Сортировка
    function lsize { eza.exe $eza_params --long --sort=size $args } # по размеру

    function lmod { eza.exe $eza_params --long --time=modified --sort=modified $args } # по дате модификации
    function lacc { eza.exe $eza_params --long --time=accessed --sort=accessed $args } # по дате 
    function lcreate { eza.exe $eza_params --long --time=created --sort=created $args } # по дате создания

    function lt {
        # Дерево с устанавливаемым первым аргументом уровнем рекурсии
        param ( $level = 1 ) # по умолчанию 1
        eza.exe $eza_params --tree --level=$level $args
    }

    function ls1 { eza.exe $eza_params --tree --level=1 $args } # быстрый lt 1
    function ls2 { eza.exe $eza_params --tree --level=2 $args } # быстрый lt 2

    Set-Alias -Name ls -Value ListItems # Замена ls
    Set-Alias -Name tree -Value TreeItems # Замена tree

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

# git
if (Get-Command git.exe -ErrorAction Ignore) {
    Set-Alias -Name g -Value git
    function gst { git.exe status $args }
    function glog { git.exe log --oneline --decorate --graph $args }
}

# ==============================================================


# Поиск
if (Get-Command scoop.ps1 -ErrorAction Ignore) {
    function which ($command) { scoop.ps1 which $command }
}
else {
    function which ($command) { Get-Command $command }
}


# Приложения
# function Open-Obsidian { & 'C:\Users\rbhbk\AppData\Local\Programs\Obsidian\Obsidian.exe' $args }


# Append to Path
#

# # PSReadLine
Set-PSReadLineOption -PredictionSource History

# Complections
(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
(& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression

