# Agent Workflow for Dotfiles

## Overview
This repo manages dotfiles using **GNU Stow**. Files in this repo are symlinked to their respective locations (e.g., `~/.zshrc` → `~/Sites/dotfiles/zsh/.zshrc`).

## Agent Guidelines
1. **Edit Files Here Only**
   - Never edit files outside this repo (e.g., `~/.zshrc`).
   - All edits must target files in this working directory.

2. **Symlinks Handle Deployment**
   - Stow ensures files in this repo are symlinked to their correct locations.
   - Example: To edit `.zshrc`, modify `zsh/.zshrc` in this repo, not `~/.zshrc`.

3. **Why?**
   - Avoids breaking symlinks or editing live files directly.
   - Ensures changes are tracked in version control.

## Example Workflow
- **Task**: Update `.zshrc`.
- **Action**: Edit `zsh/.zshrc` in this repo.
- **Result**: Stow ensures `~/.zshrc` points to the updated file.