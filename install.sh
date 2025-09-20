#!/bin/env sh

set -e

# Check dotbot binary
if command -v dotbot >/dev/null; then
    DOTBOT_BIN="dotbot"
else
    echo "dotbot not found"
    return 1
fi

CONFIG=".install.conf.yaml"

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${BASEDIR}"

# Run
"${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

# Termux
if [ -n "$TERMUX_VERSION" ]; then
    cp termux/shortcuts ~/.shortcuts -rf --no-target-directory
    cp termux/termux/boot ~/.termux/boot -rf --no-target-directory
    ln -s "$SHELL" ~/.termux/shell -f
fi
