#!/usr/bin/env bash
# Aplica las migraciones de tender-api contra la BD local.
# Requiere el repo tender-api como hermano de tender-infra.
set -euo pipefail

API_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../tender-api" && pwd)"
cd "$API_DIR"

if [ -d .venv ]; then
  # shellcheck disable=SC1091
  source .venv/Scripts/activate 2>/dev/null || source .venv/bin/activate
fi

alembic upgrade head
echo "Migraciones aplicadas."
