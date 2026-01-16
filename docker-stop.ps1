# PowerShell script to stop all-in-one Docker setup

Write-Host "Stopping all Docker containers for Gumroad development..." -ForegroundColor Yellow

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

$env:COMPOSE_PROJECT_NAME = if ($env:COMPOSE_PROJECT_NAME) { $env:COMPOSE_PROJECT_NAME } else { "gumroad_dev" }

docker compose -f docker/docker-compose-dev.yml down

Write-Host "✅ All containers stopped." -ForegroundColor Green
