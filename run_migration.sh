#!/bin/bash

# Run the slug migration on SurrealDB
# Make sure your SurrealDB is running and accessible

echo "Running migration to add slug field to guitars..."
echo "Connecting to: https://followthetone-surreal.fly.dev"
echo "Namespace: gear"
echo "Database: guitars"
echo ""

# Run the migration using the working format
surreal sql --conn "https://followthetone-surreal.fly.dev" --user root --pass "Password0978" --ns gear --db guitars < migrations/20250114_add_slug_field.up.surql

echo ""
echo "Migration completed!"
