#!/usr/bin/env bash

set -e

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

BACKUP_DIR="/opt/backup"
ENV_FILE="/opt/virtd-practice-5/.env"
NETWORK="virtd-practice-5_backend"
MYSQL_HOST="db"

mkdir -p "$BACKUP_DIR"

set -a
. "$ENV_FILE"
set +a

docker run --rm \
  --user "$(id -u):$(id -g)" \
  --network "$NETWORK" \
  -e MYSQL_HOST="$MYSQL_HOST" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -v "$BACKUP_DIR:/backup" \
  --entrypoint sh \
  mysql:8 \
  -c 'mysqldump --opt --no-tablespaces -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" > "/backup/${MYSQL_DATABASE}_$(date +%Y%m%d_%H%M%S).sql"'
