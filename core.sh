# ================= RAFSUN HACKER PAD =================

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"
VERSION_FILE="$REPO_DIR/version.txt"

# -------- Local version --------
LOCAL_VERSION="0.0"
[ -f "$VERSION_FILE" ] && LOCAL_VERSION=$(cat "$VERSION_FILE")

# -------- Latest version --------
LATEST_VERSION=$(curl -fs https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt)

# -------- Update check --------
if [[ -n "$LATEST_VERSION" && "$LOCAL_VERSION" != "$LATEST_VERSION" ]]; then
    echo
    echo "New update available"
    echo "1) Update now"
    echo "2) Continue"
    read -p "Select option: " choice

    if [[ "$choice" == "1" ]]; then
        rm -rf "$REPO_DIR"
        git clone "$REPO_URL" "$REPO_DIR" >/dev/null 2>&1

        # Remove old core.sh link
        sed -i '/Rafsun-termaxbd\/core.sh/d' ~/.bashrc
        echo 'source $HOME/Rafsun-termaxbd/core.sh' >> ~/.bashrc

        # Clear screen and immediately restart shell
        exec bash
        # ❌ Do NOT call banner here, exec reloads core.sh anyway
    fi
fi

# -------- Load banner once --------
if [ -f "$REPO_DIR/banner.sh" ]; then
    source "$REPO_DIR/banner.sh"
    banner
fi

# -------- Prompt --------
PS1="=>> "

# -------- Clear --------
c() { clear; banner; }
alias clear='c'

# -------- Help --------
h() {
cat <<'EOF'
HACKER PAD HELP

Commands:
  c / clear        → clear screen
  h / help         → show help
  go <path>        → jump directory

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
    [ -d "$1" ] && cd "$1" || echo "Path not found"
}

# -------- Auto run scripts --------
command_not_found_handle() {

    if [[ "$1" == *.py && -f "$1" ]]; then
        python "$1"
        return 0
    fi

    if [[ "$1" == *.sh && -f "$1" ]]; then
        bash "$1"
        return 0
    fi

    return 127
}

# ================= END =================
