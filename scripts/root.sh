#!/bin/bash

# Define text color variables
GREEN=$(tput setaf 2)
NC=$(tput sgr0) # No Color

# Check if script is already running as root
if [[ $EUID -ne 0 ]]; then
    # If not running as root, re-run this script with sudo
    sudo "$0" "$@"
    exit $?
fi

echo "${GREEN}Cloning repository to /usr/local/bin...${NC}"
git clone -b TDX-300 https://github.com/elhub/devxp-linux.git /usr/local/bin # remember to remove the TDX-300 after merging

# Run the auto-bootstrap script for the first time
/usr/local/bin/devxp-linux/scripts/auto-bootstrap.sh

echo "Install anacron if not already installed"
apt-get install -y anacron

echo "${GREEN}Configure anacron job to run /usr/local/bin/devxp-linux/scripts/auto-bootstrap.sh once a week. This can be eddited in the /etc/anacrontab file.${NC}"
cat << EOF >> /etc/anacrontab
@weekly 15      cron.weekly             /usr/local/bin/devxp-linux/scripts/auto-bootstrap.sh
EOF

echo "${GREEN}First time setup is complete${NC}"