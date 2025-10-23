#!/bin/bash

# Run comparison feature migration
# This adds the new fields and tables needed for guitar comparison

set -e

echo "🔧 Running guitar comparison migration..."

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

# Run the migration
echo "📝 Running migration: migrations/20250123_add_comparison_fields.surql"
surreal sql --conn "https://$SURREAL_URL" --user "$SURREAL_USER" --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" --db "$SURREAL_DB" \
  < migrations/20250123_add_comparison_fields.surql

if [ $? -eq 0 ]; then
    echo "✅ Migration completed successfully"
else
    echo "❌ Migration failed"
    exit 1
fi

# Seed the normalizations data
echo "📝 Seeding normalizations: data/spec_normalizations_seed.surql"
surreal sql --conn "https://$SURREAL_URL" --user "$SURREAL_USER" --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" --db "$SURREAL_DB" \
  < data/spec_normalizations_seed.surql

if [ $? -eq 0 ]; then
    echo "✅ Normalizations seeded successfully"
else
    echo "❌ Seeding failed"
    exit 1
fi

echo "🎉 Guitar comparison migration completed successfully!"
echo ""
echo "New features added:"
echo "  - production_year field on guitars table"
echo "  - spec_version_year field on guitars table"
echo "  - spec_normalizations table with common mappings"
echo ""
echo "You can now implement the comparison API endpoints."
