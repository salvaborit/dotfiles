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

## Stack (1118 pacman packages)

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

Config files in `~/.config/hypr/`:
- `hyprland.conf` - Main (sources all others)
- `envs.conf` - Environment variables
- `input.conf` - Keyboard/mouse
- `monitors/` - Monitor layouts
- `looknfeel.conf` - Appearance
- `autostart.conf` - Startup apps

Binding files:
- `bindings.conf` - Application launchers
- `tiling-bindings.conf` - Window/workspace management
- `clipboard-bindings.conf` - Universal copy/paste
- `media-bindings.conf` - Volume/brightness/media
- `utility-bindings.conf` - Menus/toggles/notifications
- `zoom-bindings.conf` - Screen zoom

**Reload**: `hyprctl reload`

### Keybindings

**Applications** (Super+Shift+Letter):
- `Super+Return` - Terminal (cwd)
- `Super+Shift+Return` - Terminal (tmux)
- `Super+Space` - App launcher (rofi)
- `Super+Shift+F` - File manager
- `Super+Shift+B` - Browser (Alt: private)
- `Super+Shift+N` - Neovim
- `Super+Shift+O` - Obsidian
- `Super+Shift+P` - btop (Alt: htop, Ctrl: fastfetch)
- `Super+Shift+D` - Docker (lazydocker)
- `Super+Shift+M` - Music (Spotify)
- `Super+Shift+L` - LocalSend
- `Super+Shift+G` - Signal
- `Super+Shift+/` - Passwords (proton-pass)
- `Super+Shift+S` - Screenshot (Alt: fullscreen)

**Web Apps** (Super+Shift):
- `Super+Shift+A` - Claude (Alt: ChatGPT)
- `Super+Shift+C` - Calendar
- `Super+Shift+G` - GitHub
- `Super+Shift+Y` - YouTube
- `Super+Shift+W` - WhatsApp
- `Super+Shift+X` - X (Alt: X Post)

**Menus**:
- `Super+Alt+Space` - Tmux session menu
- `Super+Ctrl+Space` - Tmux project launcher
- `Super+Alt+J` - Java version switcher
- `Super+Alt+V` - VPN Manager
- `XF86Calculator` - Calculator
- `XF86Launch5` - Power profile

**Window Management**:
- `Super+W` - Close window
- `Super+F` - Fullscreen (Ctrl: tiled, Alt: full width)
- `Super+T` - Toggle floating
- `Super+J` - Toggle split
- `Super+P` - Pseudo window
- `Super+Arrows` - Move focus
- `Super+Shift+Arrows` - Swap windows
- `Super+1-9` - Switch workspace
- `Super+Shift+1-9` - Move to workspace
- `Super+Tab` - Next workspace (Shift: prev, Ctrl: previous)
- `Alt+Tab` - Cycle windows
- `Super+S` - Scratchpad (Alt+S: move to scratchpad)
- `Super+-/=` - Resize window
- `Super+Mouse` - Move/resize

**Groups**:
- `Super+G` - Toggle group
- `Super+Alt+G` - Move out of group
- `Super+Alt+Arrows` - Join group
- `Super+Alt+Tab` - Cycle group windows
- `Super+Alt+1-5` - Switch to group window

**Clipboard**:
- `Super+C` - Copy
- `Super+V` - Paste
- `Super+X` - Cut

**Media** (laptop keys):
- Volume up/down/mute (Alt: 5% increments)
- Brightness up/down (Alt: 5% increments)
- Play/pause/next/prev

**Utilities**:
- `Super+Escape` - System menu
- `Super+K` - Show keybindings
- `Super+M` - Monitor layout
- `Super+D` - Show desktop
- `Super+Backspace` - Toggle window transparency
- `Super+Shift+Ctrl+Space` - Toggle waybar
- `Super+,` - Dismiss notification (Shift: all, Ctrl: DND)

**Zoom** (Super+Mod):
- Scroll/+/- to zoom, Shift+0 to reset

### Waybar

- Config: `~/.config/waybar/config.jsonc`
- Style: `~/.config/waybar/style.css`
- Scripts: `~/.config/waybar/scripts/`

**Reload**: `killall waybar && waybar &`

### Theme System

Location: `~/.config/themes/main-theme/`
- `colors.conf` - Color scheme
- `wallpapers/` - Background images

Wallpaper set via `autostart.conf` using swaybg

## Installation Scripts

Modular package installers in `scripts/packages/`:
- `core.sh` - Base system (git, vim, yay, etc)
- `hyprland.sh` - Compositor and UI
- `terminal.sh` - Terminal tools
- `development.sh` - Dev tools
- `applications.sh` - User applications
- `fonts.sh` - Nerd fonts
- `audio.sh` - Sonic Pi (optional)
- `claude.sh` - Claude Code CLI

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

Preset layouts in `~/.config/hypr/monitors/`:
- `1a.conf` - 1 Display (integrated)
- `2a.conf` - 2 Displays
- `3a.conf` - 3 Displays
- `4a.conf`, `4b.conf` - 4 Display variants

Switch layouts: `Super+M` (rofi menu)

To add a new layout:
1. Create `~/.config/hypr/monitors/name.conf`
2. Add `# Layout: Description` as first line
3. Define monitor lines

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

