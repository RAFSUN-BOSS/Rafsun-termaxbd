# ================= RAFSUN HACKER PAD =================

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"

source "$REPO_DIR/banner.sh"

# -------- Prompt --------
PS1="=>> "

# -------- Auto Update Check --------
cd "$REPO_DIR"

git fetch origin main >/dev/null 2>&1

LOCAL=$(git rev-parse main)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo
    echo "[!] Update available"
    echo "1) Update now"
    echo "2) Continue without update"
    read -p "Select option: " choice

    if [ "$choice" = "1" ]; then
        echo "[+] Updating..."
        git pull origin main
        echo "[✓] Updated successfully"
        sleep 1
        exec bash
    fi
fi

banner

# -------- Clear --------
c() { clear; banner; }

# -------- Help --------
h() {
cat <<'EOF'
HACKER PAD HELP

Commands:
• c / clear        → clear screen
• h / help         → show this help
• go <path>        → jump directory

Features:
• Run .py without python
• Run .sh without bash
• Use full path directly

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

# -------- Auto-run .py & .sh --------
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
