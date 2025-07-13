#!/bin/bash

set -euo pipefail

echo "🔧 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "✅ System updated successfully."

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

echo "🖥️ Installing system utilities..."

sudo apt install -y \
  htop \
  neofetch \
  p7zip-full \
  tree \
  lsb-release

echo "✅ System utilities installed."
