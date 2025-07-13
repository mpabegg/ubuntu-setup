#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/mpabegg/ubuntu-setup.git"
CLONE_DIR="$HOME/.dotfiles"

# Install git if not present
if ! command -v git >/dev/null 2>&1; then
  echo "📦 'git' not found. Installing it..."
  sudo apt-get update -qq > /dev/null
  sudo apt-get install -y git -qq > /dev/null
fi

echo "📥 Cloning ubuntu-setup into $CLONE_DIR..."
rm -rf "$CLONE_DIR"
git clone --quiet --depth=1 "$REPO_URL" "$CLONE_DIR"

echo "🚀 Running full setup..."
cd "$CLONE_DIR"
./install.sh

echo "✅ Setup completed."
