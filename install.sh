#!/bin/env sh

set -e

# Set vars
CONFIG=".unix.conf.yaml"
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Run
dotbot -d "${BASEDIR}" -c "${CONFIG}" "${@}"
