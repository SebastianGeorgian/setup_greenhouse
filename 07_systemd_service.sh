cat > 07_systemd_service.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

SERVICE_PATH="/etc/systemd/system/greenhouse.service"
WORKDIR="/home/sebastian/apps/GreenHouseV3"
ENTRY="/home/sebastian/apps/GreenHouseV3/greenhouse_web/app.py"

if [ ! -f "$ENTRY" ]; then
  echo "[ERR] Nu găsesc entrypoint: $ENTRY"
  exit 1
fi

sudo tee "$SERVICE_PATH" > /dev/null <<UNIT
[Unit]
Description=GreenHouseV3 Flask App
After=network.target postgresql.service

[Service]
User=sebastian
WorkingDirectory=${WORKDIR}
EnvironmentFile=${WORKDIR}/.env
ExecStart=${WORKDIR}/.venv/bin/python ${ENTRY}
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
UNIT

sudo systemctl daemon-reload
sudo systemctl enable --now greenhouse
sudo systemctl status greenhouse --no-pager

echo "[OK] Service running."
EOF
chmod +x 07_systemd_service.sh
