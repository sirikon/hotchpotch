PB_VERSION="$(cat .pb-version)"
PB_BIN=".tmp/pocketbase/${PB_VERSION}/pocketbase"
PB_DIR="$(realpath -m "$(dirname "$PB_BIN")")"
return 0
