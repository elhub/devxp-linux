#!/bin/bash

lastRun='/usr/local/bin/devxp-files/lastRun'

if [ -f "$lastRun" ]; then
    echo "$(cat "$lastRun")"
fi

reminder_file="/usr/local/bin/devxp-files/reminder"

if [ -f "$reminder_file" ] && [ "$(cat "$reminder_file")" == "true" ]; then
    /usr/local/bin/devxp-files/devxp-linux/scripts/update.sh
fi
