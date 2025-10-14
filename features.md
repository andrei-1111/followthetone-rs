## Project Features — FollowTheTone (REST API)

- **Backend (Actix Web REST API)**
  - **Health**: `GET /health` — simple JSON OK response.
  - **Guitars API**:
    - `GET /api/guitars` — list all guitars from SurrealDB.
    - `GET /api/guitars/{id}` — get guitar by ID (accepts `guitars:<id>` or `<id>`).
    - `DELETE /api/guitars/{id}` — delete guitar by ID.
    - `POST /api/guitars/{id}/delete` — form-friendly delete with redirect.
  - **SurrealDB Integration**: HTTP client with env-driven config.
  - **CORS**: Permissive CORS for API access.
  - **Config** (`src/config.rs`): `HOST`, `PORT`, `SURREAL_URL`, `SURREAL_NS`, `SURREAL_DB`, `SURREAL_USER`, `SURREAL_PASS`.

- **Models**
  - `Guitar` (`src/models.rs`): `id: Option<Thing>`, `brand`, `model`, `body_style`, `year_reference`, `price_cents`, `serial_number`, etc.

- **Database & Migrations**
  - SurrealDB over HTTP/HTTPS.
  - Schema and seed files in `data/` and `migrations/`.
  - Namespace: `gear`, Database: `guitars`.

- **Build & Development**
  - Standard Rust build: `cargo build`, `cargo run`.
  - No frontend dependencies or build complexity.

- **Deployment**
  - **Fly.io ready**: `fly.toml` with health check, `Dockerfile` for server-only build.
  - **Required secrets**: `SURREAL_URL`, `SURREAL_NS`, `SURREAL_DB`, `SURREAL_USER`, `SURREAL_PASS`, `HOST=0.0.0.0`, `PORT=8080`.

- **API Design**
  - All endpoints under `/api/*`.
  - JSON responses with proper HTTP status codes.
  - Error handling with descriptive messages.
