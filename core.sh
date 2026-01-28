# ================= RAFSUN HACKER PAD =================

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"

# -------- Read local version safely --------
LOCAL_VERSION=$(cat "$REPO_DIR/version.txt" 2>/dev/null)

# -------- Fetch latest version safely --------
LATEST_VERSION=$(curl -s https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt)

# -------- First update block (with cleanup) --------
if [ -n "$choice" ] && [ "$choice" = "1" ]; then
    echo "[+] Updating..."

    # ---------- AUTO CLEANUP ----------
    [ -f ~/.bashrc ] && sed -i '/Rules:/,/jump/d' ~/.bashrc
    [ -f ~/.bashrc ] && sed -i '/autocd/d' ~/.bashrc
    [ -f ~/.bashrc ] && sed -i '/Rafsun-termaxbd/d' ~/.bashrc
    # ----------------------------------------------

    # Remove old version completely
    rm -rf "$REPO_DIR"

    # Clone fresh updated version
    git clone "$REPO_URL" "$REPO_DIR"

    # Re-link clean core.sh
    echo 'source $HOME/Rafsun-termaxbd/core.sh' >> ~/.bashrc

    echo "[✓] Updated to version $LATEST_VERSION"
    sleep 1

    # Reload shell with clean state
    exec bash
fi

# -------- Version check --------
if [ "$LOCAL_VERSION" != "$LATEST_VERSION" ] && [ -n "$LATEST_VERSION" ]; then
    echo
    echo "[!] New version available"
    echo "Installed : ${LOCAL_VERSION:-none}"
    echo "Latest    : $LATEST_VERSION"
    echo
    echo "1) Update now"
    echo "2) Continue without update"
    read -p "Select option: " choice

    if [ "$choice" = "1" ]; then
        echo "[+] Updating..."

        # ---------- AUTO CLEANUP ----------
        [ -f ~/.bashrc ] && sed -i '/Rules:/,/jump/d' ~/.bashrc
        [ -f ~/.bashrc ] && sed -i '/autocd/d' ~/.bashrc
        [ -f ~/.bashrc ] && sed -i '/Rafsun-termaxbd/d' ~/.bashrc
        # ----------------------------------------------

        # Remove old version completely
        rm -rf "$REPO_DIR"

        # Clone fresh updated version
        git clone "$REPO_URL" "$REPO_DIR"

        # Re-link clean core.sh
        echo 'source $HOME/Rafsun-termaxbd/core.sh' >> ~/.bashrc

        echo "[✓] Updated to version $LATEST_VERSION"
        sleep 1
        exec bash
    fi
fi

# -------- Load banner safely --------
[ -f "$REPO_DIR/banner.sh" ] && source "$REPO_DIR/banner.sh"

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
