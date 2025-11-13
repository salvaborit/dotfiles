# CLAUDE.md - Arch + Hyprland Dotfiles

## Overview
Backend developer's vanilla Arch Linux + Hyprland dotfiles. Self-contained, modular configuration with centralized theming. No distribution-specific dependencies (migrating from Omarchy). Uses stow for deployment.

## Architecture Principles
- **Modular configs**: Split files for maintainability (Hyprland: bindings/monitors/looknfeel)
- **Centralized theming**: Single theme directory with per-app configs
- **Explicit over implicit**: No magic sourcing, version-controlled everything
- **Developer-first**: Git workflow, Docker shortcuts, terminal-centric tools

## Core Stack

### Hyprland (Window Manager)
- **Main**: `~/.config/hypr/hyprland.conf` - Sources modular configs
- **Bindings**: `~/.config/hypr/bindings.conf` - Super+Shift+Letter pattern for apps
- **Monitors**: `~/.config/hypr/monitors.conf` - Multi-monitor layouts (4-monitor setup)
- **Look & Feel**: `~/.config/hypr/looknfeel.conf` - Gaps (2px), rounded corners (11px), blur effects

### Waybar (Status Bar)
- **Config**: `~/.config/waybar/config.jsonc` - Extensive system monitoring modules
- **Style**: `~/.config/waybar/style.css` - Frosted glass aesthetic
- **Scripts**: `~/.config/waybar/scripts/` - ipaddr.sh (network info), cava.sh (audio viz)
- **Modules**: CPU, memory, disk, load, uptime, network, battery, media controls, system tray

### Application Launcher & Clipboard
- **Walker**: `~/.config/walker/config.toml` - Desktop apps, files, websearch, calculator, clipboard, symbols
- **Elephant**: Backend service providing clipboard history to walker
- **Clipboard bindings**: `~/.config/hypr/clipboard-bindings.conf` - Universal Super+C/V/X shortcuts

### Terminal Stack
- **Alacritty**: `~/.config/alacritty/alacritty.toml` - CaskaydiaMono Nerd Font, custom padding
- **Starship**: `~/.config/starship.toml` - Cross-shell prompt with language/tool detection
- **Bash**: `~/.bashrc` - Git aliases, Docker shortcuts, tree visualization, PATH extension
- **Neovim + LazyVim**: `~/.config/nvim/` - Modern IDE-like editing with lazy-loaded plugins
  - Quick launch: `n` alias (from terminal)
  - Default editor: `$EDITOR` set to `nvim`
  - Fallback vim: `.vimrc` remains for classic vim usage

### Theme System
**Location**: `~/.config/themes/`
- **Structure**: Each theme in `themes/<theme-name>/`
- **Current theme**: Symlinked at `themes/current`
- **Per-theme files**: alacritty.toml, waybar.css, hyprland.conf, mako.conf, btop.theme, wallpaper.jpg
- **Switching**: `theme-set <name>` (auto-reloads all components)
- **Single source of truth** for visual consistency across all applications

## Key Scripts

### Installation & Deployment
- **Target**: Stow-based deployment (replacing current install.sh)
- **Package management**: pacman for core packages (hyprland, waybar, walker, alacritty, starship, docker, lazydocker, lazygit, vim, tree, obsidian)

### User Scripts (~/.local/bin/)
**Clipboard & Utilities:**
- `screenshot`: Smart screenshot with region/window selection + annotation (satty)
- `screenrecord`: Region/output recording with audio mixing and webcam overlay
- `show-keybindings`: Interactive searchable keybinding viewer

**System Toggles:**
- `toggle-waybar`: Show/hide status bar
- `toggle-hypridle`: Enable/disable idle lock
- `toggle-nightlight`: Switch screen temperature (4000K/6000K)

**Theme Management:**
- `theme-set <name>`: Switch active theme and reload components
- `theme-list`: List available themes
- `theme-current`: Show current theme

**System Menu:**
- `system-menu`: Unified walker-based menu for all utilities

## Keybinding Philosophy

### Universal Clipboard (Super+C/V/X)
- **Super+C**: Universal copy (works in terminals and GUI apps via Ctrl+Insert)
- **Super+V**: Universal paste (works everywhere via Shift+Insert)
- **Super+X**: Universal cut
- **Super+Ctrl+V**: Clipboard history manager (walker)

### Application Bindings (Super+Shift+Letter)
Quick access to frequently-used applications. Examples:
- Web apps via browser (Claude, ChatGPT, Calendar, Email)
- Terminal tools (btop, lazydocker, lazygit)
- Development environment
- **Super+Shift+S**: Screenshot (smart selection)
- **Super+Shift+R**: Screenrecord (region)
- **Super+SPACE**: System menu

### Utility Bindings (Super+Alt)
- **Super+Alt+W**: Toggle waybar
- **Super+Alt+I**: Toggle hypridle (idle lock)
- **Super+Alt+N**: Toggle nightlight
- **Super+Shift+?**: Show keybindings viewer

### Reference Table
See `~/.config/hypr/bindings.conf` and `~/.config/hypr/clipboard-bindings.conf` for complete mappings.

## Customization Patterns

### Adding/Modifying Keybindings
Edit `~/.config/hypr/bindings.conf`:
```conf
bind = SUPER SHIFT, X, exec, your-command-here
```
Reload: `hyprctl reload`

### Multi-Monitor Setup
Edit `~/.config/hypr/monitors.conf`:
```conf
monitor = HDMI-A-1, 1920x1080@60, 0x0, 1
monitor = eDP-1, 1920x1080@60, 0x1080, 1
```
Test without logout: `hyprctl reload`

### Theme Modification
1. Edit color schemes in `~/.config/themes/main-theme/`
2. Update per-app configs (waybar/style.css, hyprland colors, etc.)
3. Reload: `hyprctl reload` (Hyprland), `killall waybar && waybar &` (Waybar)

### Extending Waybar Modules
1. Add module config to `~/.config/waybar/config.jsonc`
2. Style in `~/.config/waybar/style.css`
3. Create script in `~/.config/waybar/scripts/` if needed
4. Reload: `killall waybar && waybar &`

## Development Workflow

### Testing Config Changes
- **Hyprland**: Edit configs → `hyprctl reload` (or Super+Shift+R if bound)
- **Waybar**: Edit configs → `killall waybar && waybar &`
- **Terminal**: Source `~/.bashrc` or reopen terminal
- **Test in isolation**: Use `hyprland -c /path/to/test/config` in nested session

### Git Workflow
- `.bashrc` aliases: `gg` (lazygit), `gita` (git add .), `gitc` (git commit), `gitp` (git push)
- Commit atomically: one feature/fix per commit
- Test before committing: ensure configs don't break Hyprland startup

### Reloading Without Logout
- Hyprland: `hyprctl reload`
- Waybar: `killall waybar && waybar &`
- Walker: Automatically picks up config changes
- Avoid full logout unless testing session init

## Directory Structure
```
~/.config/
├── hypr/              # Hyprland configs (modular)
├── waybar/            # Status bar + scripts
├── walker/            # App launcher
├── alacritty/         # Terminal emulator
├── nvim/              # Neovim + LazyVim
├── starship.toml      # Shell prompt
├── themes/            # Centralized theme system
└── ...

~/.local/bin/          # User scripts
~/.bashrc              # Bash config + aliases
~/.vimrc               # Vim config (fallback)
```

## Important Paths
- Hyprland main config: `~/.config/hypr/hyprland.conf`
- Hyprland autostart: `~/.config/hypr/autostart.conf`
- Clipboard bindings: `~/.config/hypr/clipboard-bindings.conf`
- Waybar config: `~/.config/waybar/config.jsonc`
- Neovim config: `~/.config/nvim/init.lua`
- Theme directory: `~/.config/themes/`
- Current theme: `~/.config/themes/current` (symlink)
- User scripts: `~/.local/bin/`
- Bash aliases: `~/.bashrc`

## Migration Notes
Rebuilt from Omarchy-based setup. **Ported features:**
- ✅ Universal clipboard (Super+C/V + history)
- ✅ Screenshot tool with smart selection
- ✅ Screenrecord with audio/webcam
- ✅ Keybinding viewer
- ✅ Toggle scripts (waybar, hypridle, nightlight)
- ✅ Theme switching system
- ✅ System menu

**Removed Omarchy-specific:**
- uwsm/uwsm-app wrappers
- Distribution update system
- Browser/IDE theme integration (simplified)
- Install/Remove/Update menus

See `MIGRATION_STATUS.md` for detailed migration guide and testing checklist.

## Dependencies

**Core System:**
- hyprland, waybar, walker, mako, hypridle, hyprsunset
- alacritty, starship, bash, vim, neovim, tree
- docker, lazydocker, lazygit, obsidian

**Clipboard System:**
- elephant, elephant-clipboard (AUR)
- wl-clipboard

**Screenshot/Screenrecord:**
- slurp, grim, satty, wayfreeze
- gpu-screen-recorder, ffplay, v4l2-ctl

**Utilities:**
- jq, xkbcli, fastfetch
