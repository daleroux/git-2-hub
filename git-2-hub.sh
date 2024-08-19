#!/usr/bin/bash

# Define variables for the Git repository and repository name
GIT_REPO_BASE_URL=$1   # The base URL including user or group name, e.g., "https://github.com/daleroux/"
REPO_NAME=$2           # The repository name, e.g., "ansible-collection-hello_tam_blog"

# Check if both parameters are provided
if [ -z "$GIT_REPO_BASE_URL" ] || [ -z "$REPO_NAME" ]; then
    echo "Usage: $0 <git-repo-base-url> <repo-name>"
    exit 1
fi

# Clone the git repository
git clone "${GIT_REPO_BASE_URL}/${REPO_NAME}"

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

