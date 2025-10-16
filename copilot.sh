#!/bin/bash

# This script updates the ASSIGNMENT value in all students' config.env files

# Prompt for the new assignment value
read -p "Enter the new assignment name (Shell Navigation, Shell Basics, or Git): " new_value

# Validate the new value
if [[ "$new_value" != "Shell Navigation" && "$new_value" != "Shell Basics" && "$new_value" != "Git" ]]; then
    echo "Invalid assignment value. Must be one of: Shell Navigation, Shell Basics, or Git."
    exit 1
fi

# Loop through all submission_reminder_* folders
for folder in submission_reminder_*; do
    config_file="$folder/config/config.env"

    if [[ -f "$config_file" ]]; then
        sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_value\"/" "$config_file"
        echo "Updated $config_file"
    fi
done

echo "All assignment values successfully updated to '$new_value'."

