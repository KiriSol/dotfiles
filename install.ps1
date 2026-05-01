#!/bin/env pwsh

#Requires -Version 7

$ErrorActionPreference = "Stop"

# Set vars

$Config = ".unix.conf.yaml"
$BaseDir = $PSScriptRoot

if ($IsWindows) {
    $Config = ".windows.conf.yaml"
}

# Run
& dotbot -d "$BaseDir" -c "$Config" $args
