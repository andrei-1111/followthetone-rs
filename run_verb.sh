#!/usr/bin/env bash
set -euo pipefail
: "${REVERB_TOKEN:?Set REVERB_TOKEN to your PRODUCTION token}"

QUERY="${1:-Gibson Flying V}"
PER_PAGE="${PER_PAGE:-25}"
BASE="https://api.reverb.com"
URL="$BASE/api/listings?per_page=$PER_PAGE&query=$(jq -rn --arg q "$QUERY" '$q|@uri')"

HEADERS=(
  -H "Authorization: Bearer $REVERB_TOKEN"
  -H "Accept: application/hal+json"
  -H "Accept-Version: 3.0"
  -H "Content-Type: application/hal+json"
  -H "User-Agent: followthetone-reverb-dump/0.1"
)

get() { curl -sS "$1" "${HEADERS[@]}"; }

PAGE=1
while [[ -n "${URL:-}" ]]; do
  echo "=== PAGE $PAGE: $URL ==="
  RESP="$(get "$URL")"

  # Dump the WHOLE page (every field)
  echo "$RESP" | jq -S .

  # If listings exist, fetch each listing's FULL doc and dump it, too
  echo "$RESP" | jq -r '.listings[]?._links.self.href' | while read -r href; do
    [[ -z "$href" ]] && continue
    [[ "$href" == /* ]] && href="$BASE$href"
    echo "----- FULL LISTING DOC: $href -----"
    get "$href" | jq -S .
    sleep 0.2
  done

  NEXT="$(echo "$RESP" | jq -r '._links.next.href // empty')"
  [[ -n "$NEXT" ]] && URL="$([[ "$NEXT" == /* ]] && echo "$BASE$NEXT" || echo "$NEXT")" || URL=""
  PAGE=$((PAGE+1))
  sleep 0.2
done
