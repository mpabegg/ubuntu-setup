#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/mpabegg/ubuntu-setup.git"
CLONE_DIR="$HOME/.dotfiles"

# Ask for sudo password once at the beginning
echo "🔐 Requesting sudo access upfront..."
sudo -v

# Install git if not present
if ! command -v git >/dev/null 2>&1; then
  echo "📦 'git' not found. Installing it..."
  sudo apt-get update -qq > /dev/null
  sudo apt-get install -y git -qq > /dev/null
fi

echo "📥 Cloning ubuntu-setup into $CLONE_DIR..."
rm -rf "$CLONE_DIR"
git clone --depth=1 "$REPO_URL" "$CLONE_DIR" > /dev/null

echo "🚀 Running full setup..."
cd "$CLONE_DIR"
./install.sh

echo "✅ Setup completed."
