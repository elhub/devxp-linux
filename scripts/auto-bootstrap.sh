#!/usr/bin/env bash
# Automated bootstrap script for devxp-linux.

# Define text color variables
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color


# Navigate to the directory containing the script
cd "$(dirname "$0")" || exit

# Perform a git pull to update the repository
git pull

# Check if the git pull was successful
if [ $? -ne 0 ]; then
    echo "Failed to update the repository. Please check your network connection and try again."
    exit 1
fi


# Read the user from the file
USER=$(cat /usr/local/bin/user)

# Upgrade the distro.
apt-get update
apt-get -y dist-upgrade

# Install tools.
apt-get install -y make git python3 python3-pip

# Install Ansible via pip.
apt-get remove -y ansible
apt-get autoremove -y
python3 -m pip install ansible

# Ansible should now be installed in ~/.local/bin.
# If this directory did not exist already, then you might have to restart WSL.
# ~/.local/bin is conditionally loaded into $PATH in ~/.profile.

# Ensure that ~/.local/bin is loaded into $PATH.
source ~/.profile

# Run Ansible-runbooks to install necessary command-line tools.
ansible-galaxy install -r /usr/local/bin/devxp-linux/requirements.yml --force # pulls down necessary dependencies for Ansible.
# Define the path for the log file
logFile="/usr/local/bin/ansible-playbook.log"
# Completion message path
lastRunFile="/usr/local/bin/lastRun"

# Write a message indicating that the Ansible playbook is starting
echo "${YELLOW}Ansible playbook is starting, this can take some time.${NC}"

# Run Ansible playbook and redirect output to the log file
if ansible-playbook /usr/local/bin/devxp-linux/site.yml --user="$USER" > "$logFile" 2>&1; then

    # Completion message content
    content="devxp-linux was last ran $(date +'%d.%m.%y %H:%M')"

    # Write completion message
    echo "$content" | sudo tee "$lastRunFile" > /dev/null

    # Write success message
    echo "${GREEN}Ansible playbook finished successfully.${NC}"
else
    # Write failure message
    echo "${RED}Ansible playbook execution failed. Please check $logFile for details.${NC}"

    # Completion message content
    content="devxp-linux failed it last run at $(date +'%d.%m.%y %H:%M') Please check $logFile for details."

    # Write completion message
    echo "$content" | sudo tee "$lastRunFile" > /dev/null
fi