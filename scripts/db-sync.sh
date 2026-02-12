#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <push|pull> <stack>"
  exit 1
fi

ACTION=$1
STACK=$2
REMOTE_USER=${REMOTE_USER:-ubuntu}
REMOTE_HOST=${REMOTE_HOST:-prod-web-01}
REMOTE_DB_DIR=${REMOTE_DB_DIR:-/opt/backups}
LOCAL_DB_DIR=${LOCAL_DB_DIR:-backups}
FILENAME="$STACK-$(date +%Y%m%d).sql"

mkdir -p "$LOCAL_DB_DIR"

if [ "$ACTION" = "pull" ]; then
  scp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DB_DIR/$STACK-latest.sql" "$LOCAL_DB_DIR/$FILENAME"
  echo "Database saved to $LOCAL_DB_DIR/$FILENAME"
elif [ "$ACTION" = "push" ]; then
  scp "$LOCAL_DB_DIR/$FILENAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DB_DIR/$FILENAME"
else
  echo "Unknown action $ACTION"
  exit 1
fi
