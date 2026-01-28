#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "[+] Installing RAFSUN HACKER PAD..."

pkg install -y git python

INSTALL_DIR="$HOME/Rafsun-termaxbd"

# Remove old version completely
if [ -d "$INSTALL_DIR" ]; then
    echo "[*] Removing old version..."
    rm -rf "$INSTALL_DIR"
fi

# Fresh clone
git clone https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git "$INSTALL_DIR"

# Clean old source lines
sed -i '/Rafsun-termaxbd\/core.sh/d' ~/.bashrc

# Link new core
echo "source \$HOME/Rafsun-termaxbd/core.sh" >> ~/.bashrc

echo "[✓] Installation complete"
echo "Restarting Termux..."
sleep 1
exec bash
