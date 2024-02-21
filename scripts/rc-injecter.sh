#!/bin/bash

# Script to append a line to shell initialization files

script_to_trigger="/usr/local/bin/devxp-files/devxp-linux/scripts/rc-notifications.sh"

# Function to add or edit the line in the initialization file
add_or_edit_line() {
    local file="$1"
    local line_to_add="$2"
    local found=false

    # Check if the line already exists in the file
    if ! grep -Fxq "$line_to_add" "$file"; then
        echo "Line does not exist in $file. Adding the line."
        # Append the line to the file
        printf "%s\n" "$line_to_add" >> "$file"
        found=true
    fi
}

# Bash
if [ -n "$BASH_VERSION" ]; then
    add_or_edit_line "$HOME/.bashrc" "$script_to_trigger"
fi

# Zsh
if [[ "$SHELL" == *"zsh"* ]]; then
    echo "Zsh detected. Triggering..."
    add_or_edit_line "$HOME/.zshrc" "$script_to_trigger"
    echo "Line added to .zshrc"
fi

# Fish
if command -v fish &> /dev/null; then
    echo "Fish detected. Triggering..."
    add_or_edit_line "$HOME/.config/fish/config.fish" "$script_to_trigger"
    echo "Line added to config.fish"
fi

# Ksh
if [ -n "$KSH_VERSION" ]; then
    echo "Ksh detected. Triggering..."
    add_or_edit_line "$HOME/.kshrc" "$script_to_trigger"
    echo "Line added to .kshrc"
fi

# Dash
if [ -n "$DASH_VERSION" ]; then
    echo "Dash detected. Triggering..."
    add_or_edit_line "$HOME/.dashrc" "$script_to_trigger"
    echo "Line added to .dashrc"
fi

# Csh
if [ -n "$CSH_VERSION" ]; then
    echo "Csh detected. Triggering..."
    add_or_edit_line "$HOME/.cshrc" "$script_to_trigger"
    echo "Line added to .cshrc"
fi

# Tcsh
if [ -n "$TCSH_VERSION" ]; then
    echo "Tcsh detected. Triggering..."
    add_or_edit_line "$HOME/.tcshrc" "$script_to_trigger"
    echo "Line added to .tcshrc"
fi

# PowerShell
if [ -n "$PSVersionTable" ]; then
    echo "PowerShell detected. Triggering..."
    add_or_edit_line "$HOME/.bash_profile" "$script_to_trigger"
    echo "Line added to .bash_profile"
fi

# Elvish
if command -v elvish &> /dev/null; then
    echo "Elvish detected. Triggering..."
    add_or_edit_line "$HOME/.elvish/rc.elv" "$script_to_trigger"
    echo "Line added to rc.elv"
fi

# Add checks for other shell types if needed
