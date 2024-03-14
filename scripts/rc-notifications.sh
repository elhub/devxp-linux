#!/bin/bash

lastRun="$HOME/.local/devxp/.last-run"
# remove or leave the file depending on if you want the startup message
notification="$HOME/.local/devxp/.startup-notification"

if [ -f "$notification" ]; then
    cat "$lastRun"
fi

$HOME/.local/devxp/cooldown.sh
