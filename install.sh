#!/usr/bin/env bash
set -euo pipefail

if [[ ! -d "/data/data/com.termux" ]]; then
  echo "Error: termux-client/install.sh is supported only inside Termux on Android." >&2
  echo "Use tmux-workspace client scripts or plain SSH on desktop/server environments." >&2
  exit 2
fi

PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"

CFG_DIR="$HOME/.config/termux-client"
CFG_FILE="$CFG_DIR/config"

mkdir -p "$CFG_DIR"
if [[ ! -f "$CFG_FILE" ]]; then
  cat > "$CFG_FILE" <<'CFG'
# Edita esto:
HOST=cdelalama@DEV_VM_IP

# Opcional:
LOCAL_PORT=18080
REMOTE_PORT=8080
CFG
  echo "Created $CFG_FILE (edit DEV_VM_IP)"
fi

mkdir -p "$PREFIX/bin"
install -m 755 bin/op "$PREFIX/bin/op"
install -m 755 bin/np "$PREFIX/bin/np"
install -m 755 bin/vscode-web "$PREFIX/bin/vscode-web"
install -m 755 bin/bootstrap-phone "$PREFIX/bin/bootstrap-phone"
install -m 755 bin/doctor-phone "$PREFIX/bin/doctor-phone"
echo "Installed: op, np, vscode-web, bootstrap-phone, doctor-phone"
