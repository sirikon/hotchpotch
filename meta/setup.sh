#!/usr/bin/env bash
set -euo pipefail

source ./meta/on_server.sh
pocketbase superuser upsert admin@admin.com adminadmin
