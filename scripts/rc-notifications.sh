#!/bin/bash

lastRun='/usr/local/bin/devxp-files/last-run'
# remove or leave the file depending on if you want the startup message
notification='/usr/local/bin/devxp-files/startup-notification'

if [ -f "$notification" ]; then
    echo "$(cat "$lastRun")"
fi

reminder_file="/usr/local/bin/devxp-files/reminder"

if [ -f "$reminder_file" ] && [ "$(cat "$reminder_file")" == "true" ]; then
    /usr/local/bin/devxp-files/devxp-linux/scripts/update.sh
fi
