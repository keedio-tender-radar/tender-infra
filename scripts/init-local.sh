#!/usr/bin/env bash
# Levanta el stack local (Postgres+pgvector, Redis, MinIO).
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../docker-compose" && pwd)"
cd "$DIR"

if [ ! -f .env ]; then
  echo "No hay .env; copiando desde .env.example"
  cp .env.example .env
fi

docker compose -f docker-compose.local.yml --env-file .env up -d
echo "Stack arriba. Postgres :5432  Redis :6379  MinIO :9000 (consola :9001)"
