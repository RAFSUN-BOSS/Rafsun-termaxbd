#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "[+] Installing RAFSUN HACKER PAD..."

pkg install -y git python

cd $HOME

if [ ! -d "Rafsun-termaxbd" ]; then
    git clone https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git
fi

grep -q "Rafsun-termaxbd/core.sh" ~/.bashrc || echo "source \$HOME/Rafsun-termaxbd/core.sh" >> ~/.bashrc

echo "[✓] Installed successfully"
echo "Restart Termux"
