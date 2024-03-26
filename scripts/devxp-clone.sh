#!/bin/bash

# Define text color variables
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Read the user from the file
USER=$(cat $HOME/.local/devxp/data/.user)

echo "${GREEN}Cloning repository to $HOME/.local/devxp...${NC}"
git clone https://github.com/elhub/devxp-linux.git $HOME/.local/devxp/devxp-linux
git config --global --add safe.directory $HOME/.local/devxp/devxp-linux

chown -R ${user}:${user} $HOME/.local/devxp/devxp-linux

# Create timestamp file and set permissions
timestamp="$HOME/.local/devxp/data/.timestamp"
date +%s > "$timestamp"
chmod a+rw "$timestamp"
