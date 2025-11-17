#!/bin/bash
set -e

# Load environment variables
set -a
source .env
set +a

echo "Creating BigsV guitar with detailed specifications..."

surreal import \
  --conn "https://$SURREAL_URL" \
  --user "$SURREAL_USER" \
  --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" \
  --db "$SURREAL_DB" \
  data/bigsv_new_only.surql

echo "✅ BigsV guitar created successfully!"
