#!/bin/bash
# Auto-Claude convenience wrapper script
# Usage: ./auto-claude.sh [args]
# Example: ./auto-claude.sh --list

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$SCRIPT_DIR/apps/backend"

cd "$BACKEND_DIR"
exec "$BACKEND_DIR/.venv/bin/python" "$BACKEND_DIR/run.py" "$@"
