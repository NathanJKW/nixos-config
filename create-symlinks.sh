#!/bin/bash

# Declare an array of key-value pairs in the format "source;destination"
declare -a MAPPINGS=(
    "./nixos;/etc/nixos"
)

# Check if sudo permissions are already valid, otherwise ask for them
sudo -v || { echo "Failed to obtain sudo permissions."; exit 1; }

# Option to overwrite existing symlinks (0 = skip, 1 = overwrite)
OVERWRITE=0  # Change to 1 if you want to overwrite existing symlinks

# Function to create symbolic links recursively
create_symlinks() {
    local SRC_DIR="$1"
    local DEST_DIR="$2"

    # Check if source directory exists
    if [ ! -d "$SRC_DIR" ]; then
        echo "Source directory $SRC_DIR does not exist. Skipping."
        return
    fi

    # Create destination directory if it doesn't exist
    if [ ! -d "$DEST_DIR" ]; then
        echo "Destination directory $DEST_DIR does not exist. Creating it."
        sudo mkdir -p "$DEST_DIR" || { echo "Failed to create $DEST_DIR"; exit 1; }
    fi

    # Use find to link files and directories in one go with relative symlinks
    find "$SRC_DIR" -mindepth 1 | while read -r SRC_ITEM; do
        DEST_ITEM="$DEST_DIR/$(basename "$SRC_ITEM")"

        # Check if the symlink or file already exists at destination
        if [ -e "$DEST_ITEM" ]; then
            if [ -L "$DEST_ITEM" ]; then
                if [ "$OVERWRITE" -eq 1 ]; then
                    echo "Overwriting existing symlink $DEST_ITEM."
                    sudo ln -srf "$SRC_ITEM" "$DEST_ITEM" || echo "Failed to overwrite symlink."
                else
                    echo "Symlink $DEST_ITEM already exists. Skipping."
                fi
            else
                echo "$DEST_ITEM exists but is not a symlink. Skipping."
            fi
        else
            # Create new symlink if none exists
            sudo ln -sr "$SRC_ITEM" "$DEST_ITEM" || echo "Failed to create symlink for $SRC_ITEM."
        fi
    done
}

# Iterate over each key-value pair
for PAIR in "${MAPPINGS[@]}"; do
    # Split the source and destination from the pair
    SOURCE=$(echo "$PAIR" | cut -d';' -f1)
    DEST=$(echo "$PAIR" | cut -d';' -f2)

    # Call the function to create symlinks
    create_symlinks "$SOURCE" "$DEST"
done
