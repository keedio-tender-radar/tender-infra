#!/usr/bin/env bash
# Backup de la base de datos de Keedio Tender Radar (InsForge OSS).
#
# Exporta esquema + datos a tender-infra/backups/ con marca de tiempo, vía el CLI de InsForge
# (no requiere pg_dump). El directorio backups/ está gitignored (no se suben datos al repo).
#
# Uso:   bash tender-infra/scripts/backup-db.sh
# Cron:  programar diariamente en una máquina del operador (Task Scheduler / cron) y, opcional,
#        sincronizar la carpeta a almacenamiento externo (S3/OneDrive/etc.).
#
# Restaurar:  npx @insforge/cli db import tender-infra/backups/<fichero>.sql   (¡sobrescribe!)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DEST="$ROOT/tender-infra/backups"
mkdir -p "$DEST"

TS="$(date -u +%Y%m%d-%H%M%S)"
OUT="$DEST/tender-db-$TS.sql"

echo "Exportando BD → $OUT"
npx --yes @insforge/cli@latest db export \
  --format sql \
  --include-sequences \
  --include-functions \
  -o "$OUT"

# Rotación: conserva los últimos 30 backups.
ls -1t "$DEST"/tender-db-*.sql 2>/dev/null | tail -n +31 | xargs -r rm -f

echo "OK. Backups actuales:"
ls -1t "$DEST"/tender-db-*.sql 2>/dev/null | head -5
