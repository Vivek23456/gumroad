# All-in-One Docker Setup

This guide explains how to use the all-in-one Docker setup for Gumroad development, which runs everything in Docker containers - no need to install Ruby, Node.js, MySQL, or other dependencies locally.

## Quick Start

### Prerequisites

1. **Docker Desktop** installed and running
   - macOS: Download from [Docker website](https://www.docker.com/products/docker-desktop)
   - Windows: Download from [Docker website](https://www.docker.com/products/docker-desktop)
   - Linux: `sudo wget -qO- https://get.docker.com/ | sh`

2. **mkcert** for SSL certificates
   - macOS: `brew install mkcert`
   - Linux: See [mkcert installation](https://github.com/FiloSottile/mkcert#installation)
   - Windows: `choco install mkcert` or see [mkcert Windows guide](https://github.com/FiloSottile/mkcert#windows)

### One-Time Setup

Generate SSL certificates:

```bash
mkcert -install
bin/generate_ssl_certificates
```

### Starting the Application

**Unix (macOS/Linux):**
```bash
./docker-start.sh
```

**Windows (PowerShell):**
```powershell
.\docker-start.ps1
```

**Using Make:**
```bash
make docker-dev
```

**Run in background:**
```bash
make docker-dev-detached
```

### Stopping the Application

**Unix:**
```bash
./docker-stop.sh
```

**Windows:**
```powershell
.\docker-stop.ps1
```

**Using Make:**
```bash
make stop_docker-dev
```

## What's Included

The all-in-one setup includes:

- **Rails Application** (web server, webpack, Sidekiq, AnyCable)
- **MySQL** database
- **Redis** (for caching and background jobs)
- **MongoDB** (for logging)
- **Elasticsearch** (for search)
- **MinIO** (S3-compatible storage)
- **Nginx** (reverse proxy with SSL)

## Accessing the Application

Once started, access the application at:
- **Main app:** https://gumroad.dev
- **MinIO Console:** http://localhost:9001 (minioadmin/minioadmin)

## Running Commands

### Rails Console
```bash
docker compose -f docker/docker-compose-dev.yml exec web bin/rails c
```

### Rails Commands
```bash
docker compose -f docker/docker-compose-dev.yml exec web bin/rails <command>
```

### RSpec Tests
```bash
docker compose -f docker/docker-compose-dev.yml exec web bin/rspec
```

### Bash Shell
```bash
docker compose -f docker/docker-compose-dev.yml exec web bash
```

### Database Commands
```bash
docker compose -f docker/docker-compose-dev.yml exec web bin/rails db:migrate
docker compose -f docker/docker-compose-dev.yml exec web bin/rails db:seed
```

## Troubleshooting

### Port Already in Use

If you get port conflicts, stop existing containers:
```bash
docker compose -f docker/docker-compose-dev.yml down
```

### SSL Certificate Issues

Regenerate certificates:
```bash
mkcert -install
bin/generate_ssl_certificates
```

### Database Issues

Reset the database:
```bash
docker compose -f docker/docker-compose-dev.yml exec web bin/rails db:reset
```

### View Logs

View all logs:
```bash
docker compose -f docker/docker-compose-dev.yml logs -f
```

View specific service logs:
```bash
docker compose -f docker/docker-compose-dev.yml logs -f web
```

## Benefits

- ✅ No need to install Ruby, Node.js, MySQL, Redis, etc. locally
- ✅ Consistent environment across all developers
- ✅ Easy to reset - just stop and start containers
- ✅ Works on Windows, macOS, and Linux
- ✅ All services managed together

## Comparison with Traditional Setup

| Feature | All-in-One Docker | Traditional Setup |
|---------|------------------|-------------------|
| Local Ruby/Node | ❌ Not needed | ✅ Required |
| Local MySQL | ❌ Not needed | ✅ Client libraries needed |
| Setup complexity | ⭐ Simple | ⭐⭐ Moderate |
| Isolation | ✅ Complete | ⚠️ Partial |
| Resource usage | ⚠️ Higher | ✅ Lower |
