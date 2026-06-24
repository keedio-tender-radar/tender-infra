#!/usr/bin/env bash
# Carga datos de demo en la BD vía la API (cuando tender-api exponga un endpoint de seed o /api/tenders).
# Placeholder hasta que tender-api tenga el endpoint de ingesta/seed.
set -euo pipefail

API_URL="${API_URL:-http://localhost:8000}"
echo "Sembrando datos de demo contra $API_URL ..."
echo "TODO: implementar cuando tender-api exponga POST /api/tenders o un endpoint /seed."
