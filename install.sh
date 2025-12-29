#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
CFG_DIR="$HOME/.config/termux-client"
CFG_FILE="$CFG_DIR/config"

mkdir -p "$CFG_DIR"
if [[ ! -f "$CFG_FILE" ]]; then
  cat > "$CFG_FILE" <<'CFG'
HOST=USER
CFG
  echo "Created $CFG_FILE"
fi

install -m 755 bin/np "$PREFIX/bin/np"

echo "Installed: np"
echo "Config: $CFG_FILE"
