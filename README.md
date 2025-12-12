# Arch + Hyprland

Dotfiles for Arch Linux with Hyprland.

## Quick Start

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Run installation
./install.sh
```

This will:
1. Install all required packages via pacman
2. Stow configurations
3. Set up custom wrapper scripts
4. Configure theme

## Structure

```
dotfiles/
├── shell/              # Shell configs (.bashrc, .vimrc)
├── hyprland/           # Hyprland window manager
├── waybar/             # Status bar
├── terminal/           # Alacritty + Starship
├── walker/             # Application launcher
├── themes/             # Centralized theme system
├── scripts-local/      # Custom wrapper scripts
├── applications/       # Desktop entries
└── scripts/            # Installation scripts
    ├── common.sh       # Shared functions
    └── packages/       # Per-program installers
```

## Core Stack

### Core System (`core.sh`)
- **git**
- **base-devel** - Build tools (make, gcc)
- **vim**
- **tree**
- **unzip**
- **less**
- **ufw**
- **man-db**
- **upower** - Power management

### Window Manager & UI (`hyprland.sh`)
- **Hyprland** - Wayland compositor
- **Waybar** - Status bar
- **Rofi** - App launcher and menus
- **Mako** - Notification daemon
- **Swaylock** - Screen locker (legacy)
- **Hyprlock** - Screen locker (Hyprland-native)
- **Hypridle** - Idle management
- **Hyprsunset** - Screen temperature (night light)
- **Swaybg** - Wallpaper daemon
- **Grim** - Screenshot capture
- **Slurp** - Region selector
- **Satty** - Screenshot annotation
- **wl-clipboard** - Clipboard manager
- **jq** - JSON processor for scripts
- **polkit-kde-agent** - Authentication dialogs
- **xdg-desktop-portal-hyprland** - Desktop integration
- **Qt5/Qt6 Wayland** - Qt app support
- **Xwayland** - X11 compatibility
- **Blueberry** - Bluetooth manager
- **Wiremix** - Audio mixer
- **Brightnessctl** - Brightness control
- **SwayOSD** - On-screen display
- **ImageMagick** - Image processing
- **FFmpeg** - Video processing
- **v4l-utils** - Webcam support
- **Keyd** - System-wide key remapping
- **gpu-screen-recorder** (AUR) - Hardware accelerated recording
- **wayfreeze** (AUR) - Screen freeze for screenshots

### Terminal & Shell (`terminal.sh`)
- **Alacritty** - Terminal
- **Starship** - Shell prompt
- **Btop** - System monitor
- **Cava** - Audio visualizer
- **Eza** - ls
- **Tmux** - Terminal multiplexer

### Development Tools (`development.sh`)
- **Neovim** - Editor
- **Lazygit** - Git TUI
- **Subversion** - SVN version control
- **LFTP** - FTP client
- **Tcpdump** - Network packet analyzer
- **Zip** - Archive creation
- **GHC** - Haskell compiler
- **Docker/Compose/Buildx** - Container platform
- **Lazydocker** - Docker TUI
- **JDK 8/21/latest** - JDKs
- **Maven** - Java build tool
- **Ant** - Java build tool
- **Netbeans** - Java IDE
- **Node.js LTS** - JavaScript runtime
- **npm** - Node package manager
- **DBeaver** - Database GUI
- **Gemini CLI** - Google AI assistant
- **Firefox** - Web browser
- **QEMU** - Machine emulator
- **Libvirt/Virt-manager** - VM management
- **WireGuard** - VPN
- **Postman** (AUR) - API testing
- **IntelliJ IDEA Ultimate** (AUR) - Java IDE
- **TLClient** (AUR) - Remote desktop

### Applications (`applications.sh`)
- **Obsidian** - Notes
- **Fastfetch** - System info display
- **Nautilus** - File browser
- **Chromium** - Web browser
- **LibreOffice**
- **Spotify**
- **Discord**
- **VLC** - Media player
- **power-profiles-daemon** - Power management
- **Slack** (AUR)
- **LocalSend** (AUR) - Local file sharing
- **Teams** (AUR) - MS Teams
- **FortiClient VPN** (AUR)
- **Zoom** (AUR)
- **Balena Etcher** (AUR)

### Fonts (`fonts.sh`)
- **Cascadia Code Nerd** - Microsoft's coding font
- **Fira Code Nerd** - Ligature font
- **JetBrains Mono Nerd** - JetBrains font
- **SF Mono Nerd** (custom) - Apple's monospace font

### Audio (`audio.sh`) - optional
- **SuperCollider** - Audio synthesis
- **PipeWire** - Audio server
- **Sonic Pi** (AUR) - Live coding music

## Configuration

### Hyprland

All Hyprland configs in `~/.config/hypr/`:
- `hyprland.conf` - Main config (sources all others)
- `bindings.conf` - Keybindings (Super+Shift+Letter pattern)
- `monitors.conf` - Multi-monitor setup
- `looknfeel.conf` - Appearance (gaps, rounding, blur)
- `input.conf` - Keyboard and mouse
- `envs.conf` - Environment variables
- `autostart.conf` - Startup applications

**Reload config**: `hyprctl reload`

### Keybindings

All application bindings use Super+Shift+Letter:
- `Super+Return` - Terminal (in current directory)
- `Super+Shift+F` - File manager
- `Super+Shift+B` - Browser
- `Super+Shift+O` - Obsidian
- `Super+Shift+P` - System monitor (btop)
- `Super+Shift+D` - Docker manager
- `Super+Shift+A` - AI (add alt for alt AI)
- `Super+Space` - App launcher

See `~/.config/hypr/bindings.conf` for complete list.

### Waybar

Configuration: `~/.config/waybar/config.jsonc`
Styling: `~/.config/waybar/style.css`
Scripts: `~/.config/waybar/scripts/`

**Reload**: `killall waybar && waybar &`

### Theme System

Centralized theme in `~/.config/themes/main-theme/`:
- `colors.conf` - Central color definitions
- `wallpapers/` - Background images
- Per-app theme overrides

To change wallpaper:
1. Add image to `~/.config/themes/main-theme/wallpapers/`
2. Update `~/.config/hypr/autostart.conf`

## Installation Scripts

Modular package installers in `scripts/packages/`:
- `core.sh` - Base system (git, vim, yay, etc)
- `hyprland.sh` - Compositor
- `terminal.sh` - Terminal tools
- `development.sh` - Dev tools
- `applications.sh` - User applications
- `fonts.sh` - Nerd fonts
- `audio.sh` - Sonic Pi (optional)
- `claude.sh` - Claude

They can be run individually.

## Stow Management

Deploy all configs:
```bash
stow shell hyprland waybar terminal walker themes scripts-local applications
```

Deploy specific package:
```bash
stow hyprland
```

Remove (unstow) package:
```bash
stow -D hyprland
```

## Customization

### Adding New Keybinding

Edit `~/.config/hypr/bindings.conf`:
```conf
bindd = SUPER SHIFT, X, Description, exec, your-command
```

### Multi-Monitor Setup

Edit `~/.config/hypr/monitors.conf`:
```conf
monitor = HDMI-A-1, 1920x1080@60, 0x0, 1
monitor = eDP-1, 1920x1080@60, 0x1080, 1
```

## Troubleshooting

### Hyprland won't start
- Check logs: `journalctl -u display-manager -e`
- Verify configs: `hyprland -c ~/.config/hypr/hyprland.conf`

### Waybar not showing
- Check if running: `pgrep waybar`
- Restart: `killall waybar && waybar &`
- Logs: `waybar -l debug`

### Keybindings not working
- Verify scripts are executable: `chmod +x ~/.local/bin/*`
- Check script path: `which launch-browser`
- Test: `launch-browser`

### Applications not launching
- Verify package installed: `pacman -Q <package>`
- Check name: `which <app>`

