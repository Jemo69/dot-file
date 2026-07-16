#!/bin/bash
# Detect which agent harness is running

detect_agent() {
  if [ "$OPENCODE" = "1" ] || [ -n "$OPENCODE_PID" ]; then
    echo "opencode"
    return 0
  fi

  if [ -n "$PI_PID" ] || [ "$PI" = "1" ]; then
    echo "pi"
    return 0
  fi

  if [ -n "$CODEX_PID" ] || [ "$CODEX" = "1" ]; then
    echo "codex"
    return 0
  fi

  PARENT=$(ps -o comm= -p $PPID 2>/dev/null)
  case "$PARENT" in
    opencode) echo "opencode"; return 0 ;;
    pi) echo "pi"; return 0 ;;
    codex) echo "codex"; return 0 ;;
  esac

  GRANDPARENT=$(ps -o comm= -p $(ps -o ppid= -p $PPID 2>/dev/null) 2>/dev/null)
  case "$GRANDPARENT" in
    opencode) echo "opencode"; return 0 ;;
    pi) echo "pi"; return 0 ;;
    codex) echo "codex"; return 0 ;;
  esac

  if [ -d ".opencode" ]; then echo "opencode"; return 0; fi
  if [ -d ".pi" ]; then echo "pi"; return 0; fi

  if pgrep -x "opencode" > /dev/null 2>&1; then echo "opencode"; return 0; fi
  if pgrep -x "pi" > /dev/null 2>&1; then echo "pi"; return 0; fi

  echo "unknown"
  return 1
}

detect_agent
