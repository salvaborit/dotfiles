#!/usr/bin/env bash
# Omarchy-specific Sonic Pi audio fix
# Fixes JACK port auto-connection for Sonic Pi on Omarchy with PipeWire
#
# This script:
# - Only runs on Omarchy OS
# - Installs required packages (jack-example-tools, sc3-plugins)
# - Deploys wrapper scripts for automatic JACK port connection
# - Makes Sonic Pi audio work out-of-the-box

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}[Sonic Pi Audio Fix]${NC} Checking if running on Omarchy..."

# Detect Omarchy OS
if ! pacman -Q omarchy-keyring &>/dev/null; then
    echo -e "${YELLOW}[Skip]${NC} Not running on Omarchy - skipping Sonic Pi audio fix"
    exit 0
fi

echo -e "${GREEN}[Omarchy Detected]${NC} Applying Sonic Pi audio fix..."

# Check if Sonic Pi is installed
if ! pacman -Q sonic-pi &>/dev/null; then
    echo -e "${YELLOW}[Info]${NC} Sonic Pi not installed - you can install it later with: sudo pacman -S sonic-pi"
fi

# Install required packages
echo -e "${BLUE}[Packages]${NC} Installing audio fix dependencies..."
PACKAGES=(
    "jack-example-tools"  # Provides jack_lsp, jack_connect for port management
    "sc3-plugins"         # SuperCollider plugins (fixes missing UGens)
)

for pkg in "${PACKAGES[@]}"; do
    if pacman -Q "$pkg" &>/dev/null; then
        echo -e "${GREEN}  ✓${NC} $pkg already installed"
    else
        echo -e "${BLUE}  →${NC} Installing $pkg..."
        sudo pacman -S --needed --noconfirm "$pkg"
    fi
done

# Deploy wrapper scripts
echo -e "${BLUE}[Scripts]${NC} Deploying audio fix scripts to ~/.local/bin/..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_SOURCE="$DOTFILES_DIR/.local/bin"
BIN_TARGET="$HOME/.local/bin"

mkdir -p "$BIN_TARGET"

# Copy and make executable
for script in supercollider-autoconnect.sh sonic-pi-with-audio; do
    if [ -f "$BIN_SOURCE/$script" ]; then
        cp "$BIN_SOURCE/$script" "$BIN_TARGET/"
        chmod +x "$BIN_TARGET/$script"
        echo -e "${GREEN}  ✓${NC} Deployed $script"
    else
        echo -e "${YELLOW}  !${NC} Warning: $script not found in dotfiles"
    fi
done

echo ""
echo -e "${GREEN}[Success]${NC} Sonic Pi audio fix applied!"
echo ""
echo -e "${BLUE}Usage:${NC}"
echo "  Launch Sonic Pi with audio: ~/.local/bin/sonic-pi-with-audio"
echo "  Or create an alias in your shell config:"
echo "    alias sonic-pi='~/.local/bin/sonic-pi-with-audio'"
echo ""
echo -e "${BLUE}What was fixed:${NC}"
echo "  • SuperCollider JACK ports now auto-connect to system audio"
echo "  • PipeWire JACK emulation works seamlessly"
echo "  • No manual port connection needed"
echo ""
