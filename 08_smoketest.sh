cat > 08_smoketest.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

cd ~/apps/GreenHouseV3
set -a; source .env; set +a

echo "[*] Checking local web..."
curl -I http://127.0.0.1:5000/login || true

echo "[*] Testing ingest..."
curl -sS -X POST http://127.0.0.1:5000/api/ingest \
  -H "Content-Type: application/json" \
  -H "X-API-Key: ${INGEST_API_KEY}" \
  -d '{"sensor":"temperature_avg_6min","value":23.4}' | cat

echo
echo "[*] Check last rows in DB..."
psql -U sebastian -d greenhouse -c "SELECT sensor_type,value,timestamp FROM sensor_readings ORDER BY timestamp DESC LIMIT 5;"
EOF
chmod +x 08_smoketest.sh
