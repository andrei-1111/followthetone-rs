# Multi-stage build for small prod image
FROM rust:1.86-bookworm AS builder   # any 1.84+ supports edition 2024
WORKDIR /app
RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# Cache deps
COPY Cargo.toml Cargo.lock .
RUN mkdir src && echo "fn main() {}" > src/main.rs && cargo build --release && rm -rf src

# Build
COPY src ./src
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates libssl3 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/target/release/gear_api /usr/local/bin/gear_api
ENV RUST_LOG=info
EXPOSE 8080
CMD ["/usr/local/bin/gear_api"]
