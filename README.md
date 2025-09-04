# Gear API Quick Start

## 1) Create DB & schema
- Ensure Postgres is running.
- Execute your schema SQL from earlier (brands, categories, gear, etc.).

# If you have Postgres installed locally
psql -h localhost -U postgres -d gear_db -f schema.sql

# Or if you need to create the database first
psql -h localhost -U postgres -c "CREATE DATABASE gear_db;"
psql -h localhost -U postgres -d gear_db -f schema.sql

## 2) Local run
```bash
cp .env.example .env
# edit DATABASE_URL
cargo run
# test
curl 'http://localhost:8080/health'
curl 'http://localhost:8080/gear?gear_type=guitar&brand=Fender&q=strat'
```

## 3) Docker
```bash
docker build -t gear-api .
docker run --rm -p 8080:8080 --env-file .env gear-api
```

## 4) Fly.io deploy
```bash
# install flyctl first
fly launch --no-deploy
# provision Postgres (or bring your own)
fly postgres create --name geardb --initial-cluster-size 1 --region sin
# attach app to the DB (populates secrets)
fly postgres attach --postgres-app geardb
# OR manually set DATABASE_URL secret
# fly secrets set DATABASE_URL=postgres://user:pass@host:5432/dbname
fly deploy
```

## 5) Railway (alt)
- Create a new Railway project, add a Postgres plugin.
- Add your repository (with this Dockerfile) and deploy.
- Set `DATABASE_URL` variable to the plugin's URL.

## Endpoints
- `GET /health`
- `GET /brands`
- `GET /gear?q=&gear_type=&brand=&page=&page_size=`
- `GET /gear/{slug}`
- `POST /gear` (JSON body; brand/category by name)
