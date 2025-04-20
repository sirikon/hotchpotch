#!/usr/bin/env bash
set -euo pipefail

source ./meta/pocketbase/config.sh

if test -f "$PB_BIN"; then
    exit 0
fi

pb_os=""
pb_arch=""

os="$(uname)"
arch="$(uname -m)"

if [ "$os" == "Linux" ]; then
    pb_os="linux"
    if [ "$arch" == "x86_64" ]; then
        pb_arch="amd64"
    else
        echo "Unexpected Linux arch: $arch"
        exit 1
    fi
elif [ "$os" == "Darwin" ]; then
    pb_os="darwin"
    if [ "$arch" == "x86_64" ]; then
        pb_arch="amd64"
    else
        echo "Unexpected Mac arch: $arch"
        exit 1
    fi
else
    echo "Unexpected OS: $os"
    exit 1
fi

pb_url="https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_${pb_os}_${pb_arch}.zip"

rm -rf "$PB_DIR"
curl -L --create-dirs --output "${PB_DIR}/pocketbase.zip" "$pb_url"
cd "${PB_DIR}"
unzip pocketbase.zip
