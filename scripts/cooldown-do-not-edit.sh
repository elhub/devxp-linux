#!/bin/bash

timestamp="/usr/local/bin/devxp-files/.timestamp"
current_timestamp=$(date +%s)

# Check if the file exists
if [ -f "$timestamp" ]; then
    # Get the timestamp from the file
    file_timestamp=$(cat "$timestamp")

    # Calculate the timestamp X days or weeks ago
    cooldown=$(date -d "7 days ago" +%s)

    # Compare timestamps
    if [ "$file_timestamp" -lt "$cooldown" ]; then
        /usr/local/bin/devxp-files/devxp-linux/scripts/update.sh
    else
        exit 1
    fi
else
    # If timestamp does not exist, create it and set permissions
    date +%s > "$timestamp"
    chmod a+rw "$timestamp"
    exit 1
fi
