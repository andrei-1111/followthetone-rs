# API Testing with cURL

This document provides cURL commands to test all endpoints of the FollowTheTone REST API.

## Prerequisites

- API server running on `http://localhost:8080`
- SurrealDB connected and populated with guitar data

## Health Check

### Test API Health
```bash
curl -X GET http://localhost:8080/health
```

**Expected Response:**
```json
{"ok": true}
```

## Guitar Endpoints

### 1. List All Guitars
```bash
curl -X GET http://localhost:8080/api/guitars
```

**Expected Response:**
```json
[
  {
    "id": "guitars:abc123",
    "brand": "Fender",
    "model": "Stratocaster",
    "body_style": "Solid Body",
    "year_reference": "2020",
    "price_cents": 120000,
    "price_currency": "USD",
    "serial_number": "US123456"
  }
]
```

### 2. Get Guitar by ID (Full Record ID)
```bash
curl -X GET http://localhost:8080/api/guitars/guitars:abc123
```

### 3. Get Guitar by ID (Short ID)
```bash
curl -X GET http://localhost:8080/api/guitars/abc123
```

**Expected Response:**
```json
{
  "id": "guitars:abc123",
  "brand": "Fender",
  "model": "Stratocaster",
  "body_style": "Solid Body",
  "year_reference": "2020",
  "price_cents": 120000,
  "price_currency": "USD",
  "serial_number": "US123456"
}
```

### 4. Delete Guitar by ID (DELETE method)
```bash
curl -X DELETE http://localhost:8080/api/guitars/abc123
```

**Expected Response:**
- Status: `204 No Content` (successful deletion)
- Empty body

### 5. Delete Guitar (POST method - form-friendly)
```bash
curl -X POST http://localhost:8080/api/guitars/abc123/delete
```

**Expected Response:**
- Status: `303 See Other`
- Location header: `/guitars`
- Empty body

## Error Cases

### 1. Guitar Not Found
```bash
curl -X GET http://localhost:8080/api/guitars/nonexistent
```

**Expected Response:**
```json
{
  "error": "not found",
  "id": "guitars:nonexistent"
}
```

### 2. Delete Non-existent Guitar
```bash
curl -X DELETE http://localhost:8080/api/guitars/nonexistent
```

**Expected Response:**
- Status: `204 No Content` (SurrealDB delete is idempotent)

## Testing with Headers

### 1. Include Content-Type
```bash
curl -X GET http://localhost:8080/api/guitars \
  -H "Content-Type: application/json"
```

### 2. Include Accept Header
```bash
curl -X GET http://localhost:8080/api/guitars \
  -H "Accept: application/json"
```

### 3. Verbose Output (for debugging)
```bash
curl -v -X GET http://localhost:8080/api/guitars
```

## Testing CORS

### 1. Preflight Request
```bash
curl -X OPTIONS http://localhost:8080/api/guitars \
  -H "Origin: http://localhost:3000" \
  -H "Access-Control-Request-Method: GET" \
  -H "Access-Control-Request-Headers: Content-Type"
```

### 2. Cross-Origin Request
```bash
curl -X GET http://localhost:8080/api/guitars \
  -H "Origin: http://localhost:3000"
```

## Batch Testing Script

Create a test script `test-api.sh`:

```bash
#!/bin/bash

BASE_URL="http://localhost:8080"

echo "Testing FollowTheTone API..."
echo "================================"

# Health check
echo "1. Health Check:"
curl -s -X GET $BASE_URL/health
echo -e "\n"

# List guitars
echo "2. List Guitars:"
curl -s -X GET $BASE_URL/api/guitars | jq '.[0:2]'  # Show first 2 guitars
echo -e "\n"

# Get specific guitar (replace with actual ID from your DB)
echo "3. Get Guitar by ID:"
curl -s -X GET $BASE_URL/api/guitars/your-guitar-id-here
echo -e "\n"

echo "API testing complete!"
```

Make it executable:
```bash
chmod +x test-api.sh
./test-api.sh
```

## Expected HTTP Status Codes

| Endpoint | Method | Success | Not Found | Error |
|----------|--------|---------|-----------|-------|
| `/health` | GET | 200 | - | 500 |
| `/api/guitars` | GET | 200 | - | 500 |
| `/api/guitars/{id}` | GET | 200 | 404 | 500 |
| `/api/guitars/{id}` | DELETE | 204 | 204* | 500 |
| `/api/guitars/{id}/delete` | POST | 303 | 303* | 500 |

*Delete operations are idempotent - they return success even if the record doesn't exist.

## Troubleshooting

### Connection Refused
```bash
# Check if server is running
curl -v http://localhost:8080/health
# Should show connection refused if server is down
```

### Database Connection Issues
```bash
# Check server logs for SurrealDB connection errors
# Look for: "connect Surreal", "signin", "use ns/db"
```

### CORS Issues
```bash
# Test with explicit origin
curl -X GET http://localhost:8080/api/guitars \
  -H "Origin: http://localhost:3000" \
  -v
```

## Performance Testing

### Load Test (basic)
```bash
# Test with multiple concurrent requests
for i in {1..10}; do
  curl -s -X GET http://localhost:8080/api/guitars &
done
wait
```

### Response Time Testing
```bash
# Measure response time
curl -w "@curl-format.txt" -o /dev/null -s http://localhost:8080/api/guitars
```

Create `curl-format.txt`:
```
     time_namelookup:  %{time_namelookup}\n
        time_connect:  %{time_connect}\n
     time_appconnect:  %{time_appconnect}\n
    time_pretransfer:  %{time_pretransfer}\n
       time_redirect:  %{time_redirect}\n
  time_starttransfer:  %{time_starttransfer}\n
                     ----------\n
          time_total:  %{time_total}\n
```
