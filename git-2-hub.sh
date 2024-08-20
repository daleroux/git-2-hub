#!/usr/bin/bash

# Define the full Git repository URL as a single parameter
FULL_GIT_REPO_URL=$1

# Check if the parameter is provided
if [ -z "$FULL_GIT_REPO_URL" ]; then
    echo "Usage: $0 <full-git-repo-url>"
    exit 1
fi

# Extract the base URL and repository name from the full URL
GIT_REPO_BASE_URL=$(dirname "$FULL_GIT_REPO_URL")
REPO_NAME=$(basename "$FULL_GIT_REPO_URL")

# Clone the git repository
git clone "${FULL_GIT_REPO_URL}"

# Change directory to the cloned repo
cd "./${REPO_NAME}"

# Build the Ansible Collection
ansible-galaxy collection build

# Copy the ansible.cfg file
cp ../ansible.cfg .

# Publish the Ansible Collection
ansible-galaxy collection publish ./*.tar.gz --ignore-certs

# Return to the previous directory and clean up
cd ..
rm -rf "./${REPO_NAME}"

