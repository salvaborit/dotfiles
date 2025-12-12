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

### Window Manager & UI
- **Hyprland** - Wayland compositor
- **Waybar** - Status bar with system monitoring
- **Rofi** - Menu
- **Mako** - Notification daemon

### Terminal/Shell
- **Alacritty** - Terminal
- **Starship** - Shell prompt
- **Bash** - Shell with some aliases

### Development Tools
- **Docker** + lazydocker
- **Git** + lazygit
- **Vim** - Text editor

### Applications
- **Chromium** - Web browser
- **Obsidian** - Note taking
- **Nautilus** - File manager

## Configuration

### Hyprland

All Hyprland configs are in `~/.config/hypr/`:
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
- `Super+Shift+T` - System monitor (btop)
- `Super+Shift+D` - Docker manager
- `Super+Shift+A` - Claude AI
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

