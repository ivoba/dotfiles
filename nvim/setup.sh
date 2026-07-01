#!/bin/bash

# LazyVim setup script for dotfiles
# This script installs LazyVim and sets up custom configuration using GNU Stow

set -e

echo "Setting up LazyVim..."

# Create nvim config directory if it doesn't exist
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
mkdir -p "$NVIM_CONFIG_DIR"

# Check if LazyVim is already installed
if [ ! -d "$NVIM_CONFIG_DIR/lua/lazyvim" ]; then
    echo "Installing LazyVim..."
    # Backup existing config if it exists
    if [ -f "$NVIM_CONFIG_DIR/init.lua" ] || [ -d "$NVIM_CONFIG_DIR/lua" ]; then
        echo "Backing up existing Neovim config to $NVIM_CONFIG_DIR.backup"
        mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup"
        mkdir -p "$NVIM_CONFIG_DIR"
    fi
    
    # Install LazyVim
    git clone https://github.com/LazyVim/starter "$NVIM_CONFIG_DIR"
    rm -rf "$NVIM_CONFIG_DIR/.git"
else
    echo "LazyVim already installed"
fi

# Create custom config directory if it doesn't exist
mkdir -p "$NVIM_CONFIG_DIR/lua/config"

# Create symlinks for custom configuration
echo "Setting up custom configuration..."

# Create the target directory if it doesn't exist
mkdir -p "$NVIM_CONFIG_DIR/lua/config"

# Create symlinks for our custom config files
ln -sf "$HOME/Sites/dotfiles/nvim/.config/nvim/lua/config/keymaps.lua" "$NVIM_CONFIG_DIR/lua/config/keymaps.lua"
ln -sf "$HOME/Sites/dotfiles/nvim/.config/nvim/lua/config/path_commands.lua" "$NVIM_CONFIG_DIR/lua/config/path_commands.lua"

# Modify lazy.lua to include our custom path_commands (if not already done)
if ! grep -q "require(\"config.path_commands\")" "$NVIM_CONFIG_DIR/lua/config/lazy.lua"; then
    echo "Adding path_commands to lazy.lua..."
    sed -i '1i-- Load custom path commands\nrequire("config.path_commands")\n' "$NVIM_CONFIG_DIR/lua/config/lazy.lua"
fi

echo "LazyVim setup complete!"
