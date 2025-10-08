# FollowTheTone - Guitar Database

A full-stack Rust application with **Leptos (SSR + hydration)** frontend, **Actix Web** backend, and **SurrealDB** database.

## 🏗️ Architecture

- **Frontend**: Leptos with SSR + client-side hydration
- **Backend**: Actix Web serving both API and Leptos SSR
- **Database**: SurrealDB over HTTP/HTTPS
- **Routes**:
  - `/` - Leptos frontend (Home, /guitars, /guitars/:id)
  - `/api/*` - REST API endpoints

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
# Install cargo-leptos (optional, for development)
cargo install cargo-leptos

# Build dependencies
cargo build
```

### 3. Run the Application

#### Option A: Standard Cargo Run
```bash
cargo run
```

#### Option B: Leptos Development Mode (if cargo-leptos installed)
```bash
cargo leptos watch
```

### 4. Access the Application

- **Frontend**: http://127.0.0.1:8080
- **API Health**: http://127.0.0.1:8080/health
- **Guitars API**: http://127.0.0.1:8080/api/guitars

## 📁 Project Structure

```
src/
├── main.rs          # Actix server + Leptos integration
├── lib.rs           # Re-exports
├── app.rs           # Leptos App component & routes
├── config.rs        # Environment configuration
├── models.rs        # Data models (Guitar, etc.)
└── routes.rs        # API routes (/api/*)

leptos.toml          # Leptos configuration
Cargo.toml           # Dependencies
.env                 # Environment variables
```

## 🔧 Development

### API Endpoints

- `GET /health` - Health check
- `GET /api/guitars` - List all guitars
- `GET /api/guitars/{id}` - Get guitar by ID

### Frontend Routes

- `/` - Home page
- `/guitars` - Guitar listing
- `/guitars/:id` - Guitar details

### Hot Reload

If using `cargo leptos watch`:
- Frontend changes auto-reload
- Backend changes require restart

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

3. **Leptos Not Loading**
   - Check browser console for errors
   - Verify static files are served at `/pkg` and `/assets`

### Common Commands

```bash
# Clean build
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
- `actix-files = "0.6"` - Static file serving
- `leptos = "0.6"` - Frontend framework
- `leptos_actix = "0.6"` - Actix integration
- `surrealdb = { version = "2", default-features = false, features = ["protocol-http"] }`

## 🎯 Next Steps

1. Add more guitar fields (price, condition, etc.)
2. Implement CRUD operations
3. Add search and filtering
4. Deploy to production
5. Add authentication

---

**Happy coding! 🎸**