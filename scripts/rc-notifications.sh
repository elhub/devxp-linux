#!/bin/bash

lastRun='echo "$(cat /usr/local/bin/lastRun)"'

if ! grep -qF "$lastRun" ~/.bashrc; then
    echo "$lastRun" >> ~/.bashrc
fi

reminder_file="/usr/local/bin/reminder"

if [ -f "$reminder_file" ] && [ "$(cat "$reminder_file")" == "true" ]; then
    /usr/local/bin/devxp-linux/scripts/update.sh
fi