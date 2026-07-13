#!/bin/bash

# Try Homebrew first
if command -v brew &> /dev/null; then
    echo "Updating Yazi via Homebrew..."
    brew upgrade yazi
else
    echo "Homebrew not found. Attempting manual download and installation..."
    
    # Detect system architecture
    ARCH=$(uname -m)
    if [ "$ARCH" = "x86_64" ]; then
        ARCH="x86_64"
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
        ARCH="aarch64"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi

    # Detect OS
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    if [ "$OS" != "linux" ] && [ "$OS" != "darwin" ]; then
        echo "Unsupported OS: $OS"
        exit 1
    fi

    # Get latest release URL from GitHub
    echo "Fetching latest Yazi release information..."
    LATEST_RELEASE=$(curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest)
    if [ $? -ne 0 ]; then
        echo "Failed to fetch release information"
        exit 1
    fi

    # Extract download URL for the appropriate asset
    if [ "$OS" = "linux" ]; then
        if [ "$ARCH" = "x86_64" ]; then
            DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-x86_64-unknown-linux-gnu\.zip" | head -1)
        elif [ "$ARCH" = "aarch64" ]; then
            DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-aarch64-unknown-linux-gnu\.zip" | head -1)
        fi
    elif [ "$OS" = "darwin" ]; then
        if [ "$ARCH" = "x86_64" ]; then
            DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-x86_64-apple-darwin\.zip" | head -1)
        elif [ "$ARCH" = "aarch64" ]; then
            DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-aarch64-apple-darwin\.zip" | head -1)
        fi
    fi

    if [ -z "$DOWNLOAD_URL" ]; then
        echo "Could not find download URL for $OS-$ARCH"
        exit 1
    fi

    # Extract checksum URL
    if [ "$OS" = "linux" ]; then
        if [ "$ARCH" = "x86_64" ]; then
            CHECKSUM_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-x86_64-unknown-linux-gnu\.zip.sha256" | head -1)
        elif [ "$ARCH" = "aarch64" ]; then
            CHECKSUM_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-aarch64-unknown-linux-gnu\.zip.sha256" | head -1)
        fi
    elif [ "$OS" = "darwin" ]; then
        if [ "$ARCH" = "x86_64" ]; then
            CHECKSUM_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-x86_64-apple-darwin\.zip.sha256" | head -1)
        elif [ "$ARCH" = "aarch64" ]; then
            CHECKSUM_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*yazi-aarch64-apple-darwin\.zip.sha256" | head -1)
        fi
    fi

    echo "Downloading Yazi from: $DOWNLOAD_URL"

    # Create temp directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || exit 1

    # Download the file
    curl -L -o yazi.zip "$DOWNLOAD_URL"
    if [ $? -ne 0 ]; then
        echo "Failed to download Yazi"
        cd / || exit 1
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    # Download checksum if available
    if [ -n "$CHECKSUM_URL" ]; then
        echo "Downloading checksum file..."
        curl -L -o yazi.zip.sha256 "$CHECKSUM_URL"
        
        # Verify checksum
        echo "Verifying checksum..."
        if command -v sha256sum &> /dev/null; then
            if ! sha256sum -c yazi.zip.sha256; then
                echo "Checksum verification failed"
                cd / || exit 1
                rm -rf "$TEMP_DIR"
                exit 1
            fi
        else
            echo "sha256sum not found, skipping checksum verification"
        fi
    fi

    # Extract and install
    echo "Extracting and installing Yazi..."
    unzip yazi.zip
    if [ $? -ne 0 ]; then
        echo "Failed to extract Yazi"
        cd / || exit 1
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    # Find and move binary to ~/.local/bin
    YAZI_DIR=$(find . -name "yazi-*" -type d | head -1)
    if [ -z "$YAZI_DIR" ]; then
        echo "Could not find Yazi directory"
        cd / || exit 1
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    # Create ~/.local/bin if it doesn't exist
    mkdir -p "$HOME/.local/bin"

    cp "$YAZI_DIR/yazi" "$HOME/.local/bin/"
    if [ $? -ne 0 ]; then
        echo "Failed to copy Yazi to $HOME/.local/bin/"
        cd / || exit 1
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    chmod +x "$HOME/.local/bin/yazi"

    # Add ~/.local/bin to PATH if not already present
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo "Adding $HOME/.local/bin to your PATH"
        echo "export PATH="$HOME/.local/bin:$PATH"" >> "$HOME/.bashrc"
        echo "export PATH="$HOME/.local/bin:$PATH"" >> "$HOME/.zshrc"
        echo "Please run: source ~/.bashrc or source ~/.zshrc to update your PATH"
    fi

    echo "Yazi successfully updated to latest version!"
    cd / || exit 1
    rm -rf "$TEMP_DIR"
fi
