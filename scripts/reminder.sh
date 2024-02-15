#!/bin/bash

# Check if script is already running as root
if [[ $EUID -ne 0 ]]; then
    # If not running as root, re-run this script with sudo
    sudo "$0" "$@"
    exit $?
fi

# Define the file path
file_path="/usr/local/bin/reminder"

# Create the file with "true" content and set permissions
echo "true" > "$file_path"
chmod a+rw "$file_path"
