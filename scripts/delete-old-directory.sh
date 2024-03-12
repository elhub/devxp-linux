#!/usr/bin/env bash
#  script for cleaning up the old directory

old_path="/usr/local/bin/devxp-files"
new_path="$HOME/.local/devxp-files"

sudo rm -rf "$old_path"

$new_path/devxp-linux/auto-bootstrap.sh
