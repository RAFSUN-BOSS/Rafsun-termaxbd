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
prompt() {
    if [ -d "$PWD" ]; then
        if [ "$PWD" = "$HOME" ]; then
            # Home directory → simple prompt
            printf "=> "
            return
        fi

        # Other directories → show last folder
        local last_dir
        last_dir=$(basename "$PWD")
        printf "=>%s-> " "$last_dir"
    else
        # Broken directory
        printf "=>BROKEN-> "
    fi
}

# Assign PS1
PS1='$(prompt)'
# -------- Prompt --------


# Default prompt function

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
# -------- Git Clone Shortcut --------
cn() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: cn <git-repo-url>"
        return 1
    fi

    if ! command -v git >/dev/null 2>&1; then
        echo "git is not installed"
        return 1
    fi

    echo "Cloning repository..."
    git clone "$1"
}
# Run python script without typing python
py() {
    if [ -f "$1" ]; then
        python "$1"
    else
        echo "File not found"
    fi
}

# Run bash script without typing bash
sh() {
    if [ -f "$1" ]; then
        bash "$1"
    else
        echo "File not found"
    fi
}

# Force update shortcut
update() {
    source $HOME/Rafsun-termaxbd/core.sh
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
