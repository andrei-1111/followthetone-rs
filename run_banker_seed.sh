#!/usr/bin/env bash
set -euo pipefail

if [[ ${1:-} == "" ]]; then
  echo "Usage: $0 path/to/seed.surql" >&2
  exit 1
fi

: "${SURREAL_URL:?SURREAL_URL is required (e.g. https://localhost:8000)}"
: "${SURREAL_NS:?SURREAL_NS is required}"
: "${SURREAL_DB:?SURREAL_DB is required}"
: "${SURREAL_USER:?SURREAL_USER is required}"
: "${SURREAL_PASS:?SURREAL_PASS is required}"

SEED_FILE="$1"

curl -sS -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -u "$SURREAL_USER:$SURREAL_PASS" \
  "$SURREAL_URL/sql" \
  -d @<(jq -Rs --arg ns "$SURREAL_NS" --arg db "$SURREAL_DB" '{ query: ., ns: $ns, db: $db }' "$SEED_FILE")

echo "\nSeed applied: $SEED_FILE"


