#!/bin/bash
set -e

# Load environment variables
set -a
source .env
set +a

echo "Creating BigsV guitar and updating V Custom with detailed specs..."

surreal import \
  --conn "https://$SURREAL_URL" \
  --user "$SURREAL_USER" \
  --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" \
  --db "$SURREAL_DB" \
  data/bigsv_only.surql

echo "✅ Guitar data created successfully!"
