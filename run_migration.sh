#!/bin/bash

# Run migrations on SurrealDB
# Usage: ./run_migration.sh <migration_file>
# Example: ./run_migration.sh 20250114_add_slug_field.up.surql

# Check if parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <migration_file>"
    echo "Example: $0 20250114_add_slug_field.up.surql"
    echo "Available migrations:"
    ls -1 migrations/*.surql 2>/dev/null || echo "No .surql files found in migrations/"
    exit 1
fi

MIGRATION_FILE="$1"

# Check if file exists
if [ ! -f "migrations/$MIGRATION_FILE" ]; then
    echo "Error: migrations/$MIGRATION_FILE not found"
    echo "Available migrations:"
    ls -1 migrations/*.surql 2>/dev/null || echo "No .surql files found in migrations/"
    exit 1
fi

echo "Running migration: $MIGRATION_FILE"
echo "Connecting to: https://followthetone-surreal.fly.dev"
echo "Namespace: gear"
echo "Database: guitars"
echo ""

# Run the migration using the working format
surreal sql --conn "https://followthetone-surreal.fly.dev" --user root --pass "Password0978" --ns gear --db guitars < "migrations/$MIGRATION_FILE"

echo ""
echo "Migration completed!"
