#!/usr/bin/env bash
set -euo pipefail
BACKUP_DIR=${BACKUP_DIR:-/opt/backups}
STACK=${STACK:-peterosea-wp}
DATE=$(date +%Y%m%d-%H%M)
FILE="$BACKUP_DIR/$STACK-$DATE.sql"
mkdir -p "$BACKUP_DIR"

docker exec $(docker compose ps -q db) sh -c "mysqldump -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME" > "$FILE"
ln -sf "$FILE" "$BACKUP_DIR/$STACK-latest.sql"
