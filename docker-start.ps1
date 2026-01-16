# PowerShell script to start all-in-one Docker setup for Gumroad development

Write-Host "Starting all-in-one Docker setup for Gumroad development..." -ForegroundColor Green
Write-Host "This will start the Rails app and all required services in Docker." -ForegroundColor Green
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Check for SSL certificates
if (-not (Test-Path "docker/local-nginx/certs/gumroad_dev.crt") -or -not (Test-Path "docker/local-nginx/certs/gumroad_dev.key")) {
    Write-Host "⚠️  SSL certificates not found. Generating them..." -ForegroundColor Yellow

    if (Get-Command mkcert -ErrorAction SilentlyContinue) {
        mkcert -install 2>$null
        & bin/generate_ssl_certificates
    } else {
        Write-Host "❌ mkcert is not installed. Please install it first:" -ForegroundColor Red
        Write-Host "   choco install mkcert" -ForegroundColor Yellow
        Write-Host "   Or see: https://github.com/FiloSottile/mkcert#windows" -ForegroundColor Yellow
        exit 1
    }
}

$env:COMPOSE_PROJECT_NAME = if ($env:COMPOSE_PROJECT_NAME) { $env:COMPOSE_PROJECT_NAME } else { "gumroad_dev" }

Write-Host "Building and starting containers..." -ForegroundColor Green
docker compose -f docker/docker-compose-dev.yml up --build
