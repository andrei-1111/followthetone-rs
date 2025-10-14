# FollowTheTone - Guitar Database API

A REST API built with **Actix Web** and **SurrealDB** for managing guitar collections.

## 🏗️ Architecture

- **Backend**: Actix Web REST API
- **Database**: SurrealDB over HTTP/HTTPS
- **Routes**: All endpoints under `/api/*`

## 🚀 Quick Start

### Prerequisites

- Rust 1.86+ (tested with 1.86.0)
- SurrealDB instance (remote or local)

### 1. Environment Setup

Create/update `.env` file:

```bash
# SurrealDB Configuration
SURREAL_URL=https://followthetone-surreal.fly.dev
SURREAL_NS=gear
SURREAL_DB=guitars
SURREAL_USER=root
SURREAL_PASS=Password0978

# Server Configuration
HOST=127.0.0.1
PORT=8080

# Logging
RUST_LOG=info,actix_web=info
RUST_BACKTRACE=1
```

### 2. Install Dependencies

```bash
# Build dependencies
cargo build
```

### 3. Run the Application

```bash
cargo run
```

### 4. Access the API

- **API Health**: http://127.0.0.1:8080/health
- **Guitars API**: http://127.0.0.1:8080/api/guitars

## 📁 Project Structure

```
src/
├── main.rs          # Actix server + SurrealDB integration
├── lib.rs           # Re-exports
├── config.rs        # Environment configuration
├── models.rs        # Data models (Guitar, etc.)
└── routes.rs        # API routes (/api/*)

Cargo.toml           # Dependencies
.env                 # Environment variables
```

## 🔧 Development

### API Endpoints

- `GET /health` - Health check
- `GET /api/guitars` - List all guitars
- `GET /api/guitars/{id}` - Get guitar by ID
- `DELETE /api/guitars/{id}` - Delete guitar by ID
- `POST /api/guitars/{id}/delete` - Delete guitar (form-friendly, redirects to /guitars)

### Database Schema

Ensure your SurrealDB has the `guitars` table with schema:

```sql
DEFINE TABLE guitars SCHEMAFULL;

DEFINE FIELD brand ON guitars TYPE string;
DEFINE FIELD model ON guitars TYPE string;
DEFINE FIELD year ON guitars TYPE int;
DEFINE FIELD created_at ON guitars TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON guitars TYPE datetime DEFAULT time::now();

DEFINE EVENT guitars_set_updated_at ON TABLE guitars
WHEN $event = "UPDATE" THEN (
  UPDATE $after SET updated_at = time::now()
);
```

## 🐛 Troubleshooting

### Connection Issues

1. **SurrealDB Connection Failed**
   - Verify `SURREAL_URL` has correct protocol (`https://` or `http://`)
   - Check network connectivity to SurrealDB instance
   - Verify credentials in `.env`

2. **Compilation Errors**
   - Ensure Rust 1.86+ is installed
   - Run `cargo clean && cargo build` to clear cache
   - For connection issues, try `cargo clean && cargo run`

3. **API Not Responding**
   - Check server logs for connection errors
   - Verify SurrealDB credentials and URL

### Common Commands

```bash
# Clean build and run (recommended for issues)
cargo clean && cargo run

# Clean build only
cargo clean

# Check compilation
cargo check

# Run with verbose logging
RUST_LOG=debug cargo run

# Kill existing process
pkill -f gear_api
```

## 📦 Dependencies

Key dependencies in `Cargo.toml`:

- `actix-web = "4"` - Web framework
- `actix-cors = "0.7"` - CORS support
- `surrealdb = { version = "2", features = ["protocol-http"] }` - Database client
- `reqwest = "0.11"` - HTTP client
- `serde = "1"` - Serialization

## 🎯 Next Steps

1. Add more guitar fields (price, condition, etc.)
2. Implement CRUD operations
3. Add search and filtering
4. Deploy to production
5. Add authentication

---

**Happy coding! 🎸**