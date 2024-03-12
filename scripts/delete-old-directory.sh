#!/usr/bin/env bash
#  script for cleaning up the old directory

old_path="/usr/local/bin/devxp-files"
new_path="$HOME/.local/devxp-files"

sudo rm -rf "$old_path"

$new_path/devxp-linux/auto-bootstrap.sh

####### remove the line from the initialization file #######
script_to_remove="$HOME/.local/devxp-files/devxp-linux/scripts/rc-notifications.sh"

# Function to remove the line from the initialization file
remove_line() {
    local file="$1"
    local line_to_remove="$2"
    local found=false

    # Check if the line exists in the file
    if grep -q "$line_to_remove" "$file"; then
        echo "Line found in $file. Removing the line."
        # Use sed to remove the line from the file
        sed -i "/^$line_to_remove\$/d" "$file"
        found=true
    fi
}

# Bash
if [ -n "$BASH_VERSION" ]; then
    remove_line "$HOME/.bashrc" "$script_to_remove"
fi

# Zsh
if command -v zsh &> /dev/null; then
    remove_line "$HOME/.zshrc" "$script_to_remove"
fi

# Fish
if command -v fish &> /dev/null; then
    remove_line "$HOME/.config/fish/config.fish" "$script_to_remove"
fi

# Ksh
if [ -n "$KSH_VERSION" ]; then
    remove_line "$HOME/.kshrc" "$script_to_remove"
fi

# Dash
if [ -n "$DASH_VERSION" ]; then
    remove_line "$HOME/.dashrc" "$script_to_remove"
fi

# Csh
if [ -n "$CSH_VERSION" ]; then
    remove_line "$HOME/.cshrc" "$script_to_remove"
fi

# Tcsh
if [ -n "$TCSH_VERSION" ]; then
    remove_line "$HOME/.tcshrc" "$script_to_remove"
fi

# PowerShell
if [ -n "$PSVersionTable" ]; then
    remove_line "$HOME/.bash_profile" "$script_to_remove"
fi

# Elvish
if command -v elvish &> /dev/null; then
    remove_line "$HOME/.elvish/rc.elv" "$script_to_remove"
fi