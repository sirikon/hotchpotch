#!/usr/bin/env bash
set -euo pipefail

export HP_VERSION="dev"
export HP_TAG="hotchpotch:${HP_VERSION}"
./meta/docker/build.sh
exec docker run -it --rm -p 127.0.0.1:8000:80 -v ./src/server/pb_data:/data "$HP_TAG"
