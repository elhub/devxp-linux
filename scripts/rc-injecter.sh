#!/bin/bash

# Script to append a line to shell initialization files

# Define the path to the script to be triggered
script_to_trigger="/usr/local/bin/devxp-files/devxp-linux/scripts/rc-notifications.sh"

# Function to add or edit the line in the initialization file
add_or_edit_line() {
    local file="$1"
    local line_to_add="$2"
    local found=false

    # Check if the line already exists in the file
    if grep -Fxq "$line_to_add" "$file"; then
        echo "Line already exists in $file. Editing the existing line."
        # Edit the existing line
        sed -i "s|^.*$line_to_add.*$|$line_to_add|" "$file"
        found=true
    fi

    # If the line doesn't exist, append it to the file
    if ! $found; then
        echo "$line_to_add" >> "$file"
        echo "Added line to $file"
    fi
}

# Add or edit the line in .bashrc if Bash shell is being used
if [ -n "$BASH_VERSION" ]; then
    add_or_edit_line "$HOME/.bashrc" "$script_to_trigger"
fi

# Add or edit the line in .zshrc if Zsh shell is being used
if [ -n "$ZSH_VERSION" ]; then
    add_or_edit_line "$HOME/.zshrc" "$script_to_trigger"
fi

# Add checks for other shell types if needed
