#!/bin/bash

# Get the absolute path of the directory containing this script
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the reminder.sh script inside the app directory
REMINDER_SCRIPT="$BASE_DIR/app/reminder.sh"

# Make sure the reminder script exists and is executable
if [[ -f "$REMINDER_SCRIPT" ]]; then
    echo "Starting reminder script..."
    bash "$REMINDER_SCRIPT"
    echo "✅ Reminder script completed successfully!"
else
    echo "❌ Error: reminder.sh not found at $REMINDER_SCRIPT"
    exit 1
fi
