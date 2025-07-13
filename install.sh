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
  zsh tmux jq fzf ripgrep bat fd-find stow eza
echo "✅ Developer tools installed."


# -------------------------------
# 🔗 STEP 5: Stow all dotfiles
# -------------------------------
echo "🔗 Linking dotfiles..."
cd "$(dirname "$0")"

for dir in */; do
  # Skip non-directories and known script files
  [[ "$dir" == "bootstrap.sh/" || "$dir" == "install.sh/" ]] && continue
  [[ -f "$dir/.stowignore" ]] && continue

  if [ -d "$dir" ]; then
    echo "➡️  Stowing: $dir"
    stow "$dir"
  fi
done

echo "✅ All dotfiles linked."

# -------------------------------
# 🔐 STEP 6: Install 1Password
# -------------------------------
echo "🔐 Installing 1Password..."

KEYRING_FILE="/usr/share/keyrings/1password-archive-keyring.gpg"
TEMP_KEYRING="/tmp/1password-archive-keyring.gpg"

# Download and dearmor
curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | \
  gpg --dearmor -o "$TEMP_KEYRING"

sudo install -o root -g root -m 644 "$TEMP_KEYRING" "$KEYRING_FILE"

# Add the correct repo (note the /amd64 path)
echo "deb [arch=$(dpkg --print-architecture) signed-by=$KEYRING_FILE] \
https://downloads.1password.com/linux/debian/amd64 stable main" | \
  sudo tee /etc/apt/sources.list.d/1password.list > /dev/null

# Add the debsig policy as per support docs
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
sudo curl -fsSL https://downloads.1password.com/linux/debian/debsig/1password.pol \
  | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol > /dev/null

sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -fsSL https://downloads.1password.com/linux/keys/1password.asc \
  | gpg --dearmor | sudo tee /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg > /dev/null

sudo apt-get update -qq > /dev/null
sudo apt-get install -y 1password -qq > /dev/null || {
  echo "❌ 1Password installation failed."
  exit 1
}

echo "✅ 1Password installed."


# -------------------------------
# 🐚 STEP 7: Set Zsh as default shell
# -------------------------------
echo "🐚 Setting Zsh as the default shell..."

if [[ "$SHELL" != "$(which zsh)" ]]; then
  sudo chsh -s "$(which zsh)" "$USER" 
  echo "✅ Zsh is now the default shell (you may need to log out and log in again)."
else
  echo "✅ Zsh is already the default shell."
fi

# -------------------------------
# 🌠 STEP 8: Install Starship prompt
# -------------------------------
echo "🌠 Installing Starship prompt..."

curl -fsSL https://starship.rs/install.sh | sh -s -- -y > /dev/null
echo "✅ Starship installed."

# -------------------------------
# 📝 STEP 9: Install Zed editor
# -------------------------------
echo "📝 Installing Zed editor..."

if curl -fsSL https://zed.dev/install.sh | sh > /dev/null 2>&1; then
  echo "✅ Zed installed."
else
  echo "❌ Zed installation failed."
fi

# -------------------------------
# 🔤 STEP 10: Install custom fonts from Google Drive
# -------------------------------
echo "🔤 Installing custom fonts..."

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Install gdown if not available
if ! command -v gdown &>/dev/null; then
  echo "📥 Installing gdown..."
  sudo apt-get install -y gdown > /dev/null
fi

# Replace with your actual file ID from Google Drive
FONT_FILE_ID="1BKd0LnsDXyIeo0ABKhnOHd5Iez2is69Z"
FONT_ZIP="/tmp/custom_fonts.zip"

# Download silently
gdown --id "$FONT_FILE_ID" -O "$FONT_ZIP" > /dev/null 2>&1

# Unzip and refresh font cache
unzip -q "$FONT_ZIP" -d "$FONT_DIR"
fc-cache -f > /dev/null

echo "✅ Custom fonts installed."
