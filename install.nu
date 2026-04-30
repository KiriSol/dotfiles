#!/bin/env nu

def main [...args] {
  # Set vars
  let config = ".unix.conf.yaml"
  let base_dir = ($env.FILE_PWD | path expand)

  # Run
  ^dotbot -d $base_dir -c $config ...$args
}
