#!/bin/bash
set -e

# Load environment variables
set -a
source .env
set +a

echo "Seeding guitar data from to-import.md (final version)..."

surreal import \
  --conn "https://$SURREAL_URL" \
  --user "$SURREAL_USER" \
  --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" \
  --db "$SURREAL_DB" \
  data/to_import_final.surql

echo "✅ Guitar data seeded successfully!"
