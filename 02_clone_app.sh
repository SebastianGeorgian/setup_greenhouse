cat > 02_clone_app.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/SebastianGeorgian/GreenHouseV3.git"

mkdir -p ~/apps
cd ~/apps

if [ -d "GreenHouseV3" ]; then
  echo "[*] Repo already exists. Pulling latest..."
  cd GreenHouseV3
  git pull
else
  echo "[*] Cloning..."
  git clone "$REPO_URL"
  cd GreenHouseV3
fi

echo "[OK] Repo ready at ~/apps/GreenHouseV3"
EOF
chmod +x 02_clone_app.sh
