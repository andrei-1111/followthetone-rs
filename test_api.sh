#!/bin/bash

# Test script for gear_api
# Make sure the server is running on localhost:8080

echo "Testing gear_api endpoints..."
echo "=============================="

# Test health endpoint
echo -e "\n1. Testing /health endpoint:"
curl -s http://localhost:8080/health
echo -e "\n"

# Test root endpoint
echo -e "\n2. Testing root endpoint:"
curl -s http://localhost:8080/ | jq .
echo -e "\n"

# Test brands endpoint
echo -e "\n3. Testing /brands endpoint:"
curl -s http://localhost:8080/brands | jq .
echo -e "\n"

# Test gear endpoint with no filters
echo -e "\n4. Testing /gear endpoint (no filters):"
curl -s "http://localhost:8080/gear" | jq .
echo -e "\n"

# Test gear endpoint with filters
echo -e "\n5. Testing /gear endpoint (with filters):"
curl -s "http://localhost:8080/gear?gear_type=guitar&brand=Fender&q=strat" | jq .
echo -e "\n"

# Test specific gear by slug
echo -e "\n6. Testing /gear/{slug} endpoint:"
curl -s http://localhost:8080/gear/fender-stratocaster | jq .
echo -e "\n"

echo "=============================="
echo "API testing completed!"
