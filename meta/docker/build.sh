#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

docker build --file ./meta/docker/_/Dockerfile --tag "${HP_TAG:-hotchpotch:dev}" .
