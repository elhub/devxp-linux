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
git clone -b TDX-300 https://github.com/elhub/devxp-linux.git /usr/local/bin/devxp-linux # remember to remove the TDX-300 after merging

# Run the auto-bootstrap script for the first time
/usr/local/bin/devxp-linux/scripts/auto-bootstrap.sh

echo "Install anacron if not already installed"
apt-get install -y anacron

# Check if the line already exists in /etc/anacrontab
if ! grep -q "/usr/local/bin/devxp-linux/scripts/auto-bootstrap.sh" /etc/anacrontab; then
    # If the line doesn't exist, append it to /etc/anacrontab
    echo "${GREEN}Configure anacron job to run /usr/local/bin/devxp-linux/scripts/auto-bootstrap.sh once a week. This can be edited in the /etc/anacrontab file.${NC}"
    cat << EOF >> /etc/anacrontab
@weekly 15      cron.weekly             /usr/local/bin/devxp-linux/scripts/auto-bootstrap.sh
EOF
else
    # If the line already exists, display a message indicating that it's already configured
    echo "Anacron job is already configured in /etc/anacrontab."
fi

echo "${GREEN}First time setup is complete${NC}"