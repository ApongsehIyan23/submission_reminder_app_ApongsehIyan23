#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REMINDER_SCRIPT="$BASE_DIR/app/reminder.sh"

if [[ -f "$REMINDER_SCRIPT" ]]; then
    echo "Starting reminder script..."
    bash "$REMINDER_SCRIPT"
    echo "✅ Reminder script completed successfully!"
else
    echo "❌ Error: reminder.sh not found at $REMINDER_SCRIPT"
    exit 1
fi
