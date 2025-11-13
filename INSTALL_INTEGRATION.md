# Installation Integration Summary

## Changes Made to Install System

All omarchy-menu features have been integrated into the stow-based installation workflow.

### 1. Package Dependencies Added

**File**: `scripts/packages/hyprland.sh`

**Added Official Packages**:
- `hypridle` - Idle management
- `hyprlock` - Screen locker
- `hyprsunset` - Screen temperature control
- `swaybg` - Wallpaper daemon
- `satty` - Screenshot annotation
- `xorg-xwayland` - X11 compatibility
- `imagemagick` - Image processing (for elephant)
- `ffmpeg` - Video processing (for screenrecord)
- `v4l-utils` - Webcam support (for screenrecord)

**AUR Packages Already Included**:
- `elephant` - Clipboard history backend
- `elephant-clipboard` - Clipboard provider for walker
- `gpu-screen-recorder` - Hardware-accelerated screen recording
- `wayfreeze` - Screen freeze for screenshots

All packages will be installed automatically when running `./install-new.sh`.

### 2. Hyprland Configuration Updates

**File**: `hyprland/.config/hypr/hyprland.conf`

**Added Source Line**:
```conf
source = ~/.config/hypr/clipboard-bindings.conf # Universal clipboard (Super+C/V/X)
```

This enables universal clipboard shortcuts on fresh installations.

### 3. New Configuration Files (Stow-Managed)

**Hyprland Package** (`hyprland/.config/hypr/`):
- `clipboard-bindings.conf` - Universal clipboard keybindings (Super+C/V/X)
- `autostart.conf` - Updated with elephant + hypridle

**Scripts Package** (`scripts-local/.local/bin/`):
- `screenshot` - Smart screenshot with annotation
- `screenrecord` - Screen recording with audio/webcam
- `show-keybindings` - Interactive keybinding viewer
- `toggle-waybar` - Toggle status bar
- `toggle-hypridle` - Toggle idle lock
- `toggle-nightlight` - Toggle screen temperature
- `theme-set` - Set active theme
- `theme-list` - List available themes
- `theme-current` - Show current theme
- `system-menu` - Unified system menu

### 4. Autostart Configuration

**File**: `hyprland/.config/hypr/autostart.conf`

**Added Services**:
```conf
exec-once = hypridle                      # Idle management
exec-once = elephant                      # Clipboard history backend
exec-once = swaybg -i ~/.config/themes/current/wallpaper.jpg -m fill
```

These will start automatically when Hyprland launches.

## Installation Workflow

### Fresh Installation
```bash
# Clone repository
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Run installation
./install-new.sh
```

**This will now automatically**:
1. Install all dependencies (including elephant, gpu-screen-recorder, satty, etc.)
2. Deploy clipboard-bindings.conf via stow
3. Deploy all utility scripts to ~/.local/bin/
4. Configure autostart with elephant + hypridle
5. Source clipboard bindings in hyprland.conf

### Updating Existing Installation

If you already have dotfiles deployed:

```bash
cd ~/dotfiles
git pull

# Re-deploy hyprland configs (updates autostart.conf and adds clipboard-bindings.conf)
stow -R hyprland

# Re-deploy scripts (adds new utility scripts)
stow -R scripts-local

# Install new packages
bash scripts/packages/hyprland.sh
```

## Post-Installation Setup

### 1. Create Theme Directory
```bash
mkdir -p ~/.config/themes/my-theme
# Add theme files (see MIGRATION_STATUS.md for structure)
```

### 2. Set Initial Theme
```bash
# Create a default theme or use existing
ln -s ~/.config/themes/my-theme ~/.config/themes/current
```

### 3. Add Custom Keybindings (Optional)

Edit `~/.config/hypr/bindings.conf`:
```conf
# Utilities
bind = SUPER SHIFT, S, exec, screenshot smart
bind = SUPER SHIFT, R, exec, screenrecord region
bind = SUPER SHIFT, question, exec, show-keybindings
bind = SUPER, SPACE, exec, system-menu

# Toggles
bind = SUPER ALT, W, exec, toggle-waybar
bind = SUPER ALT, I, exec, toggle-hypridle
bind = SUPER ALT, N, exec, toggle-nightlight
```

### 4. Verify Installation

Test key features:
```bash
# Test clipboard
echo "test" | wl-copy
walker -m clipboard  # Should show "test"

# Test scripts
screenshot smart
show-keybindings
system-menu
```

## File Structure After Stow Deployment

```
~/.config/hypr/
├── hyprland.conf              # Sources clipboard-bindings.conf
├── clipboard-bindings.conf    # Universal clipboard (Super+C/V/X)
├── autostart.conf             # Includes elephant + hypridle
├── bindings.conf              # Your custom keybindings
└── ...other configs

~/.local/bin/
├── screenshot
├── screenrecord
├── show-keybindings
├── toggle-waybar
├── toggle-hypridle
├── toggle-nightlight
├── theme-set
├── theme-list
├── theme-current
├── system-menu
└── ...other scripts

~/.config/themes/
├── current -> my-theme/       # Symlink to active theme
└── my-theme/
    ├── wallpaper.jpg
    ├── alacritty.toml
    ├── waybar.css
    ├── hyprland.conf
    └── ...
```

## What Was NOT Ported from Omarchy

These features were intentionally excluded:

- ✗ uwsm/uwsm-app wrappers (using direct commands)
- ✗ Distribution update system (not needed for vanilla Arch)
- ✗ Browser/VSCode/Obsidian theme integration (can add manually if needed)
- ✗ Install/Remove/Update menus (using pacman/yay directly)
- ✗ Web app installer (manual .desktop creation if needed)

## Maintenance

### Adding New Utilities

1. Create script in `scripts-local/.local/bin/`
2. Make executable: `chmod +x scripts-local/.local/bin/myscript`
3. Re-deploy: `stow -R scripts-local`

### Adding New Dependencies

1. Edit `scripts/packages/hyprland.sh` (or appropriate category)
2. Add package to `packages=()` or `aur_packages=()`
3. Re-run: `bash scripts/packages/hyprland.sh`

### Updating Configs

1. Edit files in stow package directories (e.g., `hyprland/.config/hypr/`)
2. Re-deploy: `stow -R hyprland`

## Troubleshooting

**Clipboard not working?**
- Check elephant is running: `pgrep elephant`
- Check walker is running: `pgrep walker`
- Verify packages installed: `pacman -Q elephant elephant-clipboard`

**Scripts not found?**
- Check PATH: `echo $PATH | grep .local/bin`
- Verify stow deployed: `ls -la ~/.local/bin/screenshot`
- Re-deploy: `stow -R scripts-local`

**Theme system not working?**
- Create themes directory: `mkdir -p ~/.config/themes`
- Create a theme with at least `wallpaper.jpg`
- Set symlink: `ln -s ~/.config/themes/my-theme ~/.config/themes/current`

## Testing Checklist

- [ ] Fresh install completes without errors
- [ ] All dependencies installed (check `pacman -Q elephant gpu-screen-recorder satty`)
- [ ] Clipboard shortcuts work (Super+C, Super+V)
- [ ] Clipboard history opens (Super+Ctrl+V)
- [ ] Screenshot tool works: `screenshot smart`
- [ ] Screenrecord works: `screenrecord region`
- [ ] Keybinding viewer works: `show-keybindings`
- [ ] Toggle scripts work: `toggle-waybar`, `toggle-hypridle`, `toggle-nightlight`
- [ ] Theme system works: `theme-list`, `theme-set <name>`
- [ ] System menu works: `system-menu`
- [ ] Autostart services launch (elephant, walker, hypridle)

## Documentation

See these files for more information:
- `MIGRATION_STATUS.md` - Detailed migration notes and testing
- `CLAUDE.md` - Updated feature documentation
- `README.md` - General dotfiles information
