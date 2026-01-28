# ================= RAFSUN HACKER PAD =================

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"
VERSION_FILE="$REPO_DIR/version.txt"

# -------- Get local version --------
LOCAL_VERSION="0.0"
[ -f "$VERSION_FILE" ] && LOCAL_VERSION="$(cat "$VERSION_FILE")"

# -------- Get latest version --------
LATEST_VERSION="$(curl -fs https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt)"

# -------- Update check BEFORE anything else --------
if [[ -n "$LATEST_VERSION" && "$LOCAL_VERSION" != "$LATEST_VERSION" ]]; then
    echo
    echo "New update available"
    echo "1) Update now (FULL RESET)"
    echo "2) Continue without update"
    read -p "Select option: " choice

    if [[ "$choice" == "1" ]]; then
        echo
        echo "Resetting system..."

        # FULL DELETE (no mercy)
        rm -rf "$REPO_DIR"

        # Fresh clone
        git clone "$REPO_URL" "$REPO_DIR" >/dev/null 2>&1

        # Clean old bashrc entry
        sed -i '/Rafsun-termaxbd\/core.sh/d' ~/.bashrc

        # Add new source
        echo 'source $HOME/Rafsun-termaxbd/core.sh' >> ~/.bashrc

        # Hard restart shell (no old memory)
        exec bash
    fi
fi

# -------- Load banner ONLY ONCE --------
#if [ -f "$REPO_DIR/banner.sh" ]; then
    #source "$REPO_DIR/banner.sh"
    #banner
#fi

# -------- Prompt --------


# Default prompt function
prompt() {
    if [ -d "$PWD" ]; then
        if [ "$PWD" = "$HOME" ]; then
            # Home directory → green prompt
            printf "\[\033[38;2;0;255;120m\]=>>\[\033[0m\] "
            return
        fi

        # Other directories → show last folder
        local last_dir
        last_dir=$(basename "$PWD")
        printf "\[\033[38;2;0;255;120m\]=>>%s->\[\033[0m\] " "$last_dir"
    else
        # Broken directory → red prompt
        printf "\[\033[38;2;255;80;80m\]=>>BROKEN->\[\033[0m\] "
    fi
}

# Assign PS1 using command substitution
PS1='$(prompt)'

# -------- Clear --------
c() { clear; }
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
    if [ "$#" -eq 0 ]; then
        echo "Usage: go <path>"
        return 1
    fi

    local target="$*"

    if [ -d "$target" ]; then
        cd "$target" || return
    else
        echo "Path not found"
    fi
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
