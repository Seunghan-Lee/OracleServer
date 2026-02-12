#!/usr/bin/env bash
set -euo pipefail
STACK=${1:-peterosea-wp}
REMOTE_USER=${REMOTE_USER:-ubuntu}
REMOTE_HOST=${REMOTE_HOST:-prod-web-01}
REMOTE_PATH=${REMOTE_PATH:-/opt/stacks/$STACK}

ssh "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_PATH && docker compose pull && docker compose up -d"
