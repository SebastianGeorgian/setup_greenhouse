cat > 05_write_env.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

cd ~/apps/GreenHouseV3

# generează random safe
FLASK_SECRET="$(python3 - <<'PY'
import secrets; print(secrets.token_hex(32))
PY
)"

INGEST_KEY="$(python3 - <<'PY'
import secrets; print(secrets.token_urlsafe(32))
PY
)"

cat > .env <<ENV
FLASK_SECRET=${FLASK_SECRET}
LOG_LEVEL=INFO

DB_NAME=greenhouse
DB_USER=sebastian
DB_PASSWORD=ghiveci
DB_HOST=localhost

GH_USER=Sebastian
GH_PASS=ghiveci

TELEGRAM_TOKEN=
TELEGRAM_CHAT_ID=
ALERT_COOLDOWN_SECONDS=300

INGEST_API_KEY=${INGEST_KEY}
INGEST_RATE_WINDOW_SEC=10
INGEST_RATE_MAX_REQ=60
ENV

# asigură-te că .env nu ajunge în git
touch .gitignore
grep -qxF ".env" .gitignore || echo ".env" >> .gitignore

echo "[OK] .env written. (Keys generated fresh)"
EOF
chmod +x 05_write_env.sh
