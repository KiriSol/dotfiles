#!/bin/env nu

def main [...args] {
  # Set vars

  mut config = ".unix.conf.yaml"
  let base_dir = ($env.FILE_PWD | path expand)

  if $nu.os-info.name == "windows" {
    $config = ".windows.conf.yaml"
  }

  # Run
  ^dotbot -d $base_dir -c $config ...$args
}
