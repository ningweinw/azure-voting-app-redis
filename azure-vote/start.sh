#!/bin/sh
set -eu
# Start Redis server in the background
redis-server --daemonize yes --bind 127.0.0.1 --port 6379
# Wait for Redis to become ready
i=0
while [ $i -lt 60 ]; do
  if redis-cli ping >/dev/null 2>&1; then
    echo "Redis is up."
    break
  fi
  i=$((i + 1))
  sleep 0.5
done
if [ $i -ge 60 ]; then
  echo "Redis did not become ready in time" >&2
  exit 1
fi
# Start Python app
export REDIS=localhost
python3.6 /app/main.py