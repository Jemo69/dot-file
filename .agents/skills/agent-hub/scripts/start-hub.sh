#!/bin/bash
# Auto-start Agent Hub if not running

HUB_URL="http://localhost:3100/api/health"
HUB_DIR="$HOME/projects/agent-hub"
LOG_FILE="$HOME/.local/share/agent-hub/hub.log"

mkdir -p "$(dirname "$LOG_FILE")"

if curl -s "$HUB_URL" > /dev/null 2>&1; then
  echo "Agent Hub already running"
  exit 0
fi

echo "Starting Agent Hub (HTTP API)..."

cd "$HUB_DIR"
nohup uv run --project "$HUB_DIR" http_api.py > "$LOG_FILE" 2>&1 &
HUB_PID=$!

for i in {1..30}; do
  if curl -s "$HUB_URL" > /dev/null 2>&1; then
    echo "Agent Hub started (PID: $HUB_PID)"
    echo "Log: $LOG_FILE"
    exit 0
  fi
  sleep 0.5
done

echo "Failed to start Agent Hub. Check log: $LOG_FILE"
exit 1
