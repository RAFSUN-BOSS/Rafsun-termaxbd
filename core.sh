# ================= RAFSUN HACKER PAD =================

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"
VERSION_FILE="$REPO_DIR/version.txt"

# -------- Prevent re-run --------
[ -n "$RAFSPAD_LOADED" ] && return
export RAFSPAD_LOADED=1

# -------- Load local version --------
LOCAL_VERSION="0.0"
[ -f "$VERSION_FILE" ] && LOCAL_VERSION=$(cat "$VERSION_FILE")

# -------- Update check (ONCE, SAFE) --------
if [ -z "$RAFSPAD_UPDATE_CHECKED" ]; then
    export RAFSPAD_UPDATE_CHECKED=1

    LATEST_VERSION=$(curl -fs https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt)

    if [ -n "$LATEST_VERSION" ] && [ "$LOCAL_VERSION" != "$LATEST_VERSION" ]; then
        echo
        echo "[!] Update available: $LATEST_VERSION (current $LOCAL_VERSION)"
        echo "1) Update now"
        echo "2) Skip"
        read -p "Select option: " choice

        if [ "$choice" = "1" ]; then
            echo "[*] Updating..."

            tmpdir="$HOME/.rafspad_update"
            rm -rf "$tmpdir"

            if git clone "$REPO_URL" "$tmpdir"; then
                rm -rf "$REPO_DIR"
                mv "$tmpdir" "$REPO_DIR"
                echo "[✓] Update complete. Restarting shell..."
                exec bash
            else
                echo "[X] Update failed. Keeping current version."
                rm -rf "$tmpdir"
            fi
        fi
    fi
fi

# -------- Banner (ONCE) --------
if [ -z "$RAFSPAD_BANNER_SHOWN" ] && [ -f "$REPO_DIR/banner.sh" ]; then
    export RAFSPAD_BANNER_SHOWN=1
    source "$REPO_DIR/banner.sh"
    banner
fi

# -------- Prompt --------
PS1="=>> "

# -------- Clear (SAFE) --------
cls() {
    command clear
    banner
}

# -------- Help --------
h() {
cat <<'EOF'
HACKER PAD HELP

Commands:
  cls              → clear screen
  h / help         → show help
  go <path>        → jump directory

Features:
  • Run .py directly
  • Run .sh directly

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
    case "$1" in
        *.py) [ -f "$1" ] && python "$1" && return 0 ;;
        *.sh) [ -f "$1" ] && bash "$1" && return 0 ;;
    esac
    return 127
}

# ================= END =================
