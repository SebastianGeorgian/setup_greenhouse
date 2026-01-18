cat > 04_db_setup.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

DB_NAME="greenhouse"
DB_USER="sebastian"
DB_PASS="ghiveci"

echo "[*] Creating DB/user if needed..."

sudo -u postgres psql <<SQL
DO \$\$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '${DB_USER}') THEN
    CREATE ROLE ${DB_USER} WITH LOGIN SUPERUSER PASSWORD '${DB_PASS}';
  END IF;
END
\$\$;

DO \$\$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_database WHERE datname = '${DB_NAME}') THEN
    CREATE DATABASE ${DB_NAME} OWNER ${DB_USER};
  END IF;
END
\$\$;
SQL

echo "[*] Creating tables..."
psql -U "${DB_USER}" -d "${DB_NAME}" <<SQL
CREATE TABLE IF NOT EXISTS sensor_readings (
  id SERIAL PRIMARY KEY,
  sensor_type TEXT NOT NULL,
  value DOUBLE PRECISION NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_sensor_type_ts
  ON sensor_readings(sensor_type, timestamp);
SQL

echo "[OK] DB ready."
EOF
chmod +x 04_db_setup.sh
