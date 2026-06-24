# tender-infra

> 🏗️ Infraestructura de **Keedio Tender Radar**. Para el MVP: Docker Compose con las
> dependencias de datos. Más adelante: Kubernetes, Helm y Terraform.

## Stack local (MVP)

`docker-compose/docker-compose.local.yml` levanta:

| Servicio | Imagen | Puerto | Uso |
|----------|--------|--------|-----|
| PostgreSQL + pgvector | `pgvector/pgvector:pg16` | 5432 | Datos + embeddings (RAG) |
| Redis | `redis:7-alpine` | 6379 | Colas/caché ligera |
| MinIO | `minio/minio` | 9000 (consola 9001) | Documentos (S3-compatible) |

## Uso

```bash
cd docker-compose
cp .env.example .env        # ajusta credenciales
docker compose -f docker-compose.local.yml --env-file .env up -d
```

O con el script:

```bash
bash scripts/init-local.sh        # levanta el stack (crea .env si falta)
bash scripts/migrate-db.sh        # aplica migraciones de tender-api (repo hermano)
bash scripts/seed-demo-data.sh    # datos de demo (placeholder)
```

## Conexión

```
DATABASE_URL=postgresql+psycopg://tender:tender@localhost:5432/tender
REDIS_URL=redis://localhost:6379/0
MinIO endpoint=http://localhost:9000  (user/pass del .env)
```

## Estructura

```
docker-compose/   stack local + .env.example
scripts/          init-local · migrate-db · seed-demo-data
k8s/              manifests (fases posteriores)
```

> Decisiones: PostgreSQL+pgvector como almacén principal (ADR 002), documentos en MinIO/S3.
> Ver `tender-platform-docs`. Secretos nunca en git: usa `.env` (gitignored) o el gestor de
> secretos del entorno.
