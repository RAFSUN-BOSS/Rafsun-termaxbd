#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"
INSTALL_DIR="$HOME/Rafsun-termaxbd"

echo "[+] Installing RAFSUN HACKER PAD..."

pkg install -y git python

rm -rf "$INSTALL_DIR"
git clone "$REPO_URL" "$INSTALL_DIR"

grep -q "Rafsun-termaxbd/core.sh" ~/.bashrc || \
echo "source \$HOME/Rafsun-termaxbd/core.sh" >> ~/.bashrc

echo "[✓] Installation complete"
echo "Restart Termux"
