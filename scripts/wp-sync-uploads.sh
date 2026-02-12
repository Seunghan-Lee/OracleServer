#!/usr/bin/env bash
set -euo pipefail
STACK=${1:-peterosea-wp}
REMOTE_USER=${REMOTE_USER:-ubuntu}
REMOTE_HOST=${REMOTE_HOST:-prod-web-01}
REMOTE_UPLOAD_DIR=${REMOTE_UPLOAD_DIR:-/opt/stacks/$STACK/wp-content/uploads}
LOCAL_UPLOAD_DIR=${LOCAL_UPLOAD_DIR:-sites/$STACK/wp-content/uploads}

mkdir -p "$LOCAL_UPLOAD_DIR"
rsync -avz --delete "$REMOTE_USER@$REMOTE_HOST:$REMOTE_UPLOAD_DIR/" "$LOCAL_UPLOAD_DIR/"
