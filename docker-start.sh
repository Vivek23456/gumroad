#!/bin/bash

set -e

echo "Starting all-in-one Docker setup for Gumroad development..."
echo "This will start the Rails app and all required services in Docker."
echo ""

cd "$(dirname "$0")"

if [ ! -f "docker/local-nginx/certs/gumroad_dev.crt" ] || [ ! -f "docker/local-nginx/certs/gumroad_dev.key" ]; then
  echo "⚠️  SSL certificates not found. Generating them..."
  if command -v mkcert &> /dev/null; then
    mkcert -install 2>/dev/null || true
    bin/generate_ssl_certificates
  else
    echo "❌ mkcert is not installed. Please install it first:"
    echo "   macOS: brew install mkcert"
    echo "   Linux: See https://github.com/FiloSottile/mkcert#installation"
    echo "   Windows: See https://github.com/FiloSottile/mkcert#windows"
    exit 1
  fi
fi

COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME:-gumroad_dev}

echo "Building and starting containers..."
docker compose -f docker/docker-compose-dev.yml up --build
