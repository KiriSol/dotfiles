#!/bin/env pwsh

#Requires -Version 5

$ErrorActionPreference = "Stop"

# Set vars
$DOTBOT_BIN = Get-Command dotbot
$CONFIG = ".windows.conf.yaml"
$BASEDIR = $PSScriptRoot

Set-Location $BASEDIR

# Run
& $DOTBOT_BIN.Source -d "$BASEDIR" -c "$CONFIG" $args
