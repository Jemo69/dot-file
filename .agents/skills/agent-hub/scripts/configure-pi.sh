#!/bin/bash
# Configure pi for Agent Hub.
#
# pi does NOT use MCP for the hub. pi uses the HTTP API through this skill's
# hub-api.sh wrapper. So there is nothing to add to any pi mcp.json — the skill
# itself is the integration. This script just verifies the skill is in place
# and prints how to use it.

SKILL_DIR="$HOME/.agents/skills/agent-hub"
API="$SKILL_DIR/scripts/hub-api.sh"

if [ ! -f "$API" ]; then
  echo "ERROR: hub-api.sh not found at $API"
  exit 1
fi

echo "pi is configured for Agent Hub via the HTTP skill (no MCP)."
echo
echo "Start the hub HTTP API:  $SKILL_DIR/scripts/start-hub.sh"
echo "Use it from pi:          bash $API register \"pi-1\" \"/repo\""
echo
echo "For a remote hub set:    export HUB_HOST=http://<host>:3100"
echo "                         export AGENT_HUB_API_TOKEN=<token>  (or store in config.json)"
