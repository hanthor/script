#!/bin/bash

# Navigate to the directory containing the build.sh script
cd ~/dev/personal

# Perform a git pull to update the local repository
git pull
git fetch

# Check for pending changes
if ! git diff-index --quiet HEAD --; then
    echo "There are pending changes in the repository. Please commit or stash them before proceeding."
    exit 1
fi

# Check if at least one package name is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 package1 package2 ..."
    exit 1
fi

# Add new packages to the packages array in build.sh
for package in "$@"; do
    sed -i "/^packages=(/a \ \ \ \ $package" build.sh
done

# Stage the changes for commit
git add build.sh

# Commit the changes with a message
git commit -m "Add new packages to the package list in build.sh"

# Push the changes to the remote repository
git push origin main  # Change 'main' to your branch name if different
