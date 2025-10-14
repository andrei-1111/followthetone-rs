# ---- Builder ----
FROM rust:1.86-bookworm AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# Copy dependencies first for better caching
COPY Cargo.toml Cargo.lock* ./
RUN cargo fetch

# Copy source and build
COPY . .
RUN cargo build --release

# ---- Runtime ----
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates libssl3 && rm -rf /var/lib/apt/lists/*
WORKDIR /app

# Copy the final binary
COPY --from=builder /app/target/release/gear_api /usr/local/bin/gear_api

ENV RUST_LOG=info
EXPOSE 8080
CMD ["/usr/local/bin/gear_api"]
