# Neovim / LazyVim Configuration

This directory contains custom LazyVim configuration that extends the standard LazyVim setup.

## Structure

- `.config/nvim/lua/config/` - Custom configuration files that override/extend LazyVim defaults
  - `path_commands.lua` - Custom commands for copying file paths
  - `keymaps.lua` - Custom key mappings
- `setup.sh` - Setup script that installs LazyVim and configures custom settings using GNU Stow

## Setup

To set up LazyVim with this custom configuration:

```bash
just nvim
```

Or manually:
```bash
bash ~/Sites/dotfiles/nvim/setup.sh
```

## Features

### Custom Commands

- `:CopyRelativePath` - Copy relative path of current file to clipboard
- `:CopyAbsolutePath` - Copy absolute path of current file to clipboard

### Key Mappings

- Yank/delete/paste operations sync with the system clipboard automatically
- `<leader>cf` - Copy relative path (typically `<space>cf`)
- `<leader>cF` - Copy absolute path (typically `<space>cF`)

## How It Works

1. The setup script installs LazyVim if not already present
2. It creates symlinks from this dotfiles directory to your Neovim config
3. Custom configuration files are loaded alongside LazyVim's defaults
4. The `lazy.lua` file is modified to include our custom path commands

