#!/bin/bash

# This script updates the ASSIGNMENT value in all students' config.env files

# Prompt for the new assignment value
read -p "Enter the new assignment name (Shell Navigation, Shell Basics, or Git): " new_value

# Validate the new value if it's a valid assignment name
if [[ "$new_value" != "Shell Navigation" && "$new_value" != "Shell Basics" && "$new_value" != "Git" ]]; then
    echo "Invalid assignment value. Must be one of: Shell Navigation, Shell Basics, or Git."
    exit 1
fi

# Track if any update was successful
updated_any=false

# Loop through all submission_reminder_* folders
for folder in submission_reminder_*; do
    config_file="$folder/config/config.env"
    #check if the config file exists
    if [[ -f "$config_file" ]]; then
        sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_value\"/" "$config_file"
        echo "Updated $config_file"
        updated_any=true
    else
        echo -e "\n\nError 404!: Check if > 1) Config folder exists 2) Submission_reminder folder exists"
        echo "And run the program again"
    fi
done

# Only print success message if at least one update was done
if $updated_any; then
    echo -e "\n\nAll assignment values successfully updated to '$new_value'."
else
    echo -e "\n\nNo assignment values were updated."
fi
