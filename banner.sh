banner() {

VERSION_FILE="$HOME/Rafsun-termaxbd/version.txt"
VERSION="unknown"
[ -f "$VERSION_FILE" ] && VERSION=$(cat "$VERSION_FILE")

# -------- RGB function --------
rgb() {
    printf "\033[38;2;%s;%s;%sm" "$1" "$2" "$3"
}

reset="\033[0m"

clear

# -------- Banner --------
echo -e "$(rgb 255 0 0) _   _    _    ____ _  __ _____ ____$(reset)"
echo -e "$(rgb 255 80 0)| | | |  / \\  / ___| |/ /| ____|  _ \\$(reset)"
echo -e "$(rgb 255 160 0)| |_| | / _ \\| |   | ' / |  _| | |_) |$(reset)"
echo -e "$(rgb 0 255 120)|  _  |/ ___ \\ |___| . \\ | |___|  _ <$(reset)"
echo -e "$(rgb 0 180 255)|_| |_/_/   \\_\\____|_|\\_\\|_____|_| \\_\\$(reset)"

echo -e "$(rgb 180 0 255)              RAFSUN-BOSS$(reset)"
echo -e "$(rgb 200 200 200)Author  : Rafsun Boss$(reset)"
echo -e "$(rgb 200 200 200)Version : $VERSION$(reset)"
echo
}
