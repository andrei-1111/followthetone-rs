# ---- Builder ----
FROM rust:1.86-bookworm AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# Cache deps
COPY Cargo.toml Cargo.lock ./
RUN mkdir -p src && echo "fn main() {}" > src/main.rs && cargo build --release

# Now copy real sources and FORCE rebuild
COPY src ./src
ARG APP_REV=unknown                     # <— cache-buster
RUN cargo build --release --bin gear_api

# ---- Runtime ----
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates libssl3 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/target/release/gear_api /usr/local/bin/gear_api
ENV RUST_LOG=info
EXPOSE 8080
CMD ["/usr/local/bin/gear_api"]
