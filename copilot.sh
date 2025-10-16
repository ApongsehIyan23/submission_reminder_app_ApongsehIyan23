#!/bin/bash

# Get the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the config.env file
CONFIG_FILE="$SCRIPT_DIR/config/config.env"

# Check if config.env exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "❌ Error: $CONFIG_FILE not found."
    exit 1
fi

# Allowed assignments
VALID_ASSIGNMENTS=("Shell Navigation" "Shell Basics" "Git")

# Prompt the user for the new assignment name
read -p "Enter the new assignment name (Shell Navigation, Shell Basics, Git): " NEW_ASSIGNMENT

# Validate input
if [[ ! " ${VALID_ASSIGNMENTS[*]} " =~ " ${NEW_ASSIGNMENT} " ]]; then
    echo "❌ Invalid assignment name. Must be one of: Shell Navigation, Shell Basics, Git."
    exit 1
fi

# Replace the ASSIGNMENT value in config.env using sed
# This searches for the line starting with ASSIGNMENT= and replaces the value
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$NEW_ASSIGNMENT\"/" "$CONFIG_FILE"

echo "✅ Assignment updated to '$NEW_ASSIGNMENT' in $CONFIG_FILE."
echo "You can now rerun startup.sh to check non-submission status."

