banner() {
    [ -n "$_BANNER_ONCE" ] && return
    _BANNER_ONCE=1

    VERSION=$(cat "$HOME/Rafsun-termaxbd/version.txt" 2>/dev/null)

    cat <<EOF
 _   _    _    ____ _  __ _____ ____
| | | |  / \  / ___| |/ /| ____|  _ \
| |_| | / _ \| |   | ' / |  _| | |_) |
|  _  |/ ___ \ |___| . \ | |___|  _ <
|_| |_/_/   \_\____|_|\_\|_____|_| \_\
              RAFSUN-BOSS
Author  : Rafsun Boss
Version : $VERSION
EOF
}
