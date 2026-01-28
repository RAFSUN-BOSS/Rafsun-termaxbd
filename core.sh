# ================= RAFSUN HACKER PAD =================

# -------- Config --------
REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"
VERSION_FILE="$REPO_DIR/version.txt"
APP_LOCK="$HOME/.rafspad_run.lock"

# -------- Prevent double sourcing in same shell --------
[ -n "$RAFSPAD_LOADED" ] && return
export RAFSPAD_LOADED=1

# -------- App run lock (persistent across tabs) --------
if [ ! -f "$APP_LOCK" ]; then
    touch "$APP_LOCK"

    # -------- Load local version --------
    LOCAL_VERSION="0.0"
    [ -f "$VERSION_FILE" ] && LOCAL_VERSION=$(cat "$VERSION_FILE")

    # -------- Check for updates --------
    LATEST_VERSION=$(curl -fs https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt 2>/dev/null)

    if [[ -n "$LATEST_VERSION" && "$LOCAL_VERSION" != "$LATEST_VERSION" ]]; then
        echo
        echo "[!] Update available: $LATEST_VERSION (current $LOCAL_VERSION)"
        echo "1) Update now"
        echo "2) Skip"
        read -p "Select option: " choice

        if [[ "$choice" == "1" ]]; then
            tmpdir="$HOME/.rafspad_update"
            rm -rf "$tmpdir"

            if git clone "$REPO_URL" "$tmpdir" >/dev/null 2>&1; then
                rm -rf "$REPO_DIR"
                mv "$tmpdir" "$REPO_DIR"
                echo "[✓] Update complete. Restarting shell..."
                rm -f "$APP_LOCK"  # Remove lock so next session re-inits
                exec bash
            else
                echo "[X] Update failed. Keeping current version."
                rm -rf "$tmpdir"
            fi
        fi
    fi

    # -------- Print banner once --------
    if [ -f "$REPO_DIR/banner.sh" ]; then
        source "$REPO_DIR/banner.sh"
        banner
    fi
fi

# -------- Prompt --------
PS1="=>> "

# -------- Clear (safe) --------
cls() {
    command clear
    [ -f "$REPO_DIR/banner.sh" ] && banner
}
alias clear='cls'

# -------- Help --------
h() {
cat <<'EOF'
HACKER PAD HELP

Commands:
  cls / clear      → clear screen
  h / help         → show help
  go <path>        → jump directory

Features:
  • Run .py directly without python command
  • Run .sh directly without bash command
  • Use full path for scripts

Creator : RAFSUN-BOSS
EOF
}
alias help='h'

# -------- Go to directory --------
go() {
    [ -d "$1" ] && cd "$1" || echo "Path not found"
}

# -------- Auto-run scripts on command not found --------
command_not_found_handle() {
    case "$1" in
        *.py) [ -f "$1" ] && python "$1" && return 0 ;;
        *.sh) [ -f "$1" ] && bash "$1" && return 0 ;;
    esac
    return 127
}

# ================= END =================
