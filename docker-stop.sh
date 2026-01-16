#!/bin/bash

set -e

echo "Stopping all Docker containers for Gumroad development..."

cd "$(dirname "$0")"

COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME:-gumroad_dev}

docker compose -f docker/docker-compose-dev.yml down

echo "✅ All containers stopped."
