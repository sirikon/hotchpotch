#!/usr/bin/env bash
set -euo pipefail

if ! test -d src/server/pb_data; then
    ./meta/setup.sh
fi

source ./meta/on_server.sh
exec pocketbase --dev serve --http 127.0.0.1:8000
