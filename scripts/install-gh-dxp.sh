#!/bin/bash

# Check the authentication status
status=$(gh auth status 2>&1)

# Check if the status contains the "You are not logged into any GitHub hosts" message
if [[ $status == *"You are not logged into any GitHub hosts"* ]]; then
  gh auth login --git-protocol https
fi

gh extension install elhub/gh-dxp --force
gh dxp alias import