#!/usr/bin/env bash
set -euo pipefail

if ! test -d src/server/pb_data; then
    ./meta/setup.sh
fi

export DEV_PROXY_PORT=8000
export SERVER_PORT=8001
export UI_PORT=8002

function main() {
    trap 'true' SIGINT SIGTERM

    log "Open: http://127.0.0.1:${DEV_PROXY_PORT}"

    start-dev-proxy &
    start-server &
    start-ui &

    wait -n || true
    kill -s SIGINT -$$
    wait
}

function start-dev-proxy() {
    log "Starting Dev Proxy"
    cd "src/dev_proxy"
    exec node main.mjs
}

function start-server() {
    log "Starting Server"
    source ./meta/on_server.sh
    exec pocketbase --dev serve --http 127.0.0.1:8001
}

function start-ui() {
    log "Starting UI"
    cd "src/ui"
    exec node builder.mjs serve
}

function log() {
    printf "### [start.sh] %s\n" "$@"
}

main "$@"
