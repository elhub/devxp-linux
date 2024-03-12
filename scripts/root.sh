#!/bin/bash

# Define text color variables
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Check if script is already running as root
if [[ $EUID -ne 0 ]]; then
    # If not running as root, re-run this script with sudo
    sudo "$0" "$@"
    exit $?
fi

# Read the user from the file
USER=$(cat $HOME/.local/devxp-files/.user)

echo "${GREEN}Cloning repository to $HOME/.local/devxp-files...${NC}"
git clone -b move https://github.com/elhub/devxp-linux.git $HOME/.local/devxp-files/devxp-linux
git config --global --add safe.directory $HOME/.local/devxp-files/devxp-linux

chown -R ${user}:${user} $HOME/.local/devxp-files/devxp-linux

# Create timestamp file and set permissions
timestamp="$HOME/.local/devxp-files/.timestamp"
date +%s > "$timestamp"
chmod a+rw "$timestamp"

# Copy cooldown script from source to destination
cp \
  $HOME/.local/devxp-files/devxp-linux/scripts/cooldown-do-not-edit.sh \
  $HOME/.local/devxp-files/cooldown.sh
chmod +rwx $HOME/.local/devxp-files/cooldown.sh
