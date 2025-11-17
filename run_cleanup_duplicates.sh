#!/bin/bash
set -e

# Load environment variables
set -a
source .env
set +a

echo "Cleaning up duplicate records for V Custom guitar..."

surreal import \
  --conn "https://$SURREAL_URL" \
  --user "$SURREAL_USER" \
  --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" \
  --db "$SURREAL_DB" \
  data/cleanup_duplicates.surql

echo "✅ Duplicate records cleaned up successfully!"
