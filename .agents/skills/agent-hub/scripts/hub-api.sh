#!/bin/bash
# Hub API wrapper for pi (and any non-MCP CLI).
#
# Works against a local hub, a hub on your LAN, or a cloud VM.
#   HUB_HOST            hub base URL (default http://localhost:3100)
#   AGENT_HUB_API_TOKEN bearer token; if unset, read from config.json
#
# Examples:
#   HUB_HOST=http://192.168.1.20:3100 bash hub-api.sh list
#   AGENT_HUB_API_TOKEN=xyz bash hub-api.sh register "pi-1" "/repo"
#   bash hub-api.sh prompt  "ab12" "ef56" "bring the prod slice, PII stripped"
#   bash hub-api.sh await   42 300      # block up to 300s for response to prompt 42
#   bash hub-api.sh prompts "ef56"      # responder reads incoming prompts
#   bash hub-api.sh respond "ef56" 42 "done, slice imported"

HUB_HOST="${HUB_HOST:-http://localhost:3100}"
HUB_URL="$HUB_HOST/api"
CONFIG_FILE="$HOME/.local/share/agent-hub/config.json"

# Resolve the API token: env var wins, else config.json .http.api_token
TOKEN="${AGENT_HUB_API_TOKEN:-}"
if [ -z "$TOKEN" ] && [ -f "$CONFIG_FILE" ] && command -v jq >/dev/null 2>&1; then
  TOKEN=$(jq -r '.http.api_token // empty' "$CONFIG_FILE" 2>/dev/null)
fi

AUTH=()
if [ -n "$TOKEN" ]; then
  AUTH=(-H "Authorization: Bearer $TOKEN")
fi

req() {
  # req METHOD PATH [JSON_BODY]
  local method="$1" path="$2" body="$3"
  if [ -n "$body" ]; then
    curl -s -X "$method" "$HUB_URL$path" "${AUTH[@]}" \
      -H "Content-Type: application/json" -d "$body"
  else
    curl -s -X "$method" "$HUB_URL$path" "${AUTH[@]}"
  fi
}

case "$1" in
  register)   req POST "/agents" "{\"name\":\"$2\",\"type\":\"pi\",\"worktree\":\"$3\"}" ;;
  deregister) req DELETE "/agents/$2" ;;
  heartbeat)  req POST "/agents/$2/heartbeat" ;;
  status-set) req PATCH "/agents/$2/status" "{\"status\":\"$3\",\"details\":\"$4\"}" ;;
  claim)      req POST "/files/claim" "{\"agent_id\":\"$2\",\"file_path\":\"$3\",\"intent\":\"$4\"}" ;;
  release)    req POST "/files/release" "{\"agent_id\":\"$2\",\"file_path\":\"$3\"}" ;;
  conflicts)  req GET "/files/$2/conflicts" ;;
  list)       req GET "/agents" ;;
  message)    req POST "/messages" "{\"from_agent\":\"$2\",\"to_agent\":\"$3\",\"message\":\"$4\"}" ;;
  broadcast)  req POST "/broadcast" "{\"from_agent\":\"$2\",\"message\":\"$3\"}" ;;
  messages)   req GET "/messages/$2" ;;
  prompt)     req POST "/prompts" "{\"from_agent\":\"$2\",\"to_agent\":\"$3\",\"prompt\":\"$4\"}" ;;
  prompts)    req GET "/prompts/$2" ;;
  respond)    req POST "/prompts/respond" "{\"agent_id\":\"$2\",\"prompt_id\":$3,\"response\":\"$4\"}" ;;
  poll)       req GET "/prompts/$2/response" ;;
  await)      req GET "/prompts/$2/await?timeout=${3:-120}" ;;
  status)     req GET "/health" ;;
  *)
    echo "Usage: hub-api.sh {register|deregister|heartbeat|status-set|claim|release|conflicts|list|message|broadcast|messages|prompt|prompts|respond|poll|await|status} [args]"
    ;;
esac
