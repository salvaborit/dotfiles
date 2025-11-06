# dotfiles

Personal dotfiles and system configuration for SBA.

## Installation

```bash
cd ~/.dotfiles
./install.sh
```

This will:
- Install required packages
- Create symlinks for configuration files
- Run optional Omarchy-specific configurations

## Structure

```
~/.dotfiles/
├── .bashrc              # Bash configuration
├── .vimrc               # Vim configuration
├── .config/             # Application configs
│   └── starship.toml    # Starship prompt config
├── .local/
│   └── bin/             # User scripts
├── optional/            # Optional/OS-specific configurations
│   └── omarchy-sonic-pi-fix.sh
└── install.sh           # Main installation script
```

## Optional Configurations

### Sonic Pi Audio Fix (Omarchy Only)

**Automatically applied on Omarchy installations.**

Fixes Sonic Pi audio output on Omarchy by auto-connecting SuperCollider JACK ports to system audio outputs.

#### What It Does
- Detects Omarchy OS using `pacman -Q omarchy-keyring`
- Installs required packages: `jack-example-tools`, `sc3-plugins`
- Deploys wrapper scripts for automatic JACK port connection
- Makes Sonic Pi work with PipeWire out-of-the-box

#### Usage
After installation, launch Sonic Pi with:
```bash
~/.local/bin/sonic-pi-with-audio
```

Or create an alias in your `.bashrc`:
```bash
alias sonic-pi='~/.local/bin/sonic-pi-with-audio'
```

#### Manual Installation
If you want to run the fix separately:
```bash
~/.dotfiles/optional/omarchy-sonic-pi-fix.sh
```

#### Technical Details
- **Problem**: SuperCollider (scsynth) connects to PipeWire's JACK emulation but ports aren't auto-connected to audio outputs
- **Solution**: Wrapper script that launches Sonic Pi and automatically connects JACK ports using `pw-jack jack_connect`
- **Scripts**:
  - `supercollider-autoconnect.sh` - Waits for SuperCollider and connects ports
  - `sonic-pi-with-audio` - Wrapper that launches Sonic Pi + autoconnect

#### Why Omarchy-Specific?
This issue affects Arch Linux installations using PipeWire + pipewire-jack (standard modern setup). The fix is made optional and Omarchy-specific to avoid running on systems where it might not be needed or where users have different audio setups.

## Packages Installed

### Core Tools
- vim, alacritty, tree, unzip
- waybar, starship
- docker, lazydocker, lazygit
- ufw, obsidian

### Audio/Music (Omarchy)
- sonic-pi, supercollider
- jack-example-tools, sc3-plugins
