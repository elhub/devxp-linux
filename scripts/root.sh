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
USER=$(cat /usr/local/bin/devxp-files/user)

echo "${GREEN}Cloning repository to /usr/local/bin/devxp-files...${NC}"
git clone -b TDX-300 https://github.com/elhub/devxp-linux.git /usr/local/bin/devxp-files/devxp-linux # remember to remove the TDX-300 after merging

chown -R $USER /usr/local/bin/devxp-files/devxp-linux
chmod -R u+rx /usr/local/bin/devxp-files/devxp-linux

echo "Install anacron if not already installed"
apt-get install -y anacron

# Check if the script already exists in /etc/cron.weekly
if [ ! -f "/etc/cron.weekly/reminder.sh" ]; then
    # If the script doesn't exist, copy it to /etc/cron.weekly
    echo "${YELLOW}Copying script to /etc/cron.weekly and granting execution rights...${NC}"
    cp /usr/local/bin/devxp-files/devxp-linux/scripts/reminder.sh /etc/cron.weekly/reminder.sh
    chmod +x /etc/cron.weekly/reminder.sh
    echo "${YELLOW}Script successfully copied and configured to run weekly.${NC}"
else
    # If the script already exists, display a message indicating that it's already configured
    echo "${YELLOW}Script is already configured to run weekly.${NC}"
fi
