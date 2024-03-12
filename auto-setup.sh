#!/bin/bash

# Define text color variables
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Check if script is already running as root
if [[ $EUID -eq 0 ]]; then
    echo "${RED}This script should not be run as root. Please run it as your regular user.${NC}"
    exit 1
fi

echo -e "Starting firstime setup of devxp-linux, note that this script will"
echo -e "install the devxp-linux repository in $HOME/.local/devxp-files/devxp-linux"
echo -e "and ${YELLOW}run some commands as root.${NC}"
echo -e "Make sure you are running this script as your user."

# Prompt the user to confirm if they want to continue running the script as their user
read -p "It is typically ${GREEN}firstname.lastname${NC} Continue? (Y/N): " choice

# Convert the choice to uppercase
choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')

# Check the user's choice
if [ "$choice" == "Y" ]; then
    echo "Continuing with the script..."
elif [ "$choice" == "N" ]; then
    echo "${YELLOW}Please switch to your user and run the script again.${NC}"
    exit 1
else
    echo "Invalid choice. Please enter Y or N."
    exit 1
fi

user=$(whoami)
# Create the directory for the devxp-files anb devxp-linux
sudo mkdir $HOME/.local/devxp-files
sudo chown -R ${user}:${user} $HOME/.local/devxp-files

# Save the username for later use
sudo echo "$user" > $HOME/.local/devxp-files/.user

./scripts/root.sh
$HOME/.local/devxp-files/devxp-linux/scripts/auto-bootstrap.sh

# Create a file to decide if the user should be reminded when the script was last run
touch $HOME/.local/devxp-files/.startup-notification

echo "${GREEN}First time setup is complete${NC}"
