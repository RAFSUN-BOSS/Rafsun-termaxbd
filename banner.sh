banner() {
clear

VERSION_FILE="$HOME/Rafsun-termaxbd/version.txt"
VERSION="unknown"
[ -f "$VERSION_FILE" ] && VERSION=$(cat "$VERSION_FILE")

cat <<EOF
 _   _    _    ____ _  __ _____ ____
| | | |  / \  / ___| |/ /| ____|  _ \\
| |_| | / _ \| |   | ' / |  _| | |_) |
|  _  |/ ___ \\ |___| . \\ | |___|  _ <
|_| |_/_/   \\_\\____|_|\\_\\|_____|_| \\_\\
              RAFSUN-BOSS
Author  : Rafsun Boss
Version : $VERSION

EOF
}
