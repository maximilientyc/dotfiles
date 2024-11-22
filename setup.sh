#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored message
print_message() {
    echo -e "${2}${1}${NC}"
}

# Function to create backup of existing config
backup_config() {
    local config_path=$1
    if [ -e "$config_path" ]; then
        backup_path="${config_path}.backup.$(date +%Y%m%d_%H%M%S)"
        print_message "Creating backup of existing config: $backup_path" "$YELLOW"
        mv "$config_path" "$backup_path"
    fi
}

# Setup Neovim configuration
setup_nvim() {
    print_message "Setting up Neovim configuration..." "$GREEN"
    
    # Create config directory if it doesn't exist
    NVIM_CONFIG_DIR="$HOME/.config/nvim"
    mkdir -p "$NVIM_CONFIG_DIR"
    
    # Backup existing configuration
    backup_config "$NVIM_CONFIG_DIR"
    
    # Create symbolic link
    print_message "Creating symbolic link for Neovim config..." "$GREEN"
    ln -sf "$PWD/nvim" "$HOME/.config/nvim"
    
    if [ $? -eq 0 ]; then
        print_message "Neovim configuration installed successfully!" "$GREEN"
    else
        print_message "Error: Failed to install Neovim configuration" "$RED"
        exit 1
    fi
}


# Setup default gems
setup_default_gems() {
    print_message "Setting up default gems..." "$GREEN$"
    rm "$HOME/.default-gems"
    ln -s "$PWD/.default-gems" "$HOME/.default-gems"
    if [ $? -eq 0 ]; then
        print_message "Default gem installed successfully!" "$GREEN"
    else
        print_message "Error: Failed to install default gems" "$RED"
        exit 1
    fi
}
# Main setup
main() {
    print_message "Starting dotfiles setup..." "$GREEN"
    
    # Check if we're in the right directory
    if [ ! -d "./nvim" ]; then
        print_message "Error: nvim directory not found. Are you in the dotfiles directory?" "$RED"
        exit 1
    fi
    
    setup_nvim
    setup_default_gems
    print_message "Setup completed successfully!" "$GREEN"
}

# Run main setup
main
