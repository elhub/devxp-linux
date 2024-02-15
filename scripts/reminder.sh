#!/bin/bash

# Define the file path
file_path="/usr/local/bin/devxp-files/reminder"

# Create the file with "true" content and set permissions
echo "true" > "$file_path"
chmod a+rw "$file_path"
