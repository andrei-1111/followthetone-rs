#!/bin/bash
set -e

# Load environment variables
set -a
source .env
set +a

echo "Importing guitar data from to-import.md..."

surreal import \
  --conn "https://$SURREAL_URL" \
  --user "$SURREAL_USER" \
  --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" \
  --db "$SURREAL_DB" \
  data/import_to_import.surql

echo "✅ Guitar data imported successfully!"
