#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/adaura-portal"
BRANCH="work/no-supabase-rebuild"

cd "$APP_DIR"
git fetch --depth=1 origin "$BRANCH"
git reset --hard FETCH_HEAD
npm install --omit=dev
npm test
node --check server/index.js
chown -R root:adaura "$APP_DIR"
chmod -R g+rX,o-rwx "$APP_DIR"
systemctl restart adaura-portal
sleep 2
curl --fail --silent --show-error http://127.0.0.1:3000/api/health
echo
