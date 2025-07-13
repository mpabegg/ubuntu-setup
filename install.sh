#!/bin/bash
set -euo pipefail

# -------------------------------
# 🔧 STEP 1: Update the system
# -------------------------------
echo "🔧 Updating system..."
sudo apt-get update -qq > /dev/null && sudo apt-get upgrade -y -qq > /dev/null
echo "✅ System updated."


# -------------------------------
# 📦 STEP 2: Install CLI essentials
# -------------------------------
echo "📦 Installing CLI essentials..."
sudo apt-get install -y -qq > /dev/null \
  git wget curl unzip gnupg ca-certificates \
  build-essential software-properties-common
echo "✅ CLI essentials installed."


# -------------------------------
# 🖥️ STEP 3: Install system utilities
# -------------------------------
echo "🖥️ Installing system utilities..."
sudo apt-get install -y -qq > /dev/null \
  htop neofetch p7zip-full tree lsb-release
echo "✅ System utilities installed."


# -------------------------------
# 🧑‍💻 STEP 4: Install developer tools
# -------------------------------
echo "🧑‍💻 Installing developer tools..."
sudo apt-get install -y -qq > /dev/null \
  zsh tmux jq fzf ripgrep bat fd-find stow
echo "✅ Developer tools installed."


# -------------------------------
# 🔗 STEP 5: Stow dotfiles (zsh, tmux)
# -------------------------------
echo "🔗 Linking dotfiles (zsh, tmux)..."
cd "$(dirname "$0")"

[ -d "zsh" ] && stow zsh || echo "⚠️  Skipping zsh: directory not found"
[ -d "tmux" ] && stow tmux || echo "⚠️  Skipping tmux: directory not found"

echo "✅ Dotfiles linked."


# -------------------------------
# 🔐 STEP 6: Install 1Password
# -------------------------------
echo "🔐 Installing 1Password..."

TEMP_KEYRING="/tmp/1password-archive-keyring.gpg"

curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  gpg --dearmor > "$TEMP_KEYRING"

sudo install -o root -g root -m 644 "$TEMP_KEYRING" /usr/share/keyrings/1password-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] \
https://downloads.1password.com/linux/debian stable main" | \
  sudo tee /etc/apt/sources.list.d/1password.list > /dev/null

sudo apt-get update -qq > /dev/null
sudo apt-get install -y 1password -qq > /dev/null

echo "✅ 1Password installed."


# -------------------------------
# 🐚 STEP 7: Set Zsh as default shell
# -------------------------------
echo "🐚 Setting Zsh as the default shell..."

if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
  echo "✅ Zsh is now the default shell (you may need to log out and log in again)."
else
  echo "✅ Zsh is already the default shell."
fi
