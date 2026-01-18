cat > 01_prereqs.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y \
  git python3-venv python3-pip \
  postgresql postgresql-contrib \
  libpq-dev python3-dev

echo "[OK] Prereqs installed."
EOF
chmod +x 01_prereqs.sh
