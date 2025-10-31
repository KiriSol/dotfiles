$ErrorActionPreference = "Stop"

# Check dotbot binary
$DOTBOT_BIN = Get-Command dotbot -ErrorAction SilentlyContinue
if (-not $DOTBOT_BIN) {
    Write-Error "dotbot not found"
    exit 1
}

$CONFIG = ".install.conf.yaml"

$BASEDIR = $PSScriptRoot
if (-not $BASEDIR) {
    $BASEDIR = Split-Path -Parent $MyInvocation.MyCommand.Path
}

Set-Location $BASEDIR

# Run
& $DOTBOT_BIN.Source -d "$BASEDIR\.." -c $CONFIG $args

if ((Get-Content "$BASEDIR\apps\Microsoft.WindowsTerminal.Preview\settings.json").Count -gt (Get-Content "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json").Count) {
    Copy-Item "$BASEDIR\apps\Microsoft.WindowsTerminal.Preview\settings.json" "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
}
