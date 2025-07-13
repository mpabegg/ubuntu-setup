#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/mpabegg/ubuntu-setup.git"
CLONE_DIR="$HOME/.dotfiles"

# Ask for sudo password and keep session alive
echo "🔐 Requesting sudo access upfront..."
sudo -v
( while true; do sudo -n true; sleep 60; done ) 2>/dev/null &
SUDO_REFRESH_PID=$!

# Install git if not present
if ! command -v git >/dev/null 2>&1; then
  echo "📦 'git' not found. Installing it..."
  sudo apt-get update -qq > /dev/null
  sudo apt-get install -y git -qq > /dev/null
fi

echo "📥 Cloning ubuntu-setup into $CLONE_DIR..."
rm -rf "$CLONE_DIR"
git clone --depth=1 "$REPO_URL" "$CLONE_DIR" > /dev/null 2>&1

echo "🚀 Running full setup..."
cd "$CLONE_DIR"
./install.sh

# Kill the sudo keep-alive loop
kill "$SUDO_REFRESH_PID"

echo "✅ Setup completed."
