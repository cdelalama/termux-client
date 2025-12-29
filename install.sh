#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

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

install -m 755 bin/np "$PREFIX/bin/np"
install -m 755 bin/vscode-web "$PREFIX/bin/vscode-web"
install -m 755 bin/bootstrap-phone "$PREFIX/bin/bootstrap-phone"
install -m 755 bin/doctor-phone "$PREFIX/bin/doctor-phone"

echo "Installed: np, vscode-web, bootstrap-phone, doctor-phone"
