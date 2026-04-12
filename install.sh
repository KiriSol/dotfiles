#!/bin/env sh

set -e

# Check dotbot binary
if command -v dotbot >/dev/null 2>&1; then
  DOTBOT_BIN="dotbot"
else
  echo "dotbot not found"
  exit 1
fi

CONFIG=".unix.conf.yaml"

BASEDIR="$(cd "$(dirname "$0")" && pwd)"
cd "${BASEDIR}"

# Run
"${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
