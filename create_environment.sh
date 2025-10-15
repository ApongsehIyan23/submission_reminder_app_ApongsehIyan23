#!/bin/bash

#This is the script for the create_environment.sh 

#prompting the user for a name
read -p "Enter your name: " name

#upon entry of the user name, the script performs validation checks
if [[ -z "$name" ]]; then #checks if the name is empty
	echo "Error 404: Name cannot be empty."
	exit 1
fi

#check if the name contains only letters (a-z or A-Z)
if [[ "$name" =~ ^[a-zA-Z]+$ ]]; then
	#proceeds to the code
	echo "Thank you, $name. Proceeding to create the directory..."
	user_dir="submission_reminder_$name"

	#creating the customized environment with it's subdirectories
	mkdir -p "$user_dir"/{app,modules,assets,config} && \
		touch "$user_dir"/{app/reminder.sh,modules/functions.sh,assets/submissions.txt,config/config.env,startup.sh} 
		#creating the contents of each respective folder

	#command to make all files with .sh extensions executable
	find "$user_dir" -type f -name "*.sh" -exec chmod +x {} \;

	#populating the files (reminder.sh, functions.sh, config.env, submissions.txt)
	# Path to the files
  	functions_file="$user_dir/modules/functions.sh"
	reminder_file="$user_dir/app/reminder.sh"
	config_file="$user_dir/config/config.env"
	submissions_file="$user_dir/assets/submissions.txt"
	startup_file="$user_dir/startup.sh"
	# Populate functions.sh with the code
	cat > "$functions_file" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
	# Populate the reminder.sh with the code 
	cat > "$reminder_file" << 'EOF'
#!/bin/bash

#Absolute path to the directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#Source environment variables and helper functions

source "$SCRIPT_DIR/../config/config.env"
source "$SCRIPT_DIR/../modules/functions.sh"

#Path to the submissions file
submissions_file="$SCRIPT_DIR/../assets/submissions.txt"
# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"
check_submissions $submissions_file	
EOF

	# Populate the config.env with the code 
	cat > "$config_file" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

	# Populate the submissions.txt 
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


# Populate the startup.sh with code
cat > "$startup_file" << 'EOF'
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
EOF
else
	echo "Error 404: Name must contain only letters (no numbers, spaces, or symbols)."
	exit 1
fi

