#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/bkotyrev/netology-devops.git"
SOURCE_DIR="05-virt-04-docker-in-practice"
DEPLOY_DIR="/opt/virtd-practice-5"
CLONE_DIR="/tmp/virtd-practice-5-git"
ENV_FILE="/opt/virtd-practice-5.env"

echo "Stop old docker compose project"
cd "$DEPLOY_DIR" 2>/dev/null && docker compose down --remove-orphans || true
cd /

echo "Remove old deploy directory"
sudo rm -rf "$DEPLOY_DIR"
rm -rf "$CLONE_DIR"

echo "Create deploy directory"
sudo mkdir -p "$DEPLOY_DIR"
sudo chown "$USER:$USER" "$DEPLOY_DIR"

echo "Clone repository"
git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

echo "Copy project files"
cp -a "$CLONE_DIR/$SOURCE_DIR/." "$DEPLOY_DIR/"
rm -rf "$DEPLOY_DIR"/task-*
rm -rf "$CLONE_DIR"

echo "Copy .env into project root"
cp "$ENV_FILE" "$DEPLOY_DIR/.env"

echo "Start docker compose"
cd "$DEPLOY_DIR"
docker compose up -d --build

echo "Show containers"
docker compose ps

echo "Wait web app"
sleep 5

echo "Check proxy port"
curl -fsS http://127.0.0.1:8090
echo

echo "Check direct app port"
curl -sS --max-time 5 http://127.0.0.1:5000 || true
