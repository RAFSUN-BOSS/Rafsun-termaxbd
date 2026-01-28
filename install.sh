#!/data/data/com.termux/files/usr/bin/bash

echo "[+] Installing Hacker Pad for Termux..."

# Update system
pkg update -y && pkg upgrade -y

# Install required packages
pkg install figlet toilet python git -y

# Create config folder
mkdir -p $HOME/.hackerpad

# Copy banner
cp banner.sh $HOME/.hackerpad/
chmod +x $HOME/.hackerpad/banner.sh

# Backup existing bashrc
if [ -f "$HOME/.bashrc" ]; then
  cp "$HOME/.bashrc" "$HOME/.bashrc.backup.hackerpad"
fi

# Inject config safely
if ! grep -q "HACKER PAD CONFIG START" "$HOME/.bashrc"; then
  cat bashrc_additions.sh >> "$HOME/.bashrc"
fi

echo
echo "[✔] Hacker Pad installed successfully!"
echo "[✔] Restart Termux or run: source ~/.bashrc"
echo
