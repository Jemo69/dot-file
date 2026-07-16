#!/bin/bash
# Configure opencode to use Agent Hub MCP server

OPENCODE_CONFIG="$HOME/.config/opencode/opencode.json"

if [ ! -f "$OPENCODE_CONFIG" ]; then
  echo "Error: opencode.json not found at $OPENCODE_CONFIG"
  exit 1
fi

if grep -q "agent-hub" "$OPENCODE_CONFIG"; then
  echo "Agent Hub already configured in opencode.json"
  exit 0
fi

cp "$OPENCODE_CONFIG" "$OPENCODE_CONFIG.bak"

if command -v jq &> /dev/null; then
  jq '.mcp["agent-hub"] = {"type": "local", "command": ["/home/jemo/.local/bin/uv", "run", "--project", "/home/jemo/projects/agent-hub/", "main.py"]}' "$OPENCODE_CONFIG" > "$OPENCODE_CONFIG.tmp" && mv "$OPENCODE_CONFIG.tmp" "$OPENCODE_CONFIG"
  echo "Added agent-hub to opencode.json"
else
  echo "jq not found. Please add manually to opencode.json:"
  echo '
  "agent-hub": {
    "type": "local",
    "command": ["/home/jemo/.local/bin/uv", "run", "--project", "/home/jemo/projects/agent-hub/", "main.py"]
  }'
fi
