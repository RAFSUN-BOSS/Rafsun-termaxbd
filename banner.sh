# ================= RAFSUN HACKER PAD BANNER =================

banner() {
    VERSION="0.0"
    VERSION_FILE="$HOME/Rafsun-termaxbd/version.txt"
    [ -f "$VERSION_FILE" ] && VERSION=$(cat "$VERSION_FILE")

    echo -e "\e[1;32m _   _    _    ____ _  __ _____ ____"
    echo -e "| | | |  / \\  / ___| |/ /| ____|  _ \\"
    echo -e "| |_| | / _ \\| |   | ' / |  _| | |_) |"
    echo -e "|  _  |/ ___ \\ |___| . \\ | |___|  _ <"
    echo -e "|_| |_/_/   \\_\\____|_|\\_\\|_____|_| \\_\\"
    echo -e "              RAFSUN-BOSS\e[0m"
    echo -e "Author  : Rafsun Boss"
    echo -e "Version : $VERSION\n"
    echo -e "Initializing 100% ✔"
    echo -e "Loading Environment 100% ✔\n"
}
