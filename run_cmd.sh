#!/bin/bash

# Run SQL commands on SurrealDB
# Usage: ./run_cmd.sh <sql_file> [--export]
# Example: ./run_cmd.sh select_all_guitars.surql
# Example: ./run_cmd.sh get_schema.surql --export

# Check if parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <sql_file> [--export]"
    echo "Example: $0 select_all_guitars.surql"
    echo "Example: $0 get_schema.surql --export"
    echo "Available files:"
    ls -1 sql_commands/*.surql 2>/dev/null || echo "No .surql files found in sql_commands/"
    exit 1
fi

SQL_FILE="$1"
EXPORT_FLAG="$2"

# Check if file exists
if [ ! -f "sql_commands/$SQL_FILE" ]; then
    echo "Error: sql_commands/$SQL_FILE not found"
    echo "Available files:"
    ls -1 sql_commands/*.surql 2>/dev/null || echo "No .surql files found in sql_commands/"
    exit 1
fi

echo "Running SQL command: $SQL_FILE"
if [ "$EXPORT_FLAG" = "--export" ]; then
    echo "Output will be exported to data folder"
fi
echo ""

# Create data directory if it doesn't exist
mkdir -p data

# Run the SQL command
if [ "$EXPORT_FLAG" = "--export" ]; then
    # Export output to data folder
    OUTPUT_FILE="data/$(basename "$SQL_FILE" .surql)_export_$(date +%Y%m%d_%H%M%S).txt"
    echo "Exporting to: $OUTPUT_FILE"
    surreal sql --conn "https://followthetone-surreal.fly.dev" --user root --pass "Password0978" --ns gear --db guitars < "sql_commands/$SQL_FILE" > "$OUTPUT_FILE" 2>&1
    echo "Output saved to: $OUTPUT_FILE"
else
    # Display output to console
    surreal sql --conn "https://followthetone-surreal.fly.dev" --user root --pass "Password0978" --ns gear --db guitars < "sql_commands/$SQL_FILE"
fi

echo ""
echo "Command completed!"
