#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/.config"
TARGET_DIR="$HOME/.config"

apps=(
    "nvim"
    "kitty"
	"zed-link.sh"
)

mkdir -p "$TARGET_DIR"

echo "Linking configuration directories..."

for app in "${apps[@]}"; do
	if [[ "$app" == *"sh" ]]; then
		$HOME/dotfiles/"$app"
		continue
	fi

    SOURCE="$DOTFILES_DIR/$app"
    DESTINATION="$TARGET_DIR/$app"

    if [ -d "$SOURCE" ]; then
        # Check if destination exists and is a REAL directory (not a symlink)
        if [ -d "$DESTINATION" ] && [ ! -L "$DESTINATION" ]; then
            echo "Removing existing directory at $DESTINATION"
            rm -rf "$DESTINATION"
        fi

        # Create the symlink
        # -s: symbolic
        # -f: force (overwrites existing symlinks)
        # -v: verbose (tells you what it did)
        ln -sfv "$SOURCE" "$DESTINATION"
    else
        echo "Notice: $app not found in $DOTFILES_DIR. Skipping."
    fi
done

echo "Done!"
