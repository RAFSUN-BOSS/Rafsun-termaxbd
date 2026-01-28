banner() {

VERSION=$(cat "$HOME/Rafsun-termaxbd/version.txt" 2>/dev/null)

echo -e "\033[1;36m"
cat <<'EOF'
 _   _    _    ____ _  __ _____ ____  
| | | |  / \  / ___| |/ /| ____|  _ \  
| |_| | / _ \| |   | ' / |  _| | |_) |  
|  _  |/ ___ \ |___| . \ | |___|  _ <  
|_| |_/_/   \_\____|_|\_\|_____|_| \_\  
EOF
echo -e "\033[1;35m              RAFSUN-BOSS"
echo -e "\033[1;33mAuthor  : Rafsun Boss"
echo -e "\033[1;32mVersion : $VERSION"
echo -e "\033[0m"
}
