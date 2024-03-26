#!/bin/bash

lastRun="$HOME/.local/devxp/data/.last-run"
# remove or leave the file depending on if you want the startup message
notification="$HOME/.local/devxp/data/.startup-notification"

if [ -f "$notification" ]; then
    cat "$lastRun"
fi

$HOME/.local/devxp/devxp-linux/scripts/cooldown.sh
