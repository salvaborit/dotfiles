# Omarchy Feature Migration Status

## Completed Features

### ✅ Clipboard System
- **Universal copy/paste**: Super+C/V/X shortcuts configured
- **Clipboard history**: Super+Ctrl+V opens walker clipboard manager
- **Location**: `.config/hypr/clipboard-bindings.conf`
- **Dependencies**: elephant, elephant-clipboard (needs manual installation)

### ✅ Toggle Scripts
- `toggle-waybar`: Show/hide status bar
- `toggle-hypridle`: Enable/disable idle lock
- `toggle-nightlight`: Switch screen temperature (4000K/6000K)
- **Location**: `.local/bin/toggle-*`

### ✅ Screenshot Tool
- Smart selection with window/monitor hints
- Region, windows, and fullscreen modes
- Satty annotation editor integration
- Clipboard support
- **Location**: `.local/bin/screenshot`
- **Dependencies**: slurp, grim, satty, wayfreeze, wl-clipboard, jq

### ✅ Screenrecord Tool
- Region and full-output recording
- Audio mixing (input+output)
- Webcam overlay support
- **Location**: `.local/bin/screenrecord`
- **Dependencies**: gpu-screen-recorder, slurp, ffplay, v4l2-ctl, jq

### ✅ Keybinding Viewer
- Interactive searchable keybinding browser
- Categorized and prioritized display
- **Location**: `.local/bin/show-keybindings`
- **Dependencies**: walker, jq, xkbcli

### ✅ Theme System
- Multi-theme support with symlink-based switching
- Component restart automation
- **Location**: `.local/bin/theme-*`
- **Theme directory**: `.config/themes/`

### ✅ System Menu
- Unified walker-based menu
- Screenshot, screenrecord, toggle, theme, power options
- **Location**: `.local/bin/system-menu`

## Required Installations

### Critical (For Clipboard)
```bash
yay -S elephant elephant-clipboard
```

### Screenshot/Screenrecord
```bash
# Core tools
sudo pacman -S slurp grim wl-clipboard jq

# Optional but recommended
yay -S satty wayfreeze gpu-screen-recorder
```

### System Tools
```bash
# Already likely installed
sudo pacman -S hyprpicker hyprsunset ffmpeg v4l-utils
```

## Configuration Integration

### Update hyprland.conf
Add this line to source clipboard bindings:
```bash
source = ~/.config/hypr/clipboard-bindings.conf
```

Or integrate into existing hyprland setup by copying relevant sections.

### Verify Autostart
`.config/hypr/autostart.conf` includes:
- elephant
- walker --gapplication-service
- waybar, mako, hypridle, swaybg

### Add PATH
Ensure `~/.local/bin` is in your PATH (usually automatic, but verify):
```bash
echo $PATH | grep -q "$HOME/.local/bin" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

## Setup Theme System

### Create First Theme
```bash
# Create theme directory structure
mkdir -p ~/.config/themes/catppuccin

# Add theme files (examples)
# - alacritty.toml
# - waybar.css
# - hyprland.conf
# - btop.theme
# - wallpaper.jpg
# - mako.conf
# etc.

# Set as active theme
theme-set catppuccin
```

### Theme File Structure
Each theme in `~/.config/themes/<theme-name>/` can contain:
- `alacritty.toml` - Terminal colors
- `waybar.css` - Status bar theme
- `hyprland.conf` - Window manager colors/borders
- `btop.theme` - System monitor theme
- `mako.conf` - Notification theme
- `wallpaper.jpg` - Background image
- `kitty.conf` - Kitty terminal theme (if using)

Current theme is symlinked at `~/.config/themes/current`

## Keybinding Suggestions

Add these to `.config/hypr/bindings.conf`:
```bash
# Clipboard (from clipboard-bindings.conf)
bind = SUPER, C, sendshortcut, CTRL, Insert
bind = SUPER, V, sendshortcut, SHIFT, Insert
bind = SUPER, X, sendshortcut, CTRL, X
bind = SUPER CTRL, V, exec, walker -m clipboard

# Utilities
bind = SUPER SHIFT, S, exec, screenshot smart
bind = SUPER SHIFT, R, exec, screenrecord region
bind = SUPER SHIFT, question, exec, show-keybindings
bind = SUPER, SPACE, exec, system-menu

# Toggles
bind = SUPER ALT, W, exec, toggle-waybar
bind = SUPER ALT, I, exec, toggle-hypridle
bind = SUPER ALT, N, exec, toggle-nightlight

# Theme
bind = SUPER ALT, T, exec, system-menu  # Opens to theme submenu
```

## Testing Checklist

- [ ] Install elephant + elephant-clipboard
- [ ] Verify walker is running: `pgrep walker`
- [ ] Test Super+C and Super+V in terminal and GUI apps
- [ ] Test Super+Ctrl+V clipboard history
- [ ] Test screenshot: `screenshot smart`
- [ ] Test screenrecord: `screenrecord region`
- [ ] Test keybinding viewer: `show-keybindings`
- [ ] Create a theme and test switching: `theme-set <name>`
- [ ] Test system menu: `system-menu`
- [ ] Test toggles: `toggle-waybar`, `toggle-hypridle`, `toggle-nightlight`

## Differences from Omarchy

### Removed
- uwsm/uwsm-app wrapper (using direct commands)
- Omarchy-specific paths and branding
- Browser/VSCode/Obsidian theme integration (can add later if needed)
- Install/Remove/Update menus
- Web app installer
- Development environment installers

### Simplified
- Theme system (core functionality only, no browser/IDE integration)
- System menu (focused on essential utilities)
- No distribution-specific update system

### Kept Core Features
- Universal clipboard (Super+C/V)
- Clipboard history
- Screenshot with smart selection
- Screenrecord with audio/webcam
- Keybinding viewer
- Toggle scripts
- Theme switching

## Next Steps

1. **Install elephant packages** (requires manual password entry)
   ```bash
   yay -S elephant elephant-clipboard
   ```

2. **Install screenshot/screenrecord dependencies**
   ```bash
   sudo pacman -S slurp grim satty wayfreeze wl-clipboard gpu-screen-recorder jq
   ```

3. **Update hyprland configuration**
   - Source clipboard-bindings.conf
   - Add keybindings for new utilities
   - Verify autostart.conf is sourced

4. **Create initial theme**
   - Create `~/.config/themes/your-theme/`
   - Add theme files
   - Run `theme-set your-theme`

5. **Test all features** using checklist above

6. **Remove omarchy dependencies** (once verified working)
   - Update bindings.conf to remove omarchy-specific commands
   - Remove omarchy sources from hyprland.conf
   - Archive or delete ~/omarchy-sba

## Support

All scripts are in `~/.local/bin/` with detailed comments.
Configuration files are in `~/.config/hypr/`.

For issues or questions, review script source code or check Hyprland/Wayland documentation.
