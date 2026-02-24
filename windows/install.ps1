# Set vars
$ErrorActionPreference = "Stop"

$DOTBOT_BIN = Get-Command dotbot
$CONFIG = ".install.conf.yaml"
$BASEDIR = $PSScriptRoot

Set-Location $BASEDIR

# Run
& $DOTBOT_BIN.Source -d "$BASEDIR\.." -c $CONFIG $args

# Apps

