#!/bin/env sh

set -e

# Set vars
config=".unix.conf.yaml"
base_dir="$(cd -- "$(dirname -- "$0")" && pwd)"

# Run
dotbot -d "${base_dir}" -c "${config}" "${@}"
