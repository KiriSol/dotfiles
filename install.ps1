#!/bin/env pwsh

#Requires -Version 5

$ErrorActionPreference = "Stop"

# Set vars
$CONFIG = ".windows.conf.yaml"
$BASEDIR = $PSScriptRoot

# Run
& dotbot -d "$BASEDIR" -c "$CONFIG" $args
