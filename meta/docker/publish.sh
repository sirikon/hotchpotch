#!/usr/bin/env bash
set -euo pipefail

HP_VERSION="$(date -u '+%Y%m%d_%H%M%S')"
export HP_TAG="ghcr.io/sirikon/hotchpotch:${HP_VERSION}"
./meta/docker/build.sh
docker push "$HP_TAG"
