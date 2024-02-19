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

# Print the first part of the prompt with the newline
echo -e "Make sure you are running this script as your user."

# Prompt the user to confirm if they want to continue running the script as their user
read -p $"It is typically ${GREEN}firstname.lastname${NC} Continue? (Y/N): " choice


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

# Create the directory for the devxp-files anb devxp-linux
sudo mkdir /usr/local/bin/devxp-files

# Save the username for later use
user=$(whoami)

# Use sudo to write to file
echo "$user" | sudo tee /usr/local/bin/devxp-files/user > /dev/null
sudo chown -R $user /usr/local/bin/devxp-files

./scripts/root.sh
/usr/local/bin/devxp-files/devxp-linux/scripts/auto-bootstrap.sh

# Create a file to decide if the user should be reminded when the script was last run
touch /usr/local/bin/devxp-files/startup-notification

echo "${GREEN}First time setup is complete${NC}"
