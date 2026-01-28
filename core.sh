#!/data/data/com.termux/files/usr/bin/bash
# ================= RAFSUN HACKER PAD =================
set +e

REPO_DIR="$HOME/Rafsun-termaxbd"
REPO_URL="https://github.com/RAFSUN-BOSS/Rafsun-termaxbd.git"
VERSION_FILE="$REPO_DIR/version.txt"
UPDATE_FLAG="/tmp/.rafsun_update_checked"

# -------- Hard version read (NO GUESSING) --------
if [ -f "$VERSION_FILE" ]; then
    LOCAL_VERSION="$(tr -d ' \n\r' < "$VERSION_FILE")"
else
    LOCAL_VERSION="UNKNOWN"
fi

# -------- Silent update check (ONCE per shell) --------
check_update() {
    [ -f "$UPDATE_FLAG" ] && return
    touch "$UPDATE_FLAG"

    LATEST_VERSION="$(curl -fs https://raw.githubusercontent.com/RAFSUN-BOSS/Rafsun-termaxbd/main/version.txt | tr -d ' \n\r')"

    # If fetch failed or same version → do NOTHING
    [ -z "$LATEST_VERSION" ] && return
    [ "$LOCAL_VERSION" = "$LATEST_VERSION" ] && return

    echo
    echo "Update available"
    echo "Installed : $LOCAL_VERSION"
    echo "Latest    : $LATEST_VERSION"
    echo
    echo "1) Update now"
    echo "2) Continue"
    read -p "Select option: " choice

    if [ "$choice" = "1" ]; then
        rm -rf "$REPO_DIR"
        git clone "$REPO_URL" "$REPO_DIR" >/dev/null 2>&1

        sed -i '/Rafsun-termaxbd\/core.sh/d' ~/.bashrc
        echo 'source $HOME/Rafsun-termaxbd/core.sh' >> ~/.bashrc

        exec bash
    fi
}

check_update

# -------- Load banner (ONLY ONCE) --------
if [ -f "$REPO_DIR/banner.sh" ]; then
    source "$REPO_DIR/banner.sh"
    banner
fi

# -------- Prompt --------
PS1="=>> "

# -------- Clear (NO recursion, NO alias loop) --------
c() {
    command clear
    banner
}

alias clear='c'

# -------- Help --------
h() {
cat <<EOF
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
Version : $LOCAL_VERSION
EOF
}
alias help='h'

# -------- Go --------
go() {
    if [ -d "$1" ]; then
        cd "$1"
    else
        echo "Path not found"
    fi
}

# -------- Script auto-run --------
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
