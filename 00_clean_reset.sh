cat > 00_clean_reset.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

echo "[*] Stop service if exists..."
sudo systemctl stop greenhouse 2>/dev/null || true
sudo systemctl disable greenhouse 2>/dev/null || true
sudo rm -f /etc/systemd/system/greenhouse.service
sudo systemctl daemon-reload

echo "[*] Remove app directory if exists..."
rm -rf ~/apps/GreenHouseV3

echo "[OK] Clean reset done."
EOF
chmod +x 00_clean_reset.sh
