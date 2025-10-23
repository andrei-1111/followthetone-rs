#!/bin/bash

# Run basic schema migration - only add new fields
set -e

echo "🔧 Running basic schema migration..."

# Load environment variables
if [ -f .env ]; then
    set -a; source .env; set +a
    echo "✅ Loaded environment variables"
else
    echo "❌ No .env file found"
    exit 1
fi

# Check required environment variables
if [ -z "$SURREAL_URL" ] || [ -z "$SURREAL_USER" ] || [ -z "$SURREAL_PASS" ] || [ -z "$SURREAL_NS" ] || [ -z "$SURREAL_DB" ]; then
    echo "❌ Missing required environment variables"
    echo "Required: SURREAL_URL, SURREAL_USER, SURREAL_PASS, SURREAL_NS, SURREAL_DB"
    exit 1
fi

echo "🔍 SurrealDB URL: $SURREAL_URL"
echo "🔍 Namespace: $SURREAL_NS"
echo "🔍 Database: $SURREAL_DB"

# Run the basic migration
echo "📝 Running migration: migrations/20250123_add_basic_fields.surql"
surreal sql --conn "https://$SURREAL_URL" --user "$SURREAL_USER" --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" --db "$SURREAL_DB" \
  < migrations/20250123_add_basic_fields.surql

if [ $? -eq 0 ]; then
    echo "✅ Basic migration completed successfully"
    echo ""
    echo "Added fields:"
    echo "  - production_year (optional number)"
    echo "  - spec_version_year (optional number)"
else
    echo "❌ Migration failed"
    exit 1
fi

echo "🎉 Basic schema migration completed!"
