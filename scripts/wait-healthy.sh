#!/usr/bin/env bash
# wait-healthy.sh — attend qu'un service Compose soit healthy avant de continuer
# Usage: ./scripts/wait-healthy.sh <nom_du_service> [délai_max_en_secondes]
set -euo pipefail

SERVICE="${1:?Usage: $0 <service> [timeout_seconds]}"
TIMEOUT="${2:-120}"
ELAPSED=0
INTERVAL=5

echo "[WAIT] Attente de la santé du service : $SERVICE (timeout: ${TIMEOUT}s)"

until [ "$(docker compose ps "$SERVICE" --format json | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('Health',''))" 2>/dev/null)" = "healthy" ]; do
  if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
    echo "[ÉCHEC] Le service $SERVICE n'est pas healthy après ${TIMEOUT}s" >&2
    exit 1
  fi
  echo "[WAIT] $SERVICE pas encore healthy — attente ${INTERVAL}s... (${ELAPSED}s écoulées)"
  sleep "$INTERVAL"
  ELAPSED=$((ELAPSED + INTERVAL))
done

echo "[OK] Le service $SERVICE est healthy après ${ELAPSED}s"
exit 0
