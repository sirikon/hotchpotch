#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

./meta/pocketbase/install.sh
source ./meta/pocketbase/config.sh
export PATH="$PB_DIR:$PATH"

cd src/server

pocketbase superuser upsert admin@admin.com adminadmin
exec pocketbase --dev serve --http 127.0.0.1:8000
