#!/bin/bash

# ========================================================
# Script: create_environment.sh
# Purpose: Create environment for submission_reminder_app
# Author: [Apongseh Iyan Foghang]
# NB: This script uses AI generated icons for better UX
# ========================================================

# -------------------------------
# Helper Functions
# -------------------------------

# Function to validate name input
validate_name() {
    local name="$1"
    if [[ -z "$name" ]]; then
        echo "❌ Error: Name cannot be empty."
        exit 1
    fi

    if [[ ! "$name" =~ ^[a-zA-Z]+$ ]]; then
        echo "❌ Error: Name must contain only letters (no numbers, spaces, or symbols)."
        exit 1
    fi
}

# Function to create directories and files
create_structure() {
    local base_dir="$1"
    mkdir -p "$base_dir"/{app,modules,assets,config} || {
        echo "❌ Error creating directories."
        exit 1
    }

    # Create files in respective directories
    touch "$base_dir"/{app/reminder.sh,modules/functions.sh,assets/submissions.txt,config/config.env,startup.sh} || {
        echo "❌ Error creating files."
        exit 1
    }
}

# Function to make all .sh files executable
make_executable() {
    local base_dir="$1"
    find "$base_dir" -type f -name "*.sh" -exec chmod +x {} \; || {
        echo "❌ Error setting executable permissions."
        exit 1
    }
}

# Function to populate files with content
populate_files() {
    local base_dir="$1"

    # File paths
    local functions_file="$base_dir/modules/functions.sh"
    local reminder_file="$base_dir/app/reminder.sh"
    local config_file="$base_dir/config/config.env"
    local submissions_file="$base_dir/assets/submissions.txt"
    local startup_file="$base_dir/startup.sh"

    # -----------------------
    # Populate functions.sh
    # -----------------------
    cat > "$functions_file" << 'EOF'
#!/bin/bash

function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"
    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOF

    # -----------------------
    # Populate reminder.sh
    # -----------------------
    cat > "$reminder_file" << 'EOF'
#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../config/config.env"
source "$SCRIPT_DIR/../modules/functions.sh"

submissions_file="$SCRIPT_DIR/../assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

    # -----------------------
    # Populate config.env
    # -----------------------
    cat > "$config_file" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

    # -----------------------
    # Populate submissions.txt
    # -----------------------
    cat > "$submissions_file" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Mpano, Git, submitted
Keza, Shell Basics, not submitted
Shiela, Shell Navigation, not submitted
Hassanat, Shell Basics, submitted
Ngome, Shell Basics, not submitted
Splendid, Git, submitted
Selome, Shell Navigation, submitted
Cora, Shell Basics, not submitted
EOF

    # -----------------------
    # Populate startup.sh
    # -----------------------
    cat > "$startup_file" << 'EOF'
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
EOF
}

# -------------------------------
# Main Script Logic
# -------------------------------

# Prompt user for their name
read -p "Enter your name: " name

# Validate name
validate_name "$name"

# Set user directory
user_dir="submission_reminder_$name"
echo "Thank you, $name. Proceeding to create the environment at '$user_dir'..."

# Create directories and files
create_structure "$user_dir"

# Populate files with content
populate_files "$user_dir"

# Make .sh files executable
make_executable "$user_dir"

echo "✅ Environment successfully created for $name!"
echo "You can now run '$user_dir/startup.sh' to start the reminder application."

