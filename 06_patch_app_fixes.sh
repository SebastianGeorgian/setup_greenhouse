cat > 06_patch_app_fixes.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

APP_PATH=~/apps/GreenHouseV3/greenhouse_web/app.py

if [ ! -f "$APP_PATH" ]; then
  echo "[ERR] Nu găsesc $APP_PATH. Rulează: ls ~/apps/GreenHouseV3/greenhouse_web"
  exit 1
fi

echo "[*] Patching $APP_PATH ..."

# 1) ensure dotenv load exists (idempotent-ish)
if ! grep -q "from dotenv import load_dotenv" "$APP_PATH"; then
  # inject after imports line 'import logging' or at top
  # add right after the first block of imports (simple approach: after "import os")
  sed -i '0,/import os/s//import os\nfrom dotenv import load_dotenv\nload_dotenv()\n/' "$APP_PATH"
fi

# 2) fix default DB user pi_sebastian -> sebastian
sed -i "s/os.getenv(\"DB_USER\", \"pi_sebastian\")/os.getenv(\"DB_USER\", \"sebastian\")/g" "$APP_PATH"

# 3) fix ROUND(AVG(value),2) -> ROUND(AVG(value)::numeric,2)
sed -i 's/ROUND(AVG(value),2)/ROUND(AVG(value)::numeric,2)/g' "$APP_PATH"
sed -i 's/ROUND(AVG(value), 2)/ROUND(AVG(value)::numeric, 2)/g' "$APP_PATH"

echo "[OK] Patch applied."
EOF
chmod +x 06_patch_app_fixes.sh
