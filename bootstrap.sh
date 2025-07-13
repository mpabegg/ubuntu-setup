#!/bin/bash

set -euo pipefail

# -------------------------------
# 🧩 STEP 1: Update the system
# -------------------------------
echo "🔧 Updating system..."
sudo apt update && sudo apt upgrade -y
echo "✅ System updated successfully."


# -------------------------------
# 📦 STEP 2: Install CLI essentials
# -------------------------------
echo "📦 Installing CLI essentials..."

sudo apt install -y \
  git \
  wget \
  curl \
  unzip \
  gnupg \
  ca-certificates \
  build-essential \
  software-properties-common

echo "✅ CLI essentials installed."


# -------------------------------
# 🖥️ STEP 3: Install system utilities
# -------------------------------
echo "🖥️ Installing system utilities..."

sudo apt install -y \
  htop \
  neofetch \
  p7zip-full \
  tree \
  lsb-release

echo "✅ System utilities installed."


# -------------------------------
# 🧑‍💻 STEP 4: Install developer tools
# -------------------------------
echo "🧑‍💻 Installing developer tools..."

sudo apt install -y \
  zsh \
  tmux \
  jq \
  fzf \
  ripgrep \
  bat \
  fd-find \
  stow

echo "✅ Developer tools installed."


# -------------------------------
# 🔗 STEP 5: Stow local dotfiles (zsh, tmux)
# -------------------------------
echo "🔗 Linking local zsh and tmux dotfiles (if present)..."

cd "$(dirname "$0")"

[ -d "zsh" ] && stow zsh || echo "⚠️  Skipping zsh: directory not found"
[ -d "tmux" ] && stow tmux || echo "⚠️  Skipping tmux: directory not found"

echo "✅ Dotfile linking step completed."
