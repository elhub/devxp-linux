#!/bin/bash

lastRun='/usr/local/bin/devxp-files/last-run'
# remove or leave the file depending on if you want the startup message
notification='/usr/local/bin/devxp-files/startup-notification'

if [ -f "$notification" ]; then
    echo "$(cat "$lastRun")"
fi

/usr/local/bin/devxp-files/cooldown.sh
