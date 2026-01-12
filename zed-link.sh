#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/.config/zed"
TARGET_DIR="$HOME/.config/zed"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Link only specific files
ln -sfv "$DOTFILES_DIR/settings.json" "$TARGET_DIR/settings.json"
ln -sfv "$DOTFILES_DIR/keymap.json" "$TARGET_DIR/keymap.json"

echo "Zed config files linked successfully"
