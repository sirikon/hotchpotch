#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

NODE_VERSION="$(grep nodejs <.tool-versions | cut -d ' ' -f 2)"
HP_VERSION="${HP_VERSION:-"dev"}"
HP_TAG="${HP_TAG:-"hotchpotch:${HP_VERSION}"}"

exec docker build \
    --file ./meta/docker/_/Dockerfile \
    --build-arg HP_VERSION="$HP_VERSION" \
    --build-arg NODE_VERSION="$NODE_VERSION" \
    --tag "${HP_TAG:-hotchpotch:dev}" \
    .
