#!/bin/bash
# Auto-detect agent and configure connection

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AGENT=$("$SCRIPT_DIR/detect-agent.sh")

case "$AGENT" in
  opencode)
    echo "Detected: opencode"
    "$SCRIPT_DIR/configure-opencode.sh"
    ;;
  pi)
    echo "Detected: pi"
    "$SCRIPT_DIR/configure-pi.sh"
    ;;
  codex)
    echo "Detected: codex"
    echo "Using HTTP API (no config needed)"
    echo "Test: curl http://localhost:3100/api/health"
    ;;
  *)
    echo "Unknown agent. Using HTTP API."
    echo "Test: curl http://localhost:3100/api/health"
    ;;
esac
