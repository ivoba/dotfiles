default: help

# Stow targets
git:
    stow --verbose --target=$HOME --adopt --restow git

zsh:
    stow --verbose --target=$HOME --adopt --restow zsh

yazi:
    stow --verbose --target=$HOME/.config/yazi --adopt --restow yazi
    if command -v ya &> /dev/null; then \
        echo "Installing Yazi flavor catppuccin-mocha..."; \
        ya pkg add yazi-rs/flavors#catppuccin-mocha; \
        echo "Installing Yazi plugins..."; \
        ya pkg install; \
    fi

all: git zsh yazi

# Update targets
update-yazi:  ## Update Yazi (if installed via homebrew)
    if command -v brew &> /dev/null; then \
        echo "Updating Yazi via Homebrew..."; \
        brew upgrade yazi; \
    else \
        echo "Homebrew not found. Please update Yazi using your package manager."; \
    fi

update-yazi-plugins:  ## Update Yazi plugins
    if command -v ya &> /dev/null; then \
        echo "Updating Yazi plugins using 'ya pkg upgrade'..."; \
        ya pkg upgrade; \
    else \
        echo "Yazi (ya) command not found. Please ensure Yazi is installed and in your PATH."; \
    fi

update: update-yazi update-yazi-plugins  ## Update Yazi and its plugins

# Cleanup targets
delete:  ## Remove all stowed configurations
    echo "Removing stowed configurations from home directory..."
    stow --verbose --target=$HOME --delete */
    if [ -d "$HOME/.config/yazi" ]; then \
        echo "Removing Yazi configuration..."; \
        stow --verbose --target=$HOME/.config/yazi --delete yazi; \
    fi

# Help target
help:
    @just --list
