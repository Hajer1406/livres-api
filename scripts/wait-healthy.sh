#!/usr/bin/env bash
# scripts/wait-healthy.sh — Contrôle de santé du service Staging (Atelier 05 Étape 5)
set -euo pipefail

URL="${1:-http://localhost:8080/health}"
MAX_ATTEMPTS=24
SLEEP_INTERVAL=5

echo "[CHECK] Contrôle de santé du point : $URL"

for i in $(seq 1 "$MAX_ATTEMPTS"); do
  if curl -fsS "$URL" > /dev/null 2>&1; then
    echo "[SUCCÈS] Staging sain : $URL répond avec succès (Code HTTP 200 OK)"
    exit 0
  fi
  echo "[WAIT] Tentative $i/$MAX_ATTEMPTS — en attente de la santé du service (attente ${SLEEP_INTERVAL}s)..."
  sleep "$SLEEP_INTERVAL"
done

echo "[ERREUR] Staging non sain après $((MAX_ATTEMPTS * SLEEP_INTERVAL)) secondes !" >&2
exit 1
