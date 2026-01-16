#!/bin/bash

set -e

cd $APP_DIR

if [ ! -f "tmp/pids/.keep" ]; then
  mkdir -p tmp/pids
  touch tmp/pids/.keep
fi

if ! bundle exec rails runner "ActiveRecord::Base.connection" 2>/dev/null; then
  echo "Setting up database..."
  bundle exec rails db:prepare
fi

echo "Starting development server..."
exec bundle exec foreman start -f Procfile.dev
