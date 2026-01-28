# ==== HACKER PAD CONFIG START ====

# Run banner
if [ -f "$HOME/.hackerpad/banner.sh" ]; then
  bash "$HOME/.hackerpad/banner.sh"
fi

# Auto cd support
set -o autocd

# go command
go () {
  cd "$1" 2>/dev/null || echo "❌ Path not found"
}

# Auto-run python files
runpy () {
  chmod +x "$1"
  ./"$1"
}

# ==== HACKER PAD CONFIG END ====
