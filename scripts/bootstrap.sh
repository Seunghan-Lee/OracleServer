#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR=$(cd "$(dirname "$0")"/.. && pwd)

for dir in oci-os/docker/peterosea-wp oci-os/docker/heworks-blog oci-os/docker/openclaw; do
  if [ -f "$ROOT_DIR/$dir/.env.example" ]; then
    target="$ROOT_DIR/$dir/.env"
    if [ -f "$target" ]; then
      echo "[skip] $target already exists"
    else
      cp "$ROOT_DIR/$dir/.env.example" "$target"
      echo "[new] $target created"
    fi
  fi
done

echo "Edit each .env with secure values."
