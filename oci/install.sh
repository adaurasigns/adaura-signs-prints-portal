#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/adaura-portal"
DATA_DIR="/var/lib/adaura"

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  nodejs nginx sqlite3 build-essential python3 ufw \
  certbot python3-certbot-nginx unattended-upgrades

id adaura >/dev/null 2>&1 || useradd --system --home-dir "$DATA_DIR" --no-create-home --shell /usr/sbin/nologin adaura
mkdir -p "$DATA_DIR/uploads" /var/backups/adaura
chown -R adaura:adaura "$DATA_DIR"
chmod 750 "$DATA_DIR" "$DATA_DIR/uploads"
chmod 700 /var/backups/adaura

cd "$APP_DIR"
npm install --omit=dev
npm test
node --check server/index.js
chown -R root:adaura "$APP_DIR"
chmod -R g+rX,o-rwx "$APP_DIR"

if [ ! -f /etc/adaura-portal.env ]; then
  cat > /etc/adaura-portal.env <<EOF
NODE_ENV=production
PORT=3000
DATA_DIR=$DATA_DIR
SESSION_SECRET=$(openssl rand -hex 32)
ADMIN_NAME=AdAura Administrator
ADMIN_EMAIL=
ADMIN_PASSWORD=
EOF
  chmod 600 /etc/adaura-portal.env
  chown root:root /etc/adaura-portal.env
fi

install -m 644 "$APP_DIR/oci/adaura-portal.service" /etc/systemd/system/adaura-portal.service
install -m 644 "$APP_DIR/oci/nginx-site.conf" /etc/nginx/sites-available/adaura-portal
rm -f /etc/nginx/sites-enabled/default
ln -sfn /etc/nginx/sites-available/adaura-portal /etc/nginx/sites-enabled/adaura-portal
nginx -t

install -m 755 "$APP_DIR/oci/backup.sh" /usr/local/sbin/adaura-backup
install -m 755 "$APP_DIR/oci/update.sh" /usr/local/sbin/adaura-update
cat > /etc/cron.d/adaura-backup <<'EOF'
15 2 * * * root /usr/local/sbin/adaura-backup >> /var/log/adaura-backup.log 2>&1
EOF
chmod 644 /etc/cron.d/adaura-backup

ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

systemctl daemon-reload
systemctl enable --now nginx
systemctl enable --now adaura-portal
systemctl enable --now unattended-upgrades

for attempt in $(seq 1 30); do
  if curl --fail --silent http://127.0.0.1:3000/api/health >/dev/null; then
    break
  fi
  sleep 2
done
curl --fail --silent --show-error http://127.0.0.1:3000/api/health
echo
