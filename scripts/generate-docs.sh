#!/bin/bash

# Generate static API documentation
echo "🔧 Generating API documentation..."

# Create scripts directory if it doesn't exist
mkdir -p scripts

# Run the documentation generator
cargo run --bin doc-generator

echo "✅ Documentation generation complete!"
echo ""
echo "📁 Files created:"
echo "  - docs/api-documentation.json (static OpenAPI spec)"
echo ""
echo "🌐 Access points:"
echo "  - Swagger UI: http://localhost:8080/swagger-ui/"
echo "  - OpenAPI JSON: http://localhost:8080/api-docs/openapi.json"
echo "  - Schema JSON: http://localhost:8080/api-docs/schema.json"
echo ""
echo "💡 Frontend developers can use the JSON files to generate TypeScript types:"
echo "  npx openapi-typescript http://localhost:8080/api-docs/openapi.json -o types/api.ts"
