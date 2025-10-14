#!/bin/bash

# Run SQL commands on SurrealDB
# Usage: ./run_cmd.sh <sql_file>
# Example: ./run_cmd.sh select_all_guitars.surql

# Check if parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <sql_file>"
    echo "Example: $0 select_all_guitars.surql"
    echo "Available files:"
    ls -1 sql_commands/*.surql 2>/dev/null || echo "No .surql files found in sql_commands/"
    exit 1
fi

SQL_FILE="$1"

# Check if file exists
if [ ! -f "sql_commands/$SQL_FILE" ]; then
    echo "Error: sql_commands/$SQL_FILE not found"
    echo "Available files:"
    ls -1 sql_commands/*.surql 2>/dev/null || echo "No .surql files found in sql_commands/"
    exit 1
fi

echo "Running SQL command: $SQL_FILE"
echo ""

# Run the SQL command using the working format
surreal sql --conn "https://followthetone-surreal.fly.dev" --user root --pass "Password0978" --ns gear --db guitars < "sql_commands/$SQL_FILE"

echo ""
echo "Command completed!"
