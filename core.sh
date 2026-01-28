# ================= RAFSUN HACKER PAD =================

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"

LOCAL_VERSION=$(cat "$REPO_DIR/version.txt")

# -------- Fetch latest version --------
LATEST_VERSION=$(curl -s https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt)

# -------- Version check --------
if [ "$LOCAL_VERSION" != "$LATEST_VERSION" ]; then
    echo
    echo "[!] New version available"
    echo "Installed : $LOCAL_VERSION"
    echo "Latest    : $LATEST_VERSION"
    echo
    echo "1) Update now"
    echo "2) Continue without update"
    read -p "Select option: " choice

    if [ "$choice" = "1" ]; then
        echo "[+] Updating..."
        rm -rf "$REPO_DIR"
        git clone "$REPO_URL" "$REPO_DIR"
        echo "[✓] Updated to version $LATEST_VERSION"
        sleep 1
        exec bash
    fi
fi

source "$REPO_DIR/banner.sh"

# -------- Prompt --------
PS1="=>> "

# -------- Clear --------
c() { clear; banner; }

# -------- Help --------
h() {
cat <<'EOF'
HACKER PAD HELP

Commands:
• c / clear        → clear screen
• h / help         → show help
• go <path>        → jump directory

Features:
• Run .py directly
• Run .sh directly
• Use full path without cd

Creator : RAFSUN-BOSS
EOF
}
alias help='h'

# -------- Go --------
go() {
    if [ -d "$1" ]; then
        cd "$1" || return
    else
        echo "Path not found"
    fi
}

# -------- Auto run scripts --------
command_not_found_handle() {

    if [[ "$1" == *.py && -f "$1" ]]; then
        python "$1"
        return
    fi

    if [[ "$1" == *.sh && -f "$1" ]]; then
        bash "$1"
        return
    fi

    echo "Command not found: $1"
}

# ================= END =================
