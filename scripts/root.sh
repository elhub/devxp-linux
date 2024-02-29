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
USER=$(cat /usr/local/bin/devxp-files/.user)

echo "${GREEN}Cloning repository to /usr/local/bin/devxp-files...${NC}"
git clone https://github.com/elhub/devxp-linux.git /usr/local/bin/devxp-files/devxp-linux # remember to remove the TDX-300 after merging
git config --global --add safe.directory /usr/local/bin/devxp-files/devxp-linux

chown -R ${user}:${user} /usr/local/bin/devxp-files/devxp-linux

# Create timestamp file and set permissions
timestamp="/usr/local/bin/devxp-files/.timestamp"
date +%s > "$timestamp"
chmod a+rw "$timestamp"

# Copy cooldown script from source to destination
cp \
  /usr/local/bin/devxp-files/devxp-linux/scripts/cooldown-do-not-edit.sh \
  /usr/local/bin/devxp-files/cooldown.sh
chmod +rwx /usr/local/bin/devxp-files/cooldown.sh
