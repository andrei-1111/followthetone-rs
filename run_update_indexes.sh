#!/bin/bash

# Load environment variables
set -a; source .env; set +a

echo "🔧 Updating guitar indexes to allow same brand/model with different listing URLs..."

echo "🔍 SurrealDB URL: $SURREAL_URL"
echo "🔍 Namespace: $SURREAL_NS"
echo "🔍 Database: $SURREAL_DB"

# Run the migration
echo "📝 Running migration: migrations/20250125_update_guitar_indexes.surql"
surreal sql --conn "https://$SURREAL_URL" --user "$SURREAL_USER" --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" --db "$SURREAL_DB" \
  < migrations/20250125_update_guitar_indexes.surql

if [ $? -eq 0 ]; then
    echo "✅ Guitar index update completed successfully"
    echo ""
    echo "Updated indexes:"
    echo "  - Dropped: idx_guitars_brand_model (prevented duplicate brand/model)"
    echo "  - Added: idx_guitars_brand_model_listing (allows same brand/model with different listing URLs)"
    echo "🎉 Guitar index update completed!"
    echo ""
    echo "Now you can import guitars with same brand/model as long as they have different listing URLs!"
else
    echo "❌ Guitar index update failed"
    exit 1
fi
