#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/mpabegg/ubuntu-setup.git"
CLONE_DIR="$HOME/.dotfiles"

echo "📥 Cloning ubuntu-setup into $CLONE_DIR..."
rm -rf "$CLONE_DIR"
git clone --depth=1 "$REPO_URL" "$CLONE_DIR"

echo "🚀 Running full setup..."
cd "$CLONE_DIR"
./install.sh

echo "✅ Setup completed."
