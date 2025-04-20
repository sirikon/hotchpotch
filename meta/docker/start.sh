#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

./meta/setup.sh
export HP_TAG="hotchpotch:dev"
./meta/docker/build.sh
docker run -it --rm -p 127.0.0.1:8000:80 -v ./src/server/pb_data:/data "$HP_TAG"
