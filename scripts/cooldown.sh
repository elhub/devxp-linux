#!/bin/bash

timestamp="$HOME/.local/devxp/data/.timestamp"
config_file="$HOME/.local/devxp/config.yml"
default_cooldown="7"
current_timestamp=$(date +%s)

# Check if the file exists
if [ -f "$timestamp" ]; then
    # Get the timestamp from the file
    file_timestamp=$(cat "$timestamp")

    # Check if the config file exists
    if [ -f "$config_file" ]; then
        # Check if the config file contains a cooldown value
        cooldown_value=$(awk '/^cooldown:/ {print $2}' "$config_file")
        if [ -n "$cooldown_value" ]; then
            # Set the cooldown value from the config file
            cooldown=$(date -d "$cooldown_value days ago" +%s)
        else
            # Use the default cooldown if no value found in the config file
            cooldown=$(date -d "$default_cooldown  days ago" +%s)
        fi
    else
        # Use the default cooldown if the config file does not exist
        cooldown=$(date -d "$default_cooldown" +%s)
    fi

    # Compare timestamps
    if [ "$file_timestamp" -lt "$cooldown" ]; then
        "$HOME/.local/devxp/devxp-linux/scripts/update.sh"
    else
        exit 1
    fi
else
    # If timestamp does not exist, create it and set permissions
    date +%s > "$timestamp"
    chmod a+rw "$timestamp"
    exit 1
fi
