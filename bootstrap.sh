#!/bin/bash

set -euo pipefail

echo "🔧 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "✅ System updated successfully."
