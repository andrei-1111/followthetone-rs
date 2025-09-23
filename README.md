# Gear API - Guitar & Effects Catalog

A production-ready REST API built with Rust, Actix Web, and SQLx for managing guitar gear and effects.

## Features

- **RESTful API** with Actix Web
- **Database migrations** with SQLx
- **PostgreSQL** backend
- **Docker** support
- **Production deployment** ready (Fly.io, Railway)
- **Comprehensive testing** suite

## Quick Start

### Prerequisites

- Rust 1.89+ (run `rustup update` if needed)
- PostgreSQL 12+
- SQLx CLI (`cargo install sqlx-cli`)

### 1) Database Setup

```bash
# Create the database
sqlx database create

# Run migrations
sqlx migrate run

# Verify tables were created
sqlx database drop  # Optional: start fresh
sqlx database create
sqlx migrate run
```

### 2) Environment Configuration

```bash
# Copy environment template
cp .env.example .env

# Edit with your database credentials
# DATABASE_URL=postgres://username:password@localhost:5432/gear_db
```

### 3) Run the API

```bash
# Development mode
cargo run

# Production build
cargo build --release
./target/release/gear_api
```

### 4) Test the API

```bash
# Health check
curl http://localhost:8080/health

# List brands
curl http://localhost:8080/brands

# Search gear
curl "http://localhost:8080/gear?gear_type=guitar&brand=Fender"

# Get specific gear
curl http://localhost:8080/gear/fender-stratocaster
```

## SQLx Migrations

This project uses SQLx migrations for database schema management.

### Migration Commands

```bash
# Create a new migration
sqlx migrate add migration_name

# Run all pending migrations
sqlx migrate run

# Revert the last migration
sqlx migrate revert

# Check migration status
sqlx migrate info
```

### Migration Files

Migrations are stored in `migrations/` directory:
- `001_initial_schema.sql` - Initial database structure
- `002_add_artists.sql` - Add artists table
- `003_add_indexes.sql` - Performance optimizations

### Adding New Migrations

```bash
# Example: Add a new table
sqlx migrate add add_gear_images

# Edit the generated file in migrations/
# Add your SQL changes
# Run the migration
sqlx migrate run
```

## API Endpoints

### Core Endpoints

- `GET /health` - Health check
- `GET /` - API info
- `GET /brands` - List all brands
- `GET /gear` - Search gear with filters
- `GET /gear/{slug}` - Get specific gear by slug
- `POST /gear` - Create new gear item

### Query Parameters

**GET /gear** supports:
- `q` - Search term (searches gear names)
- `gear_type` - Filter by type (guitar, effect, amplifier, accessory)
- `brand` - Filter by brand name
- `page` - Page number (default: 1)
- `page_size` - Items per page (default: 20, max: 200)

### Example Requests

```bash
# Search for Fender guitars
curl "http://localhost:8080/gear?gear_type=guitar&brand=Fender"

# Search for distortion effects
curl "http://localhost:8080/gear?gear_type=effect&q=distortion"

# Paginated results
curl "http://localhost:8080/gear?page=2&page_size=10"
```

## Development

### Project Structure

```
gear_api/
├── src/
│   ├── main.rs          # Application entry point
│   ├── config.rs        # Configuration management
│   ├── models.rs        # Data models
│   └── routes.rs        # API routes
├── migrations/          # SQLx migration files
├── tests/              # Integration tests
├── Cargo.toml          # Dependencies
├── Dockerfile          # Container configuration
└── fly.toml           # Fly.io deployment config
```

### Running Tests

```bash
# Unit tests
cargo test

# Integration tests (requires database)
cargo test --features sqlx/runtime-tokio-rustls
```

### Code Quality

```bash
# Format code
cargo fmt

# Lint code
cargo clippy

# Check for security issues
cargo audit
```

## Deployment

### Docker

```bash
# Build image
docker build -t gear-api .

# Run container
docker run --rm -p 8080:8080 --env-file .env gear-api
```

### Fly.io

```bash
# Deploy to Fly.io
fly launch --no-deploy

# Create Postgres database
fly postgres create --name geardb --initial-cluster-size 1 --region sin

# Attach database to app
fly postgres attach --postgres-app geardb

# Deploy
fly deploy
```

### Railway

1. Create new Railway project
2. Add Postgres plugin
3. Connect your repository
4. Set `DATABASE_URL` environment variable
5. Deploy

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | Required |
| `HOST` | Server bind address | `0.0.0.0` |
| `PORT` | Server port | `8080` |
| `RUST_LOG` | Log level | `info` |
| `CORS_ORIGIN` | CORS allowed origins | `*` |

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Run `cargo test` and `cargo clippy`
5. Submit a pull request

## License

MIT License - see LICENSE file for details.