#!/bin/bash

lastRun='echo "$(cat /usr/local/bin/devxp-files/lastRun)"'

if ! grep -qF "$lastRun" ~/.bashrc; then
    echo "$lastRun" >> ~/.bashrc
fi

reminder_file="/usr/local/bin/devxp-files/reminder"

if [ -f "$reminder_file" ] && [ "$(cat "$reminder_file")" == "true" ]; then
    /usr/local/bin/devxp-files/devxp-linux/scripts/update.sh
fi