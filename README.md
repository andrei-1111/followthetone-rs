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

### 🧭 SurrealDB schema workflow (add/verify/export)

1) Make changes live

```surql
-- Add a new field to an existing table
DEFINE FIELD new_field ON guitars TYPE option<string>;

-- Add a new table and its fields
DEFINE TABLE my_table SCHEMAFULL;
DEFINE FIELD name ON my_table TYPE string;

-- Optional index
DEFINE INDEX idx_my_field ON guitars FIELDS new_field;
```

Run via helper script:

```bash
./run_cmd.sh some_change.surql
```

2) Verify the change

```bash
# Full DB + NS info
./run_cmd.sh get_schema.surql               # prints
./run_cmd.sh get_schema.surql --export      # saves to data/schema_info_*.txt

# Or per-table (CLI directly)
surreal sql --conn "$SURREAL_URL" --user "$SURREAL_USER" --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" --db "$SURREAL_DB" --pretty "INFO FOR TABLE guitars;"
```

3) Persist in repo

- Append the same DEFINE statements to `sql_commands/create_current_schema.surql`.
- Optionally add a dated migration file under `sql_commands/` (e.g., `20251015_add_new_field.surql`) and run it with `./run_cmd.sh`.

4) Recreate schema on a fresh DB (idempotent)

```bash
./run_cmd.sh create_current_schema.surql
```

Short reference:

- Export live schema info → `./run_cmd.sh get_schema.surql --export`
- Update live schema → add `DEFINE` statements and `./run_cmd.sh <file>.surql`
- Keep repo schema current → edit `sql_commands/create_current_schema.surql`

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