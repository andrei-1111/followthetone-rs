#!/bin/bash
set -e

# Load environment variables
set -a
source .env
set +a

echo "Importing detailed specs for Banker 58' Spec V..."

surreal import \
  --conn "https://$SURREAL_URL" \
  --user "$SURREAL_USER" \
  --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" \
  --db "$SURREAL_DB" \
  add_detailed_specs.surql

echo "✅ Detailed specs imported successfully!"

