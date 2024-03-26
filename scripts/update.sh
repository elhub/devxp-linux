#!/usr/bin/env bash
# Automated bootstrap script for devxp-linux.

# Define text color variables
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color
timestamp="$HOME/.local/devxp/data/.timestamp"

# Print the first part of the prompt with the newline
echo -e "Hey there, looks like its been a while since you last ran ${GREEN}devxp-linux${NC}"
echo -e "Running it will update the repository and install the latest tools and update your system."
echo -e "${YELLOW}This can break things like python versions.${NC}"

# Prompt the user to confirm if they want to continue running the script as their user
read -p "Would you like to run it now?  Continue? (Y/N): " choice

# Convert the choice to uppercase
choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')

# Check the user's choice
if [ "$choice" == "Y" ]; then
    echo "Starting up..."
elif [ "$choice" == "N" ]; then
    date +%s > "$timestamp"
    echo "To customize the update frequency, you can add a 'cooldown' variable in the config file."
    echo "Open ${YELLOW}$HOME/.local/devxp/config.yml${NC} in a text editor and add a line like:"
    echo "${GREEN}cooldown: number${NC},"
    echo "where ${GREEN}number${NC} represents the number of days between reminders."
    echo "The config.yml will not be overwritten by updates."
    echo "We'll remind you again after a while. ${GREEN}Have a great day!${NC}"
    exit 0
else
    echo "Invalid choice. Please enter Y or N."
    exit 1
fi

$HOME/.local/devxp/devxp-linux/scripts/auto-bootstrap.sh
