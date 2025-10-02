# ---- Builder (safe) ----
FROM rust:1.86-bookworm AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# Copy EVERYTHING needed to build the app (incl. src)
COPY . .

# Build in release mode
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
