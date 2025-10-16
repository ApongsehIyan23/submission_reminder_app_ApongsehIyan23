# 📘 Submission Reminder Application

## 🧾 Overview

The **Submission Reminder App** is a Bash-based program designed to help instructors or students track pending assignment submissions.  
It automatically sets up the required directory structure, runs reminders for upcoming deadlines, and allows users to update assignment values dynamically.  

This project demonstrates your understanding of shell scripting, automation, and error handling in Linux.

---

## 🧩 Directory Structure

After setup, the folder structure looks like this:

```
.
├── create_environment.sh
├── copilot_shell_script.sh
├── README.md
├── submission_reminder_{YourName}
│   ├── app
│   │   └── reminder.sh
│   ├── modules
│   │   └── functions.sh
│   ├── assets
│   │   └── submissions.txt
│   ├── config
│   │   └── config.env
│   └── startup.sh
```

Each folder serves a specific purpose:
- **app/** → Contains the main logic (`reminder.sh`) that displays assignment reminders.
- **modules/** → Holds helper functions used by the app.
- **assets/** → Stores student data (`submissions.txt`).
- **config/** → Contains configuration values such as the current assignment name and days remaining.
- **startup.sh** → The main launcher that starts the reminder app.
- **copilot_shell_script.sh** → Updates the assignment value across all students' config files.

---

## 🚀 How to Set Up and Run the Program

### 1️⃣ Step 1: Create the Environment

Run the environment creation script:

```bash
bash create_environment.sh
```

You’ll be prompted to enter your **name**.  
- Example input: `Dominion`
- The script creates a personalized folder named `submission_reminder_Dominion/` with all the necessary files and subdirectories.
- All `.sh` files are automatically made executable.

Once the setup completes successfully, you’ll see:
```
✅ Environment successfully created for Dominion!
```

---

### 2️⃣ Step 2: Start the Reminder Application

Navigate into your folder and run the **startup.sh** script:

```bash
bash submission_reminder_{YourName}/startup.sh
```

This script:
- Loads your configuration from `config/config.env`
- Displays the current assignment and days remaining
- Checks which students have **not submitted** their assignments
- Displays reminders for each student who still has pending work

If everything runs correctly, you’ll see:
```
✅ Reminder script completed successfully!
```

---

### 3️⃣ Step 3: Update Assignment Values (Using copilot_shell_script.sh)

Run the **copilot_shell_script.sh** to change the assignment being tracked:

```bash
bash copilot_shell_script.sh
```

You’ll be prompted to enter a new assignment name.  
Only **three valid assignment values** are accepted:
- `Shell Navigation`
- `Shell Basics`
- `Git`

Once entered, the script will automatically:
- Find all folders starting with `submission_reminder_`
- Locate each `config/config.env`
- Update the `ASSIGNMENT` value in every file

If successful, you’ll see:
```
All assignment values successfully updated to 'Shell Basics'.
```

---

## 🛡️ Safety Rules and Error Handling

The program includes built-in safety checks to prevent errors. Follow these rules to ensure smooth execution:

1. **Enter a valid name** — Your name must contain only letters (A–Z or a–z).  
   Numbers, spaces, or symbols will stop the script.

2. **Do not delete or rename subfolders** — The app depends on the folder structure created by `create_environment.sh`.

3. **Valid assignment values only** — When using `copilot_shell_script.sh`, ensure your input matches one of the following exactly:
   - `Shell Navigation`
   - `Shell Basics`
   - `Git`

4. **Run scripts in order:**
   - First: `create_environment.sh`
   - Then: `startup.sh`
   - Optionally: `copilot_shell_script.sh`

5. **Handle missing files cautiously** —  
   If the program displays:
   ```
   ❌ Error: reminder.sh not found
   ```
   or  
   ```
   Error 404!: Check if Config folder exists
   ```
   It means some files were deleted or renamed.  
   Re-run `create_environment.sh` to recreate them.

---

## ⚙️ File Descriptions

| File | Description |
|------|--------------|
| **create_environment.sh** | Automates creation of the environment, directories, and files. Populates all contents and ensures executability. |
| **startup.sh** | Launches the reminder app, loads configuration, and displays students who have not submitted assignments. |
| **copilot_shell_script.sh** | Updates the `ASSIGNMENT` value in all student folders to reflect a new assignment. |
| **functions.sh** | Contains reusable helper functions such as `check_submissions` that processes the student records. |
| **reminder.sh** | The main executable that runs checks, loads config, and calls helper functions. |
| **config.env** | Holds environment variables like `ASSIGNMENT` and `DAYS_REMAINING`. |
| **submissions.txt** | Contains the list of student submissions used for testing. |

---

## 🧠 Key Learning Outcomes

This project demonstrates:
- Automated environment setup using shell scripting  
- Use of functions to reduce repetition and improve modularity  
- Error handling and input validation in Bash  
- File manipulation with `sed`, `cat`, and `chmod`  
- Dynamic configuration management across multiple directories

---

## 🏁 Conclusion

The **Submission Reminder App** provides a simple yet powerful automation workflow for managing student assignments.  
It highlights the importance of clean scripting practices, modular design, and reliability in software development.

---

**Author:** Apongseh Iyan Foghang  
**Course:** Shell Scripting Project – Submission Reminder App

