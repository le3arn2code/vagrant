# Lab 07: Automating User Management with Bash

## Objective
Automate three core user-management tasks on Ubuntu:
- **Create** multiple users.
- **Delete** multiple users (safely, if they exist).
- **Check** whether a given user exists.

## Prerequisites
- Ubuntu VM (Al Nafi-provided), running
- `sudo` privileges
- Shell access (`nano`, `bash`)

---

## Step-by-Step (nano-friendly)

### 1) Create multiple users
```bash
nano create_users.sh
```
Paste:
```bash
#!/bin/bash

# List of users to create
users=("user1" "user2" "user3")

# Loop through the user list and create each user
for user in "${users[@]}"; do
  # Create the user
  sudo useradd -m "$user"
  
  # Set a default password for the user
  echo "$user:password123" | sudo chpasswd
  
  # Provide feedback
  echo "User $user created successfully!"
done
```
Save/exit (CTRL+O, ENTER, CTRL+X), then run:
```bash
chmod +x create_users.sh
sudo ./create_users.sh
cat /etc/passwd | grep "user"
```

### 2) Delete multiple users
```bash
nano delete_users.sh
```
Paste:
```bash
#!/bin/bash

# List of users to delete
users=("user1" "user2" "user3")

# Loop through the user list and delete each user
for user in "${users[@]}"; do
  # Check if the user exists
  if id "$user" &>/dev/null; then
    # Delete the user
    sudo userdel -r "$user"
    
    # Provide feedback
    echo "User $user deleted successfully!"
  else
    echo "User $user does not exist!"
  fi
done
```
Save/exit, then:
```bash
chmod +x delete_users.sh
sudo ./delete_users.sh
cat /etc/passwd | grep "user"
```

### 3) Check user existence
```bash
nano check_user_existence.sh
```
Paste:
```bash
#!/bin/bash

# Ask for the username to check
read -p "Enter username to check: " username

# Check if the user exists
if id "$username" &>/dev/null; then
  echo "User $username exists!"
else
  echo "User $username does not exist!"
fi
```
Save/exit, then:
```bash
chmod +x check_user_existence.sh
./check_user_existence.sh
```

### Screenshot (Proof)
`./screenshots/lab07_user_mgmt_run.png`

---

## Layman's Summary
Your server is like a building. Each **user** gets a key and a room. The **create** script gives keys and rooms to many people at once. The **delete** script removes their rooms and keys when they leave. The **check** script tells you whether someone currently has a key.

---

## Errors We Hit & How We Resolved Them
- **Mail spool not found** during deletion (e.g., `userdel: user1 mail spool (/var/mail/user1) not found`)  
  *Why:* Not every user has a mail spool; it's harmless.  
  *Fix:* Nothing needed—`userdel -r` still succeeds. Proceed.

- **Typed a bare word at shell prompt** (e.g., `-bash: toor: command not found`)  
  *Why:* Entering a username alone tries to run it as a command.  
  *Fix:* Re-run the script and **enter the username when prompted** (e.g., `root`, `toor`).

- **User exists/does not exist** messages while testing `check_user_existence.sh`  
  *Why:* Reflects the current system state after creation/deletion.  
  *Fix:* Expected behavior—use an existing name (e.g., `root`) to see positive result.

- **Tooling mismatch (`useradd` vs `adduser`) (potential)**  
  *Why:* Some distros prefer `adduser` (interactive). We use `useradd` (non-interactive) which exists on Ubuntu.  
  *Fix:* On non-Ubuntu systems, switch to the available tool or install the appropriate package.

---

## Final Commands (clean run)
```bash
chmod +x create_users.sh delete_users.sh check_user_existence.sh
sudo ./create_users.sh
cat /etc/passwd | grep "user"

sudo ./delete_users.sh
cat /etc/passwd | grep "user"

./check_user_existence.sh
```
