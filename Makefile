.PHONY: git zsh yazi all update-yazi update-yazi-plugins update delete help

# Stow targets
git:
	stow --verbose --target=$$HOME --adopt --restow git

zsh:
	stow --verbose --target=$$HOME --adopt --restow zsh

yazi:
	stow --verbose --target=$$HOME/.config/yazi --adopt --restow yazi
	@if command -v ya &> /dev/null; then \
		echo "Installing Yazi flavor catppuccin-mocha..."; \
		ya pkg add yazi-rs/flavors#catppuccin-mocha; \
		echo "Installing Yazi plugins..."; \
		ya pkg install; \
	fi

all:
	make git zsh yazi

# Update targets
update-yazi:  ## Update Yazi (if installed via homebrew)
	@if command -v brew &> /dev/null; then \
		echo "Updating Yazi via Homebrew..."; \
		brew upgrade yazi; \
	else \
		echo "Homebrew not found. Please update Yazi using your package manager."; \
	fi

update-yazi-plugins:  ## Update Yazi plugins
	@if command -v ya &> /dev/null; then \
		echo "Updating Yazi plugins using 'ya pkg upgrade'..."; \
		ya pkg upgrade; \
	else \
		echo "Yazi (ya) command not found. Please ensure Yazi is installed and in your PATH."; \
	fi

update: update-yazi update-yazi-plugins  ## Update Yazi and its plugins

# Cleanup targets
delete:  ## Remove all stowed configurations
	@echo "Removing stowed configurations from home directory..."
	@stow --verbose --target=$$HOME --delete */
	@if [ -d "$$HOME/.config/yazi" ]; then \
		echo "Removing Yazi configuration..."; \
		stow --verbose --target=$$HOME/.config/yazi --delete yazi; \
	fi

# Help target
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)