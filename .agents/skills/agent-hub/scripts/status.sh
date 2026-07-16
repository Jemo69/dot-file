#!/bin/bash
# Show Agent Hub and agent status

echo "=== Agent Hub Status ==="

if curl -s http://localhost:3100/api/health > /dev/null 2>&1; then
  echo "Hub: RUNNING"
else
  echo "Hub: STOPPED"
  echo "Start with: ~/.agents/skills/agent-hub/scripts/start-hub.sh"
  exit 0
fi

echo ""
echo "=== Registered Agents ==="
curl -s http://localhost:3100/api/agents | jq -r '.[] | "\(.name) (\(.type)) - \(.status)"' 2>/dev/null || echo "No agents registered"

echo ""
echo "=== File Locks ==="
curl -s http://localhost:3100/api/agents | jq -r '.[] | select(.status == "working") | "\(.name): \(.details)"' 2>/dev/null || echo "No active work"
