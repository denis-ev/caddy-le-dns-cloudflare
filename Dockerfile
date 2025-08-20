# syntax=docker/dockerfile:1

# Declare build args *before* they are used with FROM
ARG CADDY_VERSION=latest

FROM caddy:${CADDY_VERSION}-builder AS builder
ARG CADDY_VERSION

# Build with Cloudflare DNS plugin pinned to Caddy version
RUN xcaddy build v${CADDY_VERSION} \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
