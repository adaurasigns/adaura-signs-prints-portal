#!/usr/bin/env bash
set -euo pipefail

DATA_DIR="/var/lib/adaura"
BACKUP_DIR="/var/backups/adaura"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

test -f "$DATA_DIR/adaura.sqlite" || { echo "AdAura database not found"; exit 1; }
mkdir -p "$BACKUP_DIR"
sqlite3 "$DATA_DIR/adaura.sqlite" ".backup '$TMP_DIR/adaura.sqlite'"
if [ -d "$DATA_DIR/uploads" ]; then
  cp -a "$DATA_DIR/uploads" "$TMP_DIR/uploads"
else
  mkdir -p "$TMP_DIR/uploads"
fi
tar -czf "$BACKUP_DIR/adaura-$STAMP.tar.gz" -C "$TMP_DIR" adaura.sqlite uploads
find "$BACKUP_DIR" -type f -name 'adaura-*.tar.gz' -mtime +14 -delete
echo "Created $BACKUP_DIR/adaura-$STAMP.tar.gz"
