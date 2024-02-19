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
git clone https://github.com/elhub/devxp-linux.git /usr/local/bin/devxp-files/devxp-linux

chown -R $USER /usr/local/bin/devxp-files/devxp-linux
chmod -R u+rx /usr/local/bin/devxp-files/devxp-linux

# Create timestamp file and set permissions
timestamp="/usr/local/bin/devxp-files/timestamp"
date +%s > "$timestamp"
chmod a+rw "$timestamp"

# Generate the cooldown script
script_content='#!/bin/bash\n\n
timestamp="/usr/local/bin/devxp-files/timestamp"\n
current_timestamp=$(date +%s)\n\n
# Check if the file exists\n
if [ -f "$timestamp" ]; then\n
    # Get the timestamp from the file\n
    file_timestamp=$(cat "$timestamp")\n\n
    # Calculate the timestamp X days ago\n
    cooldown=$(date -d "7 days ago" +%s)\n\n
    # Compare timestamps\n
    if [ "$file_timestamp" -lt "$cooldown" ]; then\n
        /usr/local/bin/devxp-files/devxp-linux/scripts/update.sh\n
    else\n
        exit 1\n
    fi\n
else\n
    date +%s > "$timestamp"\n
    chmod a+rw "$timestamp"\n
    exit 1\n
fi\n'

# Define the cooldown file path and write the contents
file_path="/usr/local/bin/devxp-files/cooldown.sh"
echo -e "$script_content" > "$file_path"
chmod +rwx "$file_path"
