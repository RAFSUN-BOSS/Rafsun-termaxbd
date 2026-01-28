#!/data/data/com.termux/files/usr/bin/bash

echo "[+] Installing RAFSUN HACKER PAD..."

pkg update -y && pkg upgrade -y
pkg install git python -y

# Backup bashrc
[ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$HOME/.bashrc.backup.rafsun"

# Remove old block
sed -i '/RAFSUN HACKER PAD START/,/RAFSUN HACKER PAD END/d' "$HOME/.bashrc" 2>/dev/null

# Inject config
cat <<'EOF' >> "$HOME/.bashrc"

# ===== RAFSUN HACKER PAD START =====

clear

rc() {
  colors=(31 32 33 34 35 36)
  echo -e "\e[1;${colors[$RANDOM % ${#colors[@]}]}m"
}

echo -e "$(rc)"
cat <<'HACKER'
 _   _    _    ____ _  __ _____ ____
| | | |  / \  / ___| |/ /| ____|  _ \
| |_| | / _ \| |   | ' / |  _| | |_) |
|  _  |/ ___ \ |___| . \ | |___|  _ <
|_| |_/_/   \_\____|_|\_\|_____|_| \_\
HACKER

echo -e "$(rc)              RAFSUN-BOSS"
echo -e "$(rc)Author  : Rafsun Boss"
echo -e "$(rc)Version : 1.4"
echo

loading () {
  msg="$1"
  for i in $(seq 0 10 100); do
    echo -ne "\r$(rc)$msg $i%"
    sleep 0.03
  done
  echo -e " ✔"
}

loading "Initializing"
loading "Loading Environment"

echo -e "\e[0m"

echo -e "\e[1;33mRules:\e[0m"
echo -e "\e[1;32m• Run .py without python\e[0m"
echo -e "\e[1;32m• Run .sh without bash\e[0m"
echo -e "\e[1;32m• Use full path directly\e[0m"
echo -e "\e[1;32m• go <path> to jump\e[0m"
echo

set -o autocd

go () {
  cd "$1" 2>/dev/null || echo "❌ Path not found"
}

command_not_found_handle() {
  if [ -f "$1" ]; then
    chmod +x "$1"
    ./"$1"
  else
    echo "Command not found: $1"
  fi
}

# ===== RAFSUN HACKER PAD END =====

EOF

echo
echo "[✔] RAFSUN HACKER PAD INSTALLED"
echo "[✔] Restart Termux or run: source ~/.bashrc"
echo
