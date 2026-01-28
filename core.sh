#!/data/data/com.termux/files/usr/bin/bash
# ================= RAFSUN HACKER PAD =================

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"
VERSION_FILE="$REPO_DIR/version.txt"
UPDATE_FLAG="$REPO_DIR/.checked"

# -------- Read local version --------
LOCAL_VERSION="UNKNOWN"
[ -f "$VERSION_FILE" ] && LOCAL_VERSION=$(cat "$VERSION_FILE")

# -------- Update check (ONCE per session, silent if no update) --------
check_update() {
    [ -f "$UPDATE_FLAG" ] && return
    touch "$UPDATE_FLAG"

    LATEST_VERSION=$(curl -fs https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt 2>/dev/null)

    # Only proceed if a newer version exists
    if [[ -n "$LATEST_VERSION" && "$LOCAL_VERSION" != "$LATEST_VERSION" ]]; then
        echo
        echo "New update available"
        echo "Installed : $LOCAL_VERSION"
        echo "Latest    : $LATEST_VERSION"
        echo
        echo "1) Update now"
        echo "2) Continue"
        read -p "Select option: " choice

        if [[ "$choice" == "1" ]]; then
            rm -rf "$REPO_DIR"
            git clone "$REPO_URL" "$REPO_DIR" >/dev/null 2>&1

            # Re-link core.sh in bashrc
            sed -i '/Rafsun-termaxbd\/core.sh/d' ~/.bashrc
            echo 'source $HOME/Rafsun-termaxbd/core.sh' >> ~/.bashrc

            exec bash
        fi
    fi
}

# Run update check only ONCE at shell startup
check_update

# -------- Load banner ONCE --------
if [ -f "$REPO_DIR/banner.sh" ]; then
    source "$REPO_DIR/banner.sh"
    banner
fi

# -------- Prompt --------
PS1="=>> "

# -------- Clear screen --------
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
  • Run .py directly
  • Run .sh directly
  • Use full path directly

Creator : RAFSUN-BOSS
EOF
}
alias help='h'

# -------- Go to folder --------
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

    echo "Command not found"
    return 127
}

# ================= END =================
