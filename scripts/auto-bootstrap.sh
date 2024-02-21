#!/usr/bin/env bash
# Automated bootstrap script for devxp-linux.

# Define text color variables
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color
timestamp="/usr/local/bin/devxp-files/.timestamp"

# Navigate to the directory containing the script
cd "$(dirname "$0")" || exit

# Store the current script hash
current_hash=$(sha256sum "$0")

# Perform a git pull to update the repository and suppress "Already up to date." message
git_pull_output=$(git pull 2>&1 | grep -v 'Already up to date.')

# Check if the script has changed after git pull
new_hash=$(sha256sum "$0")

if [ "$current_hash" != "$new_hash" ]; then
    echo "${GREEN}Script has been updated. Reloading...${NC}"
    exec "$0" "$@" # Reload the script
    exit 0
fi

# Read the user from the file
USER=$(cat /usr/local/bin/devxp-files/.user)

# Ensure that user has ownership of the devxp scripts directory and its sub directories
sudo chown -R ${user}:${user} /usr/local/bin/devxp-files/devxp-linux/scripts
sudo chmod -R u+rx /usr/local/bin/devxp-files/devxp-linux/scripts

# Upgrade the distro.
sudo apt-get update
sudo apt-get -y dist-upgrade

# Install tools.
sudo apt-get install -y make git python3 python3-pip

# Install Ansible via pip.
sudo apt-get remove -y ansible
sudo apt-get autoremove -y
python3 -m pip install --user ansible

# Ansible should now be installed in ~/.local/bin.
# If this directory did not exist already, then you might have to restart WSL.
# ~/.local/bin is conditionally loaded into $PATH in ~/.profile.

# Ensure that ~/.local/bin is loaded into $PATH.
source ~/.profile

# Run Ansible-runbooks to install necessary command-line tools.
ansible-galaxy install -r /usr/local/bin/devxp-files/devxp-linux/requirements.yml --force

logFile="/usr/local/bin/devxp-files/ansible-playbook.log"
lastRunFile="/usr/local/bin/devxp-files/.last-run"

# Write a message indicating that the Ansible playbook is starting
echo "${YELLOW}Ansible playbook is starting, this can take some time.${NC}"

# Run Ansible playbook and redirect output to the log file
ansible-playbook /usr/local/bin/devxp-files/devxp-linux/site.yml --ask-become-pass > "$logFile" 2>&1;
if [[ "$?" -eq 0 ]]; then

    # Completion message content
    content="devxp-linux was last run $(date +'%d.%m.%y %H:%M')"

    # Write completion message
    echo "$content" > $lastRunFile

    # Write success message
    echo "${GREEN}Ansible playbook finished successfully.${NC}"
else
    # Write failure message
    echo "${RED}Ansible playbook execution failed. Please check ${logFile} for details.${NC}"

    # Completion message content
    content="devxp-linux failed on its last run at $(date +'%d.%m.%y %H:%M') Please check $logFile for details."

    # Write completion message
    echo "$content" > $lastRunFile
fi

# Run the rc-injecter script to add the rc-notifications.sh script to the shell initialization files
/usr/local/bin/devxp-files/devxp-linux/scripts/rc-injecter.sh
chmod +x /usr/local/bin/devxp-files/devxp-linux/scripts/rc-notifications.sh
date +%s > "$timestamp"

echo "${GREEN}Update complete${NC}"
