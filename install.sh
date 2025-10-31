#!/bin/env sh

set -e

# Check dotbot binary
if command -v dotbot >/dev/null; then
    DOTBOT_BIN="dotbot"
else
    echo "dotbot not found"
    exit 1
fi

CONFIG=".install.conf.yaml"

BASEDIR="$(cd "$(dirname "$0")" && pwd)"
cd "${BASEDIR}"

# Run
"${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

# Termux
if [ -n "$TERMUX_VERSION" ]; then
    rm -rf ~/.shortcuts ~/.termux/boot
    cp termux/shortcuts ~/.shortcuts -r
    cp termux/termux/boot ~/.termux/boot -r
    ln -s "$SHELL" ~/.termux/shell -f
fi
