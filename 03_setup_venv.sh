cat > 03_setup_venv.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

cd ~/apps/GreenHouseV3

# creează requirements.txt dacă lipsește
if [ ! -f requirements.txt ]; then
  cat > requirements.txt <<'REQ'
Flask==3.0.0
psycopg2-binary==2.9.9
pandas==2.1.4
requests==2.31.0
python-dotenv==1.0.0
REQ
  echo "[*] Created requirements.txt"
fi

python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

echo "[OK] venv ready."
EOF
chmod +x 03_setup_venv.sh
